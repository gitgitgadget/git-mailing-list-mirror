Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A4335571
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905378; cv=none; b=BZgSJT9RAghgPINwP2boG3tbJsx9bKqdFZR7eIPhAtn4xGZ0ZkJnL62YJ0r3wBS/bsyFJvE5YAKvQ426vK5OW1ibEVbIoRHhV2oom96BVG04FxBjWFTXRja33W+0Q24oG+iFDLBmeUqKdBEM+gNv2GQcB0eQEVz1tYzJ15KMrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905378; c=relaxed/simple;
	bh=XFfUZ/xH863RQRWa7dV3960buU0Etsw9WmBGYkXZgFE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kVwgzMLBsG+Cf/nw4HZQ67atxwOllqD2W5YyAErn2H+fuW7uLlHOQ/eLPvpwnNPReATIpxbh27jBWzbBvZl7+y/3HOOdNsIcsA6VZzX95Y3jv8fudhNz23R+Ppmrdy+DavCZQWolYbPe5wuq8fif+nlJMxvjS8Ngao1ZMrFgDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De7UcMNc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De7UcMNc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-294fc62d7f4so16196585ad.2
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761905373; x=1762510173; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyesd1uICfMnOj0Pa5Xa5gTVRkIfAGwjJP9RABvZSZM=;
        b=De7UcMNcaSmF62JW9SfHBtFl2OhHCEXla7uQypY8SJw3HBDGkk6raHCMwwktz6Kh3x
         xk8sYr8glIiEqnFraJR1nKydJlNy9sA23X2k5DLYDSVoYv+fQmrw6SznMxfaG9IdCFCg
         TNtNOPvGg2ctK5kMifgKUDXtDygceqoz5Y0uEGzm7g3MD2qiL4Uz6o6xzozfCqelii1e
         rBTUvqQ8v5xk5JbGGYal8uaCKWgTxWZ5px6GTNpoPHWCSbcpYqH9vwo7aS1HZRglL1us
         2JmqAvwdcEVtupwMsO2/kEegs6h9edb4q0jCXDPXtGwCW5aS9koMi91ZrpoMZXu+kapb
         lgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905373; x=1762510173;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyesd1uICfMnOj0Pa5Xa5gTVRkIfAGwjJP9RABvZSZM=;
        b=Ee/9qv/n0IwIzprjRfdEq1S9lPI8B2GTjz8X029YPc4ZjPGAOGfiMj99usn1+Em+nM
         c0/RduZb6s4QnucTtvE28gv7sz5l9cdjUsJkhtxUCTMU+eLnJUpJo5Ye8ecZwFu8u7vG
         jUd6EPFLJNZ3TtQ93BbXXYIWYHnZQ2YhAJdtvf15SWSxlCK9eTVeqW85Ez8R5dqD5gz5
         omiTsqq9L3Wc2DEtim55azlf0d+B4UPbfiSMAhYuOb6gx8ssfCWJ2TRqHY0dIfxKxUcn
         /u+SFb7h7r9wzcM30TYEzeyuGYwlEEJqR35U4VNybJJNTZf0/2M9U0ycaS+nbxy0QNoF
         m/CA==
X-Gm-Message-State: AOJu0YyIEviGUDzX7a6U7eDhLYwcgMRCMu5tNtRrkFgEz/cnnTbG1ETd
	CmP6r90u7t8BT5szytFm8RttMLhEkSEkekNY5mx0h4oCh5/PGTprA4RHab35Ew==
X-Gm-Gg: ASbGncsnZa8WfAxfIyK3jTUTS6ENNx1OKpqDgsmZMfzNF+fpztdGaHLZ0BVgxzUBFSY
	w3ZrqhwsPmQO6mmzVqjhNxSxw5BpeKcXjXriIl+J6glBQQPHjEgnwGGxTaKb4jRimBHGsbfIftk
	xTjmgymvvi6mcu0JmodnWhEKEmSbIqqI7xizPEhqL6htvuFUglaFdePC7Gtn8iTxSUlJF96LGlY
	2xrq78rP2fckSDtzv1NrmJRkK3dr//05bn6SbtqqeDActDFAenmtesKMxsScWDuThZpLPGoHZUR
	2AexPfgN2p7c/jaWApN9U4ndDZsctouA8n1eGvHrVRurCttYzxlD059aQRyWajRt6sshxViiiMo
	x0F6aEg3Jw7zULukrYuHL8VsFfW3Edk+2j3Nctf356UBlOouuwry+Ht9lGU8syVB4pjSmFlLbnC
	rxQCElQBT8Zs5uWS88WHk0cJzF
