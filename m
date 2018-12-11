Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A3220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 00:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeLKAir (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 19:38:47 -0500
Received: from igloo.infernal-iceberg.com ([78.47.19.187]:42970 "EHLO
        igloo.infernal-iceberg.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726693AbeLKAiq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Dec 2018 19:38:46 -0500
X-Greylist: delayed 1457 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 19:38:46 EST
Received: from localhost ([127.0.0.1] helo=fortress.battleship)
        by igloo.infernal-iceberg.com with esmtp (Exim 4.89)
        (envelope-from <gsromero@infernal-iceberg.com>)
        id 1gWVgy-00087s-1l; Tue, 11 Dec 2018 01:14:28 +0100
Received: from unnamed by fortress.battleship with local (Exim 4.91)
        (envelope-from <gsromero@infernal-iceberg.com>)
        id 1gWVgx-0008Qy-Mw; Tue, 11 Dec 2018 01:14:27 +0100
Date:   Tue, 11 Dec 2018 01:14:27 +0100
From:   "Guillermo S. Romero" <gsromero@infernal-iceberg.com>
To:     git@vger.kernel.org
Cc:     paulus@samba.org
Subject: [PATCH] gitk: Use themable foundbgcolor also in headlines and authors
Message-ID: <20181211001427.GA10426@fortress.battleship>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Guillermo S. Romero <gsromero@infernal-iceberg.com>
---

Hi:

This removes the hardcoded color and uses the user config (still
yellow by default) so searches share a common look.

GSR
 

PS: Not subscribed to git@vger, so remember to CC: me.


 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..8837e46 100755
--- a/gitk
+++ b/gitk
@@ -6952,7 +6952,7 @@ proc findselectline {l} {
 
 # mark the bits of a headline or author that match a find string
 proc markmatches {canv l str tag matches font row} {
-    global selectedline
+    global selectedline foundbgcolor
 
     set bbox [$canv bbox $tag]
     set x0 [lindex $bbox 0]
@@ -6966,7 +6966,7 @@ proc markmatches {canv l str tag matches font row} {
 	set xlen [font measure $font [string range $str 0 [expr {$end}]]]
 	set t [$canv create rect [expr {$x0+$xoff}] $y0 \
 		   [expr {$x0+$xlen+2}] $y1 \
-		   -outline {} -tags [list match$l matches] -fill yellow]
+		   -outline {} -tags [list match$l matches] -fill $foundbgcolor]
 	$canv lower $t
 	if {$row == $selectedline} {
 	    $canv raise $t secsel
-- 
2.20.0.rc2

