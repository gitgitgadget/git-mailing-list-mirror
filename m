Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8169C1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeGISW3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:22:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34347 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932574AbeGISW2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 14:22:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id ABA3121ADE;
        Mon,  9 Jul 2018 14:22:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Jul 2018 14:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KSJg446aMRgzmiDsW
        DxiaOUN/FfxCPGrYcm+L31iGUI=; b=OZl/qslPvDHgLd29PzXnhlEVj1UDPvB2v
        rDxYiYPUBZnefAU+pQ0sJ03xcuHJgL0ouYTiE3ah4kc93Yc08NP9crLnfsqeyncF
        OVpWk3jgeDvd9EVneElLsmM7zqflfZQBtyKpsVyiMWftIMYpdra8wLURq1MktN3v
        bcVIFYu5ulQ8S3/UvPsTrZaFWMbrqBLkX+ypAlyseCeFF2DyLc9rc9FuvnwmCz9U
        N6IRh5Yhv5mRRKrSuqlRN8JtRcnKoaYiws9vs44YqzJMYpCgjJEa+GLbvwaubnyc
        1/vc17VEWvExwnK24LIMLZPw4yi4SIveDIgg8u+nPYQ8FtpUJPbPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KSJg44
        6aMRgzmiDsWDxiaOUN/FfxCPGrYcm+L31iGUI=; b=PblsgvmxExV08VsT9wKveK
        6U5HqFmjC1Dwrnw6GrxywvIVnKqy6RCUCZ0TMoyGIaZ8EsCJ/wRClNBWFRIdouhK
        Yu1AG/wB1E+GYv/odLw8pXahtzLe3GLvudEfZDwZ9NI4d0961YHo5AWMloc0sGeg
        W1wcUTOHoM2nHfCWUuQnqsEHrKGlsySMVtL23B2dRptSkEdbh3xUXm6ydhjdfM9V
        xchWVVg8IrFOQglf9wlmuaGo78srbnQxsyPJTjKloMluzBFFAVoLE6KvhRigxQRU
        LnYNgSh7oDlFvd/mSPfV23YqHjRnmyLMnxHQpRkHlCpXKLLfFh1H7OfObpSON6KA
        ==
X-ME-Proxy: <xmx:46dDW2y1NEcEimK-OoFfdHUn9tL4yq6YY89yeNY_WuBwT7GGUUg-Ug>
    <xmx:46dDWznF9rpuiqSbKif-vXT44Y3IcPPfrKiqHfXJ9wWs1HYf-VYXeA>
    <xmx:46dDW95OgiaXgQh7rWgD0z3TEZzSAP5hHvFFzXaJNuAyPHntGWAYnA>
    <xmx:46dDWyHouYG31DWeDSVeaZdnxbf-siatrsJffvXvQjY6_d7juBZIsg>
    <xmx:46dDW2t_U8pHrf4obY3DF7gpRMwwJkofoanGr7wx9eEbGZZ607LlRA>
    <xmx:46dDWxo52TxLu-Hu-u-CXy3AIibRnePdZANFGWp4MVZVp-rX-eeXbA>
X-ME-Sender: <xms:46dDW1i4gwhw0hx-iARZ1BogbTTM4cQhL9SwwNrHyCUMkigiO-HeBQ>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id 596FAE4514;
        Mon,  9 Jul 2018 14:22:26 -0400 (EDT)
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180708184110.14792-1-dharding@living180.net>
 <20180708184110.14792-3-dharding@living180.net>
 <20180708210200.GA4573@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet>
From:   Daniel Harding <dharding@living180.net>
Message-ID: <13a876a2-7fbc-de05-2e82-814c782e8a80@living180.net>
Date:   Mon, 9 Jul 2018 21:22:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Mon, 09 Jul 2018 at 10:52:13 +0300, Johannes Schindelin wrote:
> Hi Brian,
> 
> On Sun, 8 Jul 2018, brian m. carlson wrote:
> 
>> On Sun, Jul 08, 2018 at 09:41:11PM +0300, Daniel Harding wrote:
>>> Signed-off-by: Daniel Harding <dharding@living180.net>
>>
>> I think maybe, as you suggested, a separate test for this would be
>> beneficial.  It might be as simple as modifying 'script-from-scratch' by
>> doing "sed 's/#/>/'".
> 
> It might be even simpler if you come up with a new "fake editor" to merely
> copy the todo list, then run a rebase without overridden
> commentChar, then one with overridden commentChar, then pipe the todo list
> of the first through that `sed` call:
> 
> 
>          write_script copy-todo-list.sh <<-\EOF &&
>          cp "$1" todo-list.copy
>          EOF
> 	test_config sequence.editor \""$PWD"/copy-todo-list.sh\" &&
> 	git rebase -r <base> &&
> 	sed "s/#/%/" <todo-list.copy >expect &&
> 	test_config core.commentChar % &&
> 	git rebase -r <base> &&
> 	test_cmp expect todo-list.copy

Indeed, as I thought about it more, using a "no-op" todo editor seemed 
like a good approach.  Thanks for giving me a head start - I'll play 
with that and try to get a new patch with an improved test posted in the 
next couple of days.

One question about my original patch - there I had replaced a "grep -v" 
call with a "git stripspace" call in the 'generate correct todo list' 
test.  Is relying on "git stripspace" in a test acceptable, or should 
external text manipulation tools like grep, sed etc. be preferred?

Thanks,

Daniel Harding
