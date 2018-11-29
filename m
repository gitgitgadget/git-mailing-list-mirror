Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C61211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeK3C4h (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:56:37 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:57920 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeK3C4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:56:37 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1gSOaT-0006uH-Mc; Thu, 29 Nov 2018 15:50:45 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23552.2773.538601.372248@chiark.greenend.org.uk>
Date:   Thu, 29 Nov 2018 15:50:45 +0000
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental
 opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
In-Reply-To: <nycvar.QRO.7.76.6.1811291638400.41@tvgsbejvaqbjf.bet>
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
        <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
        <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
        <20181128043154.GA34163@google.com>
        <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1811291516540.41@tvgsbejvaqbjf.bet>
        <23551.63504.876084.449440@chiark.greenend.org.uk>
        <nycvar.QRO.7.76.6.1811291638400.41@tvgsbejvaqbjf.bet>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin writes ("Re: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)"):
> >  In a successful run with older git I get a reflog like this:
> > 
> >    4833d74 HEAD@{0}: rebase finished: returning to refs/heads/with-preexisting
> >    4833d74 HEAD@{1}: debrebase new-upstream 2.1-1: rebase: Add another new upstream file
> >    cabd5ec HEAD@{2}: debrebase new-upstream 2.1-1: rebase: Edit the .c file
> >    0b362ce HEAD@{3}: debrebase new-upstream 2.1-1: rebase: Add a new upstream file
> >    29653e5 HEAD@{4}: debrebase new-upstream 2.1-1: rebase: checkout 29653e5a17bee4ac23a68bba3e12bc1f52858ac3
> >    85e0c46 HEAD@{5}: debrebase: launder for new upstream
...
> >  This breaks the test because my test suite is checking that I set
> >  GIT_REFLOG_ACTION appropriately.
> > 
> >  If you want I can provide a minimal test case but this should suffice
> >  to see the bug I hope...
> 
> This should be plenty for me to get going. Thank you!

Happy hunting.

While you're looking at this, I observe that the fact that the `rebase
finished' message also does not honour GIT_REFLOG_ACTION appears to be
a pre-existing bug.

(In general one often can't rely on GIT_REFLOG_ACTION still being set
because the rebase might have been interrupted and restarted, which I
think is why my test case looks for it in the initial `checkout'
message.)

Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
