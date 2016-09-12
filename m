Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51020207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932971AbcILNj7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 09:39:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54449 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932955AbcILNj6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Sep 2016 09:39:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0308F207C2;
        Mon, 12 Sep 2016 09:39:56 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 12 Sep 2016 09:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=zcQwaWCyAs0sWVm+VrbyP/a4CwE=; b=gybdVL
        E4ax1vzITx0od9/RQs1XFSCwxV+urpDqgf19Dvjs1+xA3lJnYXmrCOJz9gOxelet
        uq/EDVJRQXJQT/h+WjAuvTIOFKfFJtZgLLtBG3ptBxl9LhridOJazzLghPfx/GQA
        WxEKMwXByOvckpjKbAkyR8Hhqj8aZ8IjHJ30g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=zcQwaWCyAs0sWVm
        +VrbyP/a4CwE=; b=g90E14IxLHlZXrSWkEX4zwqahgIsD9k8SL1I6bThObIwkNB
        9aL+PfM/OgmWp1VJzO7GVRpkc6ewH4dZg5ZLJWW2wSAzeZL62xqdTjcnqtzRl5NH
        TKPGkp5gPEHqaNuQqYopGCixstLAQkPtjORHsapjzTnXNoVHcGmxSMY+8BfU=
X-Sasl-enc: tEzq8yu6g5ndEVrGubQLPqtOo8i5rVaMlFSD3bCHcUVh 1473687596
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 468BEF2985;
        Mon, 12 Sep 2016 09:39:56 -0400 (EDT)
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
 <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
 <alpine.DEB.2.20.1609061827290.129229@virtualbox>
 <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox>
 <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
 <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
 <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
 <20160908200305.okeeh35xmrvcveyg@sigill.intra.peff.net>
 <xmqqzinidqfi.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <3b2f13c5-c315-7156-5126-8f469956d645@drmicha.warpmail.net>
Date:   Mon, 12 Sep 2016 15:39:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqzinidqfi.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 08.09.2016 23:36:
> Jeff King <peff@peff.net> writes:
> 
>>> Even though this patch is fixing only one of the two issues, I am
>>> tempted to say that we should queue it for now, as it does so
>>> without breaking a bigger gain made by the original, i.e. we learn
>>> the status of verification in a way the authors of GPG wants us to,
>>> while somebody figuires out what the best way is to show the prompt
>>> to the console on Windows.
>>
>> That's OK by me, but I don't know if we can put off the "best way to
>> show the prompt" fix. It seems like a pretty serious regression for
>> people on Windows.
> 
> Yes, I am not saying that it is OK to keep Windows users broken.
> 
> As I understand what Dscho said correctly, his users are covered by
> a reversion of the "read the GPG status correctly" patch, i.e. with
> a different trade-off between the correctness of GPG status vs
> usability of the prompt, he will ship with Git for Windows, and that
> stop-gap measure will last only until developers who can do Windows
> (which excludes you, me, and Michael it seems) comes up with a
> solution that satisfies both.

Unfortunately "I can't do Windows". Also, I'm not sure "I can do pipes",
but it's really the ifdeffing that keeps me from even trying: Nothing is
gained for Windows users if I extend the Linux code to use an extra file
handle for status-fd - which would be the clean and correct solution,
but which would need to be implemented twice.

> I consider that an approach that is perfectly fine.

As a side note, I'm wondering why MSYS-gpg version 1 is bundled with
non-MSYS-git. It's an honest question - there must be good reasons for
that, and git should work with gpg 1, 2 (maybe) and 2.1, of course. I'm
just trying to understand the situation, and the question goes both ways:

- some Windows user(s) in the Github issue apparantly had wrong
assumptions about which gpg they're using (via git) - why bundle it at all?

- If bundling it to get a known working setup, why not gpg 2(.1) which
runs gpg-agent automatically, giving a more Windows-like experience for
the passphrase-prompt?

On Fedora, with some things still requiring gpg 1, gpg 2.1 installed in
parallel, things can become confusing quickly because  of the 1-time
1-way migration of the secret key store. It's probably the same on
Windows with those two gpg's used in parallel (and probably answers my
second question).

Michael
