Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A0155C87
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771682304; cv=pass; b=T45dMOGmwX9+/oJdCV+/mf7EOdXyVknAs2ucc58CVWRAosMmP2wR4drfCV8ZhthFsrNREqXtGo/38mAtoVL5PEhdcUVMRnJSIwXPUblNzNdYrmYm4mmbmEtG9ONBCSG7SLa85ZUdegwQ/XZidCESBoupR2hZRAFOBjkPQ+qu/aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771682304; c=relaxed/simple;
	bh=yAMr2mOpIENVoHzpkcLtzmM8Efrm0TyMBUawwcL5UAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcM7lVIpeO8o0bivWfcPKWJg4qXO81epHBcxKfiiV7pciFpMAsrgSEYVEzYt1oplrwkgpscNiWT6NyVSiFAmZ9dt+lCGGyDo1dTz8/kZ8FRbwmtJMKs2Ro+asnm2bboLGSrEuvGGbZruTdkuRPBMe2qZ2r6Abnevy5egKrNhaO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mspteiTU; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mspteiTU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so26738305ad.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 05:58:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771682302; cv=none;
        d=google.com; s=arc-20240605;
        b=ekslvotMMcq7nfhG22jKu5NRECQJmgBHO4u18hDJ8d9UKaR6tBU/fllJFl4mDKtZa5
         1Y6K3xoS5qM+I/Xc9JdnVsp2WI2a0JYpg3xfRkzGDMfr+B3kqbUJac4d+ePw3e3J72Oi
         RcNHslmRpqaoafi9nGxTi5ovPvEwnWDnacYdpwjR2WhRNSd4MLeunWmdztUqdSyFHPR5
         nGGa7LbHI0Z6bIlT0VkH2NX8AcazJvWd+wV7g3P1+cY7rHphWZN1WRGNQiCiL9t1Z9+k
         BJFOjWEiLpM4BNnvcaKWy0Vc0flch9XSxOsfAUjgB8ZLopVra9AaR/d1qWG3NcYvc3TX
         jbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEY6vwp1DPFWBibpBSpQGLxexjLeLqoMeUKR4S2Zmuc=;
        fh=WYFal4PD61lPbX6SPNp2lNFheeszDDBThluPHNMXZ/M=;
        b=hV1KgqEXVyZY+9p7Wx5rfMZA2cb+UJOZeoXTfBFcWfQma2PWOyUt/Mzwi0usEA/UB+
         KVngWdrVrRbEwe2fQlFDsHknnxOhYmUwJum0eoU6NfHIO7L0a9SPAN3ktX9iaPvDnump
         sj+AhgWmRHTDn5BfbXT7DhahZqp9H9X0muWqPPwyku8C9UcC+EdERuZ2n3GdMRk7BQXf
         RlXFQdIYMk1ew64sdDYMwA6yjT90odjs6xfU8V/t3h+lM88znTFhFT6/ouWQusRhKQZi
         u0m3zZdZs8ZFogAV93lapTEZfaEztvJ1+AoXMb4Y68P2K9LEJxiYau95Z9/tCD9qWSYx
         SkvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771682302; x=1772287102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEY6vwp1DPFWBibpBSpQGLxexjLeLqoMeUKR4S2Zmuc=;
        b=mspteiTUSrPX0Rek+IRUpi5Cf2TeNaDGNgBc+O7dgfRJ5lmp73BSf9WpSr7GoL5hlM
         CNS/kEiWh0ofzovi7Z9fLj1a6UpdzOpwMVza4L1ndP2D/6FpRZVYj1yH1IMNu7UiBJVK
         1zkR8I43/99USxdltFAAw1AZFklDFuLEwHp+fjlfEDh7p3Da6W+uaDniijGcjEWSSP7f
         7kHXhthpy5G5d5I63SRl/QYzqiII5p1uCQA+QaZ2v6ep41rVYkn7+RDPRePeg9pNW+MW
         /d3YbGK5KfsV/Xm5qZhUY81hQaUbCkVgjlyV3ht+1gDnM2uNTvko3mIlEMmc9evlr+JN
         72/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771682302; x=1772287102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEY6vwp1DPFWBibpBSpQGLxexjLeLqoMeUKR4S2Zmuc=;
        b=oIiC1Si06cc8w1npOXTBzFt1kjPg8Ch9Z5qW3NKULa7rdq0LRl/AQXO5y8A3n7BSWR
         Tsf02nCw3Bs1r0kuQq2vaamEzQdtS3wrlDN80losJJbR9kIAlUVvAXTmDYK9Zbi9jC43
         6SsNoh/abHp0CUzHnfwOgsxfsKImTcmaN7IjLT1wrrtmu2QzyPl5bTQXtJglIZoQjxia
         ngVhsPc6E7wp7/oWoBgImgSPmIWHpdCMoPcDwyu3ixLGQivQcKOiAKaN6M+mokq5yxNG
         QAanSu0x8AfBizwKg8eabdOVmP/aB374GMfst9EdAM8HMt3OufhsAH8+V+VmUHyHBYSK
         OuxA==
