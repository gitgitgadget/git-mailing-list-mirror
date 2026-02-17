Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D372B25
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351188; cv=pass; b=OYv6n2V3dTJFJRFbtQ1VTOwZNLG5EM8Oi3+wdM3zybNooaggm05Se2RioeGHe6WnjVSbVjGnyDkTLHUxZDdGX9xf9QozS8BqOo1sU0fLBO9jsmqPgXQBm8BrX/1QGD97rTdPCkmDsgFoOyaX8N3zk0yutpIY++AB0QbqkfiUT6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351188; c=relaxed/simple;
	bh=TBw9gpubBnrdOwk80xvRYXy7c1L4mjzYitIofesM3cI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMrgwejkdOAVgodu6/npYYOi4jFc6yQ6/L3kGRgBzZrvprVMLpJk77VGsoh797jUO3TjLuTsoGgL1tsauaHgKS52scBLp1wCmXyoFEztY2IYyBDjfwTd1Q/P4m5znUhuR4Hj4fEsId6Dgi7HSNzAbz+TnKZuxyV9zJWGVgN9Sco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyv1O4Gc; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyv1O4Gc"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fdef6330bfso3230948137.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771351186; cv=none;
        d=google.com; s=arc-20240605;
        b=QZoXlQp+h0r0fBE8pWq0air1a7PrYPbCup3BKX6Mxe96wJas8TlCchHVI/M/9hOaBO
         KVsV84VKpfkZYvexrwQN3KyiQ6X0Elk3o0RF7+PXUfgMl3dWGHjWAhvGboj0416Itu92
         3VS/A26Js2Gjhiir7BuuY2arBm4AyPXmk+JVfFVTXWulhWkDtfjJpnWgOjchHUuK8OuO
         LyvbS5KFxARZWkjeSO0bTJUd91yK1FCKXh+jSLicSoEssqBKMIQRGhS2/5xfx7x53J9p
         Yd5G46WxJljyosusCfYWbl9TF8hAiLFZHH7iIyAuKpWgcenl+MRCz3cG6EaDB1u+jvIU
         VdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Fm6VJfebl31TmgWvOJ7EBR/aEj5JimQNETXYienZ184=;
        fh=HRezJflFKCl4Gpz3GPeQN2IKwKbEmLNfO6x+XAJSlYE=;
        b=cWEvOlbWNm1PvEuaAYrN/yUGjbI1k31hEuFMjhjcHnkSdcfGQhRGUb0WncUbhkeV6W
         BSpxXvmb0wS/VQs88h6UaWORRgggybQbjP2cIcgdrAiEKZaWyuiH73kvBMPtVNXdLGE9
         huh/49uYTbZV0Lr3Adkto15c9PeQYJr8pbQ6tYJKx05M4gmlzd72mwasL9Bl+cu7KBGa
         6LNWT2/D8phvpsC5UBP9FnLqAODKvFxGFk2oleaIhtAg32qv7GIvzVRfhW9IV3mtDBGE
         ilhcUoQZnbNk5/TMU4wQHKT6ZGn20UPgze+PBNAKWvWcYu4Srdp+E1FkHygvz6urQ4wm
         FiNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771351186; x=1771955986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm6VJfebl31TmgWvOJ7EBR/aEj5JimQNETXYienZ184=;
        b=Zyv1O4GcDiOSjbIR6lfDIGqm78yLQCBjcqXA+XoQWgLQqENYoysWGqfOaGCNtY5W51
         8w8Tt+uL0GA98Ra5ZwhJL9gEVMtbz4cze9dCTcUJSEtcxvKmOfBx1fiPd9COAUcOEwol
         G+UbfcVl+Lwgj35aztoicgXZbFctaRheE7C+r0ZTwrw1N3wpkIdXAtbkYyYf2mSlhnRx
         264S2jCjcTF0pSkUIqB4KWwjXdTQi55PUtkq84oiciqtfbyzD0ZpQCtQNJWjkbbdpFfj
         ciqARdv6cnMIrAfwrPEHszh6eA0kNa0JtCot5bqmcTvm3XILBVIHG3pArIAtDsz9H3Yb
         1eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771351186; x=1771955986;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fm6VJfebl31TmgWvOJ7EBR/aEj5JimQNETXYienZ184=;
        b=rBOnss8BLdjEbUeyGcbATLQ+cGWHyb3VCKKZMys5V+BxY/LchVBbgta7+NOhyMj+yx
         n09dLTxCb/HHtrKePSJiORDukMMiIAcoootBpucKpVQpDZ4eML6fIHAKXqhOrT5sFnUk
         equ7AH0Yflg1iqcAiI+vbxWToOyN+s2yazjIAmePIdRw/MDZ8cl0jZbzvjpqJ4D5mtpL
         1Lg8GgrLtdBcqboaW2+pGFX07pNGpYVIw/b/062GS0L34yQfM7lr0v+yDoWbxohJpJQS
         D+c+4ErkoaCIoPPCk1IwT8x36WoCQklg7ZCBIJtoKMC+mP8K3Rf/c8p6+BZPZSuAPmvf
         7STg==
