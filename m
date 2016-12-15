Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7397D1FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 11:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755587AbcLOL3C (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:29:02 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33672 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcLOL3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:29:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id 3so5975056pgd.0
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 03:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0FLO93pndRepjwgLtAHIo1gnZVj0Aag8d++AG83NJkM=;
        b=qQn3T6KQ6TRL5VHT1kfA5JaIXV08p0OJvMxcUv+WspBWt2jHFahQAjNM1S0I5VJLMi
         W4ZEqb/feQUKQZU/HWrXtw0Ai+hqIgHT4mWUThvW1ME4ZaJKKNcbmlgV45RTcj2vpdtO
         pSmLEnS2znwHr6W19iS79N8dJ2FsXvwN8l+HsRFIMMnG2lj/iTqQPzbJ0Nl89Ln2ofPX
         q/4iwWC6ra6DkOgSO+bK5/MsgGylKiH2YQfkQt9BpXOFxIyljUm9HRENgSjx+/p47fZM
         Fpao5aamJ4TMfSrnE0Sf4VZiWHXLgE7RFPCTlG19Gl26Uii65xNj5nDnpQQSR5O+1pX4
         cvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0FLO93pndRepjwgLtAHIo1gnZVj0Aag8d++AG83NJkM=;
        b=qgQpfrnGBGT+Wnz8Cv7+V1jnoupmylRPmetsMn+NBYqdnJBBCRlGlQdc0rE1og1fro
         6knL0RRhAdAAnTHQNnC4x8la977z4mAWKpWpj152ntec8Cc9UKYOY0CiROsa1jjBNcVS
         KPBSt/BeLZ0cpl7wetjlN8TSVM5D//F54WVwPmrOZA4/QejBLGDQo8OY1H3/ZjBDqCyb
         qXYhDdctJbt5Jr3KDYJu5wcQEBEibf+6DddOwBNRnzVv9yIJNRXXFen7KBZ+6E1ujzMB
         OYnQ0B5TGjQHMmRhzbsb6i6uN7acZGng+x/2m+Z+JOJL01etKbxz1oVbnFgq1KizmRg4
         pekQ==
X-Gm-Message-State: AKaTC01G/M8l1UWoxI9iddNTNhACy21GNcA008aXuM0V7g5ItH9Qbe6J0xoTnwrRpnMejQ==
X-Received: by 10.99.60.11 with SMTP id j11mr1424638pga.26.1481801340359;
        Thu, 15 Dec 2016 03:29:00 -0800 (PST)
Received: from kpdpro.suho.local ([118.211.97.195])
        by smtp.gmail.com with ESMTPSA id 189sm3930190pgh.5.2016.12.15.03.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 03:28:59 -0800 (PST)
From:   Pierre Dumuid <pmdumuid@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Pierre Dumuid <pmdumuid@gmail.com>
Subject: [PATCH 3/6] Add a tree view to the local branches, remote branches and tags, where / is treated as a directory seperator.
Date:   Thu, 15 Dec 2016 21:58:44 +1030
Message-Id: <20161215112847.14719-3-pmdumuid@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161215112847.14719-1-pmdumuid@gmail.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
---
 gitk | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/gitk b/gitk
index 36cba49..a894f1d 100755
--- a/gitk
+++ b/gitk
@@ -2089,6 +2089,10 @@ proc makewindow {} {
 	    {mc "Reread re&ferences" command rereadrefs}
 	    {mc "&List references" command showrefs -accelerator F2}
 	    {xx "" separator}
+	    {mc "List Local Branches"  command {show_tree_of_references_dialog "localBranches"}  -accelerator F6}
+	    {mc "List Remote Branches" command {show_tree_of_references_dialog "remoteBranches"} -accelerator F7}
+	    {mc "List Tags"            command {show_tree_of_references_dialog "tags"}           -accelerator F8}
+	    {xx "" separator}
 	    {mc "Start git &gui" command {exec git gui &}}
 	    {xx "" separator}
 	    {mc "&Quit" command doquit -accelerator Meta1-Q}
@@ -2601,6 +2605,9 @@ proc makewindow {} {
     bind . <F5> updatecommits
     bindmodfunctionkey Shift 5 reloadcommits
     bind . <F2> showrefs
+    bind . <F6> {show_tree_of_references_dialog "localBranches"}
+    bind . <F7> {show_tree_of_references_dialog "remoteBranches"}
+    bind . <F8> {show_tree_of_references_dialog "tags"}
     bindmodfunctionkey Shift 4 {newview 0}
     bind . <F4> edit_or_newview
     bind . <$M1B-q> doquit
@@ -10146,6 +10153,116 @@ proc rmbranch {} {
     run refill_reflist
 }
 
+# Display a tree view of local branches, remote branches, and tags according to view_type.
+#
+# @param string view_type
+#    Must be one of "localBranches", "remoteBranches", or "tags".
+#
+proc show_tree_of_references_dialog {view_type} {
+    global NS
+    global treefilelist
+    global headids tagids
+
+    switch -- $view_type {
+	"localBranches" {
+	    set dialogName "Local Branches"
+	    set top .show_tree_of_local_branches
+	    set listOfReferences [lsort [array names headids -regexp {^(?!remotes/)} ]]
+	    set truncateFrom 0
+	}
+	"remoteBranches" {
+	    set dialogName "Remote Branches"
+	    set top .show_tree_of_remote_branches
+	    set listOfReferences [lsort [array names headids -regexp {^remotes/} ]]
+	    set truncateFrom 8
+	}
+	"tags" {
+	    set dialogName "Tags"
+	    set top .show_tree_of_tags
+	    set listOfReferences [lsort [array names tagids]]
+	    set truncateFrom 0
+	}
+    }
+
+    if {[winfo exists $top]} {
+	raise $top
+	return
+    }
+
+    ttk_toplevel $top
+    wm title $top [mc "$dialogName: %s" [file tail [pwd]]]
+    wm geometry $top "600x900"
+
+    make_transient $top .
+
+    ## See http://www.tkdocs.com/tutorial/tree.html
+    ttk::treeview $top.referenceList -xscrollcommand "$top.horizontalScrollBar set" -yscrollcommand "$top.verticalScrollBar set"
+
+    # Populate the dialog
+    foreach reference $listOfReferences {
+	# The display name omits some leading characters (such as "remotes/")
+	set referenceDisplayName [string range $reference $truncateFrom end]
+
+	# Split the branch/tag by slashes, and incrementally ensure that each leaf in the treeview exists..
+	# otherwise add it.
+	set treeLeaves [split $referenceDisplayName "/"]
+	for {set i 0} {$i < [llength $treeLeaves]} {} {
+	    set leafReferenceId [join [lrange $treeLeaves 0 $i] "/"]
+	    if {![$top.referenceList exists $leafReferenceId]} {
+		if {$i > 0} {
+		    set parentLeafId [join [lrange $treeLeaves 0 $i-1] "/"]
+		} else {
+		    set parentLeafId {}
+		}
+		$top.referenceList insert $parentLeafId end -id $leafReferenceId -text [lindex $treeLeaves $i]
+	    }
+	    incr i
+	}
+    }
+
+    ${NS}::scrollbar $top.verticalScrollBar   -command "$top.referenceList yview" -orient vertical
+    ${NS}::scrollbar $top.horizontalScrollBar -command "$top.referenceList xview" -orient horizontal
+
+    grid $top.referenceList $top.verticalScrollBar -sticky nsew
+    grid $top.horizontalScrollBar x -sticky ew
+
+    bind $top <Key-Escape> [list destroy $top]
+
+    bind $top.referenceList <<TreeviewSelect>> {callback_tree_of_references_item_selected %W; break}
+
+    grid columnconfigure $top 0 -weight 1
+    grid rowconfigure    $top 0 -weight 1
+}
+
+# Call back for selecting a branch / tag in the tree of references
+#
+# @param w
+#
+proc callback_tree_of_references_item_selected {w} {
+    global headids tagids
+
+    set itemId [$w focus]
+    switch -- $w {
+	".show_tree_of_local_branches.referenceList" {
+	    if {[info exists headids($itemId)]} {
+		selbyid $headids($itemId)
+	    }
+	}
+	".show_tree_of_remote_branches.referenceList" {
+	    set itemId "remotes/$itemId"
+	    if {[info exists headids($itemId)]} {
+		selbyid $headids($itemId)
+	    }
+	}
+	".show_tree_of_tags.referenceList" {
+	    if {[info exists tagids($itemId)]} {
+		selbyid $tagids($itemId)
+	    }
+	}
+    }
+}
+
+
 # Display a list of tags and heads
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor NS
-- 
2.10.2

