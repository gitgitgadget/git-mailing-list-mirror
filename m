Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5716C1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfIZVNd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:13:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25707 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfIZVNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:13:33 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46fSMZ75ZQz5tlG;
        Thu, 26 Sep 2019 23:13:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A08F71D27;
        Thu, 26 Sep 2019 23:13:30 +0200 (CEST)
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
 <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9d77189d-a357-ab0a-6cb5-e87ecdeffb91@kdbg.org>
Date:   Thu, 26 Sep 2019 23:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.09.19 um 21:15 schrieb Pratyush Yadav:
> Reading the Stackoverflow link, it seems this is already possible via an 
> undocumented config variable "gui.gcwarning". I haven't tried using it 
> though, but I see no reason for it to not work (looking at 
> git-gui.sh:4141).

Ah! That explains why I don't see the message on one of my computers,
but I do see on others. I must have reset gui.gcwarning there a decade
ago, and forgot about it.

> Maybe we should add this variable in the options dialog, so people at 
> least know it exists?

That may be the most reasonable thing to do, IMO.

>> What about a configurable limit, but still show the dialog?
> 
> Do people really care that much about configuring this limit to warrant 
> something like this? 

Never mind. We don't need it if there is a simple switch.

> Talking about auto compression, would it be a better idea to let users 
> disable the dialog, and then if they do want auto compression, they can 
> just run a cron job (or the Windows equivalent) to do this on their 
> repos? What reasons do people have to have this feature in git-gui, 
> instead of running cron jobs?

This is a GUI. It was intended for people with a dislike of the command
line. If you avoid the command line as much as possible, you never get
to see any object statistics; yet, all operations would slow down
gradually due to object bloat with no way out. Remember that this
feature was invented long before auto-gc came to existence. Not to
mention that git-gui uses plumbing mostly where auto-gc would not
trigger anyway.

-- Hannes
