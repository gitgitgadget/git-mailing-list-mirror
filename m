Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13BA200B9
	for <e@80x24.org>; Tue,  8 May 2018 12:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeEHMWy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 8 May 2018 08:22:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEHMWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 08:22:53 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MKuxg-1fG1do3SNM-0001Is; Tue, 08 May 2018 14:22:48 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id BFB4964AA6C;
        Tue,  8 May 2018 12:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZT86aBYe-wCj; Tue,  8 May 2018 14:22:29 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id DF8AA64A854;
        Tue,  8 May 2018 14:22:29 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Tue, 8 May 2018 14:22:29 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 0F3F5804D2; Tue,  8 May 2018 14:22:29 +0200 (CEST)
Date:   Tue, 8 May 2018 14:22:29 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Paul Mackerras <paulus@ozlabs.org>
CC:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] gitk: show part of submodule log instead of empty pane
 when listing trees
Message-ID: <20180508122229.k3n3ccpa5g3g4dxa@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20180508121104.rtsrektxiihvpqtx@pflmari>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180508-2, 08.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:WkwxiUXPtYFlPBBUY6LvTWmKRY8J8N2vwa6dQLB6acQECNWpRuP
 DsW8080Ylct4Ifnin9JLolPqx43vYS8OAgaEMmytvf6/Ya+XzMEqndp+QilbpBSAdr3GRQb
 nOnB+4QHfe/6m5o7yueR3hAWj8rvwBGTvBAR271xCCVKG+GDk+EttL/s5UXtEehNS/k8/9/
 G9Jr3bldzJV/1PtGK98cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SHcfkBm0MB4=:KkgPlasfhBkVe9AiK8sy5W
 C7K7eIjoUFdVoZla3dXtRKZJEGSZsgOYStkG3QiJMHDPeIyHgcaQZdoKRQG3h4njPOlEMYhi7
 qGdrJuf7I5vpci9BTAnPBwTd3C10xLS01BV/eSztwQOqOZ5lMvyzfGJNWJkr2m/Te3lpvYi9G
 TIzOA+q6ZVaEnriLFV8gOG7SA9bBBjVek4T8IE8py2L1Movwqf7xMQwZDknd7pIh4jqnr/lMf
 g6m+tzqQzcPiNufk6OosuEZ5/w1h1mBf3CW4Tq43Nn8QXlZZeb4JyM7AbzC3YbGOs+89ufQaJ
 pRacAjpEecFCS8TU5DM2Cy9Qnpqa9nhJMhKteGEfJjV4YWoF1wUxApWE8Dxbx1GiDlgWmx2BD
 1VMLh44A7t0DZdEllfsjrxdwyuWzHMPrsQ7sOYT6p9vib3jU1TnXgE/lkpI2/U9rHhQ5X0pzh
 qoSp1xmvBEW2FHlMru1zyFUoisA7Eu9wGAvQamb0v5alCU0p1CzY4jWlNTDPaIpQu6su59BBa
 C1VClnED/i4Ze0LGpKW3xl5jXU/A7KLGesT5fM9laDUaAAt0ehH7K1qnba5y26g50avBHQFPQ
 XEQ/ESMvgUysaZcW31IhGKDy5wK7f3tH+iVKgP8aPeH3hw+MJawH9SZF85w925eEeNNnWj4lO
 O29X5vNn/hJ+Id/J60zonwgHOklGWV1mNK5JwLW4l72IV3xTSW9hMRrFM4SMdYTRPa9k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

Currently, the submodules either are not shown at all (if listing a
committed tree) or a Tcl error appears (when clicking on a submodule
from the index list).

This will make it show first arbitrarily chosen number of commits,
which might be only marginally better.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 gitk | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..d34833f 100755
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
@@ -7659,21 +7660,42 @@ proc showfile {f} {
     global ctext_file_names ctext_file_lines
     global ctext commentend
 
+    set submodlog "git\\ log\\ --format='%h\\ %aN:\\ %s'\\ -100"
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
+	    if {[catch {set bf [open "| sh -c cd\\ \"$f\"&&$submodlog" r]} err]} {
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
+	    if {[catch {set bf [open "| sh -c cd\\ \"$f\"&&$submodlog\\ $blob" r]} err]} {
+		puts "oops, error reading submodule commit: $err"
+		return
+	    }
+	    set fcmt "/"
 	}
     }
     fconfigure $bf -blocking 0 -encoding [get_path_encoding $f]
@@ -7683,7 +7705,7 @@ proc showfile {f} {
     lappend ctext_file_names $f
     lappend ctext_file_lines [lindex [split $commentend "."] 0]
     $ctext insert end "\n"
-    $ctext insert end "$f\n" filesep
+    $ctext insert end "$f$fcmt\n" filesep
     $ctext config -state disabled
     $ctext yview $commentend
     settabs 0
-- 
2.17.0.rc1.56.gb9824190bd


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

