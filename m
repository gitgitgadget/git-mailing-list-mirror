Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC2C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 14:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59123207BB
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 14:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJOEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:04:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60921 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGJOEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 10:04:37 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B3FCl2fs8z1qs3D;
        Fri, 10 Jul 2020 16:04:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B3FCl2NNYz1qrF2;
        Fri, 10 Jul 2020 16:04:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dHlAl3Mdd9FG; Fri, 10 Jul 2020 16:04:34 +0200 (CEST)
X-Auth-Info: 885S2WDzlQdrDGM2Zc33QkjyxqgmcRAwD3ikccIQvQ5REUkIt/Uj1O1EQdmdeTNN
Received: from igel.home (ppp-46-244-174-178.dynamic.mnet-online.de [46.244.174.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 10 Jul 2020 16:04:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 134E42C0B4A; Fri, 10 Jul 2020 16:04:34 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Tom Browder <tom.browder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "git rm" could be safer and have a better help msg
References: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
        <878sfr1rdm.fsf@igel.home>
        <CAFMGiz8+pjskPpPqVgQUevKdWgxPvCKBcmx-07E2yizDqhm9mg@mail.gmail.com>
X-Yow:  I always wanted a NOSE JOB!!
Date:   Fri, 10 Jul 2020 16:04:34 +0200
In-Reply-To: <CAFMGiz8+pjskPpPqVgQUevKdWgxPvCKBcmx-07E2yizDqhm9mg@mail.gmail.com>
        (Tom Browder's message of "Fri, 10 Jul 2020 08:14:08 -0500")
Message-ID: <874kqf1n65.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 10 2020, Tom Browder wrote:

> If the existing file has been modified, with 'rm'  the '--cached'
> option doesn't remove it from Git
> unless one uses the '-f' option with it.

It doesn't?  Worksforme.

$ echo >> zlib.c
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   zlib.c

no changes added to commit (use "git add" and/or "git commit -a")
$ git rm --cached zlib.c
rm 'zlib.c'
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        deleted:    zlib.c

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        zlib.c


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
