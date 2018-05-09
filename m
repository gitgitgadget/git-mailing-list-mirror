Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069281F424
	for <e@80x24.org>; Wed,  9 May 2018 12:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934154AbeEIMfy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 9 May 2018 08:35:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeEIMfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 08:35:53 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MKQMA-1fGwYE124E-001iMK; Wed, 09 May 2018 14:35:48 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 1D6AE64A7C8;
        Wed,  9 May 2018 12:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mTqHPQJ813oR; Wed,  9 May 2018 14:35:29 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 142DE64A8D4;
        Wed,  9 May 2018 14:35:29 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Wed, 9 May 2018 14:35:28 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id BC7F6804D2; Wed,  9 May 2018 14:35:28 +0200 (CEST)
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/2] gitk: show part of submodule log instead of empty pane when listing trees
Date:   Wed, 9 May 2018 14:35:25 +0200
Message-ID: <bf7dfd9a48578d05dd91c0936ed55a88dd7d93d3.1525868167.git.raa.lkml@gmail.com>
X-Mailer: git-send-email 2.17.0.593.g2029711e64
In-Reply-To: <cover.1525868167.git.raa.lkml@gmail.com>
References: <cover.1525868167.git.raa.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="UTF-8"
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180509-0, 09.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:hKFvwIDSElaT321Z5D3lTUvxJd/KuZoqy6ESaC93HeJ5BRjhxlU
 PNYm6DfZl+dZDxV6bWclmCMTGIwmD3i6tsAT0O+ibZ84KAPNUOvAnM2435+6aOT/e0wSoJd
 qJz0qXZ7FucOrqdbe2T3jM9diopW8ZOPezZsPTfoveTFnWuCz/g3rVJIXxU0G6J5NeJtEQZ
 6OKoL518l8g9kC0Z/qNLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WdnwzmDLvGY=:tafLbzbE5vc5OCgxCQvF95
 Dh9AALgJkAZZNx+HnzSS6gLY2InnnXiYOwMjZSreDLiSRkYQvM7X5+WzxgEV1/MxqMQ3wYGde
 ZehscvAa+gFRwf21BylGPvCfj9U2VI6IB9uvSKcctZhNS1SfzzEe0oShiPADZpdItqtd2f0aP
 S+9AbdnqQ3VWE0JqD1nnVD6x/jkbmOLpdBepmKVX7RrshG8AOtXJ7EixC92IRhfIIh8jYjidR
 Gbb/LgVRplzPwD/N3Uy/poCU0BylDmgyv7uAAibEiIHAh+/Rz/cPUQFNtgJ58XdFLAVhE/lAe
 PlZ4Aw39/5HuEJFtmuE1NhWGshP6cda7APlBNSMSL+6HEe7b4fGhjzNnOuNs8jqNIB5ydsTsY
 5M+B7Ac4wP1ae7qGAjO63M0+fk6kDSHh3rycpAD9edS4QvZJxf7eZYbHdTxrz99xGwELhyG/G
 zZ5pnd9K3xdNQRDk67GLbhFS0Sr+2wuXcCXwoXoj2AxMKBlDVedVDJm1DBGKKXwb/DUpzG3Fw
 ZvPY1xKXU2AmppvrSHOxsiWIMwnG5WEgUSwKe3yJ3lJddZRZAY/0jaQhTIc7ONVB+BA99vBXQ
 yWYMKTBu37n+ZTCquXQ/vGoovn4Iy2wIDDdHPEI70pgjBayPlURx1XkRoD60MqdDdFtTMAUnp
 nc8lxl4UWL/iA6OUqB2W2+pKvHOh9VbSgnztMqJz6MUxgvAFVtp2M6Oy7XECl98Kt5OfY3jMK
 z4TND04fe7r9jDY/
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

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
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

