Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFB32ED4C
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718703; cv=none; b=VvuEydXrc2RQ2puR4ME0Xs6VZhddKtOk3NyqAsezlivOirZXy/FB1fs6OldGMUormfCDJ1+wVV+WuLEfiX5d+u8vWMSdK1QwbXCBEuC3LQTy7hGtu0fzB+l5C8I5GLGgWHSRAMo0O+mOfxvWXWpi/qJTcjP62CUVgIoKK/8okyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718703; c=relaxed/simple;
	bh=5MrMQUKvLsgrx3YIqwIRU0ueZonO286ye7OhI0heA1E=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OTHBjKnNp+Ra03AHkpeOov79BYj8wY1cYsgGw/R3k2zClY6/Lu37Z2xlFll56eI5TaNHM+jAlsx0kqfAjz/uOJsbxfSBL26QgYkboQ3WuHZEectWr/ZrkNSKS6O/yQzqoIueQ5ZlgEOc4djpkrdFabJPNHQrLXVxGI7mGZ55IdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHran2zu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHran2zu"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fba1a1b1eso253367b3.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767718700; x=1768323500; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mg7OcsXFB5kosV4u8vihUo2jkxi1D6T+ztXorI4GcCs=;
        b=GHran2zuElNlr+CoHsgwcEJjo83JtOLyTTALu9oehuYyP9OfkopWPsXFfXoimLg4Yd
         +ZebB9Jqu0Xhe7F0Rpra+aYZSBr3xlWpNFAbtDi5F8dIA1AlqmvqTjbF9+Schilh0Cd0
         mHR7uBADdCvjaOfOHZDoVf1xSW8ApJjsl+blb4ME3gDDdH7ypLKJHDPvLenW9r0RNQt7
         DAEwvSniQX2vwIs7Q+wt8274qR3If3fS0PJxAIkdoLoyxWGCnMyVEiWPSdkd0OVsewhq
         nMebFaapBRLgOHvpVPeIwdliYjiCchoOoX0prv0NNFBtbBUWGWOkXVt67u1BN0sTA0Ok
         iZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767718700; x=1768323500;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mg7OcsXFB5kosV4u8vihUo2jkxi1D6T+ztXorI4GcCs=;
        b=v4O4dq3Etr5dF0OWAb9M4JLOPv/pB7VsxoL3nOT8zpbj+yXcOXDrDnaapeZBFehkjF
         OBnfbWpcK2/NxG/MdN9BgaLGIrwhmBnLqj5mDkg/NDew55Z3w2Qv1X/HTtSDMryodNWj
         3wgGxK2rxA9zz49en8vPRvnffu5bOoe0aDZSnNg/0aMUVsOlAYCEGO3QQ2O6k0C++XXu
         7Orj1GNXzk5HhyjZA3Dc8SRK72AzPM3S9OV4ViYgqqwdqPiTpAGR/kz/h/819WTMz97V
         4lopMpTl6MHfl+Mp/YH/Giaf1uKs2Svg0WV5TxtMy3ihD85urhZ9i+Un0NSWHQrSfySg
         gzHQ==
X-Gm-Message-State: AOJu0YwFQYA02goiSVBc2BYTMt0FNDYgM8jK1M8IR5on46R7LB61efyF
	w8B37Or9/qTsd0TWe5/5T7obz2NmSC3SSVVV8RabxBFH8nBb64dusx0MVLAQ0A==
X-Gm-Gg: AY/fxX5fmgVO9nQt3xgn4i0Wr43/fGxqnPW4tw8JL9i7uu0s3fgkfLrU0Halt3GEysi
	h8AKXsmTQET2nwfXBJjz2+uzjVC+Z9QVOkH2cpDUCS9VZ5StLIaPKuDyqwXv7GB41NLJctPwND0
	6Tea/O+oY8RmSZX7xb3BITIF3vXMbGhSYegSivqAQPEWbEMPLjb/s0OGTwwx33Fw5MMo0fVMcao
	OetDQlgC4EWcmJofN7fnRchbpSx2y1T12u6Ca5T83JXrtz77IuhUN4VcNN/6fiw0qXtV6O9uBJ0
	EwMqvWgvAHQEyTQ6OqWdRw32Bq2AA0y5UJglpzaQ8lmKualsnWL9Niga3DwtivmUbJkIEUwPmNO
	M8YTrRscrWPqL9enr4OTsSbw/ygsA9BaVNRIytI7wvvQuFXoZoTdMSzP04BBbMTuIWnLrNLtiJw
	UTiu6+HOcIQX8f7F5xpFIW58c1Xny4sO/qtw3fRlR50orBG+J/+Q==
