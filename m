Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8669C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7CC215A4
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgIGWLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:11:14 -0400
Received: from aibo.runbox.com ([91.220.196.211]:56860 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgIGWLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 18:11:12 -0400
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1kFPLT-0004qE-Rf; Tue, 08 Sep 2020 00:10:39 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1kFPLC-0003uW-43; Tue, 08 Sep 2020 00:10:22 +0200
Date:   Mon, 7 Sep 2020 22:10:10 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200907221010.GA1554@pluvano.com>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
 <20200810100249.GC37030@coredump.intra.peff.net>
 <20200811041728.GA1748@pluvano.com>
 <20200811045509.GA81227@coredump.intra.peff.net>
 <20200905025518.GA1524@pluvano.com>
 <xmqqr1rg7vl8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1rg7vl8.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-04 20:26:11-0700, Junio C Hamano wrote:
> Emma Brooks <me@pluvano.com> writes:
> 
> > However, I couldn't find a way to get "rev-list --format" to separate
> > commits with NULs.
> 
> A workaround would be "git rev-list --format='%s%x00'", iow,
> manually insert NUL
> 
> I would have expected "-z" to replace LF with NUL, but that does not
> appear to work X-<.

Thanks. I'll need to ignore the extra LF when parsing then. Later, "-z"
support could be added/fixed in rev-list (#leftoverbits?) and gitweb
could be updated to use that instead.
