Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73E71F462
	for <e@80x24.org>; Sat, 25 May 2019 13:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfEYNqJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 09:46:09 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43728 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfEYNqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 09:46:09 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45B4Jb0PJpz1rXgy;
        Sat, 25 May 2019 15:46:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45B4JZ6yhqz1qql0;
        Sat, 25 May 2019 15:46:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cG-SZ4kzvfyf; Sat, 25 May 2019 15:46:06 +0200 (CEST)
X-Auth-Info: DrcsDBb3fCDCAoAzdAgta4f3fYSokZZ/MwmyqMiJc73c9XbZbo6GElCXcxQlUAfC
Received: from igel.home (ppp-46-244-160-177.dynamic.mnet-online.de [46.244.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 25 May 2019 15:46:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id B385F2C162C; Sat, 25 May 2019 15:46:05 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
        <20190524070644.GF25694@sigill.intra.peff.net>
        <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
        <20190524081337.GA9082@sigill.intra.peff.net>
        <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
X-Yow:  I've been WRITING to SOPHIA LOREN every 45 MINUTES since JANUARY 1ST!!
Date:   Sat, 25 May 2019 15:46:05 +0200
In-Reply-To: <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 25 May 2019 15:26:53 +0200")
Message-ID: <87tvdi3aw2.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 25 2019, René Scharfe <l.s.r@web.de> wrote:

> Can Unicode symlink targets contain NULs?  We wouldn't want to damage
> them even if we decide to truncate.

The POSIX interface doesn't allow creating such a symlink, since the
argument to symlink is a C string.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
