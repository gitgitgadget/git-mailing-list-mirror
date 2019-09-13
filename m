Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1931F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391119AbfIMN3h (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:29:37 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48997 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390390AbfIMN3h (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Sep 2019 09:29:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5810B514;
        Fri, 13 Sep 2019 09:29:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 13 Sep 2019 09:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=mesmtp; bh=EOxObcT5ZncxYQP3DIMvm2I
        sIwUIBvD39UP5jJ1I6F4=; b=W+2XpgsmmZHx2MKP0MvCd4+/YZdUSSkB60mZtO2
        8aHPH5RNPYzbtWyMEwn/DWZkquoa+S4q3F+p6EbAJQRbtweJkEnB3DUZ3MB3LMKs
        cPk6TL1MjOv+qtYgq+N88jbI0tpBb9OuIRTxtC18t2J4UHK9SZp3My7N4kUJUD4e
        CZvs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EOxObc
        T5ZncxYQP3DIMvm2IsIwUIBvD39UP5jJ1I6F4=; b=UG7q/bTcNku4VFJn5+N06A
        4nbuwKB8+BWHQXRFNvnx6DhNhdVDZ2DZzwozxCos2URiGo8Oe0Zp4eIkjCRaD0Cn
        OQq5/tE1IIshryMbrIh6wbbpZ8eB6+XUt4G3WTzMi1eJZpyCFdHWVTW10kpAXOKS
        Ssgu9AaBruqNwrOgRuK8kIf6WUD4oONzClmy5RdpG8ZNb59S3Y5WazQMe32WlYTj
        CBhRjsrjdlRH/+qNPSm2DtYslHwUQ3fQCunxA6WciWn3qXb4nAb4HfvfXdyHCaKj
        38cYafjoBbsXr8tt0CTtBLrtNkEvBWJSdFXsCc9bAG9eq9f8zpabN1IYoBGf/8Gg
        ==
X-ME-Sender: <xms:v5l7XZ2GdNBmU0LJvdl--_Wow8WzfSu-IMm0eRGFMPh352BEWPe4rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdejgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffokfgjfhggtgesthdtmhdtredttdenucfhrhhomhepfdflrghmvghs
    ucftrghmshgrhidfuceojhgrmhgvshesjhhrrghmshgrhidrtghomhdrrghuqeenucffoh
    hmrghinhepghhithhlrggsrdgtohhmpdhgihhtqdhstghmrdgtohhmpdgrnhgurdhorhhg
    necukfhppeejgedrieegrdehhedruddvieenucfrrghrrghmpehmrghilhhfrhhomhepjh
    grmhgvshesjhhrrghmshgrhidrtghomhdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:v5l7XRXTH13oYCcIYDUX9-NVRaoxSRQ5FSGMYCVS6qndF2F6vH5aHQ>
    <xmx:v5l7XW8boKazJp4RU_aS-xnchyqK0QNO92jxAxbeuUn7Zg8M8xT_2Q>
    <xmx:v5l7XZ1qSSoftJUC8AaHoHDrb5kXUrZgmBJBMD6Ooesn-JAemq3SwQ>
    <xmx:v5l7XQ09M7_TaC2yqxR6ZsIhBCNDw0MODmZv9ZGu9CdSo--A1vGrjg>
Received: from [10.1.1.5] (cpe-74-64-55-126.nyc.res.rr.com [74.64.55.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id B0ECBD6005F;
        Fri, 13 Sep 2019 09:29:35 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     "Emily Shaffer" <emilyshaffer@google.com>
Cc:     "Jeff King" <peff@peff.net>, git@vger.kernel.org
Subject: Re: RFC - Git Developer Blog
Date:   Fri, 13 Sep 2019 09:29:33 -0400
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
In-Reply-To: <20190806204925.GA196191@google.com>
References: <20190806014935.GA26909@google.com>
 <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Aug 2019, at 16:49, Emily Shaffer wrote:

> On Tue, Aug 06, 2019 at 09:20:52AM -0400, Jeff King wrote:
>> On Mon, Aug 05, 2019 at 06:49:35PM -0700, Emily Shaffer wrote:
>>
>>> Are folks interested in writing and reviewing this kind of content? 
>>> Any
>>> ideas for where we may be able to host (maybe git-scm)?
>>
>> I think it would make sense to have blog.git-scm.com (and .org) with
>> this content. I'd be happy to deal with the technical side of setting
>> the name up. I think it should live in a different repository than 
>> the
>> main site, though (which is an overly-messy Rails app).
>
> I'd certainly be happy with that setup if others agree, although the
> incorporation with Git Rev News sounds interesting too (I'll reply to
> that post also).
>

As volunteered yesterday at the Virtual Contributors' Summit, I have 
created a project on GitLab to start working on this 
https://gitlab.com/git-scm/blog. I hope to have a basic text centric 
implementation for feedback in the next few weeks. For now, all I've 
created is merge request with an empty Hugo site and automated deploys.

Those who would like to be added as maintainers, you should be able to 
Request Access using the link near the project name.

Peff, you mentioned Jason might have some designs or ideas with regards 
visuals. I'm happy to be put in touch directly or collaborate here.

