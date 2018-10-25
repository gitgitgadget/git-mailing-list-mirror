Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6481F453
	for <e@80x24.org>; Thu, 25 Oct 2018 13:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJYVxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 17:53:46 -0400
Received: from mail.ao2.it ([92.243.12.208]:44011 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeJYVxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 17:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=4Irp2W1Ut1ULWS95OKKeJDkQsCRni0ayMx2GBUr8624=;
        b=P2XVW2jJgDRmAH+Wu0dWPTAN5N2XWJFL5fG8O8FHh+nSXqz0+6nxnBiM6O6wAn4kb1nnNMdezsLBw2/i9pWu1MnqwA0wTilI396PO85p4IO2ZVWqgXA28UODkp0rvq1+ZWM+VSs9jOpXZqDO1Dzm++5IQCd9RfzG5zRbp++5GKephaU7vdLzf3aJaa6DPjRS8NQTOeCy43Y3wCcRzn2UxGs8mMGpgPegpBnJ1cGpOBEXbv7nbLtjwdjj1Rn+F7XmuEOn4v28nUp1CLxmT+UC47Xh6qSt8FaMDvkBkk9Me3PtWvrRh74Ln8CQCzOcgMdfmoDyx9JsVT0mYYB/qw2iCg==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFfZ3-0005gc-T9; Thu, 25 Oct 2018 15:20:41 +0200
Date:   Thu, 25 Oct 2018 15:20:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?ISO-8859-1?Q?G?= =?ISO-8859-1?Q?=E1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/10] Make submodules work if .gitmodules is not
 checked out
Message-Id: <20181025152059.78c488d5b24aa2b0b6817259@ao2.it>
In-Reply-To: <xmqqd0ryiflc.fsf@gitster-ct.c.googlers.com>
References: <20181005130601.15879-1-ao2@ao2.it>
        <xmqqd0ryiflc.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 25 Oct 2018 17:40:47 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> > this series teaches git to try and read the .gitmodules file from the
> > index (:.gitmodules) or from the current branch (HEAD:.gitmodules) when
> > the file is not readily available in the working tree.
> 
> What you said in [*1*] the discussion on [09/10] sounded like you
> are preparing an update of the series, so the topic is marked as
> "Expecting a reroll" in the recent "What's cooking" report.  At
> least one topic now depends on the enhancement this topic makes, so
> I'd like to know what the current status and ETA of the reroll would
> be, in order to sort-of act as a traffic cop.
> 

Hi Junio,

I can send a v7 later today.

It will only contain the improvements to
7416-submodule-sparse-gitmodules.sh as discussed in [*1*], it won't
contain changes to patch 8 as motivated in
https://public-inbox.org/git/20181008143709.dfcc845ab393c9caea66035e@ao2.it/

I will also leave patch 10 unchanged, improvements can be made in
follow-up patches.

BTW, what is the new topic which depends on this one?

Thank you,
   Antonio

> [Reference]
> 
> *1* http://public-inbox.org/git/20181010205645.e1529eff9099805029b1d6ef@ao2.it/


-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
