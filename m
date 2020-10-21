Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5268C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F73F218AC
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506915AbgJUWsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506751AbgJUWsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:48:20 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A7C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 15:48:19 -0700 (PDT)
Received: from [2404:440c:1348:1500:30ae:2589:119b:7ae9] (port=33710 helo=default-rdns.vocus.co.nz)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <victor@engmark.name>)
        id 1kVMtz-000390-IB; Thu, 22 Oct 2020 00:48:16 +0200
Message-ID: <f56cff1c617de3fa0ce6ebff106dab629565e1fa.camel@engmark.name>
Subject: Re: [PATCH v2] userdiff: support Bash
From:   Victor Engmark <victor@engmark.name>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 22 Oct 2020 11:48:09 +1300
In-Reply-To: <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org>
References: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
         <xmqqk0vk8o20.fsf@gitster.c.googlers.com>
         <1442e85cfbe70665890a79a5054ee07c9c16b7c6.camel@engmark.name>
         <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-10-21 at 09:07 +0200, Johannes Sixt wrote:
> Am 21.10.20 um 05:00 schrieb Victor Engmark:
> > Uses the default `IFS` characters to define words.
> 
> We could do better than this, I think. At a minimum, the equal sign,
> single quote, double quote, parentheses, and braces should also
> delineate words. $(, ${, $((, ((, )), [[, ]], should be words. I
> would
> exclude single brackets because they could only occur in globs, IIRC,
> and they need not be broken into words at brackets. $var should be a
> single word, IMO.
> 
> That said, this can be presented as a patch on top of this one.

I can't tell where this word definition is used, and I can't seem to
find any tests for the word regexes for the other languages. Is it used
for word diffs somehow? I'll leave it for now, but if you have some
pointers I could look into that later.

Thank you very much for the comments!

