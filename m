Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FD296BB8
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256960; cv=pass; b=dPwkHsNWgkfNq1Pm/Zmp+RUlUySBA4N0epdzvUBTPNcF7adKOay+qqjblocsT/dGaMxAmKPznIaqDk0prIRe3bxdQvBS3bPFIiGFMb3cPZWcf3H2QF2M4E6wjWEIKCv4tda2mnmOQgAIq+tSC4MR/G7i3WLABfCofDiM6atukO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256960; c=relaxed/simple;
	bh=2YP9kvJYn/sTqJOspAiBeFdCksWNrTnWxwJlw1Z2JB0=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA14Sfa3S7KASx7718xBoCJnPNW6qQLp4GquRhUzan3JvEuQzAedHguTZIm8lqywiPJcM98U9oXsprI4Ht0cVArMSVgPGJgIv76AfB+S2oYzQlgmp4HwDjgW8TKNDJ3uh2loFgwKe6YuEWP8o0lkLS7OWt0ahnfxExmb0ZfGobc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com; spf=none smtp.mailfrom=sph3r3.com; dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b=F7GTNR8t; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sph3r3.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sph3r3-com.20251104.gappssmtp.com header.i=@sph3r3-com.20251104.gappssmtp.com header.b="F7GTNR8t"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9142e83204aso4284606d6.1
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 20:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791256957; cv=none;
        d=google.com; s=arc-20260327;
        b=Ok8xqqN6hXMKyJchQ6EVHFLMPacJt2chfasgLJHCZd1+bsZHucJubs2Ma722F5o3M6
         u/OQuKSmN8mwvSwkBthmccDVtNQ+a63GevuQVp0NSc2w7TlxHtzLsvaqnlULRC4hAN2Q
         PulozgSmV8XEPNPRw1HFxB73ofDOam4BeEy7g00VkexH4eyCz1lzdFmZwrPy7kYzY0UM
         bCjN+cJlOR5ZTtmVvtQelrdIhn/qBubFLywlOGQ7HPkiqoSo8Wef37ZqLHgtsIaysJBY
         mEoD5G3KnRNbjvSksSUcALQ/wjz03aTbDZoI32IGp7EIxEt/xm/b0kZRgunzr62sHcCP
         UsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=zboVP/l0brJfRc41EASAH4BTesT2EDJBChCuGJMRCw8=;
        fh=71a8gNWjjH3jDnCK3/PRHZEeOlOeFkLaM81Nc2bGo4I=;
        b=IC0XG/WX0/NcuRUPO5xSYESFAEOpldP+xYXtD79DCCEDlfzRnDtVoM/vs1u+0IrX72
         ObbfS80c/gEYyj1B+FP2JVVbWQYB8hwQichsFLcN+QB3dedq7l71IxOmpXTE5bgUpZEd
         LwIw5STio52K7kxPa7RM8mg+0KzEJLXMmDCZ2OUiD3s1k9g4SC3jLsHUmw7RjaVA8/nV
         5r35pDt3T5Ic8hPCMCBa+z2m7zYkmqVj2NrPxcBdK4ZelGLSH2mhVJy3F6Pu9i732dDj
         u65rDoanCMymti1WKPJ7hNISQ2+Vswc8hLWM/+VhfO0mLKMhg+YkvTUHcrd9ThsoXib5
         cwQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sph3r3-com.20251104.gappssmtp.com; s=20251104; t=1791256957; x=1791861757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zboVP/l0brJfRc41EASAH4BTesT2EDJBChCuGJMRCw8=;
        b=F7GTNR8t/lLUGnXxvkxZihsea3Z7dVfHxUVMEPLh1qsDsmiW4MnF8wH9mnNzY5Yd0J
         hGgJKEA44K3qU27xyjLN/O5c6PX7AQpkCB3mRTO1g8qCXCUnjsX9uSextiJITk3EyEW/
         fcZTvrsr2cqYz7V3rF8d9Y3A1p/hj5e1ujqAN353AeLjTNwvlDncPRFRdAjFBYCEjT+P
         Ow5trZcgeo4RwNS+XG8Va37ZIHcuAZQu+lx5XjJ/Upcu4XoOqHNqubpJSycErTv6Z+e9
         IAyYNTg4XY+HSRP6hl0lSLgV+f8RcJ/8nG5Cg4NOTMx+qYyq7v0IcxGbUcjfe7WNAMkC
         qvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256957; x=1791861757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zboVP/l0brJfRc41EASAH4BTesT2EDJBChCuGJMRCw8=;
        b=ugAW3lgicJZJbCQz/Xr9QbHFZKeqebCRrvwlmb8OYSgTe/poHAY6HPUQvFuYlMAdSb
         L0KGIlcbkjqIXk68tw1wDTECGyDrg6FhSzy2LNyj8s5wxs57ncGntuzITHqI1uz6betH
         QJ4o7M+t55Wz8iqIxfczUkCRQpavo2y0vrprjE8hfeWFveXYPr6rVOx2rY/KfAR+wD95
         LxZ7CnETTvaMoR5Ath1dHherc7ELz13HemKIs6AVBfk0mYJSkMBTa7vOp1kBjo8+3Ugd
         Ib3/rt9x3DRLnYBVjpOJdnFor4sgt3u1rA9ukos9KryQwfmrGAqUL5Dv3zezKlzz6l/h
         bdUw==
