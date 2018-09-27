Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786171F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeI1Ckk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:40:40 -0400
Received: from gateway10.unifiedlayer.com ([66.147.251.97]:59404 "EHLO
        gateway10.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727294AbeI1Ckk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Sep 2018 22:40:40 -0400
Received: from cm3.websitewelcome.com (unknown [108.167.139.23])
        by gateway10.unifiedlayer.com (Postfix) with ESMTP id B7D00200978C5
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:59:03 -0500 (CDT)
Received: from uscentral401.accountservergroup.com ([23.91.71.222])
        by cmsmtp with ESMTP
        id 5cRDgM4R8cHiL5cRDgbLNv; Thu, 27 Sep 2018 14:59:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lonetwin.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3dxClJO79Jjhe795UUjJ4rxvgu3yrJIFduUzFJgT2H4=; b=m6joNYTMJRwZIOmerBBl/V/YlM
        oYTZp2NvOE5D5Zc9BXdVrGHl+kv6BCR4U7C53HO0Y0D662nWQJINxpbvVWQOuPXb8mteKxjY5M1nZ
        QvlfToJZS52s4tm/dGN4miA2AXALe3VPuIxkYShBHqP1MIURezHaxRz0EaEY7Fjn7hQpgH8D3krgp
        KGaXQSOKQDgLczmjrUMFjuaVoIEoD3ApQh98QDX9A91ibiKjHFQnKhg+febR1S3GAqZB0/wk4Kixn
        Hi2n6iFB0R5Zad/EqhYZ7GcOvHcfQh3Rp1+xDQ17oBuIwsDCH3eFEOdF3H6LO1I5b1yhBJzQs4pVN
        pgZIWjOQ==;
Received: from [37.228.246.228] (port=16160 helo=lonelap.localdomain)
        by uscentral401.accountservergroup.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <steve@lonetwin.net>)
        id 1g5cRD-000WMi-1v
        for git@vger.kernel.org; Thu, 27 Sep 2018 15:59:03 -0400
Message-ID: <ef5e9e8da180a5ead70b53d767a8ed4a0666e598.camel@lonetwin.net>
Subject: [PATCH] git-completion.bash: Add completion for stash list
From:   Steve <steve@lonetwin.net>
To:     git@vger.kernel.org
Date:   Thu, 27 Sep 2018 20:59:00 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uscentral401.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lonetwin.net
X-BWhitelist: no
X-Source-IP: 37.228.246.228
X-Source-L: No
X-Exim-ID: 1g5cRD-000WMi-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (lonelap.localdomain) [37.228.246.228]:16160
X-Source-Auth: steve@lonetwin.net
X-Email-Count: 1
X-Source-Cap: Z2FicmlsY287Z2FicmlsY287dXNjZW50cmFsNDAxLmFjY291bnRzZXJ2ZXJncm91cC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Since stash list accepts git-log options, add the following useful
options that make sense in the context of the `git stash list` command:

  --name-status --oneline --patch-with-stat

Signed-off-by: Steven Fernandez <steve@lonetwin.net>
---

This is my first patch to the project so please be excuse any process
errors.
Although, I've tried my best to follow the guidelines in
Documentation/SubmittingPatches but I'm not sure if I missed anything.

 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git contrib/completion/git-completion.bash
contrib/completion/git-completion.bash
index d63d2dffd..06ec6ca11 100644
--- contrib/completion/git-completion.bash
+++ contrib/completion/git-completion.bash
@@ -2567,6 +2567,9 @@ _git_stash ()
 		drop,--*)
 			__gitcomp "--quiet"
 			;;
+		list,--*)
+			__gitcomp "--name-status --oneline --patch-
with-stat"
+			;;
 		show,--*|branch,--*)
 			;;
 		branch,*)
-- 
2.17.1

