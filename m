Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599291F462
	for <e@80x24.org>; Fri, 26 Jul 2019 18:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfGZSLC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 14:11:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42331 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfGZSLC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jul 2019 14:11:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2851D21B6A
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:11:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 14:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:mime-version:content-type; s=
        mesmtp; bh=HkJp6L9eWla3JPU5/7pvb+G71KxFC7TVufPlPYi8joM=; b=aOfNK
        +XGodunc55utsEmjfSIWH/tNRmHGeTqY5+W1+iX88/4oxCszgafeqgPLShsq8QPK
        FVSmgeyODRiyUfMSRitRLLl1sZRzwgCdXwK8vzyanTVLRH/Kr+JdqIRGEMldiO1v
        GCpFQ2TorRY6/gyO27ORWRGtlPGXiItPJpt8e8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=HkJp6L9eWla3JPU5/7pvb+G71KxFC
        7TVufPlPYi8joM=; b=BO9JYUOWYmX08YQs9PcHSXWCW1830PThq/03/PQTs8Vao
        7QsJ+F+kXp4myh18U9oDBCZxAFdD/2KhHE2KSgnhn/LY0CtKyqsYSumuT3ndXVO9
        fRpWa9aCf7yhY9FJ+FYb5t5Fxh7IVGO+WXX25de770iw8iKCEDj7YB9GTeevdNYL
        KDdhVOJPps0+ROjafAXpMGPTMPGc7BzIUWnKGYn6j4PtPWh6t4TbRoDhE3LXTFhO
        4XXWb5dC7LUCoRC8R6agPHe5uROlRmHIsNCmj8DvZV76+aV4T1KD2WNST4mLhkLM
        o4s3vYP06UL3TW2rF7YvG4M8YOEck93Wzr6WaJbHg==
X-ME-Sender: <xms:NEI7XYyO-vXSHvFKxTAUtBclATRBzP-UWCsjFIY9YEZiY675GgCf8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfggtgesthdtmhdtre
    dttdenucfhrhhomhepfdflrghmvghsucftrghmshgrhidfuceojhgrmhgvshesjhhrrghm
    shgrhidrtghomhdrrghuqeenucfkphepvdegrdduleefrddvvdelrddvudegnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjrghmvghssehjrhgrmhhsrgihrdgtohhmrdgruhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NEI7XQ9hXxeybsUHkcnUDu7NuutyxztM4ekxhvhf4bWb2Z8084lFcQ>
    <xmx:NEI7XSOwFFybp6bxiecNmb-zYnqRIU1ArtigRUGxm1zibtacYlxmmA>
    <xmx:NEI7XaSdBbijzNkmW7gWfzugQG-yIb-qK6hwFZh-BtvJWijuTWORbg>
    <xmx:NUI7XZNEZoSJydfxkEPv81HClCnHzvJxoSXehljc9qhq8lcYOIpq7A>
Received: from [192.168.128.94] (cpe-24-193-229-214.nyc.res.rr.com [24.193.229.214])
        by mail.messagingengine.com (Postfix) with ESMTPA id C99BB380086
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 14:11:00 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: Reporting reused packfile objects
Date:   Fri, 26 Jul 2019 14:10:58 -0400
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating improvements to clone performance at GitLab we've 
been looking at how to trigger packfile reuse during clones. A challenge 
of the investigation and a future challenge of rolling out changes to 
encourage more frequent packfile reuse is knowing when packfile reuse 
kicks in and the extent of the reuse.

I notice that GitHub outputs 'pack-reused' statistics when fetching. I 
assume this is for similar reasons.

Would there be interest in including a reused packfile objects statistic 
in the output of upload-pack?

I'm happy to contribute a patch (it is quite a small change), but it 
might be more efficient to upstream the patch that GitHub appears to 
already be running in production. Peff, what do you think?

Thanks,
James
