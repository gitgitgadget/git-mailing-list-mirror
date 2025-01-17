Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135481AA1F1
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150255; cv=none; b=Q89UZRRMtL8/ywu5WsJAfX1onHdtrFIz/OzzYpm/HKzHL8VNhBZhDz7ba7voTgptbdyEtSzF+TGzq7ff1DElho2xv6FFHV64+fmUIIPngmWdD6ViCgm5XW+oiBTZjrjY32yi62IhtZjRBhPHgJkSd0uIcD5+m7dnNJmCtqqTCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150255; c=relaxed/simple;
	bh=vJ0BrXIEU5EMHW2wipRBU+woC/EHDU+xrTi6pOwEviE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgLOrRqXjvwQSMFf2XfU/2gTVcuW8Ug6boue65ynxJneSySx9YJx7EBzXf/nfqSNpOvKXLvWi2lU1fweuyLAMHUyZeruhMUsbtks+OUiALYOkak1rHREyyosVgywNdR9R1IB1uGwX0vkr0NsCIlyzMGtlXbzREoO7odyACM0xS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dafe70ccd6so4500716d6.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737150252; x=1737755052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuNdCOvPbIYCy+1G5SHI8yH5puWIjGpJdKAfdwTekpQ=;
        b=azCEirwXhAZYyKHlZOBSvtRV2Ewjcwivvozm4U9K9IczxHV/jSE4gUuKEq26TrInx1
         xaH6x1dLUOd14ymhQBrt8xmMF0hxiV2qe7zW1Ch8euuMvlsBufe2v+Q3EZ3Oaw/y3Fvv
         FDd0StSepYKmwyF0gYrURYwBfZ/JvAztl6atvhvgX43liKw7AHlfJ/4sfUVSXU2KK2RD
         ccqk9VUTs484rcShpQT1RAND4jVKmyQQNCAd07RnsBMxdtkcDWnyPM7Vy1y3/yb9Ob/L
         6Pe0JWTCy1SjoecyBUlNZ3W0QnyMzLVZeBLqMYBuhRFm/dIMJ5UiXdE/ChsA54SbArcc
         PmVA==
X-Gm-Message-State: AOJu0Yyvw2UheHc61tbXpyZgTRa+tGQsnoVr29zV8ryMu7CWcv64xXDE
	X0c8pjc2bqZzYnq/31tFR/3w36XeTE0cfeBqPYQERY1jWII2iQPmtbU0AxUuZC7SkxCU7ai/HzC
	0tHy7d2p1Q8wtefE7gH2bs40ehs0=
X-Gm-Gg: ASbGnctuuRubmvurIAomUPBKp13eamATmAUuErdip+OdicSPX1KcprHAWnpj/jvHw4M
	reD+yjdKvQ/xl1XO8kHy5HGR3G2QPxhI74TelEcoVYE4Uy0tsFlfi3WKUougmU0pY0Ck7UkM=
X-Google-Smtp-Source: AGHT+IFW5q4ITHV0cdYsGyzMyONmUBNmhUZCC3m5fJwZw/GzZqW4/ahu5HDyNE7cxLXXAe5L+m1N9Znt6vWJAky88BE=
X-Received: by 2002:a05:6214:4019:b0:6d8:e634:203a with SMTP id
 6a1803df08f44-6e1b2168b60mr23666246d6.4.1737150251993; Fri, 17 Jan 2025
 13:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-7-usmanakinyemi202@gmail.com>
In-Reply-To: <20250117104639.65608-7-usmanakinyemi202@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 17 Jan 2025 16:44:01 -0500
X-Gm-Features: AbW1kvZbxRuSmRCsbpyX_RaCu0q-iCnleNBVkTsBaw_zdo8I75L2mX29HvqlzwQ
Message-ID: <CAPig+cR6oCLw5h78NTrxDztTCLn4eseidk7wBc3JgVzKEE3+zA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	ps@pks.im, johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:47=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> Currently by default, the new `os-version` capability only exchange the
> operating system name between servers and clients i.e "Linux" or
> "Windows".
>
> Let's introduce a new configuration option, `osversion.command`, to handl=
e
> the string exchange between servers and clients. This option allows
> customization of the exchanged string by leveraging the output of the
> specified command. This customization might be especially useful on some
> quite uncommon platforms like NonStop where interesting OS information is
> available from other means than uname(2).
>
> If this new configuration option is not set, the `os-version` capability
> exchanges just the operating system name.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
> diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
> @@ -150,6 +150,34 @@ test_expect_success 'git upload-pack --advertise-ref=
s: v2' '
> +test_expect_success 'git upload-pack --advertise-refs: v2 with osVersion=
.command config set' '
> +       test_config osVersion.command "uname -srvm" &&
> +       printf "agent=3DFAKE" >agent_and_long_osversion &&
> +
> +       if test_have_prereq !WINDOWS
> +       then
> +               printf "\nos-version=3D%s\n" $(uname -srvm | test_redact_=
non_printables) >>agent_and_long_osversion
> +       fi &&

As an aid to future readers, please add an explanation either in the
commit message or as a comment here in the code explaining why Windows
is being singled out as special.

> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> @@ -53,6 +53,35 @@ test_expect_success 'test capability advertisement' '
> +test_expect_success 'test capability advertisement with osVersion.comman=
d config set' '
> +       test_config osVersion.command "uname -srvm" &&
> +       printf "agent=3Dgit/$(git version | cut -d" " -f3)" >agent_and_lo=
ng_osversion &&
> +
> +       if test_have_prereq !WINDOWS
> +       then
> +               printf "\nos-version=3D%s\n" $(uname -srvm | test_redact_=
non_printables) >>agent_and_long_osversion
> +       fi &&

Ditto.
