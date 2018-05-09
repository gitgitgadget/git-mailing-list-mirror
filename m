Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1BF1F42D
	for <e@80x24.org>; Wed,  9 May 2018 11:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933949AbeEILBL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 07:01:11 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeEILBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 07:01:10 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MRUkK-1es8uu3VKi-00SgFv; Wed, 09 May 2018 13:01:04 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 5453A64A6CB;
        Wed,  9 May 2018 11:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ESchQwZzjFGY; Wed,  9 May 2018 13:00:44 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 64B48648D24;
        Wed,  9 May 2018 13:00:44 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 13:00:44 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 1CBEB804D2; Wed,  9 May 2018 13:00:44 +0200 (CEST)
Date:   Wed, 9 May 2018 13:00:44 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/2] gitk: show part of submodule log instead of empty
 pane when listing trees
Message-ID: <20180509110044.jnuzyz7ya4ehersr@pflmari>
References: <cover.1525862998.git.raa.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cover.1525862998.git.raa.lkml@gmail.com>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:h9F6JNDpIfSm1DNJDL7Rg6pCJXjzp1RpUs1JCt7Uzdt6K51sYeY
 xWQQIjt/zrB9SQDNHXShY+R4+0Tu1VGS3cmyNtfTsVPRpKCFoSOSyRgWZbx+958LZISYxIC
 DpWZRnKp4pkkhD4Ct09CJMcWiC3pzc76bo4RNN3J8PonI2828UZhjjVOXdnIrI5ManlD1zf
 3BhuKwrRMbgd4fGimWOPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8+eHK/0Cizk=:lYX8bE5cxReDEjtbwAi6g6
 Lt67/7DF8b8Y/bSKq7mp0IxaF9gN14FT27gzq5RpaC54Yhd7hXUgL1er38fIpGHqqYdpTRJN9
 gtKAGSrwUfyydFRn34LSQrMzhkZOXNCijajrWVvB2AV6Ze4oLEtRGoX3yukajPK5xn+Hj4CaH
 g0DI66QRew3z1WhkdFeqzym1wipc8j1jkGnRJ0rNrHLSTxwmy3K7sjh0kkCn0qgbm9+ZU/3Fs
 80AdlkPADX2t5wNbIEB5X+Eje/ReHMKOLfpurf+e8xouxqSDBBFRb5vB5f+RFHGnUIMOv3BUN
 JSe8rl/sdmp/noGs5B2wo+JCaAIjWVtWNJCJPwlpr954v09t0+PEWOZAnho5c3jrxtyoLJj7G
 +Lkogu27rthvRj/oj22V6po3+H2DmjQET8oM0INLY7/DpG5iduxrd0rjYhN1OOwTLqcDTlebU
 Ur5e0U/95vPsEerKQljOxa3IMp6oC9EqGykhwCX/mnFUTir4nR6ta21ZFcsjK9pAgmnKiLpzL
 wIw7rwfytu/G4rJJsyip96sml8alyzSm9RokG5dolN2El8fTjAcN11COrk8/DocY4DNY4mEpV
 9dh9cCGWez8uUoyRfwoqhUoEz/tuV5el5XAp67oqJ6gYNEGLXCGTTLTUxNTIGAqf1hjuMiKvm
 fhzS7MinkV1oDUxrkqxEcYAaFkK9qGIIqw//0/EC7iVcN8ufQzDeqVU7U1w5CT79YIvM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

Currently, selecting a name in the file list (bottom right) panel in
"Tree" mode does not do anything useful if the name is a submodule.
If gitk is currently showing a commit, the submodule names are not shown
at all (which is very confusing). If the gitk is showing the uncached
change, the submodules are shown, but focusing a submodule name causes a
Tcl error to appear. And finally, if gitk shows the index, the submodule
is presented as its bare name in the diff/file contents panel.

This change will show the first arbitrarily chosen number of commits.
---
 gitk | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..742f36b 100755
--- a/gitk
+++ b/gitk
@@ -7627,9 +7627,10 @@ proc gettreeline {gtf id} {
 	    if {$i < 0} continue
 	    set fname [string range $line [expr {$i+1}] end]
 	    set line [string range $line 0 [expr {$i-1}]]
-	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
+	    set objtype [lindex $line 1]
+	    if {$diffids ne $nullid2 && $objtype ne "blob" && $objtype ne "commit" } { continue }
 	    set sha1 [lindex $line 2]
-	    lappend treeidlist($id) $sha1
+	    lappend treeidlist($id) "$sha1 $objtype"
 	}
 	if {[string index $fname 0] eq "\""} {
 	    set fname [lindex $fname 0]
@@ -7659,21 +7660,44 @@ proc showfile {f} {
     global ctext_file_names ctext_file_lines
     global ctext commentend
 
+    set submodlog "log --format=%h\\ %aN:\\ %s -100"
+    set fcmt ""
     set i [lsearch -exact $treefilelist($diffids) $f]
     if {$i < 0} {
 	puts "oops, $f not in list for id $diffids"
 	return
     }
     if {$diffids eq $nullid} {
-	if {[catch {set bf [open $f r]} err]} {
-	    puts "oops, can't read $f: $err"
-	    return
+	if {[file isdirectory $f]} {
+	    # a submodule
+	    set qf [shellquote $f]
+	    if {[catch {set bf [open "| git -C $qf $submodlog" r]} err]} {
+		puts "oops, can't read submodule $f: $err"
+		return
+	    }
+        } else {
+	    if {[catch {set bf [open $f r]} err]} {
+		puts "oops, can't read $f: $err"
+		return
+	    }
 	}
     } else {
-	set blob [lindex $treeidlist($diffids) $i]
-	if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
-	    puts "oops, error reading blob $blob: $err"
-	    return
+	set bo [lindex $treeidlist($diffids) $i]
+	set blob [lindex $bo 0]
+	set objtype [lindex $bo 1]
+	if { "$objtype" eq "blob" } {
+	    if {[catch {set bf [open [concat | git cat-file blob $blob] r]} err]} {
+		puts "oops, error reading blob $blob: $err"
+		return
+	    }
+	} else {
+	    # also a submodule
+	    set qf [shellquote $f]
+	    if {[catch {set bf [open "| git -C $qf $submodlog $blob" r]} err]} {
+		puts "oops, error reading submodule commit: $err"
+		return
+	    }
+	    set fcmt "/"
 	}
     }
     fconfigure $bf -blocking 0 -encoding [get_path_encoding $f]
@@ -7683,7 +7707,7 @@ proc showfile {f} {
     lappend ctext_file_names $f
     lappend ctext_file_lines [lindex [split $commentend "."] 0]
     $ctext insert end "\n"
-    $ctext insert end "$f\n" filesep
+    $ctext insert end "$f$fcmt\n" filesep
     $ctext config -state disabled
     $ctext yview $commentend
     settabs 0
-- 
2.17.0.593.g2029711e64


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

