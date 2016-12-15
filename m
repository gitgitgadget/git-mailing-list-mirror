Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CC01FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 11:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbcLOL27 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:28:59 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33649 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcLOL26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:28:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so5974928pgd.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 03:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/mXsqXhr50wRSEJFIyL0K5EChFZdc5/ffJnmak5Vy/Y=;
        b=cFqL5GKnzhrVJD8mmdAuqVb1Qi/qrgBwsEkRemJseYe7vcbAUUXnM+XcvCVIcTO//d
         k/54rqOPRM5F+VbPwGc16NnTQRPf+3xb7lDZdWS7+Mr45bp++iY/Q0a36S/dfevBGtAU
         sGbrkYmeZAvNhDk78vTAS/0a6qwZuw96ynanf9fLrl2N0VIqcuyLDLgOwZLhJpzMm/9Q
         hmUep/gzaYlLPPoqCRUXd9dtCbnhC66y2i9E7Oa+t+BVmAoFHUUw0hEMb6A/W6cDZjiW
         murVvHoZDbG/SThncbLcP5nN8o4vgmC3IBCeVHImZHRT8Dg2hP/nSQvJgsaTBx726Aom
         ewTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/mXsqXhr50wRSEJFIyL0K5EChFZdc5/ffJnmak5Vy/Y=;
        b=DzE/ZecALtwngkpxioiONSyqFwF+Sxv17Dvz3Wap/kyadSWd4pXBN6r+Qvt/h3k7QP
         iCKyNuYPLvQ5yBhX/vUFoscdKBmfobYKUpcYqnxe/U65wti7sMzQf0o+xPErt+2ki/Cj
         tO7ho5oA0xk2aTu5PcV+rmBvqT4OtdIyEE+Kd9YtVhpZ7uKrt78jhUV/HK4o2ybZ1eg2
         H98WrzGxrwaZ6iroxZKY1eopUDOkV62rPp78Ut2JNILxtE5SfGU2LcOLoghHW+0XHsWV
         TPsBJUhyxWRqbHeVcMmlGkPuqoehsmc6UZcrRjrgaVpnGjmeWaM7zcGKK3OT+MobPPDX
         Yu6w==
X-Gm-Message-State: AKaTC00AdNdS1ZDEg1y/4/u1qXoGinQqg7hOPqcbFvHGBPKUYxag9mzTA+V23+UnfQaeIw==
X-Received: by 10.99.166.2 with SMTP id t2mr1398581pge.40.1481801337446;
        Thu, 15 Dec 2016 03:28:57 -0800 (PST)
Received: from kpdpro.suho.local ([118.211.97.195])
        by smtp.gmail.com with ESMTPSA id 189sm3930190pgh.5.2016.12.15.03.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 03:28:56 -0800 (PST)
From:   Pierre Dumuid <pmdumuid@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Pierre Dumuid <pmdumuid@gmail.com>
Subject: [PATCH 2/6] Add ability to follow a remote branch with a dialog
Date:   Thu, 15 Dec 2016 21:58:43 +1030
Message-Id: <20161215112847.14719-2-pmdumuid@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161215112847.14719-1-pmdumuid@gmail.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A suggested name is provided when creating a new "following" branch.

Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
---
 gitk | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 50d1ef4..36cba49 100755
--- a/gitk
+++ b/gitk
@@ -2673,6 +2673,7 @@ proc makewindow {} {
 	{mc "Rename this branch" command mvbranch}
 	{mc "Remove this branch" command rmbranch}
 	{mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
+	{mc "Follow this branch"  command follow_remote_branch_dialog}
     }
     $headctxmenu configure -tearoff 0
 
@@ -9947,23 +9948,100 @@ proc headmenu {x y id head} {
     stopfinding
     set headmenuid $id
     set headmenuhead $head
-    array set state {0 normal 1 normal 2 normal}
+    array set state {0 normal 1 normal 2 normal 3 normal}
     if {[string match "remotes/*" $head]} {
 	set localhead [string range $head [expr [string last / $head] + 1] end]
 	if {[info exists headids($localhead)]} {
 	    set state(0) disabled
 	}
-	array set state {1 disabled 2 disabled}
+	array set state {1 disabled 2 disabled 3 normal}
     }
     if {$head eq $mainhead} {
-	array set state {0 disabled 2 disabled}
+	array set state {0 disabled 2 disabled 3 disabled}
+    } else {
+	set state(3) disabled
     }
-    foreach i {0 1 2} {
+    foreach i {0 1 2 3} {
 	$headctxmenu entryconfigure $i -state $state($i)
     }
     tk_popup $headctxmenu $x $y
 }
 
+proc follow_remote_branch_dialog {} {
+    global headmenuhead NS
+
+    # check the tree is clean first??
+    nowbusy createFollowingBranch [mc "Creating following branch"]
+    update
+    dohidelocalchanges
+
+    set top .create_following_branch
+    catch {destroy $top}
+    ttk_toplevel $top
+    make_transient $top .
+
+    ${NS}::label $top.title -text [mc "Create following branch"]
+    grid $top.title - -pady 10
+
+    ${NS}::label $top.remote_branch_name_label -text [mc "Remote Branch:"]
+    ${NS}::entry $top.remote_branch_name -width 40
+    $top.remote_branch_name insert 0 $headmenuhead
+    $top.remote_branch_name conf -state readonly
+    grid $top.remote_branch_name_label $top.remote_branch_name -sticky w
+
+    ${NS}::label $top.new_branch_name_label -text [mc "Name:"]
+    ${NS}::entry $top.new_branch_name -width 40
+    set suggested_name $headmenuhead
+    regsub {^remotes/[^/]*/} $suggested_name {} suggested_name
+    $top.new_branch_name insert 0 $suggested_name
+    grid $top.new_branch_name_label $top.new_branch_name -sticky w
+
+    set actionCreate [list follow_remote_branch_callback $top]
+    set actionCancel "catch {notbusy createFollowingBranch; destroy $top}"
+
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.go  -text [mc "Create"] -command $actionCreate
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command $actionCancel
+    grid $top.buts.go $top.buts.can
+    grid columnconfigure $top.buts 0 -weight 1 -uniform a
+    grid columnconfigure $top.buts 1 -weight 1 -uniform a
+    grid $top.buts - -pady 10 -sticky ew
+
+    bind $top <Key-Return> $actionCreate
+    bind $top <Key-Escape> $actionCancel
+
+    focus $top.new_branch_name
+}
+
+proc follow_remote_branch_callback {top} {
+    global headids idheads NS
+    set new_branch_name    [$top.new_branch_name get]
+    set remote_branch_name [$top.remote_branch_name get]
+    set cmdargs {}
+
+    if {$new_branch_name eq {}} {
+	error_popup [mc "Please specify a name for the new branch"] $top
+	return
+    }
+    if {[info exists headids($new_branch_name)]} {
+	error_popup [mc "The branch name you specified already exists, please specify a new name"] $top
+	return
+    }
+    catch {destroy $top}
+
+    lappend cmdargs $new_branch_name $remote_branch_name
+
+    if {[catch {
+	eval exec git branch --track $cmdargs
+    } err]} {
+	notbusy createFollowingBranch
+	error_popup $err
+    } else {
+	notbusy createFollowingBranch
+	updatecommits
+    }
+}
+
 proc cobranch {} {
     global headmenuid headmenuhead headids
     global showlocalchanges
-- 
2.10.2

