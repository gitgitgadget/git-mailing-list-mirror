Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E470208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbdHUQFY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:05:24 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:53473 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754004AbdHUQFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:05:22 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1djpCY-0002rC-Kf; Mon, 21 Aug 2017 18:05:18 +0200
Date:   Mon, 21 Aug 2017 18:05:14 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
Message-ID: <20170821160514.GA1618@book.hvoigt.net>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
 <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 11:51:13PM -0700, Junio C Hamano wrote:
> As long as we are talking about idealized future world (well, at
> least an idea of somebody's "ideal", not necessarily shared by
> everybody), I wonder if there is even any need to have commits in
> submodules in such a world.  To realize such a "monorepo" world, you
> might be better off allowing a gitlink in the superproject to
> directly point at a tree object in a submodule repository (making
> them physically a single repository is an optional implementation
> detail I choose to ignore in this discussion).

IMO this is one step to far. One main use of submodules are shared
repositories that are used by many superprojects. The reason you want to
have commits in the submodule are so that you can push them
independently and all other users can pick up the changes. You could get
by by Using the superproject commits for the submodule once you push or
something but those do not necessarily make sense in the context of the
submodule.

So I think it is important that there are commits in the submodule so
its history makes sense independently for others.

Or how would you push out the history in the submodule in your idea?
Maybe I am missing something? What would be your use case with gitlinks
pointing to trees?

Cheers Heiko
