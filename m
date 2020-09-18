Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF54C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80372388B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRPVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRPVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:21:30 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE45C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:21:30 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BtHc62Tcxz1rwbD;
        Fri, 18 Sep 2020 17:21:26 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BtHc627Ytz1qrDN;
        Fri, 18 Sep 2020 17:21:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id VFkGrKp-NFKQ; Fri, 18 Sep 2020 17:21:25 +0200 (CEST)
X-Auth-Info: CC4u+A0M1nCFdZ3e6bwr+ephQuyqaOuDOw0J214yb5pAxtmAKACYexvyXMyhick6
Received: from igel.home (ppp-46-244-177-180.dynamic.mnet-online.de [46.244.177.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 18 Sep 2020 17:21:25 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E42DC2C28F1; Fri, 18 Sep 2020 17:21:24 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Apply git bundle to source tree?
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
        <20200918140236.GA1602321@nand.local>
        <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
        <20200918141725.GA1606445@nand.local>
        <CAHpGcMJXZ++t0UtyCRSh=cB8uzy51hJTNxaF1Zd8Z-AQs4w+QQ@mail.gmail.com>
X-Yow:  It's today's SPECIAL!
Date:   Fri, 18 Sep 2020 17:21:24 +0200
In-Reply-To: <CAHpGcMJXZ++t0UtyCRSh=cB8uzy51hJTNxaF1Zd8Z-AQs4w+QQ@mail.gmail.com>
        ("Andreas =?utf-8?Q?Gr=C3=BCnbacher=22's?= message of "Fri, 18 Sep 2020
 16:50:47 +0200")
Message-ID: <871rizglfv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 18 2020, Andreas Grünbacher wrote:

> Am I right in assuming that v5.8^{tree} isn't included in a
> v5.8..v5.9-rc1 bundle?

From git-bundle(1):

       As no direct connection between the repositories exists, the user must
       specify a basis for the bundle that is held by the destination
       repository: the bundle assumes that all objects in the basis are
       already in the destination repository.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
