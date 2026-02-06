Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33718B0A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365105; cv=pass; b=F5K6EH1dQ+VyxgdyUmaJr9HInYKAiXQbzja+gqx5DYj9p2cexWynGwqve+w5SVyiHpXkhxD7TE6PW0y4GX98CrAxvbwR/92uoJ8/JlrUxOAG3myFy7DYGkWH9wsDAvVMhI7xzQbM2I3gAfRCTs+zYzipDth4ojU733AbShWJ3yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365105; c=relaxed/simple;
	bh=MawWIdHiVTZYkqUpvIjZRH9byP/aWcGdpyFZECKKLyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks516FNqmUR1iDVHb1hpu+R1PBRFYPm5F9oqMFoK9M1uZt+7CUjlT/WIhJSLvF00p7fHJJrcPPiy8i2JVY4W4AZQdbAXpngZjpUJfUI7E/IlyP9hIc1Ckj9BH4AOAfZrQOCgiqtmqXLcd8sVpqOH7fpeDtHlCGDpbSidKLgYNco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR6bZT82; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR6bZT82"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4042cd2a336so1338487fac.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 00:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770365104; cv=none;
        d=google.com; s=arc-20240605;
        b=QPjPQfa484LQhkc2S106CiE6msLVtKrCkiMBDPEOPF+5Aq2ermcinLEUP5PXGXsSz8
         8lSCdTEmtkCILORJkdZXsMrWBe3UwQsu4N+8vFZdI5pvy6mDORyDhKUfhoM0s2L35hLI
         iIKv4PzgN0tOnd/Z3UCCgXPr+E2fRvSEtZmraC4Um2T1GaeafboxoNYtP8IlsREdvx4m
         JUMIkC3AckiCoAvV6ibeoDWdmYaTmuTh/8tIOt0bWNfChv7ZbZJOB6rjvpIvD4M9HJ5x
         L8sWQeiyDG+YDpgn4OYclQy1ylgs2LUfnB3vSDjBPrEB7vuyL1YutQipAYpaBAXiamM6
         Xgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhyC4Jl4tzqyRnayhh+jis88T4m02oiF63k2M8+Fxbg=;
        fh=FvrUBQN1yUWtc3xTK+GAU5ZkN09eSlkw2Ifnce5hllo=;
        b=Cx/yXlI98hmgKifxg2JBSKn9kUGhmw4LLEClyVWdhp5xN2jvBBV3URhLzCNj4kVnQx
         oAssRwwjRWYdkoGLlXhqcSM1GGCvRezg2RmuHm6f/DT9IZs6RTqugAAcKHSzDo860/p7
         6DsLyGkYA0KzEuscDDhyr7m1hBy+LAWu7rvpt11dIa/cUIgJC7ubD3lNEQutZNdsCFsp
         wsmod4usd/D5dz/zVYWKY7XH9nPymJ3NGO5Lv5I5eMgEa8IL74cjHj2v8YzlkVgWNXNe
         +NEii/zqXY0DwESHQZTReKz1lPKVvVvLzwHq8cOhf0wCleEie6WPu8A1bbJwM06KPxPZ
         MwLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770365104; x=1770969904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhyC4Jl4tzqyRnayhh+jis88T4m02oiF63k2M8+Fxbg=;
        b=CR6bZT82EIW6fue1AwmyZLu4U4dZNDisapl5XO2zHH6//4u+x5nXNb4Z5W/+fg8U62
         CwOYQHiiEA1zBUAqrrmaC6HuMd+XqC7asEioUiJW9rKFDwd0OeXg7UCmlsl0BNEyqTJM
         cuDkUsUVtioavoJ8RZnELSwvRqZjTlWF2ly1H7W0WhfBfV8HyGS1rvURBZHw4vDEyRKI
         dk94+eP4j3/Owx76f/ynaenhoyB4ksoimA1b7crVOFvd8ko0u/baU4IalzOiwVXXixeT
         uoa+3FeQyDqZd7G3Fa4+uDTEe+BdXE1fHJ62w6GL9XNtYMmsgEq+UzN3tgMCm3mWXzu2
         8qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770365104; x=1770969904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhyC4Jl4tzqyRnayhh+jis88T4m02oiF63k2M8+Fxbg=;
        b=U7QLcN+blNC0Jo7avxPZR++zMABLYonpIwGo0Y1Xnb20ZKJLAHf42sokXgpFSYftkG
         wFlWXhn+YI4rinTkJlDDexHwD6PdfwThLUbeqCqE5J39QtS97WjNy4xGskYkkuOHHurj
         7V7Zh2qaPZeavOXp3K6TZD09PkAxTmwJRPMVcn6MRCAMNzgGiIgMVh15Du3yp94QlEUP
         XZ0FRKx8ZhREVC63VqL4nNJSeGJC7k6ZE65YlWQ7KOWZz4E7UVuGthDQr8/B7MRUdhUX
         M6fYU8kKC3IwqeWp/R0vgEoKtwPc53piEQgKsCNTvzGXDshjF4FaR76KT7V1WFg+NRck
         XnMg==
