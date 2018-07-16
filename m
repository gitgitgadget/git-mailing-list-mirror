Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C352F208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 10:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeGPLGO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 07:06:14 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:32977 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeGPLGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 07:06:13 -0400
Received: by mail-it0-f48.google.com with SMTP id y124-v6so11162222itc.0
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EnhSqq/4qprIvFjCRuNtvJ0fWJ16OuX686GUpnGwNXI=;
        b=jMFinlfi+2emdFjtcAWH+e0DzbJBbRW8XldKKfvqUL8L/u6dS0vfr1aOtgD/+F6ZFa
         mVqO+bCKBtUFY0jJxkAVrbh/325Rfct+p/dO+i7a7/r+3VrRJuB6Gu+Wlnscfny0s0zP
         tBhTM6MG+/1BN/uniwBEIN0iZJPWX6uC62gSi1q9pw7fvaUTJ0kTRecAqIo+jnFMQTWt
         UjUlaCZB6rwVtw1Zun/Y/Fmn3XSaVLaDDrkv9B13QBfEx3KmwVZnW7C/o80UEp0b+eYt
         BtAtK34w91mQLzq/wg9H4wso0IfzrKrvbWZV/jsvMIBuaKX5RyCjUEf1KCkIurX37skG
         /hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EnhSqq/4qprIvFjCRuNtvJ0fWJ16OuX686GUpnGwNXI=;
        b=BlkD3sonTICIbwO7fIk7UJsj2srKJqMMB5dRsp/KgxIb95bBidxzWao2xMk0UW5P3m
         HjjOPQGj173mEqHe3k3m6HgfBbeZjr+rpEbVudFQqRC70l2F4V3iyLk2D/9SfJI/7I0z
         gY8Rk8vtYo+x6O2V2OnEijUxT7LtVL9YDLCwPfhdTVNispOJ/WszSsMMuJBH4v/4NMqn
         kzTie/ml49whccCNZ5H7Y7xMmITjW+wRF5LNLwTb4cTE7skPfPYOTruUvMHlc5eQ+aat
         xV8zx2fjYkEBoOA34th7SZvSiyx0NDWUwfI5BNpQyF24M3X4QP5t2SjGlLBrGpWtQVDM
         71uA==
X-Gm-Message-State: AOUpUlGYVatjF6WeOP3DvVgNH28znggwqC/wlcYlROBkxraXM0ISIVWm
        sInh5Stn96lffFvfi+dipG58U7NTsWmvkHVIx6bipbJK
X-Google-Smtp-Source: AAOMgpcY+K8OwmNOYbkYePnKdcfToWRnGMxYRewpqewX42BDjgsl3pF8bdLCHUQIF+Io5+u1ZwylRZB6g0+s0Ab48eo=
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr11550233itl.96.1531737565077;
 Mon, 16 Jul 2018 03:39:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:39:24
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 16 Jul 2018 12:39:24 +0200
Message-ID: <CAP8UFD0JYOxYd=SxK6vQ54+pT5mh+vdZ8NMg511QCh6TpKvb9Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 41
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        Keccak Team <keccak@noekeon.org>,
        Gilles Van Assche <gilles.van.assche@noekeon.org>,
        Derrick Stolee <stolee@gmail.com>, David Lang <david@lang.hm>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-41.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/299

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

This month a summary of one of the Git standups on IRC (see
https://public-inbox.org/git/20180713170018.GA139708@aiede.svl.corp.google.com)
would be very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday July 18th.

Thanks,
Christian.
