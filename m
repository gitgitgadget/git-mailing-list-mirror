Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE12442C
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093282; cv=none; b=NbFxO92YzWyV/EdqEoZYUcPSnYsTdRrCWpDAEPTsZl/ijbTQyTkhS5nEqAdrXJqlvafQQZ4WH8nIWf4Px9KxLZ9tVbWo/vuuy/6XL6ywkM4ESy8C92lgsEvmK7+5d9iu5ScoEzDAuIq9r4OfWJqlrNNEojvOYaIex9b4E6mJ0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093282; c=relaxed/simple;
	bh=32+tncTUjvjLcSZou65UmCrEU6M7K3cRPLkAtzfIrAM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ja1B+dJxKUaTrkF7nDaM18mkgQArrE8yVtVN/Z347UpBF/oLNVhscP4riFL/HJrTkxuK7x11R5e8MmReDTd/GgOMW6qdt8b1FLzCfAvE4mwydyb1wusdxfqQFMlEaFMSUFTPggVE3TUZft7xpADxR0tRrpg6q4XuIJ/iyddpt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7tZharE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7tZharE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5556579so2186670f8f.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 05:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741093278; x=1741698078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kBhdyBS/UPX1ZKJR7bcSnQpMoBfWi7Q7NQuPR8rb2k=;
        b=c7tZharE5p0+HqkKSL2xRs/aWky51vO7ksFzcDN3Vn+I/HMn1IQsocW+vQU8+9H6rt
         uUfuL+6NO64Bq8/8T75YYeMWDHLDdfFNGslu4BNOwdB7aN4UOhaPa+vSIMKjSHLJMRPt
         4Ni1iEJGFW+rFgbtUPodRYxV2eLkZmuiCqUUSyRok+sGLtGoVJOuccPhUQxlMLm3Zpsa
         czzxz3HZpaPEKsTj+KrKgEtfqpqvk+PyXH9Yhz5vM6Y4r6GlV/LmsKaDxdPCrxTb4+Qy
         mhT7Xm4Ocmb4urqAWoU22KElIDsUmkNr5NCU91nBdPiQxIhJmZziz3sJWgXrFBHB0Z9V
         qY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093278; x=1741698078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kBhdyBS/UPX1ZKJR7bcSnQpMoBfWi7Q7NQuPR8rb2k=;
        b=ENi5N9mMjIHKW6DIYj+tqoU5YY9d071eOJ1R8pCmf5JSAb/T8BWa/GvLr4WBRaJ0b9
         0OUnLOT1bzKipspxkOKiG9zPVqufb4mvS7+QDS0X8Ck6QZk0JnfE/0i6DvCRQu+QvgPW
         gnzf4ENlx/YmyXhiIUw50X9CSK5+QRiLxqahT+Cwhec7LRszodg+CsLMEL/2+Du5PJkt
         G22785fVWF8f5OfhYM5DJMnPR3krmzaBfFEmF2ym2/6ClnKN+XG+loB/ydiv6+UYRWhA
         E7p1j3pRSalkjDtOwR/tJAsd2pvsVskWl9BYBlBiruoB3VsfiBeVgitXpWxiw6IVsoCd
         aAww==
X-Gm-Message-State: AOJu0YxeTtF3zeYFHeo1hssIoWyiR+oIE58NEIo9sd/QW351SzSODz+G
	80IhRVKLEReti9YWxpXZvU6giayVguwhTbBDODgazQP+237f1PUeG9dwOA==
X-Gm-Gg: ASbGncsFV1DI/fPbfPw7orLgHPsLfcBUzAj8fViSoLc9j3Fe6FxL8kSTSzl2AYJ5Zq1
	aa2D5HxhUN1UDLFPaGr4fbcEa+naJIFK7SWnva+fFHEND6U48aWY5I3iuN2e2bXAj9VbE++gEHe
	iwLSSSWKyESvzlKLeVKTsfTMSj8ixtrBrMPpGthIDDDK0HhlNSH9oBrdO2gOS4yM8HchgiboKK/
	z/68MqRvzA9kEcZadg/hkoz0qFYaVGX6quO9pSKpJN0KdjPtHnO17iZ93dRTrVRZhkMRfb+C06M
	GWNbjoTexa1TFp+7eFd2ORS2BT/+WzOL6P5xYCJ9gg1XRw==
