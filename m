Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDB71F453
	for <e@80x24.org>; Sun, 23 Sep 2018 22:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeIXErS (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 00:47:18 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49187 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbeIXErS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Sep 2018 00:47:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D4F332B4
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 18:48:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 23 Sep 2018 18:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=xfOfkbX6h9BsSDbKJ4jlxfM8hxVgZ
        KDAReEK0y/q52Q=; b=iauij2giVRDiyfoazpEbSnkH0mIoiHXhkuLesyFT/AA1T
        bBbtVj950UVfJ0v5XEcYuEnuaMyREWMTS71j3tCH8/13++f+CiYZa6Zf7Oz4EFL6
        FwFfwIMH1GFjyljcTVsobDxxjaPQju1TXxZ3j78eX3/Yndkx5ExUXsACjTHrqeh9
        aV7/OYUxrFEZ0bIexn+swsgXXrj0rlblkD6y7KwDBCVa+Wia6i8X73r46DgKMxhK
        K6muuYHrhyQuindk7KOsaKv47ZmmPCRtk/0Q4/Lx9dFm1u/CLb0K8edS1vaJqGJP
        m1541ZNY622Aw2EBlyactSEShZi+DSY1W2E9t5Ytg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xfOfkb
        X6h9BsSDbKJ4jlxfM8hxVgZKDAReEK0y/q52Q=; b=Q+GXeG80RPQIeIijRBtJ4I
        YOne9DtPxSa/udmgI3JRJ1khFI4xN+f10C8FJ3feH+9ciFnriA0Wa7KiUi8lEQgI
        DodAOY45DpMMaC35KUCR2K2VwSRb7jdddAP0SkXxtudINE/KedIkQQmrRo8Zdt2L
        OqNSYdXhLj0h9h/MqEfF6VJdL0Q8TTZXCudCDtSjMEbSoAk6nM5LmiYZU1v4yPQD
        88IB4imbI28w76rctzvNGqRFgBB3uGFYxw2pYQe9m6Sn5zKlLefAJccXzExJDI/t
        Amab52l+alCal5BHr88edOdZiAH0eALGkKUkvCPi98N85E08VofwQfydqK1rMUUA
        ==
X-ME-Proxy: <xmx:IhioW42R9OwV3C0ePTJv6Wobf8WBxRwXwJ_Rs1FItBHFDM0YKcOn5g>
    <xmx:IhioWxubkoPwR9tA466K2yHJpdEwp0xqb-hioEmiqKpNLxQo6Hx0bg>
    <xmx:IhioWwjcZGh5d6NsoyvIXuGouLQKF_2tHIAjOl33yug9rbOYRbUzSg>
    <xmx:IhioW4BAiljSd57n8FFO7MjOXn_uCMD-zkWZjMI917hs4K31_V1XAQ>
    <xmx:IhioWwUOd47Yg7pb9BNgA36djyRoSm2MX_sI5EgHrXeN5cMAO0aQhg>
    <xmx:IhioW8YF_sukxvH3L5FjkWVXd2pnS14-wtB21_U9RMa5CwUFwX4ggA>
X-ME-Sender: <xms:IhioW2JjkWw3-uKp697sy_EATnpqyXJfS5KwVbqjCPuhUYGRARXubA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F71D102D4
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 18:48:02 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
 <20180908211436.GA31560@sigill.intra.peff.net>
 <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
 <20180909023332.GA14762@sigill.intra.peff.net>
 <xmqqk1nrojpq.fsf@gitster-ct.c.googlers.com>
 <20180911205709.GA25828@sigill.intra.peff.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
To:     Git Mailing List <git@vger.kernel.org>
Message-ID: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
Date:   Sun, 23 Sep 2018 15:48:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911205709.GA25828@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for I don't know how this project manages issues, so I'm not
sure whether it is my responsibility to make sure this issue gets
resolved, or do you have some tracking mechanism where you have it
registered? There is no rush, I'm asking because the discussion about
this issue has suddenly dropped about 2 weeks ago, hence my ping.

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
