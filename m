Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7BC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823C564F64
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhCPTzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:55:43 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56609 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCPTzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 15:55:22 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F0PCX2Ybfz1qrfh;
        Tue, 16 Mar 2021 20:55:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F0PCW4vWMz1qqlF;
        Tue, 16 Mar 2021 20:55:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 6sBQ6JNKQ_mo; Tue, 16 Mar 2021 20:55:19 +0100 (CET)
X-Auth-Info: DEEfB51HvAHbN0UG35oI2wlPqlVA0tdnsZRbRpNeXQser1WqRKeZ261sY1ezDJ/p
Received: from igel.home (ppp-46-244-163-222.dynamic.mnet-online.de [46.244.163.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Mar 2021 20:55:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 776332C37EC; Tue, 16 Mar 2021 20:55:18 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Lamborn, Peter Craig" <plamborn@lanl.gov>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Nielsen, Johnathan Patrick" <jnielsen@lanl.gov>,
        "Herrera, Thomas Anthony" <taherrera@lanl.gov>
Subject: Re: GIT_SSH and mirror not working with git 2.30.1
References: <e39d23615e084671965fc96174ac881e@lanl.gov>
X-Yow:  There's a little picture of ED MCMAHON doing BAD THINGS to JOAN RIVERS
 in a $200,000 MALIBU BEACH HOUSE!!
Date:   Tue, 16 Mar 2021 20:55:18 +0100
In-Reply-To: <e39d23615e084671965fc96174ac881e@lanl.gov> (Peter Craig
        Lamborn's message of "Tue, 16 Mar 2021 18:53:24 +0000")
Message-ID: <87r1keyiu1.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 16 2021, Lamborn, Peter Craig wrote:

> workstation$ cat ssh-hop.sh
> #!/bin/bash
>   
> MACHINE_REGEXP="<...>"
>   
> if [[ $1 =~ $MACHINE_REGEXP ]]; then
>   
>   exec ssh <gateway> ssh "$@"
>   
> else
>   exec ssh "$@"
> fi

FWIW, it might be easier to use the ProxyJump configuration setting of
ssh instead.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
