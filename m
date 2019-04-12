Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8297120248
	for <e@80x24.org>; Fri, 12 Apr 2019 21:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLVzB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 17:55:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43038 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfDLVzB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 17:55:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id w3so9637819edu.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7L2ygXCLh+47I/mba4Ih0v9wVp6t5aIVB9fXksXE3r4=;
        b=i6VQhtVLQ9VAv2Sp6gJAOVbzjX9XQuvl1aTgCwDpkTGv1MOtNYg6QKfRo56WsB53pn
         1xK6G3mmRRuvaeAIZG/YMfGv1u79qvWkBF9JgtLYhvNgMXE6fDY5T7w2heP/GQHPW5eO
         BvzUQT8K6o8AtDcJD2Prqj3/tigQoOMXeAqISzDvGOLVgAbdZJv8MHUyf+451e4Xclxd
         BNiDdYuFHVd3DSzbAboCB/QDZzSw/+7cHL/Enz6xH7UT5O72Zu3pRTHahnzy0CmEEW7/
         PprNlo82odg2IGZIEWVn9QVbRdOXRItK/UlJNZSEvfPxr25nhVDCeeHztspT8z34dmbJ
         o3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7L2ygXCLh+47I/mba4Ih0v9wVp6t5aIVB9fXksXE3r4=;
        b=ucluV/nuDcBrxotOEDtiVpSK2xcFpFOd1OdMk6pudWOJXf3O/FrtFbI1AdfClMM8zc
         b5JQ+DZgwIQAwhCNB9FC4ri6ZJxc7wGnVX8/MNEn9UFa0hq314J2XgCE8DZl9YaizzyO
         xMsabgMqy69u5DdJfyKbK9wLRNuPcHiCIjSoXKrUrpBxT3duXiXhrEDeQwUfbhW2wAqM
         jctQgeJWZgXJA7tvQQqvQcBpnHSq7wFMVCw+JrCbpNrmqFm9TRRc9Cf7ES88ykPVW06B
         NrTf3eULxMqZixTgDuLFR+O4K/IzjFYgEZSO2KKULOS2E1h5tooRbuCk7tTrv7p0kpDO
         piig==
X-Gm-Message-State: APjAAAVAms7badTb28O9M7Dw32IAPUZ8y36+v7n70gRdCqGvklHsEa8l
        oc7KiCRKcYOhQkaAj7zHRaA=
X-Google-Smtp-Source: APXvYqzMpsAdAqIR6ZHEe39kJugMKqKCo69jancGnebn54KVZt6gsrMJB1v3DV/kbXAcBoWUfwLhPQ==
X-Received: by 2002:a05:6402:7da:: with SMTP id u26mr24232450edy.127.1555106099078;
        Fri, 12 Apr 2019 14:54:59 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d13sm4069864edl.77.2019.04.12.14.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 14:54:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] Introduce "precious" file concept
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com> <20190409102649.22115-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190409102649.22115-1-pclouds@gmail.com>
Date:   Fri, 12 Apr 2019 23:54:56 +0200
Message-ID: <875zriga8f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 09 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  Here's the replacement patch that keeps "git clean" behavior the same
>  as before and only checks 'precious' attribute when --keep-precous is
>  specified.

Cool to have the expected interaction with -x. Thanks.

> -'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path=
>...
> +'git clean' [<options>] [-d] [-f] [-i] [-n] [-x | -X] [--] <path>...

For e.g. git-status(1) we just say:

    git status [<options>...] [--] [<pathspec>...]

And for git-add(1) we do:

     git add [--verbose | -v] <very long exhaustive list of options
                              spanning 4 lines omitted>


Seems we should do one or the other here, i.e. either just add
--keep-precious to the list, or leave it at just:

    git clean [<options>...] [--] [<pathspec>...]

> +This attribute is set on files to indicate that their content is
> +valuable. Some commands will behave slightly different on precious
> +files. linkgit:git-clean[1] may leave precious files alone.

As noted upthread I think it's better to start with "clean" and
"--keep-noclean", we can always alias it to "precious" later without
squatting on that more general term when we (IMO) don't have the full
picture yet & know if we even want that...

But anyway, with that out of the way and assuming this is kept-as is
seems we could document this better if we're going to keep "precious",
e.g. maybe:

    This attribute is set on files to indicate that they're important
    while not being tracked. This attribute is experimental and subject
    to future change as more commands are changed to support it.

    Now it's only supported by linkgit:git-clean[1] which'll skip
    cleaning files marked ith `precious` when given the
    `--keep-precious` option. This can be useful in combination with
    linkgit:gitignore[5] to e.g. mark `*.o` build assets as both ignored
    and precious.

I.e. say it's still early days, that it's "experimental" (not insisting
on that phrasing, but somehow signaling to users that if they set this
now it may do new/unexpected things in the future), and briefly describe
how it works with "clean" and what the main intended use-case is.

> +test_expect_success 'git clean -xd --keep-precious leaves precious files=
 alone' '
> +	git init precious &&
> +	(
> +		cd precious &&
> +		test_commit one &&
> +		cat >.gitignore <<-\EOF &&
> +		*.o
> +		*.mak
> +		EOF
> +		cat >.gitattributes <<-\EOF &&
> +		*.mak precious
> +		.gitattributes precious
> +		*.precious precious
> +		EOF
> +		mkdir sub &&
> +		touch one.o sub/two.o one.mak sub/two.mak &&
> +		touch one.untracked two.precious sub/also.precious &&
> +		git clean -fdx --keep-precious &&
> +		test_path_is_missing one.o &&
> +		test_path_is_missing sub/two.o &&
> +		test_path_is_missing one.untracked &&
> +		test_path_is_file .gitattributes &&
> +		test_path_is_file one.mak &&
> +		test_path_is_file sub/two.mak &&
> +		test_path_is_file two.precious &&
> +		test_path_is_file sub/also.precious
> +	)
> +'

AFAICT this is the first attribute intended purely to be set on files
that aren't tracked. I wonder if we should test for setting it on files
that are tracked, and whether we should e.g. warn about that? Maybe not,
but just raising it since I don't think it was discussed already...
