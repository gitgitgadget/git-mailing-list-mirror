Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D5147C94
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126573; cv=none; b=PtStBDx5uJtIRbJy4decEVHCDhLx2BCyr0jKCykFm0tctBPvNNaSx+pivV9/9kD6kckNwjW9AyzNDJhh7rwBNpVcb3Gz//DcT3ExbIJGoSsk3blw/qTMDOsdnvNePu9WcIuEz8QzA2/eI/n2//IU0Rp8EbzjBRR3NczmoQoRf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126573; c=relaxed/simple;
	bh=4CMD4v+c/uhljvQM1V/wfMoiEC1toFRscj86G9OXR8s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=SLPj3kN6Lybjh9x5aE+NgoJ2taijtw6dE51u4WeRp3/s1m4WWMVRKtFeiVTocxS4yxkLg1zH2n+zHvNB0IiCeL22iVuIuFQzBXzD9MJxln30UDy7140yb30XJs3Bl8BTKqPSTyj2m2dMF47ZtIE5sF6hEj/jciyL4w855ox6FhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxXvREwE; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxXvREwE"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-234db9dde9bso945909fac.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714126571; x=1714731371; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CMD4v+c/uhljvQM1V/wfMoiEC1toFRscj86G9OXR8s=;
        b=fxXvREwECl+tLLgcfce5T/Gk9o2Xh+hGMoawAh4V0AeHg3eYNqLP5kNmLbkgI0yhJh
         Q+3PYheLZgV9NZi3nL5BH3Z4y3w26aEoWfj5Af5VIAwohNc7D/KfWUm7dICHkjd1lq1R
         N02D68FVkG6AcVEvl+CSDf54+6urcgjtoEicpzX3JRQuSIxr+9Hdti2k5HYZdxiXcygv
         mtfHIZR3vNWVIqcFdvc9NzSsiYyMycBNCxUHtHpoaK/KS1WWriF13Po5P02T7ov1soT5
         /8EOOk8y5eX36azJWiWRwMHQGEo0+9CMZvxLfounCwmGlTJVhiL4xs4MTkWmWYYonDDz
         8QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126571; x=1714731371;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CMD4v+c/uhljvQM1V/wfMoiEC1toFRscj86G9OXR8s=;
        b=btEoH0YVEdGeVqgpvXgic163w4rtPwbxjmMjlxXin7t8TDts4l0oDHiA8NRekn3zNx
         4LLRgOKKESduimlSfXzmGOF2WtFMdDX4pKikpo/RR1DBcHkhQcGN0dmf4UwSxMz10XoJ
         zQuQ7rhCHo6AjjqSNMqCbxf9VDC2LuhHd7YP8IrhPBwBB8gyLuPeDIYyyAkwDF2qSys6
         4k1fog6y4wKF5XAlMgtl8BLphZ/JnzC29QP5dMJhOeELV1JGsZUIsKKJmv1Lggi9uYcz
         ZzBoAOknMsYDIiZd0KtKwsXDG3RYcFYizUEiobzh9u58XVJNkIclfF0gVQuwRY2ybnNg
         vyZA==
X-Forwarded-Encrypted: i=1; AJvYcCWtCCp9d9eGuVop65dP1wNPkyyhpWpJV7u04aisHMTY3iielUsKKgbWXQ8JLKshS3Lq2Nw2oUAsYZYh8MSE5mU5y82P
X-Gm-Message-State: AOJu0Yy1JvNXLEzFLOcMeX22TIJsFI2xc7SuSqwlTbMrXkNTZvL5oEHo
	EtyqVZkEbzn+EJna97a8r+yS8847KEWC6nu5gOo8y8SS+6mOKaR61YCi12GnMBVUpxBrStnZcIy
	08a36H8P3BBdkTO6CZuphC48u+YE=
X-Google-Smtp-Source: AGHT+IEA0sAAdcvsKGr06R153inwUEYfJC3D0qT74KMED0TENwTU/MPI50CvmsQjKLwktsJYSAgTeAik/25FOPaOvFg=
X-Received: by 2002:a05:6870:f29a:b0:22e:bcfd:debc with SMTP id
 u26-20020a056870f29a00b0022ebcfddebcmr2786606oap.13.1714126571026; Fri, 26
 Apr 2024 03:16:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Apr 2024 10:16:10 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <000901da972c$61efc670$25cf5350$@gmail.com>
