Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA50E1F407
	for <e@80x24.org>; Mon, 11 Dec 2017 01:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbdLKBNq (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 20:13:46 -0500
Received: from smtp-out12.tpgi.com.au ([220.244.226.122]:52628 "EHLO
        mail12.tpgi.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751420AbdLKBNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 20:13:46 -0500
X-Greylist: delayed 727 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Dec 2017 20:13:45 EST
X-TPG-Junk-Status: Message not scanned
X-TPG-Antivirus: Passed
X-TPG-Abuse: host=60-242-171-118.static.tpgi.com.au; ip=60.242.171.118; date=Mon, 11 Dec 2017 11:49:52 +1100
Received: from gw.urbanec.net (60-242-171-118.static.tpgi.com.au [60.242.171.118])
        by mail12.tpgi.com.au (envelope-from git.user@urbanec.net) (8.14.3/8.14.3) with ESMTP id vBB0nojC019153
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Dec 2017 11:49:52 +1100
Received: from beep.urbanec.net ([192.168.42.2])
        by gw.urbanec.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <git.user@urbanec.net>)
        id 1eOCI2-0004mr-A5; Mon, 11 Dec 2017 11:49:50 +1100
From:   Peter Urbanec <git.user@urbanec.net>
To:     git@vger.kernel.org
Cc:     patthoyts@users.sourceforge.net,
        Peter Urbanec <git.user@urbanec.net>
Subject: [PATCH] git-gui: Make push remote combobox full width
Date:   Mon, 11 Dec 2017 11:48:48 +1100
Message-Id: <20171211004848.13048-1-git.user@urbanec.net>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pushing changes, the Remote combobox for the Destination Repository
does not take all available space in the layout. With long remote names,
this causes the combobox to have truncated entries even though there is
room to display them.

Anchor the remote_m combobox to both left and right edges of the grid
cell and use the same padding as url_t for a consistent, dynamic layout.


Signed-off-by: Peter Urbanec <git.user@urbanec.net>
---
 lib/transport.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/transport.tcl b/lib/transport.tcl
index a1a424a..1046dc5 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -173,7 +173,7 @@ proc do_push_anywhere {} {
 		} else {
 			eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
 		}
-		grid $w.dest.remote_r $w.dest.remote_m -sticky w
+		grid $w.dest.remote_r $w.dest.remote_m -sticky we -padx {0 5}
 		if {[lsearch -sorted -exact $all_remotes origin] != -1} {
 			set push_remote origin
 		} else {
-- 
2.15.1

