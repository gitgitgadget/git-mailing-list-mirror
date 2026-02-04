Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DF3D3484
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199214; cv=pass; b=Lyvw7GL45hsOSUEpuPR5ijBODmrkczT6Au2lpMDc744WdWF7VWVCDwfFJwUY+e0tnIV/ANRL1Y41i0r9+nn8i/mAWJlu1hJlIvr2yphTdi6vBX68fuLVQK42VFgmEyOVlOUmopDOLr14apPrK+66RLsXnHkvrAmGIAnJC31B/uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199214; c=relaxed/simple;
	bh=Wf6SxbRirIHCUWLtECg7q3hoTDaTGrUKcdhhabMNskY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mj/vARoAbm+sin8wHIsRaI6rFPXrg7Ha70wf7e5p3d2Pa6vmrHcJVuu64A3msanoyw2YGNCUuYIAJF4XftbIwN6D+sAj1eGJzNKQqu0/JF4j9fP7/ZgiQys6FAzWT87F8kKmJ3sO1c5nhjzpSofPWlEX0OeSNOOjebRo6S34nFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCATTo3B; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCATTo3B"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-948e5592c9eso128466241.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770199213; cv=none;
        d=google.com; s=arc-20240605;
        b=VBlIW1PqpOzl4Ko3fd0R2F+ScDn4wA61KXBG1B8k1AS1PWu/5c4UsEaivyev4h4BYM
         doRuBS2urJh8X8s/4fHJ2Ei7OftEKJ6n0ayE2LoDmG+wRzOV8sBRX/1nH4zio10+H+87
         nhIAv0nh+ULZ/fAnvVqjK5vW0/DETSf/ne27EtCMTjPQz6PTKd53Pp5mAJH7czFaMMVS
         CbIphFj+wWWdJAnRA3b++bYNudjujYjiYS6OHtik3KbsFJ5JHRNXqXHdyo09LQtp0mkG
         iMaPewOSTLq9SB8STmjlS+dicu+TmZFBi7yGFzr4AokjVjPSXUMlz36khX02PQZZq9cr
         ygLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Nhj/EFewWd1MlqTaMFnvv0LO4lr0pjL6GBBJk6gymlY=;
        fh=ooS2oOP9DpuXU3orM8keOuya/9MiaSFBv0ZoAsvAAzQ=;
        b=K8cFcfkdjSvlMOhPFNlNqX19DMsbzT3/eQF0tdarr1FI1Eigk+tSU2rYK+ZVf9Qx8P
         yagKqO+DxkhzvrM0cvLoAlPyzE8md/ejAzJLXDWKsj83yC0/oKzdpKBFfmWONoIinVsl
         fetEGAu4mmW7qS768wvleI2N1gVHhjSiK8S7qEzJps6j47pteob+DW6wj5TFuR8jv9Ss
         KHTiaAtOpBsEPwfxmCZA20Bk0BsGK9cF0PhV+K6CnPBiO6Hjpt6KuzozUfNz9Do12ZDA
         pLO8ETT9yJrZIf/vsdZ2ArlszCvmOyXyyg3YXzCUjdydMSyoVadjT8E8Oj3Uk07AgQSJ
         ulPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770199213; x=1770804013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhj/EFewWd1MlqTaMFnvv0LO4lr0pjL6GBBJk6gymlY=;
        b=gCATTo3BHU/NpsMl4yh+UBo9hRbF3UcQfS5AchkDZDwrHIvJsx1Za458teWeTknhPs
         BqS2aHCcZ/pjX33zakdlWrdU9GoB/3WKyCp/RbyNBbd6S8swuXX3MlfMYGr4BFhwtq/S
         1iKaS3D3qMFcuqUvH9q3Y3tiPsSSX+SnzCztw11azZvMuGGkmJAi6v7x/HyzIBo2+Azj
         S8EysDKbxUAeESFE3mpK5hBI65jGuRUnF3IHGjIkvJNYAIrjnwq44x5+TxZtfuhbRFtV
         s/02gAvX2N221KodyjpwN8H44U1+5/jUqxiK5dTDBezgcaUehO3DJT9d8ch4Ib9BhHQM
         4a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199213; x=1770804013;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nhj/EFewWd1MlqTaMFnvv0LO4lr0pjL6GBBJk6gymlY=;
        b=ViMR+5pUPSuxtXfxgLYZ0Jck8pbMHkxrRAkSnLro6BWSnpbWrrCGF0HWey3exaUUDm
         jFNGXsjmgHWDPN1cVgF7P5wNlwG2DaeCPaeGWfqmTGawS9YHnrHJTMGLnI02I6YXrU+T
         qnSG+3Pxy0/ghZEq1Fg1GhaKnTtAEgv4qgFGAdltAOv/m/LcvU1gPPrDRgd/rvEqJaz0
         ISecV1pZ07sSYFRgo67QPwgdPOBV15+kBSpvuS8Iw6zUvpDDse6XlYkXpdVBPjqlPDxB
         y31Dg+em3AUhTOzNvLOdQIt8RwddvcjLAluZD/J2RYnnABBGRgTWA2BmKADJ5bKvdBAT
         yDUg==