X-Gm-Message-State: AFq9FYI8igv8fBN6HMsMcf5mMnw8CYjkzmt6U/hPZBxVEOSA/7JrNUOr
	Ovl9bVAARJGT6DplgVXgoGpkkxRR51ChdBNfHLDOxxjLWru2cctUEOS8rOJ+WGrJmpHm4zydiUR
	KARnhpCIQZEPOq3c8/2gNEgMrkHxK+rQAcyestNei4PYNtv4l4Cry
X-Gm-Gg: AYBFou1wbfpZCTEHNE0D0gqBQ4QRIa/KR1ykYnLL25ClBFnsUTKh3xHEwXSGQbrf7YK
	c2/v6saZcVaETgou3qSDx4jWuUpgMzM/gNNY9JPAngdZtUX1h9x0rkazhVl5xav05+AngHa3iUZ
	ozUsefu65e+fYxGHn90iX4CdR7SLgyEcoEaNCVVe7dBu2rklYU/6tQsG1b5qyRN6Dpc5fZElJcV
	zXqx9B8Gdkjaxf720zzXP9enY3i84SkBoAhXDbbDCSX95M/xzErukDPkI9UXYsXKzkedx7WLq3A
	mZfIb63J5HRi1cGU1pr0Oo+MkrJsoe0Zwty+ShK/yQbrRjHB8aDtM/PwXe9Ri74ah3syzqnLQWt
	N6yfITtxJzKdSaNMfTkuQiqinerA9h8nTwf86039JQO6jC1GbU8UIMVawUib+S53fVg6mHMKFDI
	ofFRESCsFUd50KxnaliyWMftLslhw5t9ymnKzE4kbQczjkZA==
X-Received: by 2002:a05:6214:440f:b0:917:ad01:d2ec with SMTP id
 6a1803df08f44-9198580ee81mr28269466d6.9.1791256957506; Mon, 05 Oct 2026
 20:22:37 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 23:22:36 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 23:22:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: m@sph3r3.com
In-Reply-To: <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
Date: Mon, 5 Oct 2026 23:22:36 -0400
X-Gm-Features: AclHuK8kkK_Ci8XwH5p6GRI591I9u-dwVFQWGSVwj6LOYXSt632tDyx_csqLsu4
Message-ID: <CA+h9NxSzuNNQZ0pKKso9Y8BkXKZYgrGFLL050Pi3O7PC_gi65g@mail.gmail.com>
Subject: Re: [BUG] ZIP timestamp conversion and strict fast-import date validation
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

Thanks for the explanation. Python 3.14.7=E2=80=99s ZipInfo.date_time is on=
e
example: it reads the DOS date as 2100 for the 1972 archive, even
though the correct Unix timestamp is present. This affects metadata
reading; the tested UnZip and bsdtar restored 1972 correctly.

The 2106 case is separate: the Unix timestamp wraps to 1970, causing
UnZip update mode to retain different existing 2025 content. The 2038
control replaced that content as expected.

Best,
Matthew

On Mon, 05 Oct 2026 21:49:33 +0200, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> On 10/5/26 3:48 PM, Matthew E. Luallen wrote:
> > Hello Git community,
> >
> > I'm reporting three date-handling bugs reproduced on Apple Git 2.50.1
> > and upstream Git 2.56.0:
> >
> > 1. Exporting a 1972-dated commit with git archive --format=3Dzip produc=
es
> >    a legacy DOS date interpreted as 2100, while the extended Unix
> >    timestamp retains 1972.
>
> DOS timestamps can express years starting from 1980.  Unix timestamps
> start at 1970.  We can't provide a DOS timestamp for 1972, but can we do
> better?  zip(1) clamps DOS timestamps to zero =3D the DOS epoch =3D
> 1980-01-01 00:00:00.
>
> Is anything using the DOS timestamp even though a Unix timestamp is
> present?
>
> > 2. Exporting a commit at epoch 4294967296 (2106-02-07 06:28:16 UTC)
> >    wraps ZIP's four-byte extended timestamp to zero (1970). Exporting
> >    the same commit as TAR preserves the original value.
>
> tar's timestamp can range from 1970 to 2242 with standard headers and
> beyond indefinitely with extended headers.
>
> We cannot put a higher value than 4294967295 into the four-byte field
> provided by the Unix time extension for ZIP, but we could clamp to that
> value.  zip(1) wraps around as well, though..
>
> (I'm using "Zip 3.0 (July 5th 2008), by Info-ZIP, with modifications by
> Apple Inc.")
>
> > 3. git fast-import --date-format=3Draw accepts -32184000 +0000, but
> >    git fsck --strict then reports badDate and ISO rendering returns
> >    literal placeholders. This occurs in strict raw mode, not just
> >    the deliberately permissive import mode.
>
> Well, raw mode passes on the timestamp value with only little checks.
> strtoul(3) used in builtin/fast-import.c::validate_raw_date() happily
> accepts negative numbers.  The latter function contains two NEEDSWORK
> comments about perhaps adding more checks, though.
>
> Ren=C3=A9
