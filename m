Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C854C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B8920671
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgEQCYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 22:24:19 -0400
Received: from smtp-1.his.com ([216.194.195.13]:45450 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgEQCYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 22:24:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id DD4D7609C8
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:15:34 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WKAk-dGNHwa8 for <git@vger.kernel.org>;
        Sat, 16 May 2020 22:15:31 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 51C82609A4
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:15:31 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id B859A6042B
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:15:30 -0400 (EDT)
X-ASG-Debug-ID: 1589681730-061c41045c25ba20001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id ESy6uUUwAEntnwzE for <git@vger.kernel.org>; Sat, 16 May 2020 22:15:30 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 4FF5960229
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:15:30 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 1B196177E99;
        Sat, 16 May 2020 22:15:30 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id siGhG4e8vy-1; Sat, 16 May 2020 22:15:30 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 033E3177E8B;
        Sat, 16 May 2020 22:15:30 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eoq_dUoN8RwQ; Sat, 16 May 2020 22:15:29 -0400 (EDT)
Received: from kenilap.lorber.home (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id D9F26177E99;
        Sat, 16 May 2020 22:15:29 -0400 (EDT)
Received: (from keni@localhost)
        by kenilap.lorber.home (8.14.5/8.14.1) id 04H2FSVh037020;
        Sat, 16 May 2020 22:15:28 -0400 (EDT)
From:   Kenneth Lorber <keni@hers.com>
To:     git@vger.kernel.org
Cc:     keni@hers.com
Subject: [RFC PATCH 1/6] Tell the glossary about core.hooksPath
Date:   Sat, 16 May 2020 22:13:39 -0400
X-ASG-Orig-Subj: [RFC PATCH 1/6] Tell the glossary about core.hooksPath
Message-Id: <1589681624-36969-2-git-send-email-keni@hers.com>
X-Mailer: git-send-email 2.7.1.287.g4943984.dirty
In-Reply-To: <1589681624-36969-1-git-send-email-keni@hers.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589681730
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 1529
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81903
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kenneth Lorber <keni@his.com>

The user manual glossary entry for hooks now knows about core.hooksPath.

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 Documentation/glossary-content.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 090c888335..37147db1bc 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -206,10 +206,12 @@ for a more flexible and robust system to do the same thing.
 	to optional scripts that allow a developer to add functionality or
 	checking. Typically, the hooks allow for a command to be pre-verified
 	and potentially aborted, and allow for a post-notification after the
-	operation is done. The hook scripts are found in the
-	`$GIT_DIR/hooks/` directory, and are enabled by simply
-	removing the `.sample` suffix from the filename. In earlier versions
-	of Git you had to make them executable.
+	operation is done. The hook scripts are found in `$GIT_DIR/hooks/`
+	or in any directory specified by the `core.hooksPath` configuration
+	variable.  The sample scripts are enabled by simply
+	removing the `.sample` suffix from the filename.  In earlier versions
+	of Git you had to make the sample scripts executable manually.
+	Hook scripts must be executable.  See linkgit:githooks[5] for details.
 
 [[def_index]]index::
 	A collection of files with stat information, whose contents are stored
-- 
2.17.1

