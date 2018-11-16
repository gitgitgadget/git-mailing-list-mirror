Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDB31F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeKQFU7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:20:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35661 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:20:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so22115449wmt.0
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8lVbAvhd1PPwoeDUG9+aVOr/Y11ZjVv9IUb/ebOhF24=;
        b=Oplb9ZPBY3huCqQ+kDP393Bomzef0JL3kI5UM3gDr+t0drFriBRjwIOlf/SF5orEzM
         EhaRb31fcVeIkTtJtH4Wvvl9QtSWS1gu06NEVCQm4TpVlynerdBJ6EmwsYeuJfSf7d4F
         qGIloGioBYVCpiAYgbIQrB2MNiTVHpH92+DS5r87umIKBVrAyLxu7RgqyC+NK7z1gvC1
         n1uJ8ozxuIUY7B/vBb0TW8ncYOGRr9ntc0+VzngUzVgu2Da7SDl9e1ANFjeaUpX16w6B
         3lRpjWu/sDJZfNWnIN/AKH0V2B3QAyfQY9Hqf2C3EY0SlZWDOcsjT1LGsdMWwrr4qOHl
         cGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8lVbAvhd1PPwoeDUG9+aVOr/Y11ZjVv9IUb/ebOhF24=;
        b=N1dhj5V26r8aLdMMj+RthYo2+j7eJYseNHNS6ZjA1zM4JC6/yv+bgdnOMaCVRyo9lz
         VszIKpAC9nfPfbmluHUtv2Rpl7udYeRCOSVcuWsndBW6q6LZeztntYvx9px5LzQDKZDS
         Mm8QnZeoDvoRpqaDkiAcs+GjtCmdvMrTwUiKB83eyCslYPaUHt/dg1R26N0lwPF5fY7N
         5Lmvf47Xfm6sdZt7b6ON3J9dEm8DZpkM+BIxNck1Ia9mzFWuorVDaHHaCztwQLVBYgDD
         APFHnDopEd5ugAgX5wUiw7X0L2C+vCALDcg3uJ62qCzOpkyx2suDbqevbQlLAnFvV9lo
         AeuA==
X-Gm-Message-State: AGRZ1gJXl3/tdPU57elcJzHVXh81dB5nlEivsdUALK8XEs40LQNuDlJk
        RfRVk2xZQkYgbXTxsI0IV0w=
X-Google-Smtp-Source: AJdET5ccEefJNGdv87pS3iHEqo/rRdabXx2M4Db0HBoYOY4SKS0Vw3rlyZXis1SFeOgIswhJK1LcRQ==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr9383281wmn.116.1542395239957;
        Fri, 16 Nov 2018 11:07:19 -0800 (PST)
Received: from szeder.dev (x4db1f8e7.dyn.telefonica.de. [77.177.248.231])
        by smtp.gmail.com with ESMTPSA id l5-v6sm31075618wrv.84.2018.11.16.11.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 11:07:19 -0800 (PST)
Date:   Fri, 16 Nov 2018 20:07:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same
 permissions
Message-ID: <20181116190716.GO30222@szeder.dev>
References: <874lcl2e9t.fsf@evledraar.gmail.com>
 <20181113153235.25402-1-avarab@gmail.com>
 <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
 <8736s43mps.fsf@evledraar.gmail.com>
 <CAP8UFD1Nd657Afgk6s+uNXMW=26Fg-6Jnv6ngB1biUX2mGBkSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1Nd657Afgk6s+uNXMW=26Fg-6Jnv6ngB1biUX2mGBkSw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 06:41:43PM +0100, Christian Couder wrote:
> On Tue, Nov 13, 2018 at 6:34 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:

> > I'm asking whether the bug in this patch isn't revealing an existing
> > issue with us not having any tests for N number of sharedindex.*
> > files. I.e. we have >1 of them, merge them and prune them, don't we?

We don't merge shared index files, but write a new one.

> I think we shouldn't have many of them. Usually we should have just
> one, though it's possible that switching the shared index files
> feature on and off several times or using temporary index files could
> create more than one.
>
> And there is clean_shared_index_files() which calls
> should_delete_shared_index() to make sure they are regularly cleaned
> up.

I would think that it's more common to have more than one shared index
files, because a new shared index is written when the number of
entries in the split index reaches the threshold given in
'splitIndex.maxPercentChange'.  The old ones are kept until they
expire, and 'splitIndex.sharedIndexExpire' defaults to 2 weeks (and
can even be be set to "never").

With the default 20% threshold a new shared index is written rather
frequently with our usual small test-repos:

  $ git init
  $ git update-index --split-index
  $ ls -1 .git/*index*
  .git/index
  .git/sharedindex.4370042739b31cd17a5c5cd6043a77c9a00df113
  $ echo 1 >file
  $ git add file
  $ git commit -q -m 1
  $ echo 2 >file
  $ git commit -q -m 2 file
  $ echo 3 >file
  $ git commit -q -m 3 file
  $ ls -1 .git/*index*
  .git/index
  .git/sharedindex.4370042739b31cd17a5c5cd6043a77c9a00df113
  .git/sharedindex.6aedbf71b1a6bdc0018078ec7571e1b21ba4b954
  .git/sharedindex.b9106e9b82a818a0e4e9148224fc44ea98f488a1
  .git/sharedindex.bad0b75d270a431b9e961cfc15df6ec935a67be8

> Anyway it's a different topic and according to what we privately
> discussed I just sent
> https://public-inbox.org/git/20181116173105.21784-1-chriscool@tuxfamily.org/
> to fix the current issue.
