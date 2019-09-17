Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045F31F463
	for <e@80x24.org>; Tue, 17 Sep 2019 19:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfIQTWp (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 15:22:45 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42589 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbfIQTWo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Sep 2019 15:22:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A71421FE5;
        Tue, 17 Sep 2019 15:22:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 17 Sep 2019 15:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=mesmtp; bh=XmpbAfNoQNbygASt2my8BSz
        N1J6FDlUxfHN6857p2DU=; b=rJ1iYHarcXg0N5h128dJhOK0KXMTnTq8ReuNuL2
        1A5jeXkqx60P1s3ygl7mkG6yVe7qtfwlXdjDEQO4YyXQFG9qEhgS+3wD2P7xipGB
        z29qrkzSXJSqVy/j0klIyXRibhap6QuvauwZNtabN0i3jhseDHKaY0ya7Jfmlsqe
        yhGU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XmpbAf
        NoQNbygASt2my8BSzN1J6FDlUxfHN6857p2DU=; b=iXCAPN7X5Ilw/ddaEunKhQ
        3Ss14GSUa5ZShbd99YTLfu5PyMd2Xp0oDW6F0erh+9z5KMKavv7qcRwGscT2/Qk/
        KuekoSRB6nsycCaYEy8lmDHInF+HkkzEKwb2OSUBrdp63yhYfGyNl6HX+9+Ue2cJ
        +FYT0N6eGFUFuQb9AYVTrWjud1/64OyX/2oDeUbZXARUJ50jXWKe6NeVEdR3Y3yY
        r4kapmnf4jFxjO3VVpRluGQfBx5QxiEcjLJE/MW2Z6hZRuZzEaLzQsNhRFNd9s7N
        I6B9mR+c0gvi7c3Kk1OXPkgZLSrCEqkqVd+7P0G/6U9Uu4cFYgeSvehj3jIalG/w
        ==
X-ME-Sender: <xms:gzKBXXWAG_SOs8Ev6rF_IYGDcl65Z0s2tNiERiQo12C1_gG5uGS2tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffoffkjghfgggtsehttdhmtdertddtnecuhfhrohhmpedflfgrmhgv
    shcutfgrmhhsrgihfdcuoehjrghmvghssehjrhgrmhhsrgihrdgtohhmrdgruheqnecukf
    hppeefkedrleeirddujeelrddvtddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghm
    vghssehjrhgrmhhsrgihrdgtohhmrdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hDKBXT3FHygz9PC4hF-N8X4K_aW0EKqj7q--bKfUIXE7OOFw-DgT8g>
    <xmx:hDKBXea1ohwrrgZ1tQHj8dZ63q-DCVmn6QEQ7OQjXPMkf6ax_oDyxg>
    <xmx:hDKBXWogu5MPi1ZgftT_BuZDUSqe7r_5MPIj2dxmrxpBubGIAzlXMw>
    <xmx:hDKBXehX4qlnMpEdolfLKL8gl1mGxStZyGKWzVGs48UXbM8y0BGv3w>
Received: from [10.205.254.245] (unknown [38.96.179.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id B98B880064;
        Tue, 17 Sep 2019 15:22:43 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     "pedro rijo" <pedrorijo91@gmail.com>
Cc:     "Git Users" <git@vger.kernel.org>
Subject: Re: RFC - Git Developer Blog
Date:   Tue, 17 Sep 2019 15:22:38 -0400
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <45DA95BF-17D8-4238-9ECF-A4D1AC1A9634@jramsay.com.au>
In-Reply-To: <CAPMsMoAwfp+jv9h7xAD9PbqV+cU4njyf7Tex6HUCznqjb5hi_w@mail.gmail.com>
References: <20190806014935.GA26909@google.com>
 <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com>
 <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
 <CAPMsMoAwfp+jv9h7xAD9PbqV+cU4njyf7Tex6HUCznqjb5hi_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; markup=markdown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 Sep 2019, at 10:05, pedro rijo wrote:

> Just a minor question: since we have git-scm, pro-git, and git
> translations in github, why not keep in the same place, under the same
> organization? I just find it easier to find than having repos
> scattered across different git hosting services

It wasn't a technical reason, but a matter of me (and my employer 
GitLab) volunteering the time needed to get the blog project off the 
ground. In the context of the Virtual Git Contributors' Summit, folks 
seemed happy with using GitLab or any other service with a Git 
interface.