X-Forwarded-Encrypted: i=1; AJvYcCWjJUFV1gwVcdY6Al2Ey4a/gxfgIDVDzTDdyIrGLj45/5rHlShU/OXJ+xEV5soH3tb8ZBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy411FitL+6vU1WSJ0uHIZYlbsKW7xQprfzjj015SlCyLziorA
	rd0B9mDCEF7bHHyS76SVPQKMn52qk9nndDC8EM5MupJ5cdJh5yziS4hme2z+jL4t4osANkTMt4P
	qqEB04UaFMHmhffrNAxHvDNVdlJaHsVhSfQu4
X-Gm-Gg: AZuq6aKtBjOHiIbrbIuYf55ifBcSiava1KDomPV0Kh60XLtUWwnqwstNZAEOwS8ma9K
	ffKZFTO3Sa0yMtwrUORKAfSbML3DMbIFgu0Z0O8IfImtAAGyMa/8wsfvIKZJE/RpkBvFZ34wU9r
	nrpk4kex+UT/k1Wz24JW8dXEaywixN4L8CQS3Df3RNLt1QkGQnqMSyJh2wf0eEY7LNy6/ygCOve
	DmnRRNNw/mm1w/uWlqLfya1J5MRciPfwXBvM0784eKkts3TbOaAZKa37Sj9PUAP5lo2mHbF/JHR
	SdRsXWq2JOx9x0Jog5dX9738Zm8PEw==
X-Received: by 2002:a05:6102:3909:b0:5f9:36d1:7dc with SMTP id
 ada2fe7eead31-5f936d10cabmr1278130137.4.1770199212633; Wed, 04 Feb 2026
 02:00:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 05:00:11 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 05:00:11 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im> <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Feb 2026 05:00:11 -0500
X-Gm-Features: AZwV_QgMWYfmgPjW1L6cqecews8Is31mT9v0GwZPckqrTyD3RxafiTiPKhIGHeA
Message-ID: <CAOLa=ZSeyKJD07xHKezQzry6KuwNnB=DzwE81Sx0A+b2u41rjA@mail.gmail.com>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Content-Type: multipart/mixed; boundary="000000000000405f4b0649fc9fb7"

--000000000000405f4b0649fc9fb7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Wire up both gitk and git-gui in Meson as subprojects. These two
> programs should be the last missing pieces for feature compatibility
> with our Makefile for distributors.
>
> Note that Meson expects subprojects to live in the "subprojects/"
> directory. Create symlinks to fulfill this requirement.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> This small patch series wires up support in Git.
>
> Changes in v2:
>   - Use symlinks instead of moving both gitk and git-gui into the
>     "subprojects/" directory.
>   - Rebased on v2.53.0, as it's been a while since v1 :)
>   - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im
>
> Thanks!
>
> Patrick


