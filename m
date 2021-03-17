Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA88C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0000864F45
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhCQOuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 10:50:11 -0400
Received: from out1.migadu.com ([91.121.223.63]:31953 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhCQOtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 10:49:46 -0400
X-Greylist: delayed 160506 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 10:49:45 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615992579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+/XzBC7ufYYcrYRa3Y7tEQC0hvn540s7Kb5oblGRAY=;
        b=p2jXF/yO3attLF+/JcclMnffa26P98ZA1DYw2q1M5T3Kt6d0bU96do2m5jJySjbAu7+exE
        oCQpF+uGkO3+szFNFnfIFMs6EN1CnGouwITB0GPtfci45B9XqmtCNUpwNIV5Q1/U9u4SB2
        eYlRZ3y2AzPvKUpDzx9lVD1Ds/ODvnFCbHkKNee5Wjxfk5+QQ/SKi88S0EvQV+Wc1+Fugu
        OVj3mSR4yjsWyfKEhpIf2P2VsJHnxbGwnQ4xsR1WZRryKJbv/M5F+a89tJ7Go0PQpXTxzS
        HnstnZQsFjd8RKrwDvY2gyf219SdKRh6H73n74FRTVUSlfO8HDQ98NpTwTaXoQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 17 Mar 2021 10:49:37 -0400
Message-Id: <C9ZPK5OX52X9.Y1EGN6VC1MRL@taiga>
Cc:     "Jonathan Nieder" <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Jeff King" <peff@peff.net>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <C9YDEO8Z8J96.262IOS9IW6F39@taiga>
 <YFEh2LxvsSP+x7d2@coredump.intra.peff.net>
In-Reply-To: <YFEh2LxvsSP+x7d2@coredump.intra.peff.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue Mar 16, 2021 at 5:23 PM EDT, Jeff King wrote:
> - one of the advantages of straight http:// URLs is that they can
> accessed by multiple tools. Most "forge" tools let you use the same
> URL both for getting a human-readable page in a browser, as well as
> accessing the repository with the Git CLI. I'd hate to see https+git
> URLs become common, because they add friction there (though simply
> supporting them at all gives people the choice of whether to use
> them).

I think their main use-cases would be limited to places where the
distinction is necessary, such as for those packaging or CI tools. I
don't expect us to end up in a situation where users are passing each
other git+https URLs in everyday conversation.

> - I'm also sympathetic to brian's point that there's a wider
> ecosystem. It's not just "git" that needs to learn them. It's jgit,
> and libgit2, and many tools that work with git remotes.

I would be happy to write the necessary patch for libgit2, at least.
