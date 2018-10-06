Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63E61F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 09:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJFQWz (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 12:22:55 -0400
Received: from mail.ao2.it ([92.243.12.208]:46024 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeJFQWz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 12:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=iBXmdoE3b0jHfZvcRFAtt564RIzkh1Ztk6EFPQqmEJg=;
        b=pFO/tNookHBGO13WlkDpqfGRjBUXfE7GXdcgkmEVpOLZrY5LClBJKIGyasan3cw1vr89O//MdKB/fFmpNsBtAmZcThRl3f/qzjT9KpHX7GJtnwhg0hpAQvVsHvlourDjqYhAGgzOOcLMKAwRSSFlGlUZyt0HeNGTWiBBaHbvbmvw6FW5xpEra72FbibEGpzCtdOq+DCZ+WmOKru/WpuliWo1ET91lU2RtvQ8HdzqXp4VQlUdtr7s9INHPJacYMbzrUZdKy9VWwlJhFOsbPIchTJF9xcDkWrAIz3mtfQNSpCHCfARvnzpN0CKXu9dnllhDnLrITqkXdNfcGBF11ADtQ==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8iiY-0007Oy-B0; Sat, 06 Oct 2018 11:17:46 +0200
Date:   Sat, 6 Oct 2018 11:20:20 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v6 00/10] Make submodules work if .gitmodules is not
 checked out
Message-Id: <20181006112020.1651e4b0dd895afd06f93bbf@ao2.it>
In-Reply-To: <20181005130601.15879-1-ao2@ao2.it>
References: <20181005130601.15879-1-ao2@ao2.it>
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

On Fri,  5 Oct 2018 15:05:51 +0200
Antonio Ospite <ao2@ao2.it> wrote:

[...]
>  t/t7416-submodule-sparse-gitmodules.sh       |  78 ++++++++++
>  16 files changed, 410 insertions(+), 32 deletions(-)
>  create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

I just saw that t7416 and t7417 have been added in the latest stable
release, I'll wait some days before sending a v7 which renames the newly
added test to t/t7418-submodule-sparse-gitmodules.sh

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