X-Gm-Message-State: AOJu0YyBYg9rbC7NUd2ndt0MMmdgLAib31cpjx2rdjNED9eAbL09xoJB
	MWoOd7h+MJ4KpFffBK4eEi1EqoNLsbNisM9zatDIEr+gGWou5L31fy/A9BlaI2QZzOV8QQzXC50
	Jj7WiNkE4ueUwiM3M8dXl6v95tAQsbVY=
X-Gm-Gg: AZuq6aICoYVY6SRfUF3MXdJihfh8Ky7tPgWNcUrHNZnNGnKRhEOGOq02l+2w2BVRT7k
	x6RSIl5TmyZNoe9cnHZo6Caa+trnxH3ejyaNDCqJ562Quq2qQDeKWrV5vI/HfqWpDwVUBzat3xd
	x/o/EifBU892K17oR8kUEWxlncdEthAwoNVZyJvOUqKa8Lhv+KzTSSIw/Yy1peZUWYywZ+5wad9
	rDceehXZtkfHSdK1/7lOWD0WpAWGmQi6e7rqLHQP8tLbZhqy0dfWFD6dju/kdgke9pGT4cDFvT3
	rZ6y/JvV5YQXBa+6DNa03JF5SpEpORFhvVN4Td/c3B3ROXSPV2b8zvt5PeVDRIQ//dNJ7n2nRjt
	LyqHYNPIgxHtPs8GzvqPC8Ye8sQ==
X-Received: by 2002:a17:902:c94b:b0:2ab:2311:e4fc with SMTP id
 d9443c01a7336-2ad7456f9abmr28328025ad.56.1771682302314; Sat, 21 Feb 2026
 05:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
 <aZcWq9SapNnRAXti@pks.im>
In-Reply-To: <aZcWq9SapNnRAXti@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sat, 21 Feb 2026 08:58:10 -0500
X-Gm-Features: AaiRm52irfuhuteSE6WBR0FSHUEcxnqVcy5tZrSEldmOCzYlx5jcEVT-AcGLenE
Message-ID: <CALnO6CB0db28NCeoq7zJU-BF=ruoTsD9_f48rgEuweumoT7--w@mail.gmail.com>
Subject: Re: [PATCH v5] build: regenerate config-list.h when Documentation changes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Evan Martin <evan.martin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 8:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Feb 18, 2026 at 09:37:59AM -0500, D. Ben Knoble wrote:
> > diff --git a/generate-configlist.sh b/generate-configlist.sh
> > index 75c39ade20..39ac8845ab 100755
> > --- a/generate-configlist.sh
> > +++ b/generate-configlist.sh
> > @@ -36,3 +37,11 @@ print_config_list () {
> >       echo
> >       print_config_list
> >  } >"$OUTPUT"
> > +
> > +if test -n "$DEPFILE"
>
> We could arguably drop conditional now that both the Makefile and Meson
> pass that argument, but I don't mind it much.

I'm going to reroll a commit message, so I could drop this. OTOH, I
think we've got a working configuration, and maybe someone runs this
script occasionally to generate the list without wanting the deps.
Idk.

> > +then
> > +     QUOTED_OUTPUT=3D"$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')=
"
> > +     printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> > +             "$SOURCE_DIR"/Documentation/config/*.adoc |
> > +             sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFI=
LE"
> > +fi
>
> Okay, so we first quote the target output file once, and then we quote
> the sources with a single call to sed(1), too. To not perform quoting
> of the target output file twice we don't include it in the printf call,
> but instead prepend it to each line.
>
> Looks reasonable to me, and we spawn at most two sed(1) processes. Nice.
>
> > diff --git a/meson.build b/meson.build
> > index 762e2d0fc0..74b459b004 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -720,11 +720,14 @@ endif
> >
> >  builtin_sources +=3D custom_target(
> >    output: 'config-list.h',
> > +  depfile: 'config-list.h.d',
> > +  depend_files: [ 'generate-configlist.sh' ],
> >    command: [
> >      shell,
> > -    meson.current_source_dir() + '/generate-configlist.sh',
> > +    meson.current_source_dir() / 'generate-configlist.sh',
> >      meson.current_source_dir(),
> >      '@OUTPUT@',
> > +    '@DEPFILE@',
> >    ],
> >    env: script_environment,
> >  )
> >
> > Diff-intervalle contre v4 :
> > 1:  e2f4e1f9ba < -:  ---------- completion: add stash import, export
>
> The range-diff is a bit broken, but that doesn't really matter much.

Gr. I must have tweaked something at the last second and missed this. Bumme=
r.

> Overall this patch looks good to me, thanks!
>
> Patrick

Thanks for the help and reviews!
