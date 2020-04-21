Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2FC38A30
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 02:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA17208E4
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 02:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDUCXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:23:21 -0400
Received: from aibo.runbox.com ([91.220.196.211]:49028 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUCXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 22:23:21 -0400
Received: from [10.9.9.204] (helo=mailfront22.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jQiZC-0006R0-Jd; Tue, 21 Apr 2020 04:23:18 +0200
Received: by mailfront22.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jQiYy-0003e4-OW; Tue, 21 Apr 2020 04:23:05 +0200
Date:   Tue, 21 Apr 2020 02:22:56 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Ash Holland <ash@sorrel.sh>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Boxuan Li <liboxuan@connect.hku.hk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] userdiff: support Markdown
Message-ID: <20200421022256.GA29071@pluvano.com>
References: <20200421010035.13915-1-ash@sorrel.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421010035.13915-1-ash@sorrel.sh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-21 02:00:35+0100, Ash Holland wrote:
> I would also appreciate feedback on the word-diff pattern here, I have
> no real idea what should constitute a word in a Markdown document, apart
> from that it should probably be similar to the definition given for
> Fountain, given that Fountain appears to have somewhat similar inline
> syntax to Markdown.

Since Markdown can have raw HTML tags in many variants, it may make
sense to extend the word pattern to "[^<>= \t]+" like HTML's pattern so
tags starting/ending will not be considered part of a word.
