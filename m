Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916E2BF01A
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182280; cv=none; b=poDURroFrqmvK0xjm9OOmiYpgbVyYr/T7jLTF9YsR09aE2/JnSnqnBqu1tdcgESVtk2ljhysKDtnyWK+hxwXI/QCVvxCi7YfDUlzwSUWVjJeBQpKlRVRkAptehFzfdhrY1rL63MEz3CESGdTomucT0SfinxYl3JnDc1cTO35ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182280; c=relaxed/simple;
	bh=T2+CnPlkOwj1wdAccjNQHYqTNWCLrXDgah3bbIi7lns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR46prNNqL6y3b/xpNiEoJWefodzZfB5Z3JcxP9WBWU2h2cSAxwSSqeQbmMN+0Ox1uIDmdZUJ5pT7+ocSKKR7+svA5T965071wOKOGXnYeHmzBAMk7PoRpWriWWxZfDpyrkE3ifc6bbuOeQObffhNo5sECd9lnA5KigenAFeUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+U/gniS; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+U/gniS"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ddc9872e69so24724805ab.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2025 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750182276; x=1750787076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q09vFTLqlQvPwBK7ZFeVaaJw94MBjDKV3BxvxeHLQp0=;
        b=Y+U/gniSmf1wHNuO5zGvMYfx1IZ5Ft7H0oX5qTXtnGPK2rKjpzTu7e1F163112RMhN
         EYQniFDedWCHW2qvTsd5W71d0AY8Z/9s8woxzBD1JVFqFQXnVpfhQ0ttRYG6Nq1FxYX/
         fkqpTGYc56ObNCp4Na86T5hBZx8hB1gCfTpsuw48uD/TaNysSbAXvJmXGOghFLbZsZtW
         M++FZzQyeICD4enWkr141O1lIpCwE+JVWS86oNOdZybCtbKwjaeWpV7jVErlcwN27asO
         O83XyPhwRDYza1tMyO6AtG5u0OYaJYHCrtBe0X8VEqznv+p4YArj7Hxd/PNCgPC4JM0z
         SHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182276; x=1750787076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q09vFTLqlQvPwBK7ZFeVaaJw94MBjDKV3BxvxeHLQp0=;
        b=wWxOKd1dbLa2oxqcg9lfPLXy9cegyjejK4wdrbvleH7X1ssBnvpoeLNsiwmwA9zfz1
         G3et5X1hZdClEi31qPn1GfTG6pdyCpwfU7yHWK9A3AEHQ9eL9rvPWMYs6btynFWZ8Ipf
         F0/EecJOeu8rIpkd1DIJrjEamVZ9zsIJf8kGlzyzLopcuN2QaiqBZURKus7Jxxpo4TK3
         eumP5vbK5WA315tZ2QZwxxuEjIblyk56luS+Ebpoe5FfAdVNzdeZvIZzzz3d4AXlb9cs
         exLNAj8CDX5pwZa5kEv4AfANmoe3SmlAVPXGXwJmwwf4wZ85Kbnnm3nRAgu/beNwQumX
         wlsg==
X-Gm-Message-State: AOJu0YwXvjXgaABlctAo2FrCjua/Pqp0qhgrljreDmJjG/WEgEbAVeSt
	oRXeZc3D3cig/nops5QN/v7Hwh1zyCjBO0JvwnlhsVLA3kNdMER+cLaHHwrr42V2ti1iL5iUBom
	UoqVwWefbRHRqIJmi9vrnAvqORDzFy6Mc4ZRN
X-Gm-Gg: ASbGnctri6Xh4ev7rO8iskcBPNrrmJl29YcLjLEs8tkvo05o/gEXGy/S8YvmhInydYq
	4UgSvULPKZl2KC6OJkKeyiIvh+l0ecLl5oO+J05a4f+qcFkC8XiL80NxUDPObexMUR7PPvK+afn
	jCSjeMUdkRcMrVWgxQ1PBw8qqjLgMqNxHrgTqIAjnNTMwKV0n6R5yVFo4pMMYoBn87gZhHqo8QX
	loy
X-Google-Smtp-Source: AGHT+IG5KukymSQ680iL8lW1xU+ZUUt/4VPfTrcdEUiQkTKSDeAOysgQGGYKRJMnhzQfEWpoAaVEgUUK1ASiVQPXutI=
X-Received: by 2002:a05:6e02:1a81:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3de07cc207bmr139904495ab.13.1750182275513; Tue, 17 Jun 2025
 10:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFFN9UHCspTjliMv@kitsune.suse.cz>