References: <000901da972c$61efc670$25cf5350$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Apr 2024 10:16:10 +0000
Message-ID: <CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com>
Subject: Re: Use of Git with local folders
To: Felipe Bustamante <fisadmaster@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005ddf920616fd3104"

--0000000000005ddf920616fd3104
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Felipe,

"Felipe Bustamante" <fisadmaster@gmail.com> writes:
> Hi,
>
> I would like to know if it is possible to combine the contents of several=
 directories with copies of the same source code but with different changes=
?
>
> The stage is:
> 1. There is a directory with the original source code, without changes.
> 2. There are several directories, ordered by the date of creation, which =
are a copy of the original source code, copies made every day after generat=
ing changes, that is, the original source code resides in the DIR1 director=
y, a copy is made with name dir2, and changes are made to the source code o=
f the project. The next day, a copy of the directory of name DIR2 is made a=
nd renamed DIR3, we work with this directory making changes to the source c=
ode. The same process is carried out for two weeks.
>
> The important question would be, is it possible to combine these director=
ies in a repository with a Master branch (the first original directory (DIR=
1) and transform the other directory into branches of the master?
>
> It would be useful, if copies were made that were made on an original dir=
ectory (dir1) that was already becoming a git repository, with the use of V=
isual Studio 2022?
>
> As an observation, the work is done on an isolated computer, without inte=
rnet connection or to backup devices, the computer is fully isolated and it=
 is necessary to generate the version control, in the case that it is possi=
ble.
>
> Any orientation in this regard would be very useful.
>
> Thanks,
>
> Felipe Bustamante
> Sverige
>

I'm not sure I fully grasp the problem, especially around why these
copies are made in such a way.

But, have you looked at 'git-worktree'? This would allow you to do
something like

$ cd dir1
$ git worktree add -b branch2 ../dir2

Once done with dir2, you can remove the worktree

$ git worktree remove ../dir2

But the branch ('branch2') would still remain and you can merge the
branch as needed.

I hope that helps

- Karthik

--0000000000005ddf920616fd3104
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 879bf315ce04fc74_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZcmZ1Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFN1Qy80MFJWTkZ0NFl5T3VHSFpQR0dzTmFXcUpHcgpqcXh6N0hXbVd4
dXlRclRzNlVGMEU1NEhtR1BLUkp6cklWL3E4NEpSSnF5ZUNLVkVGQXhTcVRRQXlYcXU1aytaCjNR
N2Y5VlBUcS9URFVuS3VZc0RYS3lPU1R1NTBzbm1JKzdlRXZaVnJPNk5XUlBJdWdCakRtYjN0YndK
QnVSbWIKNzluYkluRE1nQy9PcTg5VnRWMGFNR2N2UlNsU3RJb2FKTm1TS01ZOXZhaVdwNGF3NWNG
ZWxVQXZ4UmRFTjhzMgpEM1A5WlJrUnlXc3hqT0NwTzRTUFJ0cVExY09Sbkp4d2d4ZmtGeFZxQllV
LzYxbXovOXk2clNQYkhHNmRpWHR4CkRTOGk3a0hza1ZuY3B0VnJRR0g5U3BmSTVQcHhIMkVKdlFw
alEzUC80aklKZWJWajFLVERhVC91bFVPKytPdlIKekJubDZFL0VxcGl3d2d2c0p4dllwdFYvQmk5
VUJYOE5ZT1pkQm1wUk9DdHIvNGptNFJCdVNjVStYN1N0YnlCUApnTGNDNnhtaUZRSWlyUFJUcUJz
elRUdFlJSFFCK3ZGNU5adGlCQ0QzeHJlNERjVGxHTjZneVdJVkszTUVvOEZjClI3UFBzWTZMVHBo
dCtEZ2pZdEZuYmtaTzRicGhPNlluN1A4YUFvaz0KPUR1QWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005ddf920616fd3104--
