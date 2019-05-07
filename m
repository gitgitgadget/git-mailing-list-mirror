Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A841F45F
	for <e@80x24.org>; Tue,  7 May 2019 05:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfEGFpW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 01:45:22 -0400
Received: from lamora.getmail.no ([84.210.184.7]:44117 "EHLO lamora.getmail.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728787AbfEGFpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 01:45:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id C562760D88;
        Tue,  7 May 2019 07:45:16 +0200 (CEST)
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JuvTM0ETyov0; Tue,  7 May 2019 07:45:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id DCC0860D78;
        Tue,  7 May 2019 07:45:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lamora.get.c.bitbit.net
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C6R2kxWpyPoA; Tue,  7 May 2019 07:45:06 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.6.62.getinternet.no [84.209.6.62])
        by lamora.getmail.no (Postfix) with ESMTPSA id 8580C60D88;
        Tue,  7 May 2019 07:45:06 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.89)
        (envelope-from <peter@softwolves.pp.se>)
        id 1hNsuX-0005Ds-Dc; Tue, 07 May 2019 07:45:05 +0200
Date:   Tue, 7 May 2019 06:45:05 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Schwartz <jefftschwartz@gmail.com>, git@vger.kernel.org
Subject: Re: Request to add option to interactive rebase to preserve latest
 commit date
In-Reply-To: <xmqqtve6nbfv.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.DEB.2.20.1905070641380.1748@perkele.intern.softwolves.pp.se>
References: <CAL3M-FZ7b3H7Z+Vr9Wbey5iYVoWiUBnDKVEenyAMrUXeNfL56w@mail.gmail.com> <xmqq4l6kvnuu.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.20.1905010900260.23829@perkele.intern.softwolves.pp.se> <xmqqtve6nbfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano:

> as merely a different way to do the following:
>
> 	$ git commit -m A
> 	$ edit
> 	$ edit further ;# working tree has an equivalent of C
> 	$ git commit --amend -a

Indeed. My last command in the chain is usually

   git commit --amend --date=now

to set the commit date to now. In my use-case it is often a 
work-in-progress commit that I start out with, which I refine over a 
couple of hours/days/weeks to get working properly (depending on the 
complexity of the change), and when I am finally done, the proper 
dating of the change is "now", not "when I first started doing it".

> I am still not convinced it is a good idea, but I can see how 
> another verb that behaves like existing "fixup" or "squash" but use 
> the authorship not from the updated but from the updating commit 
> might seem useful.

I'd be happy with a parameter and/or configuration variable saying 
"amend and rebase uses last commit date".

-- 
\\// Peter - http://www.softwolves.pp.se/
