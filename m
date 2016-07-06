Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAA620705
	for <e@80x24.org>; Wed,  6 Jul 2016 11:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbcGFLJR (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 07:09:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56185 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750937AbcGFLJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 07:09:16 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DC7252014A;
	Wed,  6 Jul 2016 07:09:15 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute7.internal (MEProxy); Wed, 06 Jul 2016 07:09:15 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=O5vVoi6ax9X2RilPJjsL1p+BmD8=; b=HX5UmW
	lYkRZg+WBcpgFtk6JhQ2GAHQDgWGKzDZFkq/jm5JBCF1PH5bQXXnh1ahoFsDcQGU
	yC9cP2NnCI4+JeDAtz+jyPbBT4d+cN78v8soaBenYkBcx9MngJTmXC6uAejnV6TP
	IdcYa77lNJ7HhEmkx8Gui9yFYhMhYesXfRYC4=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=O5vVoi6ax9X2Ril
	PJjsL1p+BmD8=; b=ckTRHJXzpK4yjp9qyFE8lI5iVKg3bm7C2LQuN1wVeEp5nk+
	u4uTQADn3p3yUPR0Y9dCBgokMNb8bFokoWeWcFSh2X/SjsQVCrC/PpVfr6hnC/eM
	DFJrCUyPoJzHFv3dcMzkliECXGM61ySZUR+ow6JkLB6VGWJFX7awOvXA2MjE=
X-Sasl-enc: 86WuXXNeECgkqfDgMIZ4WpTZb3FaLkqX8PjBVIhFrEs7 1467803355
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 24CD9F29F4;
	Wed,  6 Jul 2016 07:09:15 -0400 (EDT)
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Keller <jacob.keller@gmail.com>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
 <20160705202820.GA14496@sigill.intra.peff.net>
 <20160705204447.GB14496@sigill.intra.peff.net>
 <CA+P7+xqODaXn2NFY-=Ktr1stzR1mu6_ZO7Lfgj7AEzhzxhLAbw@mail.gmail.com>
 <alpine.DEB.2.20.1607060857240.6426@virtualbox>
Cc:	Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <d1e0e688-a309-2a01-4ee2-c1af9d71cea0@drmicha.warpmail.net>
Date:	Wed, 6 Jul 2016 13:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607060857240.6426@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 06.07.2016 09:01:
> Hi Peff & Jacob,
> 
> On Tue, 5 Jul 2016, Jacob Keller wrote:
> 
>> On Tue, Jul 5, 2016 at 1:44 PM, Jeff King <peff@peff.net> wrote:
>>> On Tue, Jul 05, 2016 at 04:28:20PM -0400, Jeff King wrote:
>>>
>>> Something like the patch below.
>>>
>>> I admit this isn't buggy _now_, so this is potentially just churn. It
>>> does make further patches look nicer, though (they don't have to add
>>> apparently meaningless OPT_END() slots).
>>>
>>> -- >8 --
>>> Subject: [PATCH] parse_options: allocate a new array when concatenating
>>>
>>> In exactly one callers (builtin/revert.c), we build up the
>>> options list dynamically from multiple arrays. We do so by
>>> manually inserting "filler" entries into one array, and then
>>> copying the other array into the allocated space.
>>>
>>> This is tedious and error-prone, as you have to adjust the
>>> filler any time the second array is modified (although we do
>>> at least check and die() when the counts do not match up).
>>>
>>> Instead, let's just allocate a new array.
>>
>> This seems much preferable to me.
> 
> Yes, this is better than my patch.
> 
> BTW Jacob, would you terribly mind cutting the quoted parts properly (I
> cut 112 lines)? It may not seem like much, but I seem to spend more and
> more of my email time budget on skimming unaddressed remainders of quoted
> mails, and I would much rather spend that time on something productive.

OTOH, I often have to look up the original message because people cut
too much, or because they take one sentence out of context.

It is not unheard of that a MUA can collapse and expand properly quoted
parts on request...

Michael

