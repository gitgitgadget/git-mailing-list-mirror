Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1941F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 23:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfACX5d (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 18:57:33 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:55845 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfACX5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 18:57:32 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190103235731.YWKG12708.fed1rmfepo102.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Thu, 3 Jan 2019 18:57:31 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 146A5B82FB2;
        Thu,  3 Jan 2019 16:57:26 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020F.5C2EA166.005B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=e8qytph/ c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=xtxXYLxNAAAA:8 a=nPmptriYux4jEt6sNx4A:9
 a=CjuIK1q_8ugA:10 a=xts0dhWdiJbonKbuqhAr:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Thu, 03 Jan 2019 16:57:25 -0700
Message-ID: <2344590.WcCB8NM0fh@thunderbird>
Organization: Personal
In-Reply-To: <xmqq1s5th0u4.fsf@gitster-ct.c.googlers.com>
References: <20181231003150.8031-1-ischis2@cox.net> <a5412274-028f-3662-e4f5-dbbcad4d9a40@iee.org> <xmqq1s5th0u4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, January 3, 2019 2:45:39 PM MST Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
> >> 
> >> 	check_human_date 432000 "$THIS_YEAR_REGEX" # 5 days ago
> > 
> > Just a quick bikeshed: if used, would this have a year end 5 day
> > roll-over error potential, or will it always use the single date?
> 
> Hmph, interesting point.  Indeed, date.c::show_date_normal() decides
> to hide the year portion if the timestamp and the current time share
> the same year, so on Thu Jan 3rd, an attempt to show a commit made
> on Mon Dec 31st of the same week would end up showing the year, so
> yes, I agree with you that the above would break.
> 

Thanks Philip.

I wrote the test just before the new year so didn't see the rollover.   I 
haven't run the test this year.
sps






