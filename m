Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14121F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbeAIOdC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:33:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:51462 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755932AbeAIOdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:33:01 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPSg-1f5Dlf2GQY-00hi0c; Tue, 09
 Jan 2018 15:32:57 +0100
Date:   Tue, 9 Jan 2018 15:32:58 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] git-gui: avoid exception upon Ctrl+T in an empty list
In-Reply-To: <cover.1515508360.git.johannes.schindelin@gmx.de>
Message-ID: <7cd5ed902e3d8102903d494ba3450b1d745928a9.1515508360.git.johannes.schindelin@gmx.de>
References: <cover.1515508360.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Fm8mMVJA8b/3ibIBuGAAAMMV2z8fJu+UliEfEFVDzkN+ZYctsVJ
 iIARpCnuSRBUbztpxtPNMSD2iVmChQ0m0zePsCM3SkWdz4A6t3f0U1o5z6TlB/GVbFKqJXA
 ghNViQfH3fglHtfzGaRIaN5Bmgm1KeU7EmrI4baSQ+CFOHEzt6z1LWdDYqPHQ+72ODQKfFJ
 0OB6YDm5EJ0bHaUkddwsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uMFWVcH9gqU=:wjOxtIoGzMKIuPFyLIVBRR
 o8waEUPB1PDAhyqg9ZJaYyvH7FJnU3UvK6uPMb6NDi6o6pdjSkqmGadgnNoSTALP63U1ydv9V
 6IH87bLQf4ouVDojtKvlrE7FWtnG7Dunv4owSNemxPQusfJdKLBtcVJY2gNQDAOv+imLh18AK
 f8A8vqyjrzPOe5VVO7TVDdie2lMOHdIeN1o35FF1+dlZHrvvdZdrGVpfT8w2rCm8+6604LZtx
 qzIwvSShL/+KMn7/3zYm7ca5RkWiubeT3Ibfk1zcljC2WHNMAL923etyJjnvL6a+Xo+E2XGPS
 oUcQM8OlKsAhU9Gfn7Nm1uERZBVw0QbnOfI5EhcKFXBeA2/BbU5xW5f9NgP1WuIZlVDs1GteB
 jHlJEusg7XpMbF3OunIggH8B0P8waZWAXbhjCFqx1TOgHh7Vvo+KBVJgbUFG3XHc/4oYQ/IJQ
 G/KVDXvoBDhJTHDqnsx/BLke7IVTcbGOTF5p/LUofkSNlE81XbMXmd92paB0tZrPf0TPCVZuf
 W0c4+OMcz7x/zpWqqhNROscqjfyq0oRoLmSOldqSUoCiMAdxwvHgpYimu5wkGo/55eZi+jnTN
 X5kbdN1NjA2FQ2bCx49L1S0ztIXf+MwGCY+4MaplTSHsAWOakpWdUh0k0Z9vb62If//xHJS99
 fGluQx9bSSMc+b/XbbUrqxrzFHlKrAzCdSMRg5fuHupyy9K/p+DcYiNgwMoEFkpNNcgiavil4
 lBStVjqwizWAGEzST4nIG7CiS03MS4pTQWP3ov37iAUf+9Pk1I+AQ8Oukqwi+CB/0a0dzpCa8
 wdx+rfiVKhon4fUEFZS62vx/Iy/ay4o+WSMrhaBlnPHb6tsBzl6bR4OmsxKjV7Sv0OIN0bK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously unstaged files can be staged by clicking on them and then
pressing Ctrl+T. Conveniently, the next unstaged file is selected
automatically so that the unstaged files can be staged by repeatedly
pressing Ctrl+T.

When a user hits Ctrl+T one time too many, though, Git GUI used to throw
this exception:

	expected number but got ""
	expected number but got ""
	    while executing
	"expr {int([lindex [$w tag ranges in_diff] 0])}"
	    (procedure "toggle_or_diff" line 13)
	    invoked from within
	"toggle_or_diff toggle .vpane.files.workdir.list "
	    (command bound to event)

Let's just avoid that by skipping the operation when there are no more
files to stage.

This fixes https://github.com/git-for-windows/git/issues/1060

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui/git-gui.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ed24aa9d2f1..3c085cddc61 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2504,6 +2504,10 @@ proc toggle_or_diff {mode w args} {
 		if {$last_clicked ne {}} {
 			set lno [lindex $last_clicked 1]
 		} else {
+			if {[llength $file_lists($w)] == 0} {
+				set last_clicked {}
+				return
+			}
 			set lno [expr {int([lindex [$w tag ranges in_diff] 0])}]
 		}
 		if {$mode eq "toggle"} {
-- 
2.15.1.windows.2.395.g5bb0817ee52


