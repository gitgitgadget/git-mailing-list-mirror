Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774761F424
	for <e@80x24.org>; Sat, 31 Mar 2018 11:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeCaLgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 07:36:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34408 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeCaLgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 07:36:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id w2so134255wmw.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DfgfaJ3n1Alw/GVbEyMEmhNFRea/95iAgg+Pu580tgI=;
        b=tJlTxfXqkdzNXlv2o0pqZAlFy3Yc2fvw/whVzg3cAVyiD4ea6YzmmVPvPZ9+BsSIfQ
         Qd9N0vfj+TuxzMznmS4SK4B+anqnfS/3bWcNi1HkDrzo3nV99BPqiG8DxuMAxG+8CcGL
         8UdpR+hYu5/Ifc4AoDDx4fHOcig3u8RUC51A5cxrxQsN1BHKrHG6KNJLhILyEP3OV9sE
         Y58DO2elKDE4zx4+N1Il6vt0eZDQZYpZnwDlKIssDh9iHRF2L8ns4eX+/mPz3HIhNooq
         tgROKjWsw4fT7ZW33UFzlGihNWWuFKBXZCSWeWK1HHDzEL7Q5Q2/2moOEN0Z0q9UR7UB
         auGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DfgfaJ3n1Alw/GVbEyMEmhNFRea/95iAgg+Pu580tgI=;
        b=rvYH4L15udWyi5yKo68tHyIWPRSfRP692rebO7pgYytz4vg04j0enhl0wJL8tt/qjS
         ZLA8uNWswNsm7iM9QlcQAK7YevwLSF3vHqocqaqIRpjMBeIkBRQXnmgHBuWfohnqLSy1
         C7vprXg5gMGmXB5uCBlLoekcoBY3RRN/JwFVO89l3ZQA83mJAt6pm8QP6FOieZXRgbQP
         XIXO7xeeqB1KLawXkSBtDN5YZrG9qSl9IWKnqtHc4IQ5h6oEAq2NgOAU6AltClz2F083
         V2dHvfK356hnBdKPONIsFUQYFIDpbV0Od/qXk5vb6oV6tSNpgBaQUovCoQEPzcJZ0DpQ
         VO/g==
X-Gm-Message-State: AElRT7Ha2x2vtkIOKsvAhDcPivyXbbKw9wujwJxaWbksatmZX1MXN9AW
        JjhGvKUTF7zp6QJoaCI/BjI=
X-Google-Smtp-Source: AIpwx49Ab7dZkn1guNwVjhXq+vSScEhDlRljKShr8J2yDacnXz1B4Ayn7tDIlq6kR+EibxUtOuHEsw==
X-Received: by 10.80.232.11 with SMTP id e11mr5695322edn.12.1522496182871;
        Sat, 31 Mar 2018 04:36:22 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id e56sm6951534edb.84.2018.03.31.04.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 04:36:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v8 00/15] nd/pack-objects-pack-struct updates
References: <20180324063353.24722-1-pclouds@gmail.com> <20180331100311.32373-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180331100311.32373-1-pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 13:36:20 +0200
Message-ID: <87efk0wk7f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 31 2018, Nguyễn Thái Ngọc Duy wrote:

I'm testing this and it looks good to me so far, aside from this:

> - use git_env_*() instead of manually handling getenv() values
> [...]
>  	struct packed_git **mapping, *p;
> -	int cnt = 0, nr = 1 << OE_IN_PACK_BITS;
> -
> -	if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
> -		/*
> -		 * leave in_pack_by_idx NULL to force in_pack[] to be
> -		 * used instead
> -		 */
> -		return;
> -	}
> [...]
>
> +	if (git_env_bool("GIT_TEST_FULL_IN_PACK_ARRAY", 0)) {
> +		/*
> +		 * do not initialize in_pack_by_idx[] to force the
> +		 * slow path in oe_in_pack()
> +		 */
> +	} else {
> +		prepare_in_pack_by_idx(pdata);
> +	}
> [...]
> diff --git a/t/README b/t/README
> index 02bfb3fed5..c01d210c15 100644
> --- a/t/README
> +++ b/t/README
> @@ -291,16 +291,26 @@ expect the rest to function correctly.
>  and know what setup is needed for it.  Or when you want to run
>  everything up to a certain test.
>
> +
> +Running tests with special setups
> +---------------------------------
> +
> +The whole test suite could be run to test some special features
> +that cannot be easily covered by a few specific test cases. These
> +could be enabled by running the test suite with correct GIT_TEST_
> +environment set.
> +
> +GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
> +
>  GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
>  path where there are more than 1024 packs even if the actual number of
>  packs in repository is below this limit.
>
> -GIT_TEST_OE_SIZE_BITS=<bits> exercises the uncommon pack-objects
> -code path where we do not cache objecct size in memory and read it
> -from existing packs on demand. This normally only happens when the
> -object size is over 2GB. This variable forces the code path on any
> -object larger than 2^<bits> bytes.

The docs here say set these env variables, but actually
GIT_TEST_FULL_IN_PACK_ARRAY is a special snowflake in requiring you to
set a bool value.

I'd set GIT_TEST_SPLIT_INDEX=YesPlease already in my test setup & just
copied that as GIT_TEST_FULL_IN_PACK_ARRAY=YesPlease, but that'll error
out since it's expecting bool, not the env variable to be set.

I really don't care which we use, but let's use either if(getenv()) or
if(git_env_bool()) consistently, and then have the docs either say "if
set" or "if set to a boolean value (see git-config(1))".