X-Google-Smtp-Source: AGHT+IFOFCa334XIlDQ5mkyJ+5qRF1as8Slrmm9OGc6qIBYw9QvQk0FpnfHt44qZWcXrruZZPJrEmQ==
X-Received: by 2002:a05:690c:5007:b0:787:fa8f:bec2 with SMTP id 00721157ae682-790a9630a99mr24130437b3.12.1767718700607;
        Tue, 06 Jan 2026 08:58:20 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:75f6:76cb:303b:9f73])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa5762f6sm9163437b3.15.2026.01.06.08.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 08:58:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Unexpected behavior in git diff --relative=<path>
Date: Tue, 6 Jan 2026 11:58:09 -0500
Message-Id: <8113ACE3-288F-46D5-949F-CEDF3D9D0E25@gmail.com>
References: <CAHLeu+ww7bBACO97ddkHeL2nkwmwqNL9G2Bjq18NZr5_d-MHyQ@mail.gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <CAHLeu+ww7bBACO97ddkHeL2nkwmwqNL9G2Bjq18NZr5_d-MHyQ@mail.gmail.com>
To: Harrison McCullough <mccullough.harrison@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 5 janv. 2026 =C3=A0 17:56, Harrison McCullough <mccullough.harrison@gma=
il.com> a =C3=A9crit :
>=20
> =EF=BB=BFWhat did you do before the bug happened? (Steps to reproduce your=
 issue)
>=20
> - Create a "foo.txt" file
> - Commit the "foo.txt"
> - Modify the "foo.txt" file
> - Create a "foo/bar.txt" file
> - Commit the "foo/bar.txt"
> - Modify the "foo/bar.txt" file
> - Run `git diff --name-only --relative=3Dfoo`
>=20
>=20
> What did you expect to happen? (Expected behavior)
>=20
> I would expect to only see modified files inside the "foo/" directory. For=

> example, I would expect this to be the output:
>=20
> ```
> $ git diff --name-only --relative=3Dfoo
> bar.txt
> ```
>=20
>=20
> What happened instead? (Actual behavior)
>=20
> Both the "foo/bar.txt" _and_ the "foo.txt" files were listed--but the "foo=
.txt"
> file had the "foo" prefix stripped, appearing as just ".txt".
>=20
> ```
> $ git diff --name-only --relative=3Dfoo
> .txt
> bar.txt
> ```

Easy to reproduce (with f or fo, too).

> What's different between what you expected and what actually happened?
>=20
> Using the `--relative=3D<path>` flag to `git diff` appears to simply remov=
e the
> prefix from each file, regardless of whether that is a full path prefix or=
 just
> part of the file name.
>=20
>=20
> Anything else you want to add:
>=20
> This is the relevant part of the man page for `git-diff`:
>=20
>> When run from a subdirectory of the project, it can be told to exclude ch=
anges
>> outside the directory and show pathnames relative to it with this option.=
 When
>> you are not in a subdirectory (e.g. in a bare repository), you can name w=
hich
>> subdirectory to make the output relative to by giving a <path> as an argu=
ment.
>> --no-relative can be used to countermand both diff.relative config option=
 and
>> previous --relative.

The wording implies to me that =E2=80=9C=3D<path>=E2=80=9D is only intended f=
or use with bare repositories. With working trees, use just the relative opt=
ion from within a directory:

    (cd foo && git diff - -relative)

If that=E2=80=99s right (?), then the docs should probably be more direct ab=
out the way each is intended to be used. I can imagine some use cases for th=
e stripping behavior in non-bare repos, but mostly around ad-hoc scripts.=20=
