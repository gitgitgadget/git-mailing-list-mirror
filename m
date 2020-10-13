Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB343C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495E720E65
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbgJMGfz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 02:35:55 -0400
Received: from mx.pao1.isc.org ([149.20.64.53]:19278 "EHLO mx.pao1.isc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389353AbgJMGfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 02:35:55 -0400
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 9A5763AB006;
        Tue, 13 Oct 2020 06:35:54 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id 90E6416003E;
        Tue, 13 Oct 2020 06:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id 7B819160053;
        Tue, 13 Oct 2020 06:35:54 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MniznaXJDoIE; Tue, 13 Oct 2020 06:35:54 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 608AE16003E;
        Tue, 13 Oct 2020 06:35:53 +0000 (UTC)
Date:   Tue, 13 Oct 2020 08:35:49 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] merge-base, xdiff: zero out xpparam_t structures
Message-ID: <20201013063549.GA3278@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-2-michal@isc.org>
 <xmqqsgajnrvo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgajnrvo.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, Johannes,

Thank you for your feedback.

> But the patch is good as-is, given especially the way how xecfg is
> cleared the same way in builtin/merge-tree.c::show_diff().

I just wanted to explain that I initially planned to take the "= { 0 }"
approach and I started checking whether all xpparam_t structures in the
source tree are stack-allocated, but I quickly noticed that, as Junio
pointed out, existing code showed an inclination towards memset(), so I
settled for that instead.

> Will queue.  Thanks.

I have a process question: since the other two patches in this patch
series will need a v3, would you like me to keep bundling patch 1 in
this series or should I only send revised version of patches 2 & 3 in
v3?

-- 
Best regards,
Michał Kępień
