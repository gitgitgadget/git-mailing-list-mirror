Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072421F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeI1C3o (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:29:44 -0400
Received: from gateway10.unifiedlayer.com ([66.147.251.97]:49732 "EHLO
        gateway10.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727294AbeI1C3n (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Sep 2018 22:29:43 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 22:29:43 EDT
Received: from cm6.websitewelcome.com (cm6.websitewelcome.com [108.167.139.19])
        by gateway10.unifiedlayer.com (Postfix) with ESMTP id 09FA02009D041
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:09:44 -0500 (CDT)
Received: from uscentral401.accountservergroup.com ([23.91.71.222])
        by cmsmtp with ESMTP
        id 5cbYge0zke2SR5cbYgseU1; Thu, 27 Sep 2018 15:09:44 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lonetwin.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NBofJGBnrbtIzjDKxA+OEWqW+/eq8kQkp8G7hGAG/Sg=; b=IpkN7jkZCeSqkDsTyGy1Xu4r2v
        2B09rnXJCQg1ozgvRd6/0uG8HK45gMsSkzgDuHRi/RTTDy17wQh3k4f1+n5M5dsV7oEnLjHgOcrsy
        hd6tvR9wVgBNp9z22Y7tIf8zOn8G3h3lQEWDo7w7kolygzByjzPdrqw51yF+9NWg/L88lqEMMk6QK
        qYj8jIIJqntsVvYYxrtnPWZuaxMeX8ZQtK7S0fQ3+xGrdsGtEvo49Xe5J3/E8WROcgP8e8x2L0Mb/
        WJJp47eEn9RNnJHMnX7ibEvmM04OJABo5lndU2juSMWmU0y1kmOcURfpnvBy38opqyzpZXXwCqZIz
        z9ocAsQA==;
Received: from [37.228.246.228] (port=16044 helo=lonelap.localdomain)
        by uscentral401.accountservergroup.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <steve@lonetwin.net>)
        id 1g5cbY-000juz-Bk
        for git@vger.kernel.org; Thu, 27 Sep 2018 16:09:44 -0400
Message-ID: <4652c92c88b6c256d7bb51cd6524088eba4f4387.camel@lonetwin.net>
Subject: [PATCH] git-completion.bash: Add completion for stash list
From:   Steve <steve@lonetwin.net>
To:     git@vger.kernel.org
Date:   Thu, 27 Sep 2018 21:09:42 +0100
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
X-Exim-ID: 1g5cbY-000juz-Bk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (lonelap.localdomain) [37.228.246.228]:16044
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

This is my first patch to the project so please be excuse any process errors. I
think my mail client messed up the line wrapping in my last mail. Hopefully this
one's better. Although, I've tried my best to follow the guidelines in
Documentation/SubmittingPatches but I'm not sure if I missed anything.

 contrib/completion/git-completion.bash | 3 +++
 1 file changed, 3 insertions(+)

diff --git contrib/completion/git-completion.bash contrib/completion/git-completion.bash
index d63d2dffd..06ec6ca11 100644
--- contrib/completion/git-completion.bash
+++ contrib/completion/git-completion.bash
@@ -2567,6 +2567,9 @@ _git_stash ()
 		drop,--*)
 			__gitcomp "--quiet"
 			;;
+		list,--*)
+			__gitcomp "--name-status --oneline --patch-with-stat"
+			;;
 		show,--*|branch,--*)
 			;;
 		branch,*)
-- 
2.17.1