So in the previous version, we moved these projects into 'subprojects/',
but we now use symlinks instead. Do you know if there is perhaps an
issue in Meson to support configurable subproject paths? If so, we could
eventually drop the symlink.

>
> [1]: https://github.com/j6t/gitk/pull/8
> [2]: https://github.com/j6t/git-gui/pull/9
> ---
>  meson.build         | 14 ++++++++++++++
>  meson_options.txt   |  4 ++++
>  subprojects/git-gui |  1 +
>  subprojects/gitk    |  1 +
>  4 files changed, 20 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index dd52efd1c8..e96953afec 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -239,7 +239,9 @@ git = find_program('git', dirs: program_path, native: true, required: false)
>  sed = find_program('sed', dirs: program_path, native: true)
>  shell = find_program('sh', dirs: program_path, native: true)
>  tar = find_program('tar', dirs: program_path, native: true)
> +tclsh = find_program('tclsh', required: get_option('git_gui'), native: false)
>  time = find_program('time', dirs: program_path, required: get_option('benchmarks'))
> +wish = find_program('wish', required: get_option('git_gui').enabled() or get_option('gitk').enabled(), native: false)
>
>  # Detect the target shell that is used by Git at runtime. Note that we prefer
>  # "/bin/sh" over a PATH-based lookup, which provides a working shell on most
> @@ -2250,6 +2252,16 @@ configure_file(
>    configuration: build_options_config,
>  )
>
> +gitk_option = get_option('gitk').disable_auto_if(not wish.found())
> +if gitk_option.allowed()
> +  subproject('gitk')
> +endif
> +
> +git_gui_option = get_option('git_gui').disable_auto_if(not tclsh.found() or not wish.found())
> +if git_gui_option.allowed()
> +  subproject('git-gui')
> +endif
> +

So gitk requires 'wish' to exist, whereas 'git_gui' also requires
'tclsh'. Looks good.

[snip]

--000000000000405f4b0649fc9fb7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 174832e4a0c86172_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tREdLa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memFVQy85c0VTb08vbWw5ei82Q1c0OWdGOEQvSzQwWApsbkFpbzlrRWs3
eG9SSndJLzNhTkZzVytVVENMUEwzcTRiVXZDSUhwY05pRU13SHFwb2xrVkltV1Y2d3VWV2Q1CmlY
a2g2ZVg2TU9CYjVJS3M5cTBnMTNyVy9kVE10TlE5MFJNVUdIcU54d0I4T0kwS3lQSWtiL1NERUxj
Vk0xYTMKcmpYSmdoQXZIQ3JySVhqL2VpZ0VtY3BQLzVCczV5WERUbi8xWE84RDl4LzhFUzBxcUNJ
a1ZCT2kzN0tzaENqNgpabi9ER1N4Z0o3RC9NVU9sRXpoWm5wT0tyOThNck85bE9IT1FkdVpLVEg1
enA1K1RnVGZpK1ZLTUVvVkpta3owCkovTm9mYmFqVlArUWNjcnMvRjRjemxkVXZUanFvMjBJa0ZX
NjhPd1FoaFJNQlNhTlNqRktSeHZPTHc0RXJqR3YKVFNsY2lHcTl2NXFxeVQvUkN3N0hOMVN6WlQy
VFNzU00xRWVQOE9MeWh4Q2pwR2pHL3dRS2dPYjdJU1JhdWU0VworNDkwRDhRakNub2c2Q3l4bkZI
dVJDem5VU09FNTh4NUllL2xnSG5LSzZjTHJCSGVleHJBcTFId2ZsTnluclhxCkQ2VEoybXYyOEJv
eisySCtKbGFubHVSTS9xSyt6dWg0N3lVTjRWTT0KPUNudnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000405f4b0649fc9fb7--
