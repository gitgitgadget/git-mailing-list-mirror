From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH 1/2] gitk: Add a 'rename' option to the branch context menu
Date: Fri, 15 Jan 2016 22:38:49 +0100
Message-ID: <1859807.50qitjY8Ul@wiske>
References: <51900395.pKIx87RN0F@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 22:49:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKCFT-0004m1-4z
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 22:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264AbcAOVtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 16:49:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36354 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbcAOVtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 16:49:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so4907764wmf.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=nKoUmCoW3bdfBSb/SAMYLkY6wEgDwxN7E2EoUjrXVgU=;
        b=bwl+kmMG1qSAlo10C4W91Dp6LbExEz92/jo/lFhIHtlo8m2YWLfKKa61kZegnjsxMt
         +K3u7p3ToeKEaxnMUaY9MOfZj/uRHcCD4/eGyxCZV0KCgiPzjWxuJ6HupYln3LZcZzIH
         5hasYY1rGZxJcGSFSnK9kvIx1sIza4YFi8wH4MVv4mkkhFasPDiHYgWMZMhunWnB2clA
         8GjAwgg4gToIij8e4C7szaTr9JDCQT6N+quLz37en1C3WWnM0vvzPTYyh3xZvuqQsqp+
         y6HRck8baKiILoYsyPC+hNFGFuyrg1Vd4WAH2b+8dizO18zDWEX1iG9CAux8xI9mHmaV
         M9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=nKoUmCoW3bdfBSb/SAMYLkY6wEgDwxN7E2EoUjrXVgU=;
        b=e+StD0DkFGk82tfJT02rU23+tSXdb0pzUP97Y7Rq7sM+3+XaNL1H31Gv35OQT0Bqhc
         jdK/3p7hOLkl98Oco0EdJ8Skb52M/G+LCWTw+7q/in+IeJp5FjMEZW8hX+nE+rVWR1Hh
         2UZpVNdKhlAKg07ZqdmTY1f8gh9d31aEfuAJWHVeohKn7Lr1nmOi/49WTNukO9UloPx2
         kkTEcS2VKw9nYl78TAn9svrwTwAqLKWEB6PJDj8gUzjnxotOHz87bxbu8n+hiOwlzcAa
         HqOc08Lp7Fs+Exb3widMugmU+xga59ze20DHH4iDchlFv0ZpIdiYh1OdsiIetmTlXsyA
         HROA==
X-Gm-Message-State: ALoCoQmIOQYSexwCLSaAE+AXIJRKdmBhlQ7cdiEnvPk6HR2dbo3inKNKbqxplmd5ATNpomEyya+LlqsOVTY3abWpdVorI8pX6g==
X-Received: by 10.194.116.170 with SMTP id jx10mr11858611wjb.166.1452894563265;
        Fri, 15 Jan 2016 13:49:23 -0800 (PST)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id f205sm4278813wme.4.2016.01.15.13.49.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jan 2016 13:49:22 -0800 (PST)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <51900395.pKIx87RN0F@wiske>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284222>


Signed-off-by: Rogier Goossens <goossens.rogier@gmail.com>
---
 gitk | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 5f1255c..e9465fb 100755
--- a/gitk
+++ b/gitk
@@ -2665,6 +2665,7 @@ proc makewindow {} {
     makemenu $headctxmenu {
 	{mc "Check out this branch" command cobranch}
 	{mc "Remove this branch" command rmbranch}
+	{mc "Rename this branch" command mvbranch}
 	{mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
     $headctxmenu configure -tearoff 0
@@ -9526,6 +9527,80 @@ proc mkbrgo {top} {
     }
 }
 
+proc mvbranch {} {
+    global mvbrtop NS
+    global headmenuid headmenuhead
+
+    set prevname $headmenuhead
+    set id $headmenuid
+
+    set top .renamebranch
+    catch {destroy $top}
+    ttk_toplevel $top
+    make_transient $top .
+    ${NS}::label $top.title -text [mc "Rename branch %s" $prevname]
+    grid $top.title - -pady 10
+    ${NS}::label $top.id -text [mc "ID:"]
+    ${NS}::entry $top.sha1 -width 40
+    $top.sha1 insert 0 $id
+    $top.sha1 conf -state readonly
+    grid $top.id $top.sha1 -sticky w
+    ${NS}::label $top.nlab -text [mc "Name:"]
+    ${NS}::entry $top.name -width 40
+    $top.name insert 0 $prevname
+    grid $top.nlab $top.name -sticky w
+    ${NS}::frame $top.buts
+    ${NS}::button $top.buts.go -text [mc "Rename"] -command [list mvbrgo $top $prevname]
+    ${NS}::button $top.buts.can -text [mc "Cancel"] -command "catch {destroy $top}"
+    bind $top <Key-Return> [list mvbrgo $top $prevname]
+    bind $top <Key-Escape> "catch {destroy $top}"
+    grid $top.buts.go $top.buts.can
+    grid columnconfigure $top.buts 0 -weight 1 -uniform a
+    grid columnconfigure $top.buts 1 -weight 1 -uniform a
+    grid $top.buts - -pady 10 -sticky ew
+    focus $top.name
+}
+
+proc mvbrgo {top prevname} {
+    global headids idheads mainhead mainheadid
+
+    set name [$top.name get]
+    set id [$top.sha1 get]
+    set cmdargs {}
+    if {$name eq $prevname} {
+	catch {destroy $top}
+	return
+    }
+    if {$name eq {}} {
+	error_popup [mc "Please specify a new name for the branch"] $top
+	return
+    }
+    catch {destroy $top}
+    lappend cmdargs -m $prevname $name
+    nowbusy renamebranch
+    update
+    if {[catch {
+	eval exec git branch $cmdargs
+    } err]} {
+	notbusy renamebranch
+	error_popup $err
+    } else {
+	notbusy renamebranch
+	removehead $id $prevname
+	removedhead $id $prevname
+	set headids($name) $id
+	lappend idheads($id) $name
+	addedhead $id $name
+	if {$prevname eq $mainhead} {
+	    set mainhead $name
+	    set mainheadid $id
+	}
+	redrawtags $id
+	dispneartags 0
+	run refill_reflist
+    }
+}
+
 proc exec_citool {tool_args {baseid {}}} {
     global commitinfo env
 
@@ -9756,15 +9831,19 @@ proc headmenu {x y id head} {
     stopfinding
     set headmenuid $id
     set headmenuhead $head
-    set state normal
+    array set state {0 normal 1 normal 2 normal 3 normal}
     if {[string match "remotes/*" $head]} {
-	set state disabled
+	set state(0) disabled
+	set state(1) disabled
+	set state(2) disabled
     }
     if {$head eq $mainhead} {
-	set state disabled
+	set state(0) disabled
+	set state(1) disabled
+    }
+    foreach i {0 1 2 3} {
+	$headctxmenu entryconfigure $i -state $state($i)
     }
-    $headctxmenu entryconfigure 0 -state $state
-    $headctxmenu entryconfigure 1 -state $state
     tk_popup $headctxmenu $x $y
 }
 
-- 
2.1.4
