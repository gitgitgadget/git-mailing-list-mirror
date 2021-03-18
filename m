Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9CC43381
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F214364E05
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhCRVxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCRVxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:53:09 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A0EC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 14:53:04 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1616104382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GLdOn9B7d2+Jd2CR4lm/Bzm1ASq6seMH+y9JAMMnbw=;
        b=OCypESpKpAye5o2jJ3JRyLtpLQOVAg3uG3pzqIT3eNpUKWTqSS5CSJlTxu1zAY5pygswzX
        uVrlJzBiB0MOFtVt5Idl96/aaX9A1Wg1TXxHs+aR+mcq0gB7tw+99FNiDiZagXIHyD6Uam
        sMnfSMvnVijoRfFJlRFdb2h7D/Xr1HW5tkxujA0KjEYmJEst+5yCEu7GeRq6v2RIAs9Imw
        BSLDWLqX2yYvUtokIEwpqSQyCMNFmWTohc1SKz5SGn+/iEkwmdFyv0/xqBlMYemLOXVBJc
        IbaWrpFVgGRYBouq4rDpO5uima6bq6afj2eAgkWkCPXIKLIVdaDkBsKnyXW4CQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 18 Mar 2021 17:53:00 -0400
Message-Id: <CA0T6V9YLG3X.1G7LSYGNW2TGY@taiga>
To:     "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc:     "Jonathan Nieder" <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <C9YDEO8Z8J96.262IOS9IW6F39@taiga>
 <YFEh2LxvsSP+x7d2@coredump.intra.peff.net> <xmqq4kh8rvy2.fsf@gitster.g>
In-Reply-To: <xmqq4kh8rvy2.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The status quo is similarly frustrating. We have no choice but to allow
these strange unofficial +git URLs to proliferate among package managers
and build systems. It has already caused confusion with users, and it
can only cause more the longer it remains unaddressed upstream.

There are two options:

1. We make the change, users are confused for a while, and software has
   to be updated, but the confusion gradually diminishes over time as
   the ecosystem adjusts and people learn the change.
2. We don't make the change, and the inconsistency continues to require
   special cases in new tools, with no central organization for keeping
   them consistent from one to the next, and users will continue to stub
   their toe on it indefinitely.