X-Google-Smtp-Source: AGHT+IEM6zCSv0Q+fJsJ8IlBKmSd4PBGAQyRLVT0poC3Li7JaDjEiBysaBj4b/F846xfk4iiQpMKZA==
X-Received: by 2002:a5d:5984:0:b0:390:f88c:a684 with SMTP id ffacd0b85a97d-390f88caccdmr13351727f8f.35.1741093277196;
        Tue, 04 Mar 2025 05:01:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795978sm17291719f8f.3.2025.03.04.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:01:16 -0800 (PST)
Message-Id: <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.v2.git.1725607698680.gitgitgadget@gmail.com>
References: <pull.1774.v2.git.1725607698680.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Mar 2025 13:01:15 +0000
Subject: [PATCH v3] gitk: added external diff file rename detection
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ToBoMi <tobias.boesch@miele.com>,
    Tobias Boesch <tobias.boesch@miele.com>

From: Tobias Boesch <tobias.boesch@miele.com>

* If a file was renamed between commits and an external diff is started
  through gitk on the original or the renamed file name,
  gitk was unable to open the renamed file in the external diff editor.
  It failed to fetch the renamed file from git, because it fetched it
  using its original path in contrast to using the renamed path of the
  file.
* With this change gitk detects the rename and opens the external diff
  with the original and the renamed file instead of no file (it is able
  to fetch the renamed file path and name now from git).
* Since git doesn't destinguish between move or rename this also works
  for moved files.
