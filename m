Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80431366542
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882956; cv=pass; b=U6RjwgYSJ4IqiI9chhD8ytkTdk95Lsy6xWCfkh0UGZozuGSDqHQyLCgGbF7TiYlD138Lw8vkw+vcni5WZfkV5m6/UzD0nWUXz/dWr0SNSwrEzOqEQ1HG2U6zd2HPXR7OM6bOqE0ZHX5dXgAlXBVVveEYZqY7nq6IgkEAyfG8vzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882956; c=relaxed/simple;
	bh=fxKsJMd9lqkxNm17+Vt+FMweMrJDZq7n83+IsBfB3OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeHO7DMzkwq/Elq70WI7Xu/7/GvB6xi0Tca/X83EaJFimhWdIYys9oe6mHzKKV+Mv5tx244yUZQAfwxnTNSZm+svPuhxc5du1LnmEISjpkvQNdZvyZleV/qW3bx9EDoCGWCcwzLiRXJ/oAjK3ZBAnI8fMtFFqcETfejIw7bu0bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMugLuwy; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMugLuwy"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so5227482a91.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776882954; cv=none;
        d=google.com; s=arc-20240605;
        b=B1covKO8JQVcfIpgUR9dGNCxZb1DP16/OJrSC7jGjaWSDttfxfyYuLSF8CMwtXhQqe
         x6fTlFzhe3iXiPsR7A4GFPflkBlpG6mzxAUWh/AjdnTeKXROgEX4QNuDtPCy+OkZusow
         qqRTdlm/s6Z/kJA43abga0KbObeRptl74BauOb+XFeJTpDW50/9KHe5Q8ENucvwPm5wA
         hhA48YJltfuKwt88mJA8cK1O3m3/yfdkNMdO+2UcH8SSsv3ZTb/jGr/ShlzaaO2B6JOW
         sGV2KkaUxHhNMHuH+RLADF5G7/nVbwOTb9KzcNR10iinYc5CjhexozO2GXZYs8O48xQ3
         2VwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ve9VpStEjcoDwid1pYw7xaG7QNiZLHD4uLfySjkshrQ=;
        fh=ZeuEFUvMW7nGHrCqfiPuyWcBybt0P3RJgcddBkt92eI=;
        b=gxnygc/i5NU6oER5sxv+zvY3OosQThbhr6TlJU/NxXHZHRf2VM7v4shg6UJLykbS9o
         JxHLPYwab0RnjZMDBRhk6mUjHK8u0AmtTTbjBORDaICtSJdIabWR/MSHr5wNROuRc2+6
         GnB4fBZY08LnVM4ty+Z9V1EciUaTbP2R/PAT6m3TLzhN+1KZ/33Wo9jy+D+/5XhIfjG+
         NYoRR/8pTaGl/uyZAcQ4aG7SPAWkWw4WlJ9q3R/xc+fqfUHaM88BQIClxgzKoBNyfwdt
         NVDkdC8GzBB6u7zRmTiXdlVprttvGlRD27RNJX+zh2MQt+OKn1E2qiof6dri+fYem+ap
         moUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776882954; x=1777487754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve9VpStEjcoDwid1pYw7xaG7QNiZLHD4uLfySjkshrQ=;
        b=WMugLuwyd7I5YnFXGPrYPdB/op84DgpbOvQD9EKPOOeR98DSEA8wd0pbRHv/3lj4RP
         uGN1/cKEhERotMDwQKBFn+VrKeXw6SJ+7OfonlSIPh0JPvJdErb15jjRXDB04hOWJCLb
         5BW/30MAf7uJEt+DS9d1ou8iTZt7j6agCNT0rLiSFW8OPKsi1w2Yqk9w/xIiFbLYQaCS
         eF3x+hES6jMQbXk9e4rzv31KkQ3P40E7HTfrXDWLWNKXh8Ag4QSz+AvI3Vpqdq7slmOZ
         K4v0x9P9pWdmKYYDIN8OvBqrJLDMyLaGp8zQZDT5AlymdOo6wmhmVhzh5G1gaYrkcRtE
         ylWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882954; x=1777487754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ve9VpStEjcoDwid1pYw7xaG7QNiZLHD4uLfySjkshrQ=;
        b=Lt9sW9Gs/IILX0r03UESqvKG5RiFq/rKQvx6wTHpmnjwqCbFka5bEwhMEf38sM/x7H
         0P2/dWxwNXAXltJ+4pAAxUOVyVkV/eWkIqy3wQzD3dM4kuvql+6eZVW6WGPZgwBaiFBg
         HbZHjj341v0/Oad+MHoYr5LyFfuX54PfmOhZPhUPvoonIpXTiosvO+sO9UAJfBF0FcZz
         lYfz2l6ltrLYpuI/k+nSv/6cTqeqffzRBiJduC85CsY8uT3QjgNtXB5dtVPNAhVua3ST
         x5DWMP4lA/8Nu+/al5ythsV9WV8pqwksulkEU8uura0uWf+FHjekYxDNKHmHqNfuzEFt
         JLsA==
