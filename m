Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A7C2090B
	for <e@80x24.org>; Tue, 19 Sep 2017 06:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbdISGmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:42:42 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:50594 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751109AbdISGmm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:42:42 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=dagon.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ijc@hellion.org.uk>)
        id 1duCEx-0002ii-Cv; Tue, 19 Sep 2017 07:42:39 +0100
Message-ID: <1505803358.4636.4.camel@hellion.org.uk>
Subject: Re: [PATCH v2 1/4] mktag: add option which allows the tagger field
 to be omitted
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 19 Sep 2017 07:42:38 +0100
In-Reply-To: <xmqqzi9rqtmn.fsf@gitster.mtv.corp.google.com>
References: <1505633797.22447.4.camel@hellion.org.uk>
         <20170917073657.31193-1-ijc@hellion.org.uk>
         <xmqqzi9rqtmn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-09-19 at 12:01 +0900, Junio C Hamano wrote:
> 
> Hmph.  I cannot shake this nagging feeling that this is probably a
> solution that is overly narrow to a single problem that won't scale
> into the future.
> 
> [...snip good point...]
> 
> If we drop the "verification" step from the above, that essentially
> becomes an equivaent to "hash-object -t tag -w --stdin".
> 
> So I now have to wonder if it may be sufficient to use "hash-object"
> in filter-branch, without doing this "allow malformed data that we
> would not permit if the tag were being created today, only to help
> replaying an old, already broken data" change to "git mktag".
> 
> Is there something that makes "hash-object" insufficient (like it
> still does some extra checks we would want to disable and cannot
> work as a replacement for your "--allow-missing-tagger")?

I've done a couple of quick tests and it looks like it will work. I'll
run a few more checks and repost.

Ian.
