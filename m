Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2061F803
	for <e@80x24.org>; Thu, 10 Jan 2019 01:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfAJBua (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 20:50:30 -0500
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:35021 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfAJBua (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 20:50:30 -0500
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190110015027.PRFS4175.fed1rmfepo202.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Wed, 9 Jan 2019 20:50:27 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 5E759B82CE0;
        Wed,  9 Jan 2019 18:50:26 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020D.5C36A4E3.0009,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=CoYLjUwD c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10
 a=a_-Y1CSePcdNey7aSO8A:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Wed, 09 Jan 2019 18:50:26 -0700
Message-ID: <2249216.RGRfnxe1O0@thunderbird>
Organization: Personal
In-Reply-To: <42e521e3-8a12-17c9-cb7f-bfba226ca126@kdbg.org>
References: <20181231003150.8031-1-ischis2@cox.net> <6530822.TNJIEUz5BA@thunderbird> <42e521e3-8a12-17c9-cb7f-bfba226ca126@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, January 8, 2019 11:58:29 PM MST Johannes Sixt wrote:
> But notice that the value of $TODAY_REGEX contains blanks.
> 
> In this line
> 
> check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX
> 
> the value of $TODAY_REGEX is substituted and then the value is split
> into fields at the blanks because the expansion is not quoted.
> 
> As a consequence, function check_human_date considers only the first
> part of $TODAY_REGEX, i.e. 'A-Z][a-z][a-z]' (which is parameter $2), but
> ignores everything else (because it does not use $3 or $4).
> 
> -- Hannes

I hadn't understood your original comment, but now i understand.   Will fix.


