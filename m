Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8721F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 22:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407909AbfJWWgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 18:36:35 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38729 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405969AbfJWWgf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Oct 2019 18:36:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 521F0210F2;
        Wed, 23 Oct 2019 18:36:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 23 Oct 2019 18:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=mesmtp; bh=7Hvj+rR8geFsv8KIYRj7r0Z
        9M+lIM6HHyjqnBE5Oc7c=; b=b+Ebs8s83FKHNfSl/j+cURwikdyLxpuHcsmzi2X
        d9fmIFCXpwxeRLDmN0dAyDPSYR7W11DYURPijSVPNo5xwVC/3orgNV+z0+diMSSz
        H1l1xAaohggi0D51CF7cPsD5dhDwsA4jHvIf3BNxExW2/V2lTvQWLVXCkR5+iUEg
        0+2Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7Hvj+r
        R8geFsv8KIYRj7r0Z9M+lIM6HHyjqnBE5Oc7c=; b=Dqo39hMKmiD3N2zGqGA26F
        6k/1Yqa0UrY6H7sdVuhXg4WKW2FT0QnuPY66p0mS6N5kk2UfvAlNS9b6aDgCo+7N
        t68+gRY/rsLb1kmIw/1emNwuDydiNOB6EXqUn+tIlLPRTCDjSD9JoOUrygWlFN+G
        z1tJU1o/fynoM47OCYzpV4BmJ/JPRwpAQ0ApCjnaYrZvxinOMcsSh/hHstXdYV7z
        lMvFIeSQlqVH0MLqUq4uXvkf3aNckrxZH2xIRV7oc+nMABnmWhvUvpgzJm2Yr8vl
        FpQERweC4AChVEcEom8YnoW6drzKeVd7TJetN1pnXqBl1WQt6ZZvIPx9HS7CU0Uw
        ==
X-ME-Sender: <xms:8dWwXYLj2tbcdC4SkuLs4U6KjgNffRCGTydZ7jQWhE9mt6UMAdWutg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrledtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffoffkjghfgggtsehttdhmtd
    ertddtnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehjrhgr
    mhhsrgihrdgtohhmrdgruheqnecukfhppeefrddvudekrdduieekrdduvdefnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjrghmvghssehjrhgrmhhsrgihrdgtohhmrdgruhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:8dWwXcafljwBOcvMBN8Aq5M1Whbx9qh7DP75iNjf8uHjmbCk7u8zfg>
    <xmx:8dWwXTvY4N9c_4udvv3a1-cEs30HFaBL8e4dr05xnE0lwI616JBEDw>
    <xmx:8dWwXZscZOQ2lW4LTmOb5onHSyYQEOzvxUlpOmt7jWIDpjfg0VScVw>
    <xmx:8tWwXZUv9CYFxYmJE2Zd7FFceNLEEow6DB3vdAPWDaFWTMm_D0lxag>
Received: from [192.168.0.152] (ec2-3-218-168-123.compute-1.amazonaws.com [3.218.168.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A576D6005A;
        Wed, 23 Oct 2019 18:36:32 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: RFC - Git Developer Blog
Date:   Wed, 23 Oct 2019 18:36:25 -0400
X-Mailer: MailMate (1.13r5655)
Message-ID: <4F3ADBAF-2DEF-4764-8056-56FFCB9EB767@jramsay.com.au>
In-Reply-To: <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
References: <20190806014935.GA26909@google.com>
 <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com>
 <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; markup=markdown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 Sep 2019, at 9:29, James Ramsay wrote:

> Peff, you mentioned Jason might have some designs or ideas with 
> regards visuals. I'm happy to be put in touch directly or collaborate 
> here.

Peff, did you touch base with Jason on the designs?

I have some travel coming up which I hope will provide quality train 
time to work on this.
