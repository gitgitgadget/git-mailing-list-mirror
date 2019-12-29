Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA92C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D15206E4
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL2Onf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:43:35 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43198 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2Onf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 09:43:35 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47m3GD5pTzz1qqkj;
        Sun, 29 Dec 2019 15:43:32 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47m3GD56B1z1qql3;
        Sun, 29 Dec 2019 15:43:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id f-F3A0sPzrzp; Sun, 29 Dec 2019 15:43:31 +0100 (CET)
X-Auth-Info: beeFYkJQWa+fSn0JX1wpPZiAJ45Yuqfuq9Wx/0g52GFA8910HgHWGhfeL22/K3K8
Received: from igel.home (ppp-46-244-161-188.dynamic.mnet-online.de [46.244.161.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 29 Dec 2019 15:43:31 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 9E77D2C01AE; Sun, 29 Dec 2019 15:43:30 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: ERANGE strikes again on my Windows build; RFH
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
        <20191229142909.7bmjbrroboitvnzq@tb-raspi4>
X-Yow:  Spreading peanut butter reminds me of opera!!  I wonder why?
Date:   Sun, 29 Dec 2019 15:43:30 +0100
In-Reply-To: <20191229142909.7bmjbrroboitvnzq@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 29 Dec 2019 15:29:09
 +0100")
Message-ID: <87mubb8a5p.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 29 2019, Torsten Bögershausen wrote:

> At least the documentation about vsnprintf does not mention that errno is touched at all.
> That is the man pages for Linux and Mac OS, or see here:
> https://linux.die.net/man/3/vsnprintf

Refer to the POSIX docs for vsnprintf, which documents its errno usage.
In general, any library call can touch errno, unless it is explicitly
documented _not_ to touch it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
