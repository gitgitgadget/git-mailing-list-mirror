Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566C9C433FE
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiK2Ss4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 13:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2Ssn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 13:48:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0A92F001
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:48:35 -0800 (PST)
Received: (qmail 14527 invoked by uid 109); 29 Nov 2022 18:48:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Nov 2022 18:48:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22264 invoked by uid 111); 29 Nov 2022 18:48:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Nov 2022 13:48:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Nov 2022 13:48:34 -0500
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
Message-ID: <Y4ZUAsT7UKguvXiz@coredump.intra.peff.net>
References: <20221127093721.31012-1-sorganov@gmail.com>
 <20221127093721.31012-4-sorganov@gmail.com>
 <xmqqedtn957j.fsf@gitster.g>
 <8735a3gmuq.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735a3gmuq.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 05:44:29PM +0300, Sergey Organov wrote:

> >> +	if (set_func != NULL) {
> >
> > Please write it like so:
> >
> > 	if (set_func) {
>[...]
> Thanks! Do we now have tool for auto-check for these issues? I still use
> one from Linux kernel, and it didn't object to this form.

Running "make coccicheck" will find this, but of course you need to have
coccinelle installed. Note that if it finds anything, "make" won't
report an error. You have to check for non-empty files in
contrib/coccinelle/*.patch.

-Peff
