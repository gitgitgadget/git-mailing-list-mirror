Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EED28682
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487821; cv=none; b=DrvyK9l+Tal4hOFembUvwnP9v8Wj8Vlzwcg6iNMRv+Z3fIhswsFqpxvk1/Ft8BlYJALXselErabOrbirT2CNWxd/mJRIX+ybpTkjryQl9gFGdZhibrWfXV9z4Igxslw4I3H/pg0DyZE8SFl0jJ/0c/bgJkkNv0g2gu8nrt0EB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487821; c=relaxed/simple;
	bh=Ciw+5Ujv1mnYYQO36JYnroP4m5r3kGxeL1yuA4qfULE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dVUCl63gVPBXN8bYJlfM87YZAEreSkCSonVOxWQm0ok/qF7q8m+H1o8GVARS18feeYkzJ+TlD+MG1q7GamGlSRBdk9NNQdb8fOulzTvA0wL1dgRefq61qGgiXyva3dyVThbJUyXADk/AdRIC4No2BMy2xwNimAMxbz6gxC3yhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt4ofVzM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt4ofVzM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7196cb401d4so26902627b3.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753487819; x=1754092619; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBIdl28K8V+T8QDLwDOexWBrAgz5iUGoAAp3SxhQ9AM=;
        b=Pt4ofVzMjLq9GNhB0bwTVu1lrEaOYjN0u4lNqiep0sBsRzIJv/XMJPNA7k09GpkdTR
         4FIpmaJmLStdpTQH2mzBHELuejktpSB+slQDHm2WqXo/TQLYlshhYwBbusoMO9hGPrJD
         4x9wQDZnVezUTnt34zxP7bEJ7gux8rUPVONYgIxKTBeLX4olYjRhBQHKQvot3JALygED
         A63/Snr2SpOoEisW4cFgPgaiCS8S/MwOEmWuNfocPB/aNw4srpLcUimY57bReedDgz3r
         1HyHR0WIrBjSn+WqDc3IllXivrkp47f0JQl/ZmU+VZqMZ6T6wedD27b8O7beoXhQ/G8k
         cfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753487819; x=1754092619;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBIdl28K8V+T8QDLwDOexWBrAgz5iUGoAAp3SxhQ9AM=;
        b=N8zr2dYrbbvn2C3Web3iFZJOLoFeinwUkZWvETL30Ht2h6oRVZ/b+9cbdqySfVJQd6
         m5p/k3XwuO+AbsZzPE+k4Im+9Aa+P6/HXARlGQibMyDxwStWVrfwhYo3GhRo5mefsi4n
         seB2+EkjZbxMEzW8iD34l3El1QOxnj/WQl3T4z2uA2nr0vMdwBwLQJnYOUofKG2M71qJ
         oAvKySYzLd4GZSBZXj+XyXLYWv+VisD5XPMUAwmT4ba4VViMnfFxIXxYu2bZtl2F2gIj
         Cxx2ym98ECkU71u8nqG9PVF6ShlZMdGQslPaB4O8TL7YBjv8UxNGmxy1eGW+fLxlvpUm
         F+kw==
X-Forwarded-Encrypted: i=1; AJvYcCWzec8MITcECtDpUhSwNZA8j9w/DJD5YDKnLhyMD/vW3JHlYyfh6a4kJm2OM5QNSCO7aQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0YecClamUi1vVbrTsdg1b9dRTwZLg5E2OIZ4cUjDXJIurpN4
	VT455+FJljxUAKpMkL0S/KojYE7u3NPD89iog2Fr8ieVcp/vcehOF98+qyUbXFmn
X-Gm-Gg: ASbGncu3oAUQ654f55fb+I8zPeVfLQHiL7nUGQ/9ZDj/Sh34SVWbaYq+vXpryXv2YEn
	2hylIBKmfXSF5sZgDB/rxNaM/H5o+aM9G/+tlCabnAyBIchLxirsOBRgxk1VcoCQ4KQYpVm1d5E
	/muMHBQFiaFDwkBX/DKZRKlX3auLpvy0/rmcOKiuKnPVRTQuOV4gpn4X1Rk7DhP1iIh2r9DrMMV
	/yitXKyW3DkrRymHk72peZSPFUlBJxO1yFwlqXw40vmdgfrZz9ozYNGIoQD1Fb2dh3mg/DUPsqi
	y9qWVwAAmGqm+YR/o6ZJiYNxvZIMLBDpp3U1VSQ/QzfuJ0ljF9Y2bWVkBS4o0pytM2jRX2p6s5l
	/Tn214yEqBm+jk3HvcV/ndT80rqhbJ7Gug2/4JEzqZRWLQsBwBiViFgZsJ2cBSaEX7dz8bLibYR
	uA7Nt+BIZgaZ8RTno=
