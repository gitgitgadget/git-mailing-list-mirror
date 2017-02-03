Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA961F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 11:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbdBCLCc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Feb 2017 06:02:32 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:39414 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753052AbdBCLC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 06:02:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 39EEF1E384D;
        Fri,  3 Feb 2017 12:02:22 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QVbU_SpgsDzK; Fri,  3 Feb 2017 12:02:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id DE9E21E3844;
        Fri,  3 Feb 2017 12:02:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C3jTAhnAcm0Q; Fri,  3 Feb 2017 12:02:21 +0100 (CET)
Received: from localhost.localdomain (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 871FD1E384D;
        Fri,  3 Feb 2017 12:02:21 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, j6t@kdbg.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v2 5/7] completion: teach replace to complete options
Date:   Fri,  3 Feb 2017 12:01:57 +0100
Message-Id: <20170203110159.377-6-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170203110159.377-1-cornelius.weig@tngtech.com>
References: <20170203110159.377-1-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Git-replace needs to complete references and its own options. In
addition to the existing references completions, do also complete the
options --edit --graft --format= --list --delete.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a355eeb..4841036 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2408,6 +2408,12 @@ _git_remote ()
 
 _git_replace ()
 {
+	case "$cur" in
+	--*)
+		__gitcomp "--edit --graft --format= --list --delete"
+		return
+		;;
+	esac
 	__gitcomp_nl "$(__git_refs)"
 }
 
-- 
2.10.2

