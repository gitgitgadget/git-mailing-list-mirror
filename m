Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE12D209A9
	for <e@80x24.org>; Fri, 14 Oct 2016 00:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbcJNAsX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 20:48:23 -0400
Received: from know-smtprelay-omc-10.server.virginmedia.net ([80.0.253.74]:52619
        "EHLO know-smtprelay-omc-10.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753942AbcJNAsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 20:48:22 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-10-imp with bizsmtp
        id vCml1t00B4fw4HN01CmlXp; Fri, 14 Oct 2016 01:46:45 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=Ha/pNXw8 c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=CH0kA5CcgfcA:10
 a=ZZnuYtJkoWoA:10 a=zl2uJyVoAAAA:8 a=Rf460ibiAAAA:8 a=WoIh_kDzt6LkAJalV2gA:9
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=E0KdIPxdrRkKdVweLlsj:22
 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id F33D41962B25;
        Fri, 14 Oct 2016 01:46:44 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     git@vger.kernel.org
Subject: Re: [GIT GUI l18n 1/2] git-gui: Mark 'All' in remote.tcl for translation
References: <20161013184349.42950-1-ash@kambanaria.org>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Fri, 14 Oct 2016 01:46:44 +0100
In-Reply-To: <20161013184349.42950-1-ash@kambanaria.org> (Alexander Shopov's
        message of "Thu, 13 Oct 2016 21:43:48 +0300")
Message-ID: <87a8e73ggb.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Shopov <ash@kambanaria.org> writes:

>Signed-off-by: Alexander Shopov <ash@kambanaria.org>
>---
> lib/remote.tcl | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/lib/remote.tcl b/lib/remote.tcl
>index 4e5c784..26af8ae 100644
>--- a/lib/remote.tcl
>+++ b/lib/remote.tcl
>@@ -250,12 +250,12 @@ proc update_all_remotes_menu_entry {} {
> 
> 			$fetch_m insert end separator
> 			$fetch_m insert end command \
>-				-label "All" \
>+			    -label [mc "All"] \
> 				-command fetch_from_all
> 
> 			$prune_m insert end separator
> 			$prune_m insert end command \
>-				-label "All" \
>+			    -label [mc "All" ]\
> 				-command prune_from_all
> 		}
> 	} else {

OK - this looks fine except the line just above compares the text of
this entry so also needs [mc] adding. I've applied it as:

-- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -246,22 +246,22 @@ proc update_all_remotes_menu_entry {} {
        if {$have_remote > 1} {
                make_sure_remote_submenues_exist $remote_m
                if {[$fetch_m type end] eq "command" \
-                       && [$fetch_m entrycget end -label] ne "All"} {
+                               && [$fetch_m entrycget end -label] ne [mc "All"]} {
 
                        $fetch_m insert end separator
                        $fetch_m insert end command \
-                               -label "All" \
+                               -label [mc "All"] \
                                -command fetch_from_all
 
                        $prune_m insert end separator
                        $prune_m insert end command \
-                               -label "All" \
+                               -label [mc "All"] \
                                -command prune_from_all
                }
        } else {
                if {[winfo exists $fetch_m]} {
                        if {[$fetch_m type end] eq "command" \
-                               && [$fetch_m entrycget end -label] eq "All"} {
+                                       && [$fetch_m entrycget end -label] eq [mc "All"]} {
 
                                delete_from_menu $fetch_m end
                                delete_from_menu $fetch_m end


-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
