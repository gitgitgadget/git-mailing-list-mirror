Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9AC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B7C2084C
	for <git@archiver.kernel.org>; Tue, 26 May 2020 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgEZROs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 13:14:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbgEZROq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 13:14:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6CC0FAC12;
        Tue, 26 May 2020 17:14:48 +0000 (UTC)
Date:   Tue, 26 May 2020 19:14:43 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Assessing about commit order in upstream Linux
Message-ID: <20200526171443.GE25173@kitsune.suse.cz>
References: <20200526065320.GA18107@lxhi-065.adit-jv.com>
 <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 08:21:25AM -0700, Junio C Hamano wrote:
> Eugeniu Rosca <erosca@de.adit-jv.com> writes:
> 
> > So, the two approaches lead to different results. If you see any false
> > assumption or mistaken belief, could you please pinpoint that? TIA.
> 
> Perhaps the assumption/belief that the set of commits in a history
> can be totally ordered is the issue?  When multiple people work
> together on a project, especially in a project where "pull --no-ff"
> is not enforced, there can exist only partial order among them?
> 
As in if you have history with two branches

   D
  / \
 B   C
  \ /
   A

commits B and C are not comparable. They are both between A and D but
the order of B and C is arbitrary. Different renderings of the history
may choose different order of B and C. This is a simle example. Linux
history is a spaghetti of tens of branches.

Thanks

Michal
