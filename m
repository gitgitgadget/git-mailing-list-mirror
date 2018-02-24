Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A39E1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBXStc (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 13:49:32 -0500
Received: from s019.cyon.net ([149.126.4.28]:50148 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeBXStb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 13:49:31 -0500
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Feb 2018 13:49:31 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=69ij7RvXV4/rLBgzRJntHVmb+7LXLtDYxTUxHV1k35M=; b=f5PW6aRltCxTlDD5hFs6wjf2AR
        a4WG2xBH8edR6dqnVwKU4kS0Q4gdgsJSZmOUnxsSLVaTNjyQhF4EuC2QDV2o7ieQvgWSCzo1aXQAf
        zjjUnaor7PfApwRvialZFKV3lWQD+CL/Fagawg7gSXVztadMdWsar9Vavrlo+JCYfoynz9sLfUgoR
        n/Rk42nt9IhOzigWv4WoXeqtGcRO76qRwvZY0Im5m+/mBIWvPuT/u84rrNtyiDv/NmoUq27RPB411
        YNAPptycN9rMMFE219nwoZLB7enI+jgWTvgPgrt+foc2azFhRwE0WWiFToIumlIjoIrI9B/RXiZip
        HbQ4fGug==;
Received: from [10.20.10.233] (port=58556 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.89)
        (envelope-from <bb@drbeat.li>)
        id 1epek1-0006OO-U6; Sat, 24 Feb 2018 19:40:16 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 6DDC12021C; Sat, 24 Feb 2018 19:40:13 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     juergen.fechter@atos.net
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        Alexander Gavrilov <angavrilov@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: search for all current SSH key types
Date:   Sat, 24 Feb 2018 19:39:13 +0100
Message-Id: <20180224183913.8345-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
In-Reply-To: <F65780F29E48994380E2BCE87C6F071101146AB1@DEERLM99EX2MSX.ww931.my-it-solutions.net>
References: <F65780F29E48994380E2BCE87C6F071101146AB1@DEERLM99EX2MSX.ww931.my-it-solutions.net>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenSSH has supported Ed25519 keys since version 6.4 (2014-01-30), and
ECDSA keys since version 5.7 (2011-01-24). git-gui fails to find these
key types in its Help/Show SSH Key dialog.

Teach git-gui to show Ed25519 and ECDSA keys as well.

This was originally reported in
https://github.com/git-for-windows/git/issues/1487 and subseqently in
https://public-inbox.org/git/F65780F29E48994380E2BCE87C6F071101146AB1@DEERLM99EX2MSX.ww931.my-it-solutions.net/

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
Cc: Alexander Gavrilov <angavrilov@gmail.com>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>

 git-gui/lib/sshkey.tcl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-gui/lib/sshkey.tcl b/git-gui/lib/sshkey.tcl
index aa6457bbb..589ff8f78 100644
--- a/git-gui/lib/sshkey.tcl
+++ b/git-gui/lib/sshkey.tcl
@@ -2,7 +2,10 @@
 # Copyright (C) 2006, 2007 Shawn Pearce
 
 proc find_ssh_key {} {
-	foreach name {~/.ssh/id_dsa.pub ~/.ssh/id_rsa.pub ~/.ssh/identity.pub} {
+	foreach name {
+		~/.ssh/id_dsa.pub ~/.ssh/id_ecdsa.pub ~/.ssh/id_ed25519.pub
+		~/.ssh/id_rsa.pub ~/.ssh/identity.pub
+	} {
 		if {[file exists $name]} {
 			set fh    [open $name r]
 			set cont  [read $fh]
-- 
2.15.0.rc1.299.gda03b47c3

