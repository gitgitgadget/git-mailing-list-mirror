Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFD5258
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710649300; cv=none; b=O1o5pFcPZC6JHbJGwJsu52dtPGS+oub+J1QI+2GWALcdqxVeAPDFNYnCMiwYEsm3FG1EnmCM62ZUxXkw5tonChRj0NdXgi/dKNOyn6RHF+wyCet+PjKjaaWoflf8Pepl3KKJQPEokW01WHJDexBVVdbGqD4cMGQKry+bIUhYPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710649300; c=relaxed/simple;
	bh=gFq6oRv6enO3XCarDGNQAdYin/3lBBT1uaFVCV2fV7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6tf/pn2Zka94aJbYSItzksz8RBoMylPVwEYxuln91qPIFXclSvz/GUSSWl9JCkuKTyrcbi7ywqcc16MTh81pCxqGjCE7O4+Doe5ZbA7lqFtbBNsOjyqQj++BS14iEU5Mfq2/vpqarK9nYW4fuRB5SNM4vbPO3oib9e4o8PK7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-690db6edb2bso20229406d6.2
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 21:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710649297; x=1711254097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIlNRpTBIGnMQX27WoEWn+4rx8myP33hGf/FnqHl/gw=;
        b=bpNxJyQMHdt2KmwJjyjB7khxtc5EC5gpPAp1Bfyqu17rhA6D7X/gwPEYn+9hIbFvMW
         exp2zdXTrnGTOf0xWt7MGJdNgNGpgTnWnkroN1z3r+CYno7QVgTig0BNh6QAMcFFp5A9
         z8LE6Uv4nXq97xLOJm4nGzQZgHql4G+aejdeSGgEz72bkpR0OWGyfSJVNrusjJbdq8XX
         rg63B/XY4oOr3Ap30z8/3za5+SLnbAwaUsxccdSPMYFvKX+maXgsFQ4OXTJpwMF32b01
         TXY/Ekqi6Irc+/rSAUhXTIlkGneHQzVjW+TZkZ779MQzHLgXmKrzdZ1LL5h3rukOOvcb
         7nVw==
X-Gm-Message-State: AOJu0Yw+G47EeHnKbiAO49HaoLy4tdsEhW0mKNobX9Ybzy2wRlSjRkOM
	M/JvJDTcQVCWeMyN62GMIL0FmppE+xmMv1wggIUco7UpNuuNw5OqKd5G7sdy9epEMsNUTlzd9n5
	vk5to1K4EGpxnOr0lrlqwYlTdSLY3dY4MY0s=
X-Google-Smtp-Source: AGHT+IGNYsJTsAur5oM6J/UVYRwnQfXpftPpu+/RdOE3BJBLS6Dq95/zfSU3qfC8ny8UxOwi5Gt564q8Mt+83khk3KQ=
X-Received: by 2002:ad4:4147:0:b0:690:735d:ff7d with SMTP id
 z7-20020ad44147000000b00690735dff7dmr8479501qvp.33.1710649296868; Sat, 16 Mar
 2024 21:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710646998.git.dsimic@manjaro.org> <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
In-Reply-To: <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 17 Mar 2024 00:21:25 -0400
Message-ID: <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 11:48=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> Add a handful of additional automated tests, to improve the coverage of
> configuration file entries whose values contain internal whitespace, lead=
ing
> and/or trailing whitespace, which may or may not be enclosed within quota=
tion
> marks, or which contain an additional inline comment.
>
> At the same time, rework one already existing automated test a bit, to en=
sure
> consistency with the newly added tests.  This change introduced no functi=
onal
> changes to the already existing test.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>     [2] https://lore.kernel.org/git/CAPig+cRG8eFxepkaiN54H+fa7D=3DrFGsmEH=
dvTP+HSSaLO_6T_A@mail.gmail.com/
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> @@ -11,7 +11,97 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +test_expect_success 'create test configuration' '

In [2] above, I intentionally suggested naming this new test "setup
whitespace" because "setup" is a common name used in the test suite
for this sort of test which prepares state for subsequent tests. Using
a common name (such as "setup") is important since it facilitates
running only specific tests within a script in which you are
interested rather than having to run all tests. The section "Skipping
Tests" in t/README says this:

    Sometimes there may be multiple tests with e.g. "setup" in their
    name that are needed and rather than figuring out the number for
    all of them we can just use "setup" as a substring/glob to match
    against the test description:

        $ sh ./t0050-filesystem.sh --run=3Dsetup,9-11

    or one could select both the setup tests and the rename ones
    (assuming all relevant tests had those words in their
    descriptions):

        $ sh ./t0050-filesystem.sh --run=3Dsetup,rename

> +       x_to_tab >.git/config <<-\EOF
> +       [section]
> +               Xsolid =3D rock
> +               Xsparse =3D big XX blue
> +               XsparseAndTail =3D big XX blue
> +               XsparseAndTailQuoted =3D "big XX blue "
> +               XsparseAndBiggerTail =3D big XX blue X X
> +               XsparseAndBiggerTailQuoted =3D "big XX blue X X"
> +               XsparseAndBiggerTailQuotedPlus =3D "big XX blue X X"X
> +               XheadAndTail =3D Xbig blue
> +               XheadAndTailQuoted =3D "Xbig blue "
> +               XheadAndTailQuotedPlus =3D "Xbig blue "
> +               Xannotated =3D big blueX# to be discarded
> +               XannotatedQuoted =3D "big blue"X# to be discarded
> +       EOF
> +'

The <<- operator strips all leading TAB characters, so the extra
indentation you've placed inside the "[section]" section is stripped
off. Thus, what you have above is the same as:

    x_to_tab >.git/config <<-\EOF
    [section]
    Xsolid =3D rock
    ...
    EOF

On a related note, it's not clear why you use 'X' to insert a TAB at
the beginning of each line. As I understand it, the configuration file
reader does not require such indentation, thus doing so is wasted.
Moreover, it confuses readers of this code (and reviewers) into
thinking that something unusual is going on, and leads to questions
such as this one: Why do you use 'X' to insert a TAB at the beginning
of the line?

> -test_expect_success 'clear default config' '
> +test_expect_success 'clear default configuration' '
>         rm -f .git/config
>  '

It's probably not worth a reroll, but it's usually better to avoid
this sort of do-nothing noise-change since it distracts reviewers from
the primary changes made by the patch.

> @@ -1066,9 +1156,25 @@ test_expect_success '--null --get-regexp' '
> -test_expect_success 'inner whitespace kept verbatim' '
> -       git config section.val "foo       bar" &&
> -       test_cmp_config "foo      bar" section.val
> +test_expect_success 'inner whitespace kept verbatim, spaces only' '
> +       echo "foo   bar" >expect &&
> +       git config section.val "foo   bar" &&
> +       git config --get section.val >actual &&
> +       test_cmp expect actual
> +'

I appreciate the revised test title ("spaces only") which indicates
that these aren't TABs which were missed when converting to use
q_to_tab() or x_to_tab().
