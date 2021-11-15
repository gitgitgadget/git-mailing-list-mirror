Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE0C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49387614C8
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbhKPAU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbhKOVBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 16:01:48 -0500
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Nov 2021 12:53:26 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3BC06122C
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 12:53:23 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HtLkV36sVz1sCwH;
        Mon, 15 Nov 2021 21:43:30 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HtLkV2CR4z1qqkB;
        Mon, 15 Nov 2021 21:43:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id uYsxoaTgS55d; Mon, 15 Nov 2021 21:43:29 +0100 (CET)
X-Auth-Info: I+gA5ncZZmbmPOcE5HD/D+ZnDBs6ViYK1bFRioxnqhp7T0/6iy0UuODEN1/BBGn7
Received: from igel.home (ppp-46-244-187-164.dynamic.mnet-online.de [46.244.187.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 15 Nov 2021 21:43:29 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 559752C38A1; Mon, 15 Nov 2021 21:43:28 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211015161356.3372-1-someguy@effective-light.com>
        <20211015161356.3372-3-someguy@effective-light.com>
X-Yow:  If I have enough money to buy 5,000 CANS of NOODLE-RONI, can I get a
 VAT of MARSHMALLOW FLUFF free??
Date:   Mon, 15 Nov 2021 21:43:28 +0100
In-Reply-To: <20211015161356.3372-3-someguy@effective-light.com> (Hamza
        Mahfooz's message of "Fri, 15 Oct 2021 12:13:56 -0400")
Message-ID: <877dd9i1zj.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This breaks 'PCRE v2: grep ASCII from invalid UTF-8 data'.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
