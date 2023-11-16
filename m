Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVJHMODV"
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5CD73
	for <git@vger.kernel.org>; Thu, 16 Nov 2023 09:54:47 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso564371fac.2
        for <git@vger.kernel.org>; Thu, 16 Nov 2023 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700157287; x=1700762087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBeObO5/QT42gZ/FKjGmXDk5JQkYqleGc7ovqZChfSk=;
        b=fVJHMODVRjgy+CUonrmqs2iMQG02n/xmO8fIxWEb0iuW8x4xApLC9krkOZgfxUDDC8
         /qLGNCneOg8Cooc+g4Xdqv78aka8cMqa1sPLVm8MviUGznu/a7V/7qqocaHFeU2zMoJI
         en0KfP/uTW7mG8IFBCGsBk1fferfpvX2UbMF6anBp4jhkaPAbtR86pl3197NPX4etrJS
         6A6KmXqoie+dLdWWfGkCC+dLXtgqGzVZrFaQotYCmc+8lRZzGU9rZbaNMxQ6ZvErbZOh
         L0zol/F9F6SRmexStDiyPkz+xPC20dcFZOn7siGObO43OkqZmQrket401Dvz02QXTekw
         S10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157287; x=1700762087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBeObO5/QT42gZ/FKjGmXDk5JQkYqleGc7ovqZChfSk=;
        b=Hce5EA7UYy4IJg4742Qk0nXDU9v5xOpateq4m7XZPVBBefp+Ux+rAGZQYvbXjtjKJP
         +E/Gxzjo6HWD5l+x/cNU7K0ZIW0f9Tx7uprjLmo1yrVuMVnTo7mMGJzUGvHWfd5OwDAM
         iGwODUYfsg8oWnw6sxH1DKARHUEIFPnAzx6gdVlOMOHvcSYTHDiGha8x1LSpIxSzxXTq
         s2jh7Jtl6SrLZvfENYQNILfC9sfcxMjShwgc/rlUbu0zurj2A5IHpNtWgnGoDWSp4mj+
         S05eYXD/1f1omG79TREy1T7otp32bxjz1Rrdm6iJWmDdmXUbqBnA6VtsUhnev0CDNUJb
         wlxg==
X-Gm-Message-State: AOJu0YzNb6U0Ia8dn1qGBJ0HZx8yrBD3zi6uM1+yNgUX36DVRsETeVQ7
	YH/lyEdX1h8DVemjKlqYHz8kCCxCWExbsDoKy1gzoQ==
X-Google-Smtp-Source: AGHT+IFjLrKXCwXxhHtjkqtPO5Pw8DvCIRjSqqwjp+sOnP3Dgg1kFCQCmSnywqwDJy55jCia2fDWhA25KZT9QAZ4jk0=
X-Received: by 2002:a05:6870:1d07:b0:1f0:3259:3ec0 with SMTP id
 pa7-20020a0568701d0700b001f032593ec0mr19924427oab.54.1700157286571; Thu, 16
 Nov 2023 09:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqttpmtnn5.fsf@gitster.g> <20231116054437.2343549-1-jojwang@google.com>
 <xmqqsf56ql14.fsf@gitster.g> <xmqqil62qfvr.fsf@gitster.g>
In-Reply-To: <xmqqil62qfvr.fsf@gitster.g>
From: Joanna Wang <jojwang@google.com>
Date: Thu, 16 Nov 2023 09:54:35 -0800
Message-ID: <CAMmZTi_BKfqw3984CyNdDUNLdMK2hFLtxeJfu_iEw23m8HW-dA@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yes sorry, t/#t1700 was a mistake.
Thank you for the review and further fixes

On Thu, Nov 16, 2023 at 12:08=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Other than the removal of that file, I locally applied the following
> > fix-up while checking the difference relative to the previous
> > iteration.
>
> Cumulatively, aside from the removal of the t/#t* file, here is what
> I ended up with so far.
>
> Subject: [PATCH] SQUASH???
>
> ---
>  Documentation/gitattributes.txt |  2 +-
>  neue                            |  0
>  t/t0003-attributes.sh           |  5 +++--
>  t/t6135-pathspec-with-attrs.sh  | 10 ++++++----
>  4 files changed, 10 insertions(+), 7 deletions(-)
>  create mode 100644 neue
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> index 784aa9d4de..201bdf5edb 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -108,7 +108,7 @@ user defined attributes under this namespace will be =
ignored and
>  trigger a warning.
>
>  `builtin_objectmode`
> -^^^^^^^^^^^^^^^^^^^^
> +~~~~~~~~~~~~~~~~~~~~
>  This attribute is for filtering files by their file bit modes (40000,
>  120000, 160000, 100755, 100644). e.g. ':(attr:builtin_objectmode=3D16000=
0)'.
>  You may also check these values with `git check-attr builtin_objectmode =
-- <file>`.
> diff --git a/neue b/neue
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 86f8681570..774b52c298 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -580,12 +580,13 @@ test_expect_success 'builtin object mode attributes=
 work (dir and regular paths)
>  '
>
>  test_expect_success POSIXPERM 'builtin object mode attributes work (exec=
utable)' '
> -       >exec && chmod +x exec &&
> +       >exec &&
> +       chmod +x exec &&
>         attr_check_object_mode exec 100755
>  '
>
>  test_expect_success SYMLINKS 'builtin object mode attributes work (symli=
nks)' '
> -       >to_sym ln -s to_sym sym &&
> +       ln -s to_sym sym &&
>         attr_check_object_mode sym 120000
>  '
>
> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs=
.sh
> index b08a32ea68..f6403ebbda 100755
> --- a/t/t6135-pathspec-with-attrs.sh
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -295,22 +295,24 @@ test_expect_success 'reading from .gitattributes in=
 a subdirectory (3)' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'pathspec with builtin_objectmode attr can be used' =
'
> +test_expect_success POSIXPERM 'pathspec with builtin_objectmode attr can=
 be used' '
>         >mode_exec_file_1 &&
>
>         git status -s ":(attr:builtin_objectmode=3D100644)mode_exec_*" >a=
ctual &&
>         echo ?? mode_exec_file_1 >expect &&
>         test_cmp expect actual &&
>
> -       git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
> +       git add mode_exec_file_1 &&
> +       chmod +x mode_exec_file_1 &&
>         git status -s ":(attr:builtin_objectmode=3D100755)mode_exec_*" >a=
ctual &&
>         echo AM mode_exec_file_1 >expect &&
>         test_cmp expect actual
>  '
>
> -test_expect_success 'builtin_objectmode attr can be excluded' '
> +test_expect_success POSIXPERM 'builtin_objectmode attr can be excluded' =
'
>         >mode_1_regular &&
> -       >mode_1_exec  && chmod +x mode_1_exec &&
> +       >mode_1_exec  &&
> +       chmod +x mode_1_exec &&
>         git status -s ":(exclude,attr:builtin_objectmode=3D100644)" "mode=
_1_*" >actual &&
>         echo ?? mode_1_exec >expect &&
>         test_cmp expect actual &&
> --
> 2.43.0-rc2
>
