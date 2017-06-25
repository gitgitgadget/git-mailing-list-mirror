Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AAC8207D2
	for <e@80x24.org>; Sun, 25 Jun 2017 08:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdFYINh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 04:13:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:60546 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdFYINg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 04:13:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3wwQ1T5qSFz1qrN6;
        Sun, 25 Jun 2017 10:13:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3wwQ1T5Cvmz3jgYP;
        Sun, 25 Jun 2017 10:13:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4oPJvfP4sB95; Sun, 25 Jun 2017 10:13:32 +0200 (CEST)
X-Auth-Info: yt4SvHMxL/PLtRc1QZQY7yzEKpCO5Cx/o1+E+64Rx8jU9sKM5MO58oCzSStQ+2DS
Received: from igel.home (ppp-88-217-26-81.dynamic.mnet-online.de [88.217.26.81])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 25 Jun 2017 10:13:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2CB442C3D28; Sun, 25 Jun 2017 10:13:32 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Urs Thuermann <urs@isnogud.escape.de>
Cc:     git@vger.kernel.org
Subject: Re: Migration from CVS to Git looses merges
References: <ygfd19stua3.fsf@tehran.isnogud.escape.de>
X-Yow:  Where's th' DAFFY DUCK EXHIBIT??
Date:   Sun, 25 Jun 2017 10:13:32 +0200
In-Reply-To: <ygfd19stua3.fsf@tehran.isnogud.escape.de> (Urs Thuermann's
        message of "25 Jun 2017 09:12:52 +0200")
Message-ID: <87a84web83.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 25 2017, Urs Thuermann <urs@isnogud.escape.de> wrote:

> In both cases, the branch "a-branch" is in the git repository but is
> not merged with the master branch, i.e. rev 1.4 has only parent 1.3
> but not 1.2.2.2.  I also tried cvsimport with several regexes passed
> using -M to match "Merge branch a-branch", but still the same result.

Merges are recognized purely by matching the commit message, and the
regexp must capture the branch name in the first subexpr.  The -m option
enables some default regexps but won't match your example.  You can use
-M 'Merge branch ([-\w]+)' to match it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
