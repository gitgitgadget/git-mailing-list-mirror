Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB390C433E0
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF43207DA
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgGSGdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:33:36 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48591 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgGSGdf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 02:33:35 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B8Zn9484Kz1qrfD;
        Sun, 19 Jul 2020 08:33:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B8Zn9348Nz1qrh3;
        Sun, 19 Jul 2020 08:33:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id etEWv4v1fEiP; Sun, 19 Jul 2020 08:33:32 +0200 (CEST)
X-Auth-Info: JyXKJpW6Q6ryFxyaab06Syv9x2Dn2Ur4e+1OCxmHk/Nbqah9Tu0JxEh/n8X0Dlur
Received: from hase.home (ppp-46-244-178-99.dynamic.mnet-online.de [46.244.178.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 19 Jul 2020 08:33:32 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 5219F10289A; Sun, 19 Jul 2020 08:33:29 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 11/12] Fix error-prone fill_directory() API; make it
 only return matches
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
        <61d9c9d758e90c6afdaa1605b191f367650d18f0.1585714667.git.gitgitgadget@gmail.com>
X-Yow:  Where's my SOCIAL WORKER?
Date:   Sun, 19 Jul 2020 08:33:28 +0200
In-Reply-To: <61d9c9d758e90c6afdaa1605b191f367650d18f0.1585714667.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 01 Apr 2020
        04:17:45 +0000")
Message-ID: <87lfjg6mkn.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This breaks git status --ignored.

$ ./git status --porcelain --ignored -- a
!! abspath.o
!! add-interactive.o
!! add-patch.o
!! advice.o
!! alias.o
!! alloc.o
!! apply.o
!! archive-tar.o
!! archive-zip.o
!! archive.o
!! argv-array.o
!! attr.o

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
