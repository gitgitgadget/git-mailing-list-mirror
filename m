Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7511FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 11:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755292AbcLOL24 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:28:56 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34867 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcLOL2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:28:55 -0500
Received: by mail-pg0-f66.google.com with SMTP id p66so5958168pga.2
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/aYoFKYMwcR7g0/IBxoQOOTOT5Yl5aK4ZpcHboJ9Pb0=;
        b=tMmqMTx7OPuX9vdVwkXF83YqcVLK0+An8mCOSjNmt1AffRAjMkH7Q+h7BZK+xa8GcD
         2cX0IJOJcEEoFWlqMNWyWe9nBXfKCA1hxNWNpwvxi4CQufQtDbxdVRKaJ5ro64kiXxhv
         bi4b9oVAhn6p/8RFFXzB/VlMqsztMZK5Ufwc+8mAs0IofphoEeoMmAPCt/J8RmVVBSJv
         ScLY/4vV+GFspZkf06KxbHZcGST2QSjlWoHmjf8CFjfwhmsOgWFl5nImx9KW6/W2KgAk
         veKMSrI9pOo39SSWVHe3sdzbWtVRqGpNcQww0ExOPGpa2Ev8CW/MeO9+/smSAqwNrU7E
         mgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/aYoFKYMwcR7g0/IBxoQOOTOT5Yl5aK4ZpcHboJ9Pb0=;
        b=DitD0Ibjx4m5PwlGvUk5STGxEbhaGJaZVZW0ns4wp7z/u5Zz4RD32xn3url+ff4Abr
         vTZyfzDwGqo0DwjqexrzE9ge5oqU/JKbzld+i3OViDPq1N3uf0Bw1aQ0cdmxDWhS+eJC
         s5YvrvYHST3VThiYqwi4cjmjfWg10ZpbBnnL1xdV4NKdLAlDHxBb6k3e4UTRutI7oaYc
         p63GaEs7bGrprLMg5oEUiwcF7cFoKOv2k3kqqT+vGNtFkwZ/JfSDnFksCrcvOPhcix3L
         6xUNiTq46GJzdxuO6wKR6fDIcr8arQSmPk4KVENwGVeKs0pKwLVdSoKN82swglTplCsx
         TCqA==
X-Gm-Message-State: AKaTC03WYHAgVlIVhQW1q1KtX91Q0h9tO9XmUyJl3z0mCaT2K1ySmtXGqkpDrdNOzUwKkw==
X-Received: by 10.99.149.22 with SMTP id p22mr1363818pgd.21.1481801334488;
        Thu, 15 Dec 2016 03:28:54 -0800 (PST)
Received: from kpdpro.suho.local ([118.211.97.195])
        by smtp.gmail.com with ESMTPSA id 189sm3930190pgh.5.2016.12.15.03.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 03:28:53 -0800 (PST)
From:   Pierre Dumuid <pmdumuid@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Pierre Dumuid <pmdumuid@gmail.com>
Subject: [PATCH 1/6] Enable ability to visualise the results of git cherry C1 C2
Date:   Thu, 15 Dec 2016 21:58:42 +1030
Message-Id: <20161215112847.14719-1-pmdumuid@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a bit clunky but it works!!

Usage:
 - mark commit one (e.g. v45)
 - Select commit two.
 - Switch the gdttype to the option, "git-cherry between marked commit and:"

Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
---
 gitk | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..50d1ef4 100755
--- a/gitk
+++ b/gitk
@@ -2319,7 +2319,9 @@ proc makewindow {} {
 		[mc "containing:"] \
 		[mc "touching paths:"] \
 		[mc "adding/removing string:"] \
-		[mc "changing lines matching:"]]
+		[mc "changing lines matching:"] \
+		[mc "git-cherry between marked commit and:"] \
+	       ]
     trace add variable gdttype write gdttype_change
     pack .tf.lbar.gdttype -side left -fill y
 
