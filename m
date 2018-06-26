Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6301F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754996AbeFZUzL (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:55:11 -0400
Received: from ao2.it ([92.243.12.208]:58278 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbeFZUzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:55:09 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fXuyp-0002Xv-7f; Tue, 26 Jun 2018 22:54:27 +0200
Date:   Tue, 26 Jun 2018 22:55:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] submodule-config: add helper function to get
 'fetch' config from .gitmodules
Message-Id: <20180626225505.7de21d73ce40af2247d3c084@ao2.it>
In-Reply-To: <xmqqfu19jojn.fsf@gitster-ct.c.googlers.com>
References: <20180626104710.9859-1-ao2@ao2.it>
        <20180626104710.9859-3-ao2@ao2.it>
        <xmqqfu19jojn.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Jun 2018 13:11:40 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> > Add a helper function to make it clearer that retrieving 'fetch'
> > configuration from the .gitmodules file is a special case supported
> > solely for backward compatibility purposes.
> > ...
> 
> Then perhaps the new public function deserves a comment stating
> that?
>

Hi Junio,

a comment about that is added to submodule-config.h in patch 4/6 in
place of the comment about config_from_gitmodules.

I can add a note here as well if that one is not enough.

[...]
> > +void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
> > +{
> > +	struct fetch_config config = {
> > +		.max_children = max_children,
> > +		.recurse_submodules = recurse_submodules
> > +	};
> 
> We started using designated initializers some time ago, and use of
> it improves readability of something like this ;-)
>

Ah, TBH I didn't even consider whether it was allowed in git code, I
just used the construct out of habit.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
