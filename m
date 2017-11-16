Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B101B201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 01:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbdKPBtF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 20:49:05 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:53533 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932317AbdKPBtD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 20:49:03 -0500
Received: by mail-qt0-f169.google.com with SMTP id n61so39027297qte.10
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0O7jobYK3puUFwTD+sBY6SxUxRZCog3Nh5wzpFlYMbU=;
        b=BY4G7bSkjOkBJssmQxu2yxbIuKWUVQgmCFFdOLsT5XcIRcp3k/r5SIAX54A9V0KNo2
         03ly281uFGtWbT0NyptZV3MMmEepXvq1z7EyJFGaDWwbLwTsqFmiia2MsnvaWXksf+bK
         nEt33x7z3f2AwT6mAqFuAvAHong423azMrdNPrfHY4/b+fxitDHdix6FVfI0eHD2ko5D
         YMVRxIFFQEOhGWQhDW8EmFv9yFx3Fu3u/XPTbm9egOwTClTf5OwaZ8vMgueNpujyICVO
         XWuSFEagJj9EjmBTGA2c7Iwpbtc18oFxosfEi+CIBPVQWfbTak6fEHRoOZ3e74KSd9rR
         Nlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0O7jobYK3puUFwTD+sBY6SxUxRZCog3Nh5wzpFlYMbU=;
        b=tr8a+DaL310OlyYQqjsyLPDLtKLFFmqGITPF9hdXPhH+C2GcYsPFOzsJ3DFI142WIg
         mGIktz6YjM+VSc11CtRhLKRfcp/H4HRiCyuu+REQ1t/uf/VE/stq8FFpD9LMAXGnI78e
         G2C4XcyMZPiAQYxPkOOcvdr5U2h+wniIal3AEq1PZFDxD07hrwBzc662H3QcywdlYoQ/
         hRTCWaDiIVnuiIyWC4A6tYA9Cp/qAgwdzc+N4mjN7KLZrSs3woqPhIFUEO5o980KMH37
         eJaUEbj8nOmIgiHhirbG6xwvnGEfUP+UyWc6+9Qc0jMcm8COH7RR9QWABw9zqgpBjhDw
         kkDg==
X-Gm-Message-State: AJaThX4Vi4JGtsDHC5gbZtHY5oNC4C+Ehs3OH7x6VL/SVZ8O/8SLkfPg
        1slqlw6WrM4JtM5pVyGsm2VQq8c93tuTe29/7Bx5+w==
X-Google-Smtp-Source: AGs4zMY3nJll/mYXBGfJhlxgt/Ui2/FLmWDHdPTsWnwUt+uKbtDQ8WJ0M3bT8pkOj3uGZDPVkPEP0NREcuO3vGQKcw4=
X-Received: by 10.200.54.86 with SMTP id n22mr79078qtb.224.1510796942765; Wed,
 15 Nov 2017 17:49:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 17:49:01 -0800 (PST)
In-Reply-To: <xmqq7eurxak0.fsf@gitster.mtv.corp.google.com>
References: <20171115003043.24080-1-sbeller@google.com> <20171115003043.24080-8-sbeller@google.com>
 <20171114175207.f23d492045d52b8aa16c00be@google.com> <CAGZ79kaum5py=14kdFy1a+K_0MzfaD5boYStixh=1aY2tUCV-Q@mail.gmail.com>
 <xmqq7eurxak0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 17:49:01 -0800
Message-ID: <CAGZ79kY109yTQESzVg69nsibucAhvP0m+vKUH21xB9m7WTGaFg@mail.gmail.com>
Subject: Re: [PATCHv4 7/7] builtin/describe.c: describe a blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
>     Give an object a human readable name based on an available ref
>
> or something like that?

will use

> Or a sentence in BUGS section.

will add.

> A case (or two) I find more interesting is to see how the code
> behaves against these:
>
>         git tag -a -m "annotated blob" a-blob HEAD:Makefile
>         git tag -a -m "annotated tree" a-tree HEAD:t
>         git describe a-blob a-tree

Glad I added a test for exactly this (well only the a-blob case,
but a-tree will be the same):

test_expect_success 'describe tag object' '
     git tag test-blob-1 -a -m msg unique-file:file &&
    test_must_fail git describe test-blob-1 2>actual &&
    grep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
