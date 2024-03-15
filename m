Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E1535AA
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531593; cv=none; b=OXr99jnMRZ7O44pd6lE3eDBg7QVAaIKnsX/A7iDw788Nx4brTtYfAB90P0dp93nDJPn4zbb3VG2bfaVYu7/yCC90kBiNWKMqJ+ep9sTAUCla9lbIBSxHImkM59wler2JR1i7swiZ/bsY10U2St9/LIlakVCXiA+Cf/fVPOCmIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531593; c=relaxed/simple;
	bh=jeDaOV98ru26axai+eDm8sa8Ewn+AO1AcLt/GXANy/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz015XKjsgcQOOWHSxCV1tkLm4+9KD9qgk6Ol+H9h+TUx5vqdbz0DQ2H6chVEoSGJsaXmvS5DkRYD+10JSsojt+W44F+HAuC9qKTINHWor7Ie7hYwkM4KdXIG649tqUY2frfd7r6DSKFtOSDdIb5nUksJMbsS1lQIysqh55r0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-690d054fff2so15574366d6.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 12:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710531589; x=1711136389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtG3VWdtdpxf8W+jf42Lhc/bTL6g4bJKErs8BoFPJsw=;
        b=Xx+zqkpDY1mteaPTEkqCgHxYIGzm26NMUgE0heAxS7bgAGNxlWGWdTvwD7YgvsTAX1
         TClOC1EZHwTNlC4hjttqAt5lNJh6fv3hNpDrlkQSHneJNwd3qDg9BjbuFxMoYjkAdEH+
         D2aR66stnDgclLzM5Wl+7qW48T0UvNwZiQruzR4HtqIJ/KW5dlz/bfkNjrjJw+YmcJfN
         WbA2hA4Orqmm0XBj7EtXZkwERpcvcSMvD0yQNJ4aZKNKYX5Llv/C/BA6Gl1hTD+Wnw0E
         4sTsIqR2E15hGuFNSskS2nRFAAfZbYbpga13XE270BeXiYdaEATnrTr5b9J7yR838Sds
         5ecg==
X-Gm-Message-State: AOJu0YxYUvQSSMOmQ9fkerLb2RMnIyFX6alVWFzjm/0eennZCSIEE8fU
	OfmDJeG0+no2E1+AnSYJyxbapMUDAv3Ero4XI3aScBNILiLjVE6B4/P/VlGYJtowGb5lluCiWCW
	RxrLDXdcDImQNDMHcAxi7Qf7FqIdDJN9sOEc=
X-Google-Smtp-Source: AGHT+IGjdZpLtPW3UI4dmFTb4oGTLaSYzB3gI7JscXxwlBei7ZObkKAdb1hiZGQ1rC3A4usJYHSg524XFr7KlvcAf/g=
X-Received: by 2002:a0c:9c45:0:b0:690:c568:8dcb with SMTP id
 w5-20020a0c9c45000000b00690c5688dcbmr6969642qve.3.1710531589215; Fri, 15 Mar
 2024 12:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710508691.git.dsimic@manjaro.org> <590731e15a01558d1bbcdfc01df4f78573138742.1710508691.git.dsimic@manjaro.org>
In-Reply-To: <590731e15a01558d1bbcdfc01df4f78573138742.1710508691.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Mar 2024 15:39:38 -0400
Message-ID: <CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com>
Subject: Re: [PATCH 3/4] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> Add a handful of additional automated tests, to improve the coverage of
> configuration file entries whose values contain internal whitespace, lead=
ing
> and/or trailing whitespace, or which contain an additional inline comment=
.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Just some minor style-related comments...

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> @@ -11,6 +11,96 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +cat > .git/config << EOF
> +[section]
> +       solid =3D rock
> +       sparse =3D big             blue
> +       sparseAndTail =3D big              blue
> +       sparseAndTailQuoted =3D "big               blue "
> +       sparseAndBiggerTail =3D big                blue
> +       sparseAndBiggerTailQuoted =3D "big                 blue          =
 "
> +       sparseAndBiggerTailQuotedPlus =3D  "big            blue          =
 "
> +       headAndTail =3D   big blue
> +       headAndTailQuoted =3D "   big blue "
> +       headAndTailQuotedPlus =3D  "      big blue "
> +       annotated =3D big blue    # to be discarded
> +       annotatedQuoted =3D "big blue"    # to be discarded
> +EOF

These days we try to place all test-related code inside a
test_expect_success() context rather than having it standalone. In
this case, since the file being created is (presumably) shared by
multiple tests in this script, you may want to add a new test which
performs this setup step.

Use \EOF rather than EOF to signal to readers that we don't expect any
variable interpolation to happen within the here-doc body.

Further, use -\EOF inside test_expect_success() to allow us to indent
the body of the heredoc to match the test indentation.

Style guideline says to omit whitespace after redirection operators
(such as `<<` and `>`).

We have a q_to_tab() function which lets us state explicitly for
readers the location of TAB characters in the heredoc body. You'll
often see that used instead of literal TABs.

Taking all the above into account, perhaps:

    test_expect_success 'setup whitespace' '
        q_to_tab >.git/config <<-\EOF
        [section]
        solid =3D rock
        sparse =3D bigQblue
        ...
        EOF

Same comments apply to rest of patch.
