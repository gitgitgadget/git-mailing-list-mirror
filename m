Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EE5200B9
	for <e@80x24.org>; Sat,  5 May 2018 13:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeEENYd (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 09:24:33 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:58323 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeEENYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 09:24:30 -0400
Received: from home.lan ([86.238.54.222])
        by mwinf5d43 with ME
        id idQT1x00Y4nfuyW03dQT2d; Sat, 05 May 2018 15:24:27 +0200
X-ME-Helo: home.lan
X-ME-Date: Sat, 05 May 2018 15:24:27 +0200
X-ME-IP: 86.238.54.222
Received: from yann by home.lan with local (Exim 4.89)
        (envelope-from <ydirson@free.fr>)
        id 1fExAp-0004mG-Je; Sat, 05 May 2018 15:24:27 +0200
From:   Yann Dirson <ydirson@free.fr>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
Subject: [PATCH 2/2] Fix wrong merge-base invocation preventing detection of up-to-date branches.
Date:   Sat,  5 May 2018 15:24:23 +0200
Message-Id: <20180505132423.18324-2-ydirson@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180505132423.18324-1-ydirson@free.fr>
References: <20180505132423.18324-1-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 git-reintegrate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-reintegrate b/git-reintegrate
index da45239..a6e3cff 100755
--- a/git-reintegrate
+++ b/git-reintegrate
@@ -581,7 +581,7 @@ def status_merge(branch_to_merge = nil)
   elsif system(*%w[git merge-base --is-ancestor], branch_to_merge, $status_base)
     state = "+"
     verbose_state = "merged to #{$status_base}"
-  elsif system(*%w[git-merge-base --is-ancestor], branch_to_merge, $branch.name)
+  elsif system(*%w[git merge-base --is-ancestor], branch_to_merge, $branch.name)
     state = "*"
     verbose_state = "up-to-date"
   else
-- 
2.11.0