In-Reply-To: <aFFN9UHCspTjliMv@kitsune.suse.cz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 17 Jun 2025 10:44:23 -0700
X-Gm-Features: AX0GCFvDK5byBB0HbrXxZ3XdTErtWgC-v9rLxQO7tKwgpcBQpQJzGL7oaWc_t3k
Message-ID: <CABPp-BFdEn8rYu+FW+CdgrKNDUGBY9h6ePSH-vjYy-f_Pji0-Q@mail.gmail.com>
Subject: Re: Rename detection fails on symlinked files
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 17, 2025 at 4:16=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:

I think your subject might be slightly misleading, and that a more
accurate subject might be: Rename detection is not performed for files
still present in the target version.  Let me explain why and you can
check if I'm understanding your problem setup correctly.

> commit 5d51b10d8b5206ef5eeb9d214237b2ec2e0b789e (HEAD -> master)
> Author: Michal Suchanek <msuchanek@suse.de>
> Date:   Tue Jun 17 13:08:51 2025 +0200
>
>     rename file
>
> diff --git a/somefile b/somefile-renamed
> similarity index 100%
> rename from somefile
> rename to somefile-renamed

So you've renamed a file, detected at the time you run git log -p.

> ln -s somefile-renamed somefile
> git add somefile
> git commit --amend

Here, you reintroduce the original file, as a symlink, and amend the commit=
.

> commit 377d9bd045aed61c7be55482f3c98f8f9d04a33d (HEAD -> master)
> Author: Michal Suchanek <msuchanek@suse.de>
> Date:   Tue Jun 17 13:08:51 2025 +0200
>
>     rename file
>
> diff --git a/somefile b/somefile
> deleted file mode 100644
> index a53032b..0000000
> Binary files a/somefile and /dev/null differ
> diff --git a/somefile b/somefile
> new file mode 120000
> index 0000000..fc49048
> --- /dev/null
> +++ b/somefile
> @@ -0,0 +1 @@
> +somefile-renamed
> \ No newline at end of file
> diff --git a/somefile-renamed b/somefile-renamed
> new file mode 100644
> index 0000000..a53032b
> Binary files /dev/null and b/somefile-renamed differ

If I'm understanding the behavior that bothers you, it doesn't seem to
be related to symlinks.  You could create any regular text file
unrelated to the original somefile (or even introduce a submodule) and
place it in somefile and amend the commit, and you'd see that the
rename wasn't detected.  For example, replace your `ln -s/git add/git
commit --amend` sequence with

$ echo content >somefile
$ git add somefile
$ git commit --amend

and you'd see that there was no rename detected from the original
somefile to the new somefile-renamed.  By default, if the file is
present in both the source and the destination, it is not involved in
rename detection.

> Can the rename detection be fixed to detect symlinked files as well?

Symlink renames can be and are detected, by default.  For example:

$ ln -s somefile old-symlink
$ git add old-symlink
$ git commit -m old
$ git mv old-symlink new-symlink
$ git commit -m new
$ git diff HEAD~1
diff --git a/old-symlink b/new-symlink
similarity index 100%
rename from old-symlink
rename to new-symlink

But from your example, you're not renaming a symlink, so instead of
"Can rename detection handle symlinked files?", your question really
is more of "Can a renamed file be detected even when some other
file/link/submodule is immediately placed where the renamed file used
to be?"

git assumes, by default, that a file which exists in both the source
and destination are "related" and will only look for renames in
deleted or added files.  Allowing git to mark a file as both a delete
and an add even when it's present in both the source and the target is
the job of break detection, which is not turned on by default.
Further, break detection and rename detection have a bug or two when
used together (brought up on the mailing list by Junio some years
ago), which might need to be fixed for your example to work as you
expect if you try to turn on break detection.

Also, not sure how deep your interest in break detection goes, but
merge-ort was written with some implicit assumptions that break
detection is _not_ active.  Trying to retrofit it to support break
detection might take a significant chunk of work; and even if someone
is motivated to make it work, it'd defeat the safety of every
optimization added to it (making it orders of magnitude slower), and
also tack on a significant performance penalty on top of all that
(break detection is not cheap when at least one side of the merge has
a significant number of files modified).

Anyway...does that help explain what's going on?
