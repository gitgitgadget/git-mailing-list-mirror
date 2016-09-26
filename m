Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2D21F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 04:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbcIZEpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 00:45:41 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34419 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbcIZEpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 00:45:40 -0400
Received: by mail-qk0-f171.google.com with SMTP id n185so153695470qke.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 21:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0v25bI8WATSJXvJwDnNUCallXAB7+NxGbmlVu6rvD3I=;
        b=vTUIV5LBmgff8nDqxs2m+0zTkGq8jUu4oPmJedWzCu8f0sfRqpPYQoY/SIcc/JSN81
         W7AoBdUYw05sWnWtyINdnNSfUN1MdnctnOokzzMjxsydOfjIFiAe7qKdjvTseLJ9BTjy
         Iz1fG/BVm2WQoDaeQtUEqCpEEtORE51PUdskqOgjq9Br/Py5MDfvq+WUxeeKGk4Imkwc
         CdMKJJKHiGIDz5LsgCbGcJM5YJrs37pvdj11C4c0PHXFmH8sIF4lDy7jPHqydwKSgm1U
         XxoIG2eLYIN+WKdL98V68Xkx4g309aj33LhSAMd7UGGGHWpQwxD54afNJl538MNFmqWA
         OdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0v25bI8WATSJXvJwDnNUCallXAB7+NxGbmlVu6rvD3I=;
        b=DT9wg9qoTxrId40XL9M1jdyA1OAXj59Gk58kFna5CKEX+DyQzTFS9O0MEAgwFZnzOx
         nKsKN9lXRLqaqdqspnaZXYvz4OkcBhPT0VDI1xXAQZhnkRP7Yv/mXrIjb74IqGj5QIak
         onTa+8baWnFDBuT9izCdNUGeCD2JpPbI5ilHNf0R47rMaxS0RFUOt3QLVDXo7qBRzic3
         N6Q11jJ8YqCyLN9UESlvtTFIf7e8Qb8NlLSJMFN8OhRFSbc/SsmZjjPRXDWPWTSyo+kl
         YpAXVzvEDMapAiQEWbokVV325BZom7m83ZDidY6KCCA1OXG19vARLQGBWQ4QTSMkOo4J
         r1LQ==
X-Gm-Message-State: AA6/9RlG6cIuqQKhqRBrBuRbmoHsRsOnGht0JT1d2TRayMM+RpXkoddU8LxMjWTufVvUJjVMyBn7x6GDiplrwA==
X-Received: by 10.55.176.67 with SMTP id z64mr20818309qke.74.1474865139395;
 Sun, 25 Sep 2016 21:45:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.19.40 with HTTP; Sun, 25 Sep 2016 21:45:18 -0700 (PDT)
In-Reply-To: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com> <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sun, 25 Sep 2016 21:45:18 -0700
X-Google-Sender-Auth: 7hQLy7mlunbY6t9391eiV9Mpm_c
Message-ID: <CAPc5daV1YJaEqH5eZCej3nkg8htHVDWQu0V0uoC4gVmPYpDL9Q@mail.gmail.com>
Subject: Re: Changing the default for "core.abbrev"?
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 9:34 PM, Jeff King <peff@peff.net> wrote:
>
> An easier (but less automatic) tool would be to improve our error
> message for the ambiguous case, and actually report details of the
> candidates. I'm working up a patch now.

That sounds like a fun little lunch-break project. Thanks.
