Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4003E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBBTj1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:39:27 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45516 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeBBTj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:39:26 -0500
Received: by mail-wr0-f194.google.com with SMTP id h9so10590120wre.12
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u1U22BA1YbeEd21hs9t4xHbSqc6AwG/7DkIs1O19WDM=;
        b=CRMjH7tQ1sQMWJzEtx30rZm60GHcEJ4TsmW5kvX9YNlSQ4z/sIvvfozqXtY6YsumzS
         VJeurQrCOTmOaS+yeLREplAO2kMkg2yJ/fVrlp7kifpMtyaoHZREEHdqS16F2BlgXQSs
         GPOB8TEVCD5lSbKAB3uoizZcP9qXxZjdJ+LHJ3QCUheuGRvY5tNQ4I4RFEU/Kx8JZDdq
         yEX5RFUJ7fXTFaZRK2sjnHNgRlOuX05QdFQ8rQ6O37sFUE4nTEZ67jEf3NKRdieWi4cI
         1P/p1aeseFEncxHw8mXyI4NwGBSQXbmvwyv0Gxr6xy1NLVezFtjBlCCY2gz/tC42vYP8
         Ql0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u1U22BA1YbeEd21hs9t4xHbSqc6AwG/7DkIs1O19WDM=;
        b=mc8MyBdJdxmm8c8DAiZp+0p/+6I8YMlO7fWQFL5okJHWhitng+B1qm419ws8GuwqqR
         9wfg9b1M0MBgx4fXfocu9lgpKwzzLySfseUQemEg/yXAtzAu0NQSmMKAhAQadlRiVQoN
         OPnb3DyI2FOs9RMWqmxlfNbtOHeTcagrO5XTfB4S7mhnKYLj2yYKo5Jwnbzoj6BW+Py4
         FcpYY2fsq8zxIXPyu2xHPvLsEpjlRkT5kmOzUnZun8q/1BC0gJKNxDdQowVb5oVydBdC
         O6Y8yfNVxDvtRCnccwgYCu2MOIzZv09E+OH+4wkVCDaXYYYYmhPHzf/oqLY3BvH0oH1u
         b5oA==
X-Gm-Message-State: AKwxytfI1cf/+MJFff71UaCTwJApwNgZh0FuWLwyUxg9YS3Yvv/xoEYO
        AXmKeWm364wNY8Vx5LTQgZA=
X-Google-Smtp-Source: AH8x224I3XVZ02TcXTSg3OXCa7kGc/endctWfWHDsxb+dJaB+/kcQFbCnIQfamDCRR06MV9DdZtmUQ==
X-Received: by 10.223.133.148 with SMTP id 20mr2335588wrt.176.1517600364459;
        Fri, 02 Feb 2018 11:39:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 89sm3036162wrq.16.2018.02.02.11.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 11:39:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/12] hash: move SHA-1 macros to hash.h
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
        <20180201021848.533188-2-sandals@crustytoothpaste.net>
Date:   Fri, 02 Feb 2018 11:39:22 -0800
In-Reply-To: <20180201021848.533188-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 1 Feb 2018 02:18:37 +0000")
Message-ID: <xmqqmv0rchat.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +#ifndef platform_SHA_CTX
> +/*
> + * platform's underlying implementation of SHA-1; could be OpenSSL,
> + * blk_SHA, Apple CommonCrypto, etc...  Note that including
> + * SHA1_HEADER may have already defined platform_SHA_CTX for our
> + * own implementations like block-sha1 and ppc-sha1, so we list
> + * the default for OpenSSL compatible SHA-1 implementations here.
> + */

This nit has been with us for a long time, but "Note that including
SHA1_HEADER may have..." has been way too stale a comment for quite
some time.  It was made different from "including SHA1_HEADER" by
f18f816c ("hash.h: move SHA-1 implementation selection into a header
file", 2017-03-11).

Perhaps

	Note that we may have already defined platform_SHA_CTX for our
	own implementations like block-sha1 and ppc-sha1, so we list
	...

or something.
