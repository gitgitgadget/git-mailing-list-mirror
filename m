Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010B2C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14420833
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfK3IAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:00:44 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33719 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfK3IAo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 03:00:44 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47Q3hl6PpFz1qqkl;
        Sat, 30 Nov 2019 09:00:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47Q3hk4mJkz1qqtG;
        Sat, 30 Nov 2019 09:00:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id RPUKYl_EQMnw; Sat, 30 Nov 2019 09:00:37 +0100 (CET)
X-Auth-Info: SEO51CwDV6ktD2ZKzkvFBqPIv+F1e03OFSg8r6ylG95k71FPWzCE4YQkru1sI+Ja
Received: from hase.home (ppp-46-244-176-84.dynamic.mnet-online.de [46.244.176.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 30 Nov 2019 09:00:37 +0100 (CET)
Received: by hase.home (Postfix, from userid 1000)
        id 8A3AA10156C; Sat, 30 Nov 2019 09:00:36 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7812: expect failure for grep -i with invalid UTF-8 data
References: <20191130004653.8794-1-tmz@pobox.com>
X-Yow:  While my BRAINPAN is being refused service in BURGER KING,
 Jesuit priests are DATING CAREER DIPLOMATS!!
Date:   Sat, 30 Nov 2019 09:00:35 +0100
In-Reply-To: <20191130004653.8794-1-tmz@pobox.com> (Todd Zullinger's message
        of "Fri, 29 Nov 2019 19:46:53 -0500")
Message-ID: <87a78ddc9o.fsf@hase.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 29 2019, Todd Zullinger wrote:

> When the 'grep with invalid UTF-8 data' tests were added/adjusted in
> 8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data, 2019-07-26)
> and 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
> 2019-07-26) they lacked a redirect which caused them to falsely succeed
> on most architectures.  They failed on big-endian arches where the test
> never reached the portion which was missing the redirect.

It's not about big vs little endian, it's only about JIT vs non-JIT.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
