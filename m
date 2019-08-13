Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7961F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 06:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfHMGBJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 02:01:09 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48091 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbfHMGBI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Aug 2019 02:01:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 7016F38A
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 02:01:07 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Tue, 13 Aug 2019 02:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=50gfW98Mseeoxnkv3X6lOtOYWIaav9YiJeCm4pCnQ+U=; b=aXMkcuPM
        Obz5S9qZjavoDYuHDw0oCSm2W3RbLilZOPPMftcxL6mbvzDgD413nU5d+aeY9vvB
        yEcJ84HBZiT8OhGCgXiq+GVMnCO/nqoouhiWFwzv+JZsay5pYgX0131YEXDn7wfN
        bjGuMywiNdtQLGKI8zbeobX58rzqvOoNyYJzprz3STj5EuBF2AeMBFIP8t2Oxo9f
        hMd44IUFU0tguPIKDfFi40ggp0V4Y/SW76j/4ZbH4uZVjyK4gyiuYoPN9cuv0tig
        3w3WlAahGg3BmUhlv9OsIF04ch5GQ4vM/JopzH70LpkAJ3ovLI8K8g+r+bqL4yH4
        HJcWy459ua5QIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=50gfW98Mseeoxnkv3X6lOtOYWIaav
        9YiJeCm4pCnQ+U=; b=kXDnNVCPdrkX16Ad4nY1FY4jWGlPb5wQCGH036DZAsMQE
        e1fjXxqDK4iipldYSATbmiYM1r2/qETPhVu0aXElX/DuC6EVv0kLKEYQNaUTaHx9
        hxuBe+qLuSYFT/qdMaw8jRVG1rbMN6gey7rThb3XqBeeim/IKwk21ru7fZD1NWCv
        AlCAWBL0PJXka4PbSbgfFy5lrobdaqd+8gcKYKY9aFKrQ9jmocGNhMV/aQaw5HS/
        rl1Q5ps//S2J1voGQa5gmmdPrL3OuUEWdNH/nsquiDjlD+D1AGVPD/YrTduSOlhg
        Mshb/i5MHC0Y79yQdo4Ys+C35GHr/JtMlQwYQO6UA==
X-ME-Sender: <xms:IlJSXdwRgs5O4dUIGZ10-dqsNI9hWJnnmVF4DdQpqlfgoAcngh8_xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepnhgrnhgrhigruceovgguhhhosehfrghsthhmrghilhdrtgho
    mheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvughhohesfhgrshhtmhgrihhlrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:IlJSXdWjvXXiD9PD6wiKKjf-diCvah_0lCL9w_CQGxB8E7pxCtzbGg>
    <xmx:IlJSXX3yHOs4JVnXb3UfFbOb-mFzeqiu5ACzCdbUpriHrTdtFGZfgA>
    <xmx:IlJSXWNGg05Zfgc1oAkkmrbcG7PkSEXylRJJnaLgXf0a4gP0vEU8-w>
    <xmx:I1JSXcOt7N6bX3ks7u9C22rSIDi1gMaOBrzwj-1YCBiRQUTWb78vFw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D8425E00A2; Tue, 13 Aug 2019 02:01:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-864-ga937f03-fmstable-20190813v1
Mime-Version: 1.0
Message-Id: <35477812-7889-4f32-85ac-d3da4e7ff902@www.fastmail.com>
Date:   Tue, 13 Aug 2019 15:01:04 +0900
From:   nanaya <edho@fastmail.com>
To:     git@vger.kernel.org
Subject: git grep -F (fixed string) requires matching parenthesis?
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I observed this today:

$ git grep -F '('
fatal: unmatched parenthesis

Which doesn't make sense and I believe shouldn't happen.

$ git --version
git version 2.22.0
