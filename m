Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A781F453
	for <e@80x24.org>; Fri,  2 Nov 2018 15:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeKCASM (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 20:18:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35299 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeKCASL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 20:18:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id z16-v6so2355037wrv.2
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f2TtmPR+BAUT7N5yHAFu9CvvMyNhM+chfdsvqwWDgCc=;
        b=fcWRlp2xpurdiDrkr7f8evjNxIOKe+683WV2gIkMwQdBd3CXQ46hCxiK/FVZP2fwFo
         YB/oFKIvIsyIvWc/CIjenrdEIDetB+GsCQ3vNtjbcROgd6VUEQksLfvE4VOG8mjCENXX
         0gUYVae1m2oXlZpkpcl51wcJDTExD6g5jhebKtUZrQ9uTM6IomZeID5KYCo45SK+Isx5
         4QWQlt31xLg0/WBgRriHkNeKLI63SW2oDgMRDDH39thpv0BOpBSdP2IWhojBcRffJAdm
         R6iXxXVsYHDMbZiir6KN9AQMGSM1K2WO1KSvBLmARKKDllod76I+Ti1mBh0NsLZnpY7u
         e9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f2TtmPR+BAUT7N5yHAFu9CvvMyNhM+chfdsvqwWDgCc=;
        b=m2ZTpZJmUDv2U6qNFi3qxnz3kwxCXjokYaTv9pAVxeolH83Lq7bnaLbH5b53CX5R3n
         np42RDHkUqyoJLplq87LchWMnFOWPvE1Nx6CB5cr05uO1jBTLFW3PHRbtpE0kek8ZIfi
         9diCAoxKzPP/h0srf+dOS3K/fuC3x4zNTcBGIazXi+UvKnwL/7jxsZ0N+pVRrwivNeg2
         zN71Mr+2M90v45+5hCdTGTK953D6oDai2cRiNZchoViZ7hASHfqMeoxaxPmeyTN1HBXx
         DeEfXuKb570D99BVj/Zww1mGp8AjIQCMis87SS07Dc1APWQT6px8Iui0KDU7hSRpzwC2
         r+Iw==
X-Gm-Message-State: AGRZ1gIhROVYFc/CT0vjF1ewBy80VEuUXxMuxjSNi3kT9PaMR913wUt3
        abdf89BORSWHE1F2sxJsc8E=
X-Google-Smtp-Source: AJdET5ebu/koCCJGEhXjEUG6QQHfZXNFt/K94MQ2bda/aa5GH/NvhRbJ/xb2xi3XO/h2I8gvcgkXmg==
X-Received: by 2002:a5d:4a91:: with SMTP id o17-v6mr1796510wrq.132.1541171446278;
        Fri, 02 Nov 2018 08:10:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i7-v6sm41440017wmd.41.2018.11.02.08.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 08:10:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     James Knight <james.d.knight@live.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] build: link with curl-defined linker flags
References: <SN4PR0701MB3679BA798ABD874D34A595DDA0CF0@SN4PR0701MB3679.namprd07.prod.outlook.com>
Date:   Sat, 03 Nov 2018 00:10:43 +0900
In-Reply-To: <SN4PR0701MB3679BA798ABD874D34A595DDA0CF0@SN4PR0701MB3679.namprd07.prod.outlook.com>
        (James Knight's message of "Fri, 2 Nov 2018 07:21:51 +0000")
Message-ID: <xmqq7ehvplak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Knight <james.d.knight@live.com> writes:

>  Makefile         | 21 +++++++--------------
>  config.mak.uname |  5 ++---
>  configure.ac     | 17 +++++++----------
>  3 files changed, 16 insertions(+), 27 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b08d5ea25..c3be87b0e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -183,10 +183,6 @@ all::
>  #
>  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
>  #
> -# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
> -#
> -# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
> -#

Hmm, because the use of autoconf -> ./configure in our build
procedure is optional, wouldn't this change give regression to those
of us who use these Makefile variables to configure their build,
instead of relying on autoconf?

> diff --git a/config.mak.uname b/config.mak.uname
> index 8acdeb71f..923b8fa09 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -431,8 +431,7 @@ ifeq ($(uname_S),Minix)
>  	NO_NSEC = YesPlease
>  	NEEDS_LIBGEN =
>  	NEEDS_CRYPTO_WITH_SSL = YesPlease
> -	NEEDS_IDN_WITH_CURL = YesPlease
> -	NEEDS_SSL_WITH_CURL = YesPlease
> +	CURL_LDFLAGS = -lssl -lcrypto -lidn

OK, as long as we describe how to update their config.mak to adjust
to the new world order, the "regression" I noticed earlier is not
too bad, and the way the new CURL_LDFLAGS variable drives the build
is much more direct and transparent than via the old way to specify
NEEDS_*_WITH_CURL to affect the build indirectly.

I think such "describe how to configure in the new world order"
should go to where NEEDS_*_WITH_CURL used to be, e.g. "Define
CURL_LDFLAGS to specify flags that you need to link using -lcurl;
see config.mak.uname and look for the variable for examples"
or something like that, perhaps.

Thanks.
