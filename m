Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFC28688C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334950; cv=pass; b=QY5sj1SuisdK2Q8yEibxPnFPXPs0L/D2PPbM18Udev85AOpTkmCVlL1cLKEtI8l+jx5j1NrnmypBfnLYHWH2ICABi31JkTamio9zRzy+hkBjhmCwGik37DtJ6aiGcBRlWjkzvU27YVD2XNEN8A36uSZYKtZlQcvKbUogVGtTaY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334950; c=relaxed/simple;
	bh=b8Mm8ZyeBRRrhnR896ui5O0ups4Xap1+6Dj87GeIHvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GndWH8mbuaDTb4W7RBqbNxcr8wXEsyl/Gn8M6LG0SXUR5VE84AElh+5ZrvFpmE7Yox6Bzm9vRpsKjm6DL2vkVocBqJyx+JBBUzQoZlWvPhSsuYVrjEmwafWNMpVEQb/43C/4uV7NyNwxTfpbTiX6s4U2Es7u+KDkh2phfO+rZtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWp/ZKzj; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWp/ZKzj"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3566af9900eso2063453a91.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:29:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771334948; cv=none;
        d=google.com; s=arc-20240605;
        b=cXMxt5nS0zHpJeMZD9e2Oz2Dwaif/MW2lNf9SchgIbbII0iANKtVcUqaEgVQG0WUBQ
         Zz+PCTgW7qC3wsj0fcrz4a4TMFgSkQZRRnITo3yroBvqcBpBbSZtUjAfV0eJVtc6GHqd
         Ph5pwXpghxHASfYEcWMGBHIjn4WohxS4aAa+25ood9NiTfZCaXkYeIG7j7mKGy9eH1UC
         ZX2aNVAdGiC/wYx3y7FGaO+1jELqZQR6YZyabbHvhKdCd5GtKW/1FaGGe66+IdLFSXL6
         OtQiwzpZJuJLQTZVGbJp1g9sb0BhU/61MDkdUSjguf53C8Cla48VNqXYguRJaIZN7a/0
         e2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b8Mm8ZyeBRRrhnR896ui5O0ups4Xap1+6Dj87GeIHvU=;
        fh=rtP/cyUBDrqqIjHuC/uoYPSjBxuiNXh+0zsNiRm0/YA=;
        b=QxnvpLypYd0tZGvVelBRI4Xgb3tDjNaZoHso5jM64C0/k3LAa8fbwaA7gJA1BRS4PT
         vwM9osdstL6urlWNHT0vGp/Nv/aiRdYwyS5R7ZBPdqHv5bp5q7yl5Gpc6GJmuytUCT3S
         jz+j3iX+pyhhsE0emlYnFkx8Out6Pnp6448WMfcGQUWAY3TEfUNfe6GIoWtx9X9YnDru
         zh18cbC85uWhzk/Aor+RAzi1vUaaHHQAtmB4GQ7Vkr4JNE7Zk9ap/t23yAQ+64YJZKH5
         6g8vaWYBLaGdo5ikf2u9jJnYvOebUkePaTNwWVpyoGBoOKxok5ozYVgIvqkk88QCVUeO
         bluQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334948; x=1771939748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8Mm8ZyeBRRrhnR896ui5O0ups4Xap1+6Dj87GeIHvU=;
        b=ZWp/ZKzjJ6RqUL+ArFGNMY8aVq2J30XK0czQ0xzU3KZhw2gwWTqS1AO4j/fTiioTWG
         Y5AiQa8pkVqxHWhwAE+NgBz6dI1S6UiTYQAhqNCvD1lV2MWaqmn10lskOVzv2q/JkA6j
         W7sGP9WvhUtL25jWCSphU/fifurtCoEVa3yiR7TCl34WGuQ0AYjWyw0iLvFo4kBRerNf
         K6XYPo7reCMrCUtajwwFCn5H4d1IF2DWv77h9BJSEl/5GQN5xp82XqqqR9Jk7GfhBYQu
         WQ+YJJL4666NK0Mqyu54hPupaRjN7AbSiyf8wH6RekqS52kLP5eIJyHp3YRrchNeAOx2
         6N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334948; x=1771939748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8Mm8ZyeBRRrhnR896ui5O0ups4Xap1+6Dj87GeIHvU=;
        b=Wo+do5g6VUEtSMm/8GO0kkqdOzlWaht3LcitrLdy1xSvWGGAqDmQTvhr76GwfW+Ush
         uwsPMABMcc+Hj9XNzByu6nu8Ln/p/DeIPtj+XBnla31/F5YowC8hqEa/heEG8wBO9QWg
         M8KWABYbDZaP8J4d18EbqFehUJAZ+4oaK1Zw0nAUIA/OCFSOej0oes08AOCM1gWMB/CM
         +HcDyqS1b/YqUWEP+dLWZ1qTg00n3XT2vh1RfU9avUOXvaTQwnRchlFvwEqNQ4zw58f9
         XYeoJ/wAKAf36FaPDqpW2VLsrrVUjxTzjPv0dFd8NC6QJIPMXym9zDrmz1zDbn9nrSJr
         7d0A==