X-Gm-Message-State: AOJu0YyNORmAtca89E0xHsOgXcCEZMpWPJHpeGo7MP3TEW4QqVkG2zGQ
	d1wQnC7pzLJ3Y8mC0rcEpMaeLS7cYN9pbbkJC/f9bSPEbC1Zvd4V8/jUQNHniumjDR+d4svxYQU
	YGS3hmPD1BhGvM003diTt2/ex8esodJIGXg==
X-Gm-Gg: AZuq6aIG03FuToi7zNyNBeRU5C+AgcKp28CLZMB0hfZUEsWCsnQil9PjvoHje5l8feQ
	iOmux/o9P+vscbnmfgqTu5nXupvXVW8IFcpGjGLCnXcQyOH/3Dp5XYXOlOOQFwe7ceqzYCxpWMH
	o9KFxZ9O5GJwjNKI6ZrWmxLWlwcQCy0HT4AcQraIzwka6TB+h3vTRk1+3C8P1PsOgEozVGr059L
	WDTqb8ayEFrp9u4nhs5CvRkJhZFp7/XAWpGRl6vvEh8vFSCx0lQTPjLreGvEvocY8Ca3A==
X-Received: by 2002:a05:6820:169e:b0:662:8b01:c7cb with SMTP id
 006d021491bc7-66d0d8ce415mr817017eaf.84.1770365103921; Fri, 06 Feb 2026
 00:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
In-Reply-To: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Fri, 6 Feb 2026 00:04:54 -0800
X-Gm-Features: AZwV_Qjov84vuF2vjMXHyJktA8XOpIuNmYe0ZLzoBE5wcIds3CFhSMMkFJxdkWo
Message-ID: <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
Subject: Re: git-am applies commit message diffs
To: Matthias Beyer <mail@beyermatthias.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 11:50=E2=80=AFPM Matthias Beyer <mail@beyermatthias.=
de> wrote:
>
> Hi,
>
> I am not sure whether this was already reported, searching the lore did
> not yield anything for me, but I might have overlooked it...
>
> This was just posted on mastodon[0]:
>
>     PSA: Did you know that it=E2=80=99s **unsafe** to put code diffs into=
 your commit messages?
>
>     Like https://
>     github.com/i3/i3/pull/6564 for example
>
>     Such diffs will be applied by patch(1) (also git-am(1)) as part of th=
e code change!
>
>     This is how a sleep(1) made it into i3 4.25-2 in Debian unstable.
>
> TL;DR: If you put a diff in the commit message, that diff will be
> applied by git-am.
>
> This looks clearly like unintended and might be an attack-vector, right?
>

It is certainly surprising. I am not certain I would consider it an
attack-vector since you should definitely be reading the commit
messages before applying, but I could see the fact that its
unintentional is a problem.

I'm surprised patch would apply since it would likely fail due to
other non-patch formatted text, no? I suspect this is something that
could be handled by using the scissors marker  "-- >8 --" in the patch
description to indicate the diff is not part of the patch, or perhaps
the splitting of the email should somehow indicate this, for example
when formatting a patch with a diff in it.

I checked by formatting a patch from my own commit message with an
embedded diff, and there is nothing in place to prevent that diff
section from being applied. In practice, I think the advice is "don't
put diffs in your commit message" or "indent the diff text so that it
won't  be parsed as a diff hunk by patch or am."

It seems like a good idea to me to improve the format patch output and
the git am patch splitting to somehow try and detect the end of a
valid commit message and not treat it as a patch content, but I am
really uncertain how to go about doing so safely without risking
backwards compatibility (modifying format-patch to insert a marker
that properly denotes end of commit would cause issues with older
versions of git, so we need to use some marker that a well formatted
patch already does.

> Best,
> Matthias
>
> [0]: https://mas.to/@zekjur/116022397626943871