X-Google-Smtp-Source: AGHT+IHWX0favcYHAJea6nF4vtu1UP5dNdcvdhmgSVh20/R4FzljlUGLZ6NmVIvH0VvVrG5P8nu8xg==
X-Received: by 2002:a05:690c:64c9:b0:719:e1de:807d with SMTP id 00721157ae682-719e3845fe6mr47308327b3.18.1753487818946;
        Fri, 25 Jul 2025 16:56:58 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df85e4103sm348120276.21.2025.07.25.16.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 16:56:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 7/7] github_workflows: install rust
Date: Fri, 25 Jul 2025 19:56:47 -0400
Message-Id: <3F4EE706-9666-40B0-9638-AC433D7048ED@gmail.com>
References: <CAH=ZcbAeMv7oO-X_o_WOvgS6_igO3XAUjmgLoEfDN0CqqTMH_g@mail.gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
In-Reply-To: <CAH=ZcbAeMv7oO-X_o_WOvgS6_igO3XAUjmgLoEfDN0CqqTMH_g@mail.gmail.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 18 juil. 2025 =C3=A0 19:04, Ezekiel Newren <ezekielnewren@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Thu, Jul 17, 2025 at 3:23=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>=20
>>> On 2025-07-17 at 20:32:24, Ezekiel Newren via GitGitGadget wrote:
>>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>>> index 7dbf9f7f123c..8aac18a6ba45 100644
>>> --- a/.github/workflows/main.yml
>>> +++ b/.github/workflows/main.yml
>>> @@ -4,6 +4,7 @@ on: [push, pull_request]
>>>=20
>>> env:
>>>   DEVELOPER: 1
>>> +  RUST_VERSION: 1.87.0
>>=20
>> Our discussed plan is to support the version in Debian stable, plus a
>> year.  So we'd be supporting 1.63.0 for a year after trixie's release.
>>=20
>> The reason for that is that people build backports and security updates
>> for Git for stable releases of distros and they will use the distro
>> toolchain for doing so.  Forcing distros to constantly build with the
>> latest toolchain is pretty hostile, especially since the lifespan of
>> Rust release is six weeks.
>>=20
>> If the Rust project provides LTS releases in the future, then we can
>> consider adopting those.
>=20
> The RUST_VERSION variable in .github/workflows/main.yaml had to have a
> specific version. 1.87.0 was selected since that's what I was using
> locally. Elijah made me aware that an older version of rust might be
> desired, but didn't know which one. I'll switch to 1.63.0 or whatever
> the community decides.
>=20
>>> +if [ "$rust_target" =3D "release" ]; then
>>> +  rust_args=3D"--release"
>>> +  export RUSTFLAGS=3D'-Aunused_imports -Adead_code'
>>> +elif [ "$rust_target" =3D "debug" ]; then
>>> +  rust_args=3D""
>>> +  export RUSTFLAGS=3D'-Aunused_imports -Adead_code -C debuginfo=3D2 -C o=
pt-level=3D1 -C force-frame-pointers=3Dyes'
>>=20
>> Can you say a little about why these options are needed and the defaults
>> are inadequate?  For instance, I build with the default options both in
>> my personal projects and at work and don't see a problem.
>=20
> What I found is that if I have a Rust function
>=20
> #[no_mangle]
> pub fn call_from_c(arg: u64) {}
>=20
> which is only meant to be called from C and isn=E2=80=99t called from
> elsewhere in Rust, then cargo will misidentify this function as dead
> code.  This was the reason for adding =E2=80=98-Adead_code=E2=80=99.

Are functions that exist for C FFI callers supposed to be marked unsafe, and=
 if so: does that prevent the dead code analyzer from removing them w/o the a=
llow flag?

Or, alternatively, can we #[] annotate them as allowed? It might be noisy, b=
ut it also lets the checkers flag actually dead code?

>=20
> The reason for adding =E2=80=98-Aunused_imports=E2=80=99 is somewhat IDE r=
elated; if I
> paste code somewhere, RustRover will sometimes automatically add the
> necessary imports.  However, if I delete a chunk of code, it=E2=80=99ll
> highlight the imports that are no longer used if I scroll to the top
> of the file, but it won=E2=80=99t automatically remove them.  Since they
> aren=E2=80=99t automatically removed, it=E2=80=99s easier to build with
> =E2=80=98-Aunused_imports=E2=80=99.

Similarly, I would think this is a problem with the IDE rather than somethin=
g we want to end up with in the implementation.

I wonder if one of the cargo fix type things can remove them for you, too, s=
o that it=E2=80=99s easier to just drop this allow.=20=