* Showing the external diff with the original and the renamed file
  works when either of the files is selected in gitk.

Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
---
    gitk: added external diff file rename detection
    
    Changes since v1:
    
     * Commit message ident
     * Commit message line length
    
    Changes since v2:
    
     * Removed option for rename detection (Adding GUI options seems to be
       not desired - which is understandable)
     * Rebased on current master of git-for-windows
     * Renamed variables for a better understanding
     * Made rename detection also work when the renamed file is selected in
       gitk

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v2:

 1:  6209080cad6 ! 1:  1a64e989713 gitk: added external diff file rename detection
     @@ Commit message
          gitk: added external diff file rename detection
      
          * If a file was renamed between commits and an external diff is started
     -      through gitk on the THE ORIGINAL FILE NAME (not the renamed one),
     +      through gitk on the original or the renamed file name,
            gitk was unable to open the renamed file in the external diff editor.
            It failed to fetch the renamed file from git, because it fetched it
     -      with the original path in contrast to using the renamed path
     -    * gitk now detects the rename and opens the external diff with the
     -      original and the RENAMED file instead of no file (it is able to
     -      fetch the renamed file now from git with the renamed path/filename)
     -    * Since git doesn't destinguish between move or rename this also works
     -      for moved files
     -    * External diff detection and usage is optional and has to be enabled in
     -      gitk settings
     -    * External rename detection ist marked EXPERIMENTAL in the settings
     -      and disabled by default
     -    * Showing the renamed file doesn't work when THE RENAMED FILE is selected
     -      in gitk and an external diff ist started on that file, because the
     -      selected file is not renamed in that commit. It already IS the renamed
     +      using its original path in contrast to using the renamed path of the
            file.
     +    * With this change gitk detects the rename and opens the external diff
     +      with the original and the renamed file instead of no file (it is able
     +      to fetch the renamed file path and name now from git).
     +    * Since git doesn't destinguish between move or rename this also works
     +      for moved files.
     +    * Showing the external diff with the original and the renamed file
     +      works when either of the files is selected in gitk.
      
     -    Signed-off-by: Tobias Boeesch <tobias.boesch@miele.com>
     +    Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
      
       ## gitk-git/gitk ##
      @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {
     @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {
      +
      +    set renamed_filenames [list {}]
      +    set filename [file tail $filepath]
     -+    set rename_from_text_length 12
     -+    set rename_to_text_length 10
     ++    set rename_from_text_identifier_length 12
     ++    set rename_to_text_identifier_length 10
      +    set reg_expr_rename_from {^rename from (.*$filename)}
      +    set reg_expr_rename_from [subst -nobackslashes -nocommands $reg_expr_rename_from]
     -+    set reg_expr_rename_to {^rename to (.*)}
      +    set rename_from_text_index [$ctext search -elide -regexp -- $reg_expr_rename_from 0.0]
      +    if { ($rename_from_text_index != {})} {
     ++        set reg_expr_rename_to {^rename to (.*)}
      +        set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to $rename_from_text_index]
      +        if { ($rename_from_text_index != {}) && ($rename_to_text_index != {}) } {
     -+            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_length chars" "$rename_from_text_index lineend"]
     -+            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_length chars" "$rename_to_text_index lineend"]
     ++            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
     ++            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
     ++        }
     ++        return $renamed_filenames
     ++    }
     ++    set reg_expr_rename_to {^rename to (.*$filename)}
     ++    set reg_expr_rename_to [subst -nobackslashes -nocommands $reg_expr_rename_to]
     ++    set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to 0.0]
     ++    if { ($rename_to_text_index != {})} {
     ++        set reg_expr_rename_from {^rename from (.*)}
     ++        set rename_from_text_index [$ctext search -backwards -elide -regexp -- $reg_expr_rename_from $rename_to_text_index]
     ++        if { ($rename_to_text_index != {}) && ($rename_from_text_index != {}) } {
     ++            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
     ++            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
      +        }
     ++        return $renamed_filenames
      +    }
     -+    return $renamed_filenames
      +}
      +
       proc external_diff {} {
           global nullid nullid2
           global flist_menu_file
     -     global diffids
     -     global extdifftool
     -+    global file_rename_detection
     - 
     -     if {[llength $diffids] == 1} {
     -         # no reference commit given
      @@ gitk-git/gitk: proc external_diff {} {
           if {$diffdir eq {}} return
       
           # gather files to diff
      -    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
      -    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
     -+    if {$file_rename_detection} {
     -+        set renamed_filenames [check_for_renames_in_diff $flist_menu_file]
     -+        set rename_from_filename [lindex $renamed_filenames 1]
     -+        set rename_to_filename [lindex $renamed_filenames 2]
     -+        if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
     -+            set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
     -+            set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
     -+        } else {
     -+            set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
     -+            set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
     -+        }
     ++    set renamed_filenames [check_for_renames_in_diff $flist_menu_file]
     ++    set rename_from_filename [lindex $renamed_filenames 1]
     ++    set rename_to_filename [lindex $renamed_filenames 2]
     ++    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
     ++        set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
     ++        set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
      +    } else {
      +        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
      +        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
     @@ gitk-git/gitk: proc external_diff {} {
       
           if {$difffromfile ne {} && $difftofile ne {}} {
               set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
     -@@ gitk-git/gitk: proc create_prefs_page {w} {
     - proc prefspage_general {notebook} {
     -     global NS maxwidth maxgraphpct showneartags showlocalchanges
     -     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
     --    global hideremotes want_ttk have_ttk maxrefs web_browser
     -+    global hideremotes want_ttk have_ttk maxrefs web_browser file_rename_detection
     - 
     -     set page [create_prefs_page $notebook.general]
     - 
     -@@ gitk-git/gitk: proc prefspage_general {notebook} {
     -     grid $page.lgen - -sticky w -pady 10
     -     ${NS}::checkbutton $page.want_ttk -variable want_ttk \
     -         -text [mc "Use themed widgets"]
     -+    ${NS}::checkbutton $page.file_rename_detection -variable file_rename_detection \
     -+        -text [mc "Use ext diff file rename detection"]
     -+    ${NS}::label $page.file_rename_detection_note -text [mc "(EXPERIMENTAL\nTries to find the file path of a\nrenamed file in external diff)"]
     -     if {$have_ttk} {
     -         ${NS}::label $page.ttk_note -text [mc "(change requires restart)"]
     -     } else {
     -         ${NS}::label $page.ttk_note -text [mc "(currently unavailable)"]
     -     }
     -     grid x $page.want_ttk $page.ttk_note -sticky w
     -+    grid x $page.file_rename_detection $page.file_rename_detection_note -sticky w
     -     return $page
     - }
     - 
     -@@ gitk-git/gitk: proc doprefs {} {
     -     global oldprefs prefstop showneartags showlocalchanges
     -     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     -     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
     --    global hideremotes want_ttk have_ttk
     -+    global hideremotes want_ttk have_ttk file_rename_detection
     - 
     -     set top .gitkprefs
     -     set prefstop $top
     -@@ gitk-git/gitk: proc doprefs {} {
     -         return
     -     }
     -     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
     --                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
     -+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk file_rename_detection} {
     -         set oldprefs($v) [set $v]
     -     }
     -     ttk_toplevel $top
     -@@ gitk-git/gitk: proc prefscan {} {
     -     global oldprefs prefstop
     - 
     -     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
     --                   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
     -+                   limitdiffs tabstop perfile_attrs hideremotes want_ttk file_rename_detection} {
     -         global $v
     -         set $v $oldprefs($v)
     -     }
     -@@ gitk-git/gitk: set autoselect 1
     - set autosellen 40
     - set perfile_attrs 0
     - set want_ttk 1
     -+set file_rename_detection 0
     - 
     - if {[tk windowingsystem] eq "aqua"} {
     -     set extdifftool "opendiff"
     -@@ gitk-git/gitk: config_check_tmp_exists 50
     - set config_variables {
     -     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
     -     cmitmode wrapcomment autoselect autosellen showneartags maxrefs visiblerefs
     --    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
     -+    hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk file_rename_detection
     -     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     -     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
     -     extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor


 gitk-git/gitk | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index bc9efa18566..ddbe60398f2 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3806,6 +3806,39 @@ proc external_diff_get_one_file {diffid filename diffdir} {
                "revision $diffid"]
 }
 
+proc check_for_renames_in_diff {filepath} {
+    global ctext
+
+    set renamed_filenames [list {}]
+    set filename [file tail $filepath]
+    set rename_from_text_identifier_length 12
+    set rename_to_text_identifier_length 10
+    set reg_expr_rename_from {^rename from (.*$filename)}
+    set reg_expr_rename_from [subst -nobackslashes -nocommands $reg_expr_rename_from]
+    set rename_from_text_index [$ctext search -elide -regexp -- $reg_expr_rename_from 0.0]
+    if { ($rename_from_text_index != {})} {
+        set reg_expr_rename_to {^rename to (.*)}
+        set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to $rename_from_text_index]
+        if { ($rename_from_text_index != {}) && ($rename_to_text_index != {}) } {
+            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
+            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
+        }
+        return $renamed_filenames
+    }
+    set reg_expr_rename_to {^rename to (.*$filename)}
+    set reg_expr_rename_to [subst -nobackslashes -nocommands $reg_expr_rename_to]
+    set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to 0.0]
+    if { ($rename_to_text_index != {})} {
+        set reg_expr_rename_from {^rename from (.*)}
+        set rename_from_text_index [$ctext search -backwards -elide -regexp -- $reg_expr_rename_from $rename_to_text_index]
+        if { ($rename_to_text_index != {}) && ($rename_from_text_index != {}) } {
+            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
+            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
+        }
+        return $renamed_filenames
+    }
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
@@ -3836,8 +3869,16 @@ proc external_diff {} {
     if {$diffdir eq {}} return
 
     # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    set renamed_filenames [check_for_renames_in_diff $flist_menu_file]
+    set rename_from_filename [lindex $renamed_filenames 1]
+    set rename_to_filename [lindex $renamed_filenames 2]
+    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
+        set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
+    } else {
+        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    }
 
     if {$difffromfile ne {} && $difftofile ne {}} {
         set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]

base-commit: db91954e18654eeebc54c900f44c704002e1866d
-- 
gitgitgadget