X-Gm-Message-State: AOJu0YyEK4bvq+v5Ve6DJv+4ZT2eElg0lISeys8i4VFFhPS/lG5n2eUu
	BDcutDeIvbNQpwA6UCIrnP5z7c60AP+iu8spG+E8AODsOouWBHtAEMwLoFlEZk6JOXMHjOSSS5E
	iUISBwNlc9s4MqyGWjuQRjDfDABG0xig=
X-Gm-Gg: AeBDies4/iioA06MEwtG+NJ3TBU+lZ0GqCiA0n/9lm1vCVaC+QkVrxejQc1AdjtqBhA
	KgzCQj+6DDzmIfa7JATCYrpJcKkHsw836oGTVhZAUgJ9YKV8+DCPnfqYP9rgInPZxymgbPCvOdy
	BfY4uMEurFsQz0TMI3YRx/T7CheoPgcozg1DwF8nR+pvQ9uY4mxxWLlheHGccD21Zmy5tulfT+J
	oXQd+a9a4Aa3lurvYg7K4+RAAvbBE2sfWjdxRNXLPs5snQru0D9AHgMmBtk1UyeL1nGyEBLsBAY
	0eUnkhxDb6Qm195UPVAdBPj596auL3pVxoX1VogbAIOYc5qY7W57WGECiu7PQQ/5wwZrWexU2H6
	eteEDuyiMq+T9cCg=
X-Received: by 2002:a17:90b:2d8c:b0:35b:93d8:6aaa with SMTP id
 98e67ed59e1d1-3614048b3f5mr22353891a91.19.1776882953734; Wed, 22 Apr 2026
 11:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
In-Reply-To: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 22 Apr 2026 14:35:41 -0400
X-Gm-Features: AQROBzD7eHZydbVKRnTphe3vktnODp198xlCSordFZLS5KV1DAwFjwtV6yt3gRc
Message-ID: <CALnO6CDM3HGcJgKWAqVMRXw=HWbW+xA+FNwDMJwkuf8AoSmv1w@mail.gmail.com>
Subject: Re: [PATCH] generate-configlist: collapse depfile for older Ninja
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:17=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
> The tools/generate-configlist.sh script generates two files:
>   * config-list.h
>   * config-list.h.d
>
> The former is included by the source code and the latter defines on
> which files the former depends.
>
> The contents of `config-list.h.d` consists of two sections:
>
>     config-list.h: Documentation/config.adoc
>     config-list.h: Documentation/git-config.adoc
>     config-list.h: Documentation/config/add.adoc
>     config-list.h: Documentation/config/advice.adoc
>     config-list.h: Documentation/config/alias.adoc
>     config-list.h: Documentation/config/am.adoc
>     config-list.h: Documentation/config/apply.adoc
>     ...
>
> This first section actually defines on which individual files
> `config-list.h` depends and thus needs to be rebuild if one of those
> changes.
>
> And the second section contains content like:
>
>     Documentation/config.adoc:
>     Documentation/git-config.adoc:
>     Documentation/config/add.adoc:
>     Documentation/config/advice.adoc:
>     Documentation/config/alias.adoc:
>     Documentation/config/am.adoc:
>     Documentation/config/apply.adoc:
>     ...
>
> These rules exist to ensure Make won't fail with the following error if
> one of the .adoc files is renamed or removed:
>
>    make: *** No rule to make target 'Documentation/config.adoc', needed b=
y 'config-list.h'.
>
> With the no-op targets defined in `config-list.h.d`, Make knows there's
> no work to be done to generate these files, so it doesn't error out if
> it doesn't exist.
>
> For the Makefile build system this works great. And since
> ebeea3c471 (build: regenerate config-list.h when Documentation changes,
> 2026-02-24) this script is also called from the Meson build system.
> Nevertheless, on AlmaLinux 8 the following build failure is seen:
>
>     ninja: error: dependency cycle: config-list.h -> config-list.h
>
> This version of this distro uses Ninja 1.8.2 and it seems to have some
> issues with the format of the `config-list.h.d` file.
>
> Ninja versions before 1.10.0 do not reset the depfile parser state on
> newlines. This causes issues when the depfile has one dependency per
> line, like we have in `config-list.h.d`:
>
>     config-list.h: Documentation/config.adoc
>     config-list.h: Documentation/config/add.adoc
>
> The parser only recognizes the first "config-list.h:" as a target. On
> subsequent lines it is still in dependency-parsing mode, so the repeated
> output name is recorded as an input. This causes the error mentioned
> above.
>
> The bug in Ninja is fixed in 1.10, with commit
> ninja-build/ninja@1daa7470ab7e (depfile_parser: remove restriction on
> multiple outputs, 2019-11-20).

Fascinating. Thanks for finding and fixing. I did wish while embarking
on this endeavor to find more documentation of what these depfiles
should look like, so I'm not surprised to find some bugs in how they
are parsed.
