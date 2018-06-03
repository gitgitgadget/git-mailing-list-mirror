Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167D41F403
	for <e@80x24.org>; Sun,  3 Jun 2018 11:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeFCL0M (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 07:26:12 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41036 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCL0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 07:26:12 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53BQ97a003671
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 13:26:09 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53BQ9eV003670;
        Sun, 3 Jun 2018 13:26:09 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53BPvF5006965;
        Sun, 3 Jun 2018 13:25:57 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53BPv1r006964;
        Sun, 3 Jun 2018 13:25:57 +0200
Date:   Sun, 3 Jun 2018 13:25:57 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vab087y2.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 12:45:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
> protection". I.e. regulators / prosecutors are much likely to go after
> some advertising company than some project using a Git repo.

Well, it is indeed rather unlikely that one particular git repo project 
will be targeted, but I guess it is basically certain that at least 
some of them will be.

It is the same as a lottery, it's very unlikely you win the jackpot, 
yet someone wins it every few months. We should care about the entire 
community, not be too selfish.

> Since the Author is free-form this sort of thing doesn't need to be part
> of the git data format. You can just generate a UUID like
> "5c679eda-b4e5-4f35-b691-8e13862d4f79" and then set user.name to
> "refval:5c679eda-b4e5-4f35-b691-8e13862d4f79" and user.email to
> "refval:5c679eda-b4e5-4f35-b691-8e13862d4f79".

Well, this is merely pseudonymization, not anonymization. Note that the 
UUID, innocent as it may look, is not in any way less "personal data" 
than the author string itself. Your proposal would thus not actually 
solve the problem, only slightly transform it. Only when you truly 
anonymize (see my proposal about one way to to it), you can completely 
evade the GDPR.

> Sites that are paranoid about the GDPR could have a pre-receive hook
> rejecting any pushes from EU customers unless their commits were in this
> format.

This won't work either. The GDPR makes each data processor directly 
responsible in relation to the data subject. So it does not matter at 
all who is pushing, it matters who is in the author field of the 
commits that were pushed. And since you don't have any information 
about whether those authors are residing within the EU or not, you have 
to assume they are and you have to obey the GDPR. Even if you are 
outside the EU and do not have any subsidiaries within the EU, the GDPR 
sill applies as long as you are processing personal data of EU citizen. 
Perhaps the authorities in your country will refuse to obey letters of 
request if the EU authorities try to enforce the GDPR on an 
international scope, but if you have a record of GDPR violation and you 
ever set foot on EU territory, you are fair game.

> Instead I'll have a daily UUID issued from a government API

Heaven forbid. ;) There is an old German proverb, warning that even 
humorous trolling might be dangerous: "Man soll den Teufel nicht an die 
Wand malen!" ;)

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