X-Gm-Message-State: AOJu0Yx8nQ7YvcUCuP7sFOSxBj63m0+UhE3c6mm9XJfDRT+5BzrHvvEq
	ERA5EpRmx80YYmT4uYYRpxxuP71vvLRe3eUHUodwkgVGNQn1XrZKD2o4sQFOOIZLncU5yO7Ye+R
	FH5ocl8JxtOoHwoNm00J7V0i/gR48pXA=
X-Gm-Gg: AZuq6aLAUSc15d5gsoG11jEav9bjr4SqDWKXqig7V+TF8CQ30E2PDgIW4NBTbOUhE6Y
	MGnhEfU3SIsE4PZ9Eg1lJ3Pgah2xzIC/7pRz/6sDc0aCK5jQH72UdtI/5lqIGmMcJR7TPErj+dw
	JzgywotTisogCw9iJcdIQzMifOLa5zrHrfSwpxpcX6v5fzDrU08/O0W+TwaclBFZZ+Q7WtzY9nP
	Wr+iber6Wm9wm+RiBCr3mcm6yZnbO8fkEy64Kf0jhQjNB6RSiH0D4JZvmWfJUm4IOdZ1Dd7cJQq
	9NlJMUru7bMO6dR5qlvpG8xjgPsLd2q0NJbNdlXqdSBnytgRhvAdaYLja3Szv6w0D1NR/r2t64L
	AnTs1vjq7znV5M87eMSd5EaKKhmf3wrY87Xzj
X-Received: by 2002:a17:90b:1dc4:b0:354:c3a4:397 with SMTP id
 98e67ed59e1d1-356aada0a0cmr11249916a91.32.1771334948567; Tue, 17 Feb 2026
 05:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <286624E8-94CD-4C65-BB91-BF8338B8A79A@gmail.com> <aZQSqtxf_alZnYXD@pks.im>
In-Reply-To: <aZQSqtxf_alZnYXD@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 17 Feb 2026 08:28:57 -0500
X-Gm-Features: AaiRm51F_y5Gc8Bautp6Tn_AjUKmrN4_CpcSYqpDitvFXDm-Ah6DukrhloKFg3E
Message-ID: <CALnO6CDSgeOMeu-acjdB=oX985xkQZFpMMA85hHS1NXsin8RmA@mail.gmail.com>
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation changes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Evan Martin <evan.martin@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 2:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Feb 16, 2026 at 07:33:19PM -0500, Ben Knoble wrote:
> > Hmm. I=E2=80=99m pretty sure this worked locally but I=E2=80=99m seeing=
 some CI
> > failures on GitHub. Will investigate.
>
> Where did you see the failures? The changes look good to me, and things
> work as expected on my machine, so I'm wondering what the root cause is.
> A test run at [1] in GitLab's CI is also successful (ignore the
> MSVC+Meson failures, a fix for these is being reviewed on the mailing
> list already).
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/505

I must have misread my mobile notifications; I _thought_ [1] was
failing, but it must have been a different branch I accidentally
pushed to GitHub :) CI for this branch succeeded.

[1]: https://github.com/benknoble/git/actions/runs/22081407078

--=20
D. Ben Knoble
