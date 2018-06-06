Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150701F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeFFUW3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:22:29 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:50286 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeFFUW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1sQCQoJG583EHxJkVgT3EdFsfqYqaX/BlAvtufzzXZI=; b=NcN8s7WPJBqI81BW/7mGQAQD/
        QhsH9kqjqiMKRCICnW+vxlxy+kQVyLMrpvBUnrQq4YVwUqyoY5SGMZy0smUFSyFik5NM9v/Yn5/R0
        1bs2mjYedqAMroRmTxb/h2sd9ucjyiGD2OJUgAVkxijvwdEnVZG0pyHzv3J27eydZC+x6/UEKW3jn
        BsEM+ppUbqY6DelRL/KMaGeNLieNEvliElpxKzUEfNTihZ6b/4+1kX92ZHfJFmKedfBeX9MOu17Xr
        KVwcPARsbursvr8SEO5+cbL0/deRIyfu50UGHeSFOcq1Xg5FZCSQmymJHrawLEoJH71IhpjS8oqFx
        yF7Pr4knw==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:54548 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fQewr-009x2e-HN; Wed, 06 Jun 2018 16:22:27 -0400
Date:   Wed, 6 Jun 2018 16:20:09 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Timothy Rice <timothy.rice@unimelb.edu.au>
cc:     Todd Zullinger <tmz@pobox.com>,
        Thomas Fischer <thomasfischer@fastmail.com>,
        git@vger.kernel.org
Subject: Re: git rm bug
In-Reply-To: <20180606201012.GA2454@sleipnir>
Message-ID: <alpine.LFD.2.21.1806061609440.10418@localhost.localdomain>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com> <alpine.LFD.2.21.1806061532420.9259@localhost.localdomain> <1528314421.2665575.1398886712.579F37CE@webmail.messagingengine.com> <20180606200137.GJ3094@zaya.teonanacatl.net>
 <20180606201012.GA2454@sleipnir>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Jun 2018, Timothy Rice wrote:

> > It does seem like something which could be noted in the git
> > rm docs.  Perhaps you'd care to take a stab at a patch to
> > add a note to Documentation/git-rm.txt Thomas?  Maybe a note
> > at the end of the DISCUSSION section?
>
> That same documentation could mention a common workaround for when
> someone does really want to keep the empty directories:
>
> $ touch ./path/to/empty/dir/.keep
> $ git add ./path/to/empty/dir/.keep
> $ git commit -m "Keep that empty directory because it is needed for <whatever>"
>
> This would obviate the need for a new flag to switch behaviours.

  i'm going to be contrarian and obstinate and suggest that the
current behaviour is fine, since there is no compelling rationale for
any *other* behaviour.

  invariably, every defense for hanging on to empty directories boils
down to, "i might do something in the future that expects those
directories to exist." well, if that's the case, then create them when
you need them -- nothing you do should ever simply *assume* the
existence of essential directories.

  in addition, by "untracking" those directories, you're suggesting
that git quietly do what should normally be done by "git rm --cached".
if i want that behaviour, i would prefer to have to type it myself.

  i'm fine with just adding a note to "git rm" making it clear what
happens in this case. i see no value in supporting extra options that
simply encourage bad behaviour.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
