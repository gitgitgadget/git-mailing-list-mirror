Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0k2tUcN"
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94C1717
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 20:02:07 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d855efb920so71315a34.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 20:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701403326; x=1702008126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvxTV2IKW/zCHJVeuurENvZ8VstuIQFxnt24z3exz0o=;
        b=J0k2tUcN1lH7CcDyBpddbt6/cnZNws2MZe6slnBxvfgiil2WT66hPF4mryAEE8J6AH
         5oCIHzTOsqB6/juBKyVkS58TqR78Uihq8cgfu0H7yiKyumf4BrBGQ+OrzCrAPoXQHDMU
         CtXMy5ND29cv6fpTHButRdUwlpAGXZfFHh8nAYgtHG1eCnTcwsYnWbsl9T6kEIKC1vgX
         0yL2FkGnWnuEcSAIPD0lbc1BBrR0W9Io/PdgEcMyeseXNhnG0cs/GjCOhQ0N7dr0v68f
         BtuRQ8jcyGo5NIbUT3UysV9kxH3+Bcq+E9Y9RMNEGF4Il7QUEEAv87EmTBAcLG9Xi7iR
         kjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403326; x=1702008126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvxTV2IKW/zCHJVeuurENvZ8VstuIQFxnt24z3exz0o=;
        b=BwgZDKRt7gKL4FPS6gSHqPFsgQfMyuyagilhecGTPrrQJ/QQCyKn2N/lO4SjI6PITj
         emoh4CoUMFoTUDBsDnYZcQVVrcVkpLiBXYZ/eWo3Xb/OaE1GPD3AWuFQn9dO58+AJoY/
         iKeFdkQygprnQn6s1jk1Yhxwf82eBouI2nB5DCE13PZ/U3vcX82hblWMUJ4C5IoP7y3m
         cZlcX3J+JrSa3tvAsTROJNfn0ULYtxTZ9n3JrSc/7VRBnpML48iLsoUhiQx41LqpP8o3
         9WXCvMd3ZHLOMz9GCK1ihDqWDgZqgH5GmXkorOT6473ZaeQPzOVo7HaX6/1mF49X5RvC
         8PPA==
X-Gm-Message-State: AOJu0YxRQLRLDAoeOrrfh3Zw1kvCqx5eFMJKu/99vJBTw4625vn5coho
	8yQ8iplta5dZD0a82kwl4B0gtL7TPsXWA2tSufXCM9tKCt0DowNddtdFaIWI
X-Google-Smtp-Source: AGHT+IFsOPeXZHPtAc2scStIKZh1bw6zvIuJfqibLShrZmOaUIjV3zenusN1ujROyvg/Cnor2NtK/0vQ6WdJ6q/ZdqU=
X-Received: by 2002:a05:6870:d0c9:b0:1ea:2d58:46e3 with SMTP id
 k9-20020a056870d0c900b001ea2d5846e3mr27745929oaa.33.1701403326249; Thu, 30
 Nov 2023 20:02:06 -0800 (PST)
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
Date: Fri, 1 Dec 2023 12:01:54 +0800
Message-ID: <CAMmZTi-U_ufzoBLCDWKbrf=3GZzGszxnM1_Pu6ufBeoYjj7Gdw@mail.gmail.com>
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Cumulatively, aside from the removal of the t/#t* file, here is what
> I ended up with so far.

I want to double check if I should followup here.
I assumed that you had already applied these final fixes on my behalf,
similar to my patch for enabling attr for `git-add`. But if I was wrong,
I'm happy to send another update with all the fixes.


On Thu, Nov 16, 2023 at 4:08=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
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
