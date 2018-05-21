Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC43F200B9
	for <e@80x24.org>; Mon, 21 May 2018 17:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeEURmo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 13:42:44 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:45960 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeEURlj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 13:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6aLFEogGlvcG2waB9K87we7ve9TpdbyQQI6W2Pw/zlA=; b=lEZIduHVVyusK3wOW3RdzU7g1
        B1jbYMMZkAsIuewhDBaMzNTcNU75qbirFdisSKXJguhbl5qp7dHVoi35OySmqlwf1gObUVGDOq97Y
        e0ixjDjx8wu/GeoPszGlwIF6smQbwT897Rap0H0OhCUypK34Y1c6tuOOkc51BciEpbb74DHqG/78d
        g7VBpmnscjSGQ+mNubwJ2RLGakm2Csjo+2HSmd7L/q/aSvz3mOdCbPma1M3smdFoX/AjVXZ/mf5+k
        EquGX2wGige7fHVD3ZQ5ssQEAzc4Ob9cOtwCcC6g0zm4fpektl3HvBIdRFAuaSVW/0qhEprR/Kcpl
        Hfmf/dzcw==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52922 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKooS-00GidM-6H; Mon, 21 May 2018 13:41:37 -0400
Date:   Mon, 21 May 2018 13:40:04 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
In-Reply-To: <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
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

On Mon, 21 May 2018, Elijah Newren wrote:

> Hi Robert,
>
> I had always assumed prior to your email that 'known to Git' meant
> 'tracked' or 'recorded in the index'...

  i *know* i've been in this discussion before, but i don't remember
where, i *assume* it was on this list, and i recall someone (again,
don't remember who) who opined that there are two categories of files
that are "known to git":

  1) files known in a *positive* sense, those being explicitly tracked
  files, and

  2) files known in a *negative* sense, as in explicitly ignored files

can anyone refresh my memory if that happened here, and whether that
was the consensus after the discussion was over? if that's the
definition that's being used, then this passage makes sense:

  "Normally, only files unknown to Git are removed, but if the -x
  option is specified, ignored files are also removed."

that pretty clearly implies that ignored files are considered "known"
to git.

rday
