Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A99C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJQHlE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 03:41:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54505 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbeJQHlD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 03:41:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C0FBF221A9;
        Tue, 16 Oct 2018 19:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Oct 2018 19:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=n
        FhMJTCNC1y/Bk8pUIpC79RTEJ12lnTfRXZVZ+2w/7g=; b=cUczpOmTfz+G2iZho
        4jr8a5l+PX5b2AZkKwgj5R7SsPWO0Vi7coXpVRq7TWsrJrGpXgdBAdx1+CH+OBN1
        ShZhmdAS/n9GSq3FTl214dtYPe+ojbx/nVZ3DL8wNrjzUE3zZR7l8XV9foD5VY1c
        qV8Z3F/ANV9IOdQCB5uTZDEPWbmY0MriZkWgt1FvG0D8dRMxkHC7sabQTTSfcANv
        u8N+duRt5QL6npBCNy9AOGFK76RS9NGDwe0eDUXd62eCQDLr/pH08ppdDvNOrlZh
        3mYnZEMNGQzUTTkQ1rq0STKaaw6+u6Ei1BjhEbmFUdvy/6fnb8clcWGpcQR4Gqyy
        ZVEjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=nFhMJTCNC1y/Bk8pUIpC79RTEJ12lnTfRXZVZ+2w/
        7g=; b=nsp0s4K2r+/eFnPRVmG2V60VeZYe3/slDXoWoNg1XFqq1SYGbJqn0csJf
        QFvXI4dRbzkAgjEsX+g8jpGitcwXxz/KnFozgAT3bwPnsDKRRM009MrD68Dzvo2y
        0m0+ee5m6qH8s2yBYL4RcE7/CS8XKoAtFO5B+YwOx1MmC49w830PFTwqkZSq8rjm
        hMMCHSNb6AJc6AaSbOLG2iGcY/OhA0Mp8+U+OHEFELuF2c3d0Pu+TNAMBHwuRVfP
        MvaEVDtCmQUI5a1mpjPoOLLvQ8LQoXGbA2oPg2CgNDUzxfylDGWpFLMdS7gULWhg
        Oe1ki8mqVH5bTfeDRWS6HADK4457Q==
X-ME-Sender: <xms:v3jGW1jd2uVjK8mYmyHr1xK69b9IFiAF_sLwOB09xtPTZPugsihsaQ>
X-ME-Proxy: <xmx:v3jGW6aZwQTDI-8RR5kIAYEWhDZ1NOxo0vR6ujDoldYnPqjATP06Bg>
    <xmx:v3jGW-Je9_W98qua79BX7xOky2IxaOhbBlc_cUKEwVdOb1YMcIZx3w>
    <xmx:v3jGWxGRGv2CZLwKQKGF0JRjR27-3DYvSfeWwlxnAN-Anf7wzvTLpg>
    <xmx:v3jGW9uAWSr9_1XMj6AZcvXdywuM_LK2awUTy0GvZnX8OfGNPBYNiQ>
    <xmx:v3jGW4ujkiQXRqUQahan-vyP1Mco6uO0cnrL_5S1s8EI6BXijWPWDw>
    <xmx:v3jGW6V_Y3WbVcf1X_QgpXSXLJ0dJ4zmLyf8W0o_zVVwUoW26-JDQA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06947E4124;
        Tue, 16 Oct 2018 19:48:14 -0400 (EDT)
Subject: Re: problem with not being able to enforce git content filters
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
 <20181016232636.GF432229@genre.crustytoothpaste.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <038d40b9-0b35-b93f-9377-7c0bb12bce8e@stason.org>
Date:   Tue, 16 Oct 2018 16:48:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016232636.GF432229@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> And the devs honestly try to do their best to remember to configure the
>> filters, but for some reason they disappear for them, don't ask me why,
>> I don't know. This is an open source project team, not a work place.
> 
> This sounds like it could be easily solved by continuous integration.
> You could set up a job on any of a variety of services that checks that
> a pull request or other commit is clean when when the filter runs.  If
> it doesn't pass, the code doesn't merge.

This is an excellent idea wrt to PRs. Thank you, Brian! I will implement
that.

It doesn't help with direct commits to master, since CI would be
detecting it after it was committed. And when that happens we all know
that already because 'git pull' fails.


-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