X-Forwarded-Encrypted: i=1; AJvYcCUEG022U7JAnxaK8JJ/sH2WfcnHhWDX6B+aDznkGBy8fE/eWMJcGMiA28XEdvcNotpQZQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylF30PkABavjco/B0AeCX/sLa00MTE+WhVLBljTBOvURdibtJs
	fLj5uHVJ/utWWzd3ua1ZdZFkhDqOjo409H7Es+leIvRktLCeU5TB5axfT2bWjQ503/HGey1iBxE
	n91O50bWAFsRdoucZHEix/+JAy7pSfm8=
X-Gm-Gg: AZuq6aJTmMRbTZ1CO9GXjPYkzUUMDTfh/ULpxWiGzfuKQ5/ywi2Wahy++RnSL9zwBq+
	EYx3H8EDku+YqIA8fMf5DhvIPCKEZXbn0ZLX4dUyLakEsBDmHxzSBX1BBzTjJrQGhnrNuP42rZa
	QyfEqwKF9f/LUFt0Aj3cglR9dbFTpRVxQdDiEEIRiIc6yJG/XGv5uZ7VBs7ufDziLeNtbCWNNLd
	gSNLiNGKT9qWjqLXST4KqTfFGO6tq75unz6g+TkOcAlMZhcCd4OE5Krl9F3O1Qe8aFi7+36pQwV
	Xs0QEowilGUVXY5IDCqGB2/ZP3YVU/9C3J02hvoApA==
X-Received: by 2002:a05:6102:41a8:b0:5ef:49d0:5862 with SMTP id
 ada2fe7eead31-5fe2afbd304mr5163854137.34.1771351185730; Tue, 17 Feb 2026
 09:59:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 09:59:44 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 09:59:44 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260217084124.150366-1-a3205153416@gmail.com>
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com> <20260217084124.150366-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 09:59:44 -0800
X-Gm-Features: AaiRm519oZzgJ620vSGXSzyzQSyNKdJM0yM3aJt5Q-U7XEW4okFuAyIiBVnUFGE
Message-ID: <CAOLa=ZR=2B7yH+vtyiAPcCyU17yd2GZwonaj=JRo1f+LzSCoTg@mail.gmail.com>
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000032cadc064b08d640"

--00000000000032cadc064b08d640
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> Strictly enforcing 'lstat()' and 'S_ISREG()' on '.git' prevents valid
> workflows where '.git' is a symbolic link pointing to a real git
> directory (e.g. created via 'ln -s').
>
> Refactor 'setup_git_directory_gently_1()' to use 'stat()' instead of
> 'lstat()'. This allows the filesystem to automatically resolve symbolic
> links.
>
> To ensure safety and correctness, the logic flow is updated to:
>
> 1. Ignore 'ENOENT' (file missing).
> 2. Check 'IS_A_DIR' cases via 'is_git_directory()'.
> 3. Explicitly reject 'NOT_A_FILE' cases (FIFOs or sockets).
>
> Add a new test script t/t0009-setup-security.sh which verifies:
>
> - Valid .git symlinks to real directories are accepted.
> - .git as a named pipe (FIFO) is rejected.
> - .git as a symlink to a named pipe is rejected.
> - .git with garbage content is rejected.
> - Empty .git directories are ignored.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c                   | 39 ++++++++++++++-------
>  setup.h                   |  2 ++
>  t/t0009-setup-security.sh | 72 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 12 deletions(-)
>  create mode 100755 t/t0009-setup-security.sh
>

I also missed this in my review, but the test needs to be added to
'meson.build', without which meson would fail. This is caught by our CI
too, if you run the CI on GitLab/GitHub you should see the issue.

Karthik

--00000000000032cadc064b08d640
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7dafd69d8f3324b6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVXJJOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWNhQy85SFFTRUJNL2hoQkJIeTRqbTk0RlVQTVptSAo3RHZHV08rVDBv
K0RZd0NJN2YvdTV4OFA0OEpPKzc5RE5PN2NCc3o0YWJJRTdtWURNaXA5UXJNN09rdnA4eUpCCklI
LzFmajRoNWh5SmlmVmRNRTlleVpIZnVQOFN3U01sUFRLaXI1c2RxNGtqN2t2M2dpcll1YVN0eFMr
UEJvam0KcFVjaVVWa0lkaTVkV2FabkMrZUltSkMrQlBaQ0lBUkRHK3diTVJxbVFxTDdVSEtNUlVI
aksyM2oyTjRUcjFDNwpSSkJyS0I1MkVlLzhrR2ZGR21Ec2ZQRDZaOGRLSEs5MXFWT04rQnY3ZEtp
K1JVWDBBYUwxTS9kemY2cXFEdTdqCjE5a0l3K3Jrd3d4M1piV2NCNWM3aFpuc3VGTWIrNDVIZkk1
VDZCQW1tdm01Y2drQWFBRE9pZjM0bXZUdFB3ZTIKYzNKaUdoejBTUllHQ1NDZllzaTlEY2ttNUdR
M291YzhaZTRDZmMrREcwL1ZKNnBpZnYxQUIzR2RybE5JZkd3WgoxT0Z5UnNIUmlkQTVranJUQmpz
dUJzbjFpaEM1UWFYd3BZOENzUXc1L3V1T29lUVBPbnRHZWUwM1NWNFpZd1g5CmozS0NxTW85c1lX
L0tTemV1c0ZjMWhzVmtRK216Sm81K1RTZ0RRUT0KPW9tdUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000032cadc064b08d640--
