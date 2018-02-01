Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5DEB1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeBAWGj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 17:06:39 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:42745 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeBAWGh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 17:06:37 -0500
Received: by mail-yw0-f182.google.com with SMTP id u17so11678015ywg.9
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 14:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nfMiGHAB22qi9CxkFxd59sLd0pEMv2eI6PBktZNSClI=;
        b=DC6C0lX2nsNxbyaBKESu62RA7yDyxhvELR1Fa6gFuJ5q39LKUE+RHPLaMzzxbCzOZ0
         gLolBI2QhM4gPrQOHCp+ODNnfEq0gSEK8FKmI5Dk/tdxSKIHXpNIndA9oNa9S1qPFTER
         IBaB4JKndVIvAnKVUMKTSwbQTUptcniUspWlxOAuE0PwxMPdU2X1kjpjFaZ60utxCzxQ
         9sz4IxUTMmn6OSRH6ZwhXl+RcQM69S6GeIVxmGk9sesPZu1YdsZwAggEjbwZdBC9uHmo
         Wdwq/JizuUGmoETwa0wSA5RbuT/kFzRWFF/UUwVPKOgcmokkvAUR9sCt3OqxeJGp10BJ
         gIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nfMiGHAB22qi9CxkFxd59sLd0pEMv2eI6PBktZNSClI=;
        b=I9LbvXMRcb2L5aj4fbLnzQ3o8uRpKbsfSByyMQy4xF2rwZ/7TlCFnSxDeOBSDEeaA0
         zuaxVBm8MljIEzpibo6SRWPEFIuq8aM3BqDeais1EQ5BYNW2WOPKtbXFDHEzzJz9nyQh
         BnImHFc/pan8C1hicv/StkZYWlHUhLGxbl2DehcE6JRcP2z82WzniXuz38RmXRNNUNRf
         YzyHQtswwOnwMDgbcSyDGTGnSqy2aGXsA4qiMlAiHuqOB1Rpx84dQCF48AWAnzxzQ+IC
         EPtdQn6gRAgwQdNoCcNDUb+ER0wQ2PhpIazV7tb9q2m9Vd8KmjvJemYB/sYS1wEZeoEs
         fGDw==
X-Gm-Message-State: AKwxytfvhNl1rWhJhK5FBRHIBntALF4V8SwUtB9Edi9YgegqrPciz0Ck
        BkE0ZoRVMdjRbfv+kUPU/m858jufjIwfK2dkdw/AWQ==
X-Google-Smtp-Source: AH8x224NIKwx9zVAKp1PEOtQ4M2mRcbSE8tIwDIZ8GeQD/g5JQSoMZ9j945oEcX/nNsPosvQbLPvQLWNzWblc98fAUc=
X-Received: by 10.37.133.12 with SMTP id w12mr17585393ybk.213.1517522796979;
 Thu, 01 Feb 2018 14:06:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 1 Feb 2018 14:06:36 -0800 (PST)
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Feb 2018 14:06:36 -0800
Message-ID: <CAGZ79kZ5FT7hD4q+=-AVBUzTaHUjR1sQ3ksmJGHfXzon-az2xA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] object_id part 11 (the_hash_algo)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 6:18 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This series includes various changes to adopt the use of the_hash_algo
> for abstracting hash algorithms away.

This series looks good to me.

>
> Changes from v1:
> * Fix comments referring to SHA-1.
> * Switch hash function wrappers to take git_hash_ctx *.
> * Use a const int variable for a constant value.
> * Wrap an overly long line.
>
> brian m. carlson (12):
>   hash: move SHA-1 macros to hash.h
>   hash: create union for hash context allocation
>   builtin/index-pack: improve hash function abstraction
>   builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
>   sha1_file: switch uses of SHA-1 to the_hash_algo
>   fast-import: switch various uses of SHA-1 to the_hash_algo
>   pack-check: convert various uses of SHA-1 to abstract forms
>   pack-write: switch various SHA-1 values to abstract forms
>   read-cache: abstract away uses of SHA-1
>   csum-file: rename sha1file to hashfile
>   csum-file: abstract uses of SHA-1
>   bulk-checkin: abstract SHA-1 usage
>
>  builtin/index-pack.c     | 108 +++++++++++++++++++++++------------------------
>  builtin/pack-objects.c   |  52 +++++++++++------------
>  builtin/unpack-objects.c |  18 ++++----
>  bulk-checkin.c           |  28 ++++++------
>  cache.h                  |  25 -----------
>  csum-file.c              |  46 ++++++++++----------
>  csum-file.h              |  38 ++++++++---------
>  fast-import.c            |  70 +++++++++++++++---------------
>  hash.h                   |  40 +++++++++++++++---
>  pack-bitmap-write.c      |  30 ++++++-------
>  pack-check.c             |  32 +++++++-------
>  pack-write.c             |  77 ++++++++++++++++-----------------
>  pack.h                   |   4 +-
>  read-cache.c             |  58 ++++++++++++-------------
>  sha1_file.c              |  72 +++++++++++++++----------------
>  15 files changed, 351 insertions(+), 347 deletions(-)
>