@@ -4707,6 +4709,18 @@ proc gdttype_change {name ix op} {
     global gdttype highlight_files findstring findpattern
 
     stopfinding
+
+    if {$gdttype eq [mc "git-cherry between marked commit and:"]} {
+	if {$highlight_files ne {}} {
+	    set highlight_files {}
+	    hfiles_change
+	}
+	findcom_change
+	update_gitcherrylist
+	drawvisible
+	return
+    }
+
     if {$findstring ne {}} {
 	if {$gdttype eq [mc "containing:"]} {
 	    if {$highlight_files ne {}} {
@@ -4733,6 +4747,9 @@ proc find_change {name ix op} {
     stopfinding
     if {$gdttype eq [mc "containing:"]} {
 	findcom_change
+    } elseif {$gdttype eq [mc "git-cherry between marked commit and:"]} {
+	findcom_change
+	update_gitcherrylist
     } else {
 	if {$highlight_files ne $findstring} {
 	    set highlight_files $findstring
@@ -4742,6 +4759,54 @@ proc find_change {name ix op} {
     drawvisible
 }
 
+proc update_gitcherrylist {} {
+    global gitcherryids
+    global markedid
+    global findstring
+    global fstring
+    global currentid
+    global iddrawn
+
+    unset -nocomplain gitcherryids
+    set fs $findstring
+
+    if {$findstring eq {}} {
+	$fstring delete 0 end
+	$fstring insert 0 $currentid
+    }
+
+    if {![info exists markedid]} {
+	error_popup [mc "Please mark a git commit before using this find method!"]
+	return
+    }
+
+    #puts [join [list "Running cherry between: `" $markedid "` and `" $findstring "`"] ""]
+
+    if {[catch {set cherryOutput [exec git cherry $markedid $findstring]}]} {
+	puts "ERROR: An error occured running git-cherry!"
+	return
+    }
+
+    set cherryLines [split $cherryOutput "\n"]
+    foreach cherryLine $cherryLines {
+	set op [lindex [split $cherryLine " "] 0]
+	set gitSha [lindex [split $cherryLine " "] 1]
+
+	#puts [join [list "line is: `" $cherryLine "`, op:`" $op "`, gitSha:`" $gitSha "`"] ""]
+	if {$op eq "+"} {
+	    set gitcherryids($gitSha) 1
+	    if ([info exists iddrawn($gitSha)]) {
+		bolden $gitSha mainfontbold
+	    }
+
+	}
+    }
+    # puts "list is as follows"
+    #foreach {gitsha setBold} [array get gitcherryids] {
+    # 	puts [concat $gitsha = $setBold]
+    #}
+}
+
 proc findcom_change args {
     global nhighlights boldnameids
     global findpattern findtype findstring gdttype
@@ -4802,6 +4867,9 @@ proc do_file_hl {serial} {
 	set gdtargs [list "-S$highlight_files"]
     } elseif {$gdttype eq [mc "changing lines matching:"]} {
 	set gdtargs [list "-G$highlight_files"]
+    } elseif {$gdttype eq [mc "git-cherry between marked commit and:"]} {
+	# Skipping opening the file handle, filehighlight
+	return
     } else {
 	# must be "containing:", i.e. we're searching commit info
 	return
@@ -4882,6 +4950,17 @@ proc doesmatch {f} {
     }
 }
 
+proc askcherryhighlight {row id} {
+    global nhighlights gitcherryids
+
+    set isbold 0
+    if {[info exists gitcherryids($id)]} {
+	set isbold 1
+    }
+
+    set nhighlights($id) $isbold
+}
+
 proc askfindhighlight {row id} {
     global nhighlights commitinfo iddrawn
     global findloc
@@ -6216,6 +6295,7 @@ proc drawcmitrow {row} {
     global filehighlight fhighlights findpattern nhighlights
     global hlview vhighlights
     global highlight_related rhighlights
+    global gdttype
 
     if {$row >= $numcommits} return
 
@@ -6226,6 +6306,11 @@ proc drawcmitrow {row} {
     if {[info exists filehighlight] && ![info exists fhighlights($id)]} {
 	askfilehighlight $row $id
     }
+
+    if {$gdttype eq [mc "git-cherry between marked commit and:"] && ![info exists nhighlights($id)]} {
+	askcherryhighlight $row $id
+    }
+
     if {$findpattern ne {} && ![info exists nhighlights($id)]} {
 	askfindhighlight $row $id
     }
@@ -6776,7 +6861,9 @@ proc dofind {{dirn 1} {wrap 1}} {
     }
     set findcurline $findstartline
     nowbusy finding [mc "Searching"]
-    if {$gdttype ne [mc "containing:"] && ![info exists filehighlight]} {
+    if {$gdttype eq [mc "git-cherry between marked commit and:"]} {
+	# Don't do anything related to open do_file_hl since we'll just have a list
+    } elseif {$gdttype ne [mc "containing:"] && ![info exists filehighlight]} {
 	after cancel do_file_hl $fh_serial
 	do_file_hl $fh_serial
     }
@@ -6803,6 +6890,7 @@ proc findmore {} {
     global findstartline findcurline findallowwrap
     global find_dirn gdttype fhighlights fprogcoord
     global curview varcorder vrownum varccommits vrowmod
+    global gitcherryids
 
     if {![info exists find_dirn]} {
 	return 0
@@ -6848,7 +6936,23 @@ proc findmore {} {
     set arow [lindex $vrownum($curview) $ai]
     set ids [lindex $varccommits($curview,$a)]
     set arowend [expr {$arow + [llength $ids]}]
-    if {$gdttype eq [mc "containing:"]} {
+
+    if {$gdttype eq [mc "git-cherry between marked commit and:"]} {
+	for {} {$n > 0} {incr n -1; incr l $find_dirn} {
+	    if {$l < $arow || $l >= $arowend} {
+		incr ai $find_dirn
+		set a [lindex $varcorder($curview) $ai]
+		set arow [lindex $vrownum($curview) $ai]
+		set ids [lindex $varccommits($curview,$a)]
+		set arowend [expr {$arow + [llength $ids]}]
+	    }
+	    set id [lindex $ids [expr {$l - $arow}]]
+	    if {[info exists gitcherryids($id)]} {
+		set found 1
+	    }
+	    if {$found} break
+	}
+    } elseif {$gdttype eq [mc "containing:"]} {
 	for {} {$n > 0} {incr n -1; incr l $find_dirn} {
 	    if {$l < $arow || $l >= $arowend} {
 		incr ai $find_dirn
-- 
2.10.2

