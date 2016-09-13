Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF97520984
	for <e@80x24.org>; Tue, 13 Sep 2016 12:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbcIMMdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 08:33:20 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36692 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbcIMMdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 08:33:19 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so162623629qkc.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=z5sqLcgY2cmABAAHosmeZ5RfYu2q4Vs2FKWo0QY3ac0=;
        b=KlxLtob775z5iMvuOagc7Y6TzHwergmZJobfszeTLqQjDgfmqnP0/WKaze67WYzzoL
         +MMjx4DyA7qHn7Z8Ty13S8dNpAzhim0ctzNYH9AEEMAT4laOk0+e3bNkIPGaabZoJC/g
         HRSzpBltaaGAh+Xhs2r60ED4nvSrkr7ZWYIWu7l6N26K/J3uJ2dpGjPGyAlnjwotaNy3
         wwBQnurW2LqZ63Bauw8fSAjlTedC7a1nlaIx+kvjCIEiJA+g268siTb0JDI4DigzzaF3
         4j/SQhmsRX0vW/vxrkp3hTf+BJrNcHedkhHPY1DidZXEkwFgihxnv42tTI4+dYunSqya
         BiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=z5sqLcgY2cmABAAHosmeZ5RfYu2q4Vs2FKWo0QY3ac0=;
        b=PxBSlfl6gNUq+rRwfNfrSGorfIPq+6EYfOHmJMeoaIYtspFDFbn5/9EZo6swGo/eUL
         HN/FcFXhfqBXMwWB42fa/n7CzJ78oRCXOQRfEjqsDolpKamcIrarJMjuo77E8Wvtembs
         dIxPXQzq65J1AgklnaL+Z9lWnvpLbvRbDQP+HMFE6K700vbCFkocIk9eKkoBWBf5VYPH
         2fdHzOG+lQXBwnCTNWbX3CYJYfd1AtcVwoEI8bghl5wInMBxB/gSmhkExkf2RoI/ySqd
         SsU4YQy4x3dhOOKhqX8LsIvmDqgi5P+Rs6jJdX3B13edoN+Abu0Jjp6tQ9HD2djidpNl
         Xlyg==
X-Gm-Message-State: AE9vXwNHggBqJEZLjAsiRFTUDZPJTU+lwEF8qOdjKiE/S84CI5iW6uvsNdrjZATg18iryw==
X-Received: by 10.55.156.5 with SMTP id f5mr561362qke.177.1473769998556;
        Tue, 13 Sep 2016 05:33:18 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t64sm4425649qke.5.2016.09.13.05.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2016 05:33:17 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <pclouds@gmail.com>,
        "'Ben Peart'" <benpeart@microsoft.com>
References: <20160909192520.4812-1-benpeart@microsoft.com>      <xmqq1t0sagcm.fsf@gitster.mtv.corp.google.com>  <13ef001d20d21$2d2ea840$878bf8c0$@gmail.com> <xmqqtwdkzwpp.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtwdkzwpp.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH v2] checkout: eliminate unnecessary merge for trivial checkout
Date:   Tue, 13 Sep 2016 08:33:17 -0400
Message-ID: <001901d20dbb$0218f080$064ad180$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFCTziZO7Bhn9UGJz40Mb8DwNCg2wIQnMjDAagnmEYCoJoXaKFkCzKQ
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, September 12, 2016 4:32 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; pclouds@gmail.com; 'Ben Peart'
> <benpeart@microsoft.com>
> Subject: Re: [PATCH v2] checkout: eliminate unnecessary merge for trivial
> checkout
> 
> "Ben Peart" <peartben@gmail.com> writes:
> 
> > I completely agree that optimizing within merge_working_tree would
> > provide more opportunities for optimization.  I can certainly move the
> > test into that function as a first step.
> 
> Note that "optimizing more" was not the primary point of my response.
> 
> Quite honestly, I'd rather see us speed up _ONLY_ obviously correct and
> commonly used cases, while leaving most cases that _MAY_ turn out to be
> optimizable (if we did careful analysis) unoptimized, and instead have
them
> handled by generic but known to be correct codepath, if it means we do NOT
> to have to spend mental bandwidth to analyze not-common case--that is a
> much better tradeoff.
> 
> The suggestion to move the check one level down in the callchain was
> primarily to avoid the proposed optimization from being overly eager and
> ending up skipping necessary parts of what merge_working_tree() does (e.g.
> like I suspected in the review that the proposed patch skips the check for
> "you have unmerged entries" situation).

The check for unmerged entries makes complete sense when you are about 
to attempt to merge different commit trees and generate an updated index 
and working directory.  This optimization however is trying to skip 
those expensive steps for the specific case of creating a new branch and 
switching to it.  In this narrow (but common) case, all that needs to 
happen is that a new ref is created and HEAD switched to it.  Since 
we're not doing a merge, I don't believe the check is necessary.