X-Google-Smtp-Source: AGHT+IFlmO1buMk+5z+Yy2YXdzoeVK7ndwz33ipnlIk38nDoGDP5t5peFPA3XvMBSgMmBtDIKK1H2w==
X-Received: by 2002:a17:902:d487:b0:273:59ef:4c30 with SMTP id d9443c01a7336-2951a39e2eemr43427495ad.15.1761905372628;
        Fri, 31 Oct 2025 03:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2953f35bc28sm471685ad.109.2025.10.31.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:09:31 -0700 (PDT)
Message-Id: <pull.1774.v7.git.1761905371163.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.v6.git.1750755954011.gitgitgadget@gmail.com>
References: <pull.1774.v6.git.1750755954011.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Oct 2025 10:09:31 +0000
Subject: [PATCH v7] gitk: add external diff file rename detection
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    tobias.boesch@miele.com,
    ToBoMi <tobias.boesch@miele.com>,
    Tobias Boesch <tobias.boesch@miele.com>

From: Tobias Boesch <tobias.boesch@miele.com>

If a file is renamed between commits and an external diff is started
through gitk on the original or the renamed file name,
gitk is unable to open the renamed file in the external diff editor.
It fails to fetch the renamed file from git, because it fetches it
using its original path in contrast to using the renamed path of the
file.
Detect the rename and open the external diff with the original and
the renamed file instead of no file (fetch the renamed file path and
name from git) no matter if the original or the renamed file is
selected in gitk.

Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
---
    gitk: add external diff file rename detection
    
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
    
    Changes since v3:
    
     * Changed message to use present tense, removed bullet points and
       described changes in imperative mood
    
    Changes sine v4:
    
     * Use a git command to gather the changed file paths rather than
       parsing the text from the diff window panel for efficiency and to
       avoid regex containing the filename as a variable.
     * Change != to ne in string comparison
     * removed extra set of parentheses around &&
     * shorter variable names
    
    Changes sine v5:
    
     * Include filename in rename check. Find only the file and its renamed
       version that is selected in the GUI.
     * Escape special characters in the filename to prevent that they are
       intepreted as part of a regular expression
    
    Changes since v6:
    
     * Don't extra mention moved files in commit message
     * Create empty list properly (avoid creting a list containing an empty
       string)
     * Avoid snake case in variable names
     * Change logic that checks the renames and gathers the file paths to
       use the difffilestart variable for efficient file path extraction
     * Removed underscores in file names

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v6:

 1:  f1c71e5632 ! 1:  7c09a28951 gitk: add external diff file rename detection
     @@ Commit message
          the renamed file instead of no file (fetch the renamed file path and
          name from git) no matter if the original or the renamed file is
          selected in gitk.
     -    Since moved or renamed file are handled the same way do this also
     -    for moved files.
      
          Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
      
     @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {
                      "revision $diffid"]
       }
       
     -+proc check_for_renames_in_diff {diffidfrom diffidto filepath} {
     -+    global nullid nullid2
     ++proc check_for_renames_in_diff {filepath} { # renames
     ++    global difffilestart ctext
      +
     -+    if {$diffidfrom eq $nullid} {
     -+        set rev [list $diffidto -R]
     -+    } elseif {$diffidfrom eq $nullid2} {
     -+        set rev [list $diffidto --cached -R]
     -+    } elseif {$diffidto eq $nullid} {
     -+        set rev [list $diffidfrom]
     -+    } elseif {$diffidto eq $nullid2} {
     -+        set rev [list $diffidfrom --cached]
     -+    } else {
     -+        set rev [list $diffidfrom..$diffidto]
     -+    }
     -+
     -+    set renames [list {}]
     -+    if {[catch {eval exec git diff $rev --find-renames --stat --raw --diff-filter=R} cmd_result]} {
     -+        error_popup "[mc "Error getting file rename info for file \"%s\" from commit %s to %s." \
     -+                            $filepath $diffidfrom $diffidto] $cmd_result.\n\n"
     -+    }
      +    set filename [file tail $filepath]
     -+    set esc_chars {\\ | ? ^ * . $ \[ \] + \( \) \{ \}}
     -+    foreach char $esc_chars {
     -+        set filename [string map [list $char \\$char] $filename]
     -+    }
     -+    set regex_base {\d+\s\d+\s\S+\s\S+\s\S+\s+}
     -+    set regex_ren_from $regex_base[subst -nobackslashes -nocommands {(\S+$filename)\s+(\S+)}]
     -+    set regex_ren_to $regex_base[subst -nobackslashes -nocommands {(\S+)\s+(\S+$filename)}]
     -+    if {[regexp -line -- $regex_ren_from $cmd_result whole_match ren_from ren_to]} {
     -+        if {$ren_from ne {} && $ren_to ne {}} {
     -+            lappend renames $ren_from
     -+            lappend renames $ren_to
     -+        }
     -+    } elseif {[regexp -line -- $regex_ren_to $cmd_result whole_match ren_from ren_to]} {
     -+        if {$ren_from ne {} && $ren_to ne {}} {
     -+            lappend renames $ren_from
     -+            lappend renames $ren_to
     ++    set renames {}
     ++    
     ++    foreach loc $difffilestart {
     ++        set loclineend [string map {.0 .end} $loc]
     ++        set ctextline [$ctext get $loc $loclineend]
     ++        if {[string first $filename $ctextline] != -1} {
     ++            set fromlineloc "$loc + 2 lines"
     ++            set tolineloc "$loc + 3 lines"
     ++            set renfromline [$ctext get $fromlineloc [string map {.0 .end} $fromlineloc]]
     ++            set rentoline [$ctext get $tolineloc [string map {.0 .end} $tolineloc]]
     ++            if {[string match "rename from *" $renfromline]
     ++                && [string match "rename to *" $rentoline]} {
     ++                set renfrom [string range $renfromline 12 end]
     ++                set rento [string range $rentoline 10 end]
     ++                lappend renames $renfrom
     ++                lappend renames $rento
     ++                break
     ++            }
      +        }
      +    }
     ++    
      +    return $renames
      +}
      +
     @@ gitk-git/gitk: proc external_diff {} {
           # gather files to diff
      -    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
      -    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
     -+    set renamed_filenames [check_for_renames_in_diff $diffidfrom $diffidto $flist_menu_file]
     -+    set rename_from_filename [lindex $renamed_filenames 1]
     -+    set rename_to_filename [lindex $renamed_filenames 2]
     -+    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
     -+        set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
     -+        set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
     ++    set renames [check_for_renames_in_diff $flist_menu_file]
     ++    set renamefrom [lindex $renames 0]
     ++    set renameto [lindex $renames 1]
     ++    if { ($renamefrom != {}) && ($renameto != {}) } {
     ++        set difffromfile [external_diff_get_one_file $diffidfrom $renamefrom $diffdir]
     ++        set difftofile [external_diff_get_one_file $diffidto $renameto $diffdir]
      +    } else {
      +        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
      +        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]


 gitk-git/gitk | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index c02db0194d..8f8f1cb9ab 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3788,6 +3788,34 @@ proc external_diff_get_one_file {diffid filename diffdir} {
                "revision $diffid"]
 }
 
+proc check_for_renames_in_diff {filepath} { # renames
+    global difffilestart ctext
+
+    set filename [file tail $filepath]
+    set renames {}
+    
+    foreach loc $difffilestart {
+        set loclineend [string map {.0 .end} $loc]
+        set ctextline [$ctext get $loc $loclineend]
+        if {[string first $filename $ctextline] != -1} {
+            set fromlineloc "$loc + 2 lines"
+            set tolineloc "$loc + 3 lines"
+            set renfromline [$ctext get $fromlineloc [string map {.0 .end} $fromlineloc]]
+            set rentoline [$ctext get $tolineloc [string map {.0 .end} $tolineloc]]
+            if {[string match "rename from *" $renfromline]
+                && [string match "rename to *" $rentoline]} {
+                set renfrom [string range $renfromline 12 end]
+                set rento [string range $rentoline 10 end]
+                lappend renames $renfrom
+                lappend renames $rento
+                break
+            }
+        }
+    }
+    
+    return $renames
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
@@ -3818,8 +3846,16 @@ proc external_diff {} {
     if {$diffdir eq {}} return
 
     # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    set renames [check_for_renames_in_diff $flist_menu_file]
+    set renamefrom [lindex $renames 0]
+    set renameto [lindex $renames 1]
+    if { ($renamefrom != {}) && ($renameto != {}) } {
+        set difffromfile [external_diff_get_one_file $diffidfrom $renamefrom $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $renameto $diffdir]
+    } else {
+        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
+        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    }
 
     if {$difffromfile ne {} && $difftofile ne {}} {
         set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]

base-commit: 57da342c786f59eaeb436c18635cc1c7597733d9
-- 
gitgitgadget
