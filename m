Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55E11F404
	for <e@80x24.org>; Sat,  8 Sep 2018 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIIDg0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 23:36:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44659 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727748AbeIIDg0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 23:36:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AE5D621990;
        Sat,  8 Sep 2018 18:49:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 18:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=4R+pzp0/Gz1yza3rc2snDf/IIT0z0
        VB6YwUR6LnMEYs=; b=sHNw7oww8LhChId7bTPBu1JuQLfPBSH+ZYPPq6oP0C50G
        Os7k1WoaKT/Mwc0LskTk+tOVcYLuZSnbk4QXJFNAosyn2DGDu6Kg/lH6SFhRKfRT
        uc1Sentf7re5daCG/3GwsNanY63O7zvxpk9YyTzCEA9BSSVZz651rUSdVh2eonvz
        lD+Tm9y2H3vTaDbQAfn2//ztNKHZBkcHq5Abqtzp3MXRH3DqeCk3NS6G+cXGDku3
        wmLYqt+5/XBMJl113Zunnysjaq7gy7nkaDaUQoLIaj8x2kVVLsHdMs6ecZ1JB7xQ
        eTBkSaaKuTuAO9ngLG4A8oRS7BRPi20tl5ar7Z7PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4R+pzp
        0/Gz1yza3rc2snDf/IIT0z0VB6YwUR6LnMEYs=; b=B1uNnvi6xvIBndKHX6gS34
        6KEo0FJDhXp2YUtBm1aRLmRKG9v2qI2+V3l3DSs9h9WFU54Wk1WMYokXsI53XFP2
        tB+akbaj5m4wp4NKgYGRzMNzEjM4QLZM6q7d+jWZEQAVeUhLB6XEZk+CSnPtoukU
        rd97XuPlWuvY6/LIS+LGnkQp996Ub/AxiGuCsEpsVxuH0jyXuVZ5aArf1gofg6sX
        R5EsaY5k7AVM5NUwDWXDn3wVC1KH7naeTZjolmOxVUUCwslTP+cEbhz1V5IEDi7c
        cEJvH25VhG+lk0qLYHpKnmeaCS1e/TH450Ixn/zduToGKhAH63g83h1qGqWiOYmA
        ==
X-ME-Proxy: <xmx:4FGUWwAbEPPKHQAwMwF9MQMaMUvw-CFyj3X_l5ndmBoEgTKdQ-qiSA>
    <xmx:4FGUW-mHYgVEZV59ujqsurdskzVOecES51Wht3SDwE_ACLNQ9Xf6hg>
    <xmx:4FGUW5juecAdoLy_Jhg-tsN7yG6_-fmVNplyjFXVa2LxQrrrFJwkZQ>
    <xmx:4FGUW3s0uTrof9R4h7fGYPTY8PQ-TQDUQHLyGd-DLTagijs64Ou9DQ>
    <xmx:4FGUWwC63izYDBxTBFTBLi7A_PICXO8pCl8ZgAEuBA90sPEoA1TLrA>
    <xmx:4FGUW3Q5YkjUwoUNXL_WS5WmWn_RBkH4voFtYQKWbv4OJ-IOgvbNSA>
X-ME-Sender: <xms:4FGUWxYAMbqSgRVfDgTe2Yn_JICZ7VmzMpOn0wMs5zgTYVOQT1AGXQ>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 824EB10293;
        Sat,  8 Sep 2018 18:49:03 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <20180908212256.GB31560@sigill.intra.peff.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <7f7e20fd-069d-f227-ce13-811398b52425@stason.org>
Date:   Sat, 8 Sep 2018 15:49:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908212256.GB31560@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 02:22 PM, Jeff King wrote:
[...]
>> The original problem cropped up due to using:
>>
>>  git config --local include.path '../.gitconfig'
>>
>> which on linux stripped the single quotes, but on some windows git bash
>> emulation it kept them.
> 
> That sounds like a bug in git bash, if it is not treating single quotes
> in the usual shell way. But I'd also expect such a bug to cause loads of
> problems in all of the shell scripts. Are you sure it wasn't cmd.exe or
> some other interpreter?

I don't know, Jeff. I think the user said it was first anaconda shell.
And then the user tried gitforwindows with same results. I don't know
MSwindows at all.

But it doesn't matter at the end of the day, since we can't cover all
possible unix shell emulations out there. What matters is that there is
a way to flag the misconfiguration, either by default, or through a
special check - some ideas I suggested in my previous email, but surely
you have a much better insight of how to deal with that.

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
