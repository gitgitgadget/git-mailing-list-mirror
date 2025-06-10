Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC317A2F3
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544180; cv=none; b=bCeR4WV/uZCCn1aXCi3BNfV3OwUKnuBFPDPR6TOFQ8Rw6wiNUZAcK9Avk6pZZRm8QSikXt+I6oPckKVezXOFJiE9zr4sYe7xDRumorb17UpN2utIJuk4PN1h2aXayvDiJT71TSOOtiQn7R63z6r0eyJSI6T018xoiU6B/gk1biQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544180; c=relaxed/simple;
	bh=zxBYOrLZ2yIcPNMljVQ80Ao7DZb75iMXIJkaiSzfmhA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PS32TEo+R2gvyavZOBRI9IrNf/25YNQylsp2R8V+UwaPsTqjxS8uVXQmaw6Lo0acZleii+xyEcp6ylBa/nlqkxDmXcNrcyPgaSfEcHnGIwnMALXRSH1+ahf8k92an9qmdIcu7fYsaLBVAXKoRZVG4Ca7M+4gwV5DoS2+lRhbcag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbHZqv3q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbHZqv3q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442fda876a6so45767405e9.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749544177; x=1750148977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMlat8lbNcsoqwayvBcfjTHOSYmT+YK59//M7S4qiX4=;
        b=UbHZqv3qfrYwUT434rjNxuvXlGJhStRoTsbSlElfu8mbY5WastnBpafD76Bf+DUfLp
         Vs9YdfS/XEaNYnYsQFpRaVuSL8VNnFHLzHO6sSklL0ujE5kKIu5uvRFuH1A6iXSLmmAj
         2qFMve5gce1pIrxaaulR1n3EQ3ELyx/xt45w+l7NeAZ3nv3R2wqcbdgLVW05Wh7JAgwV
         WtZgZscyp+EgrzOk31MxgVgIzXKV/QBMoQ4BqBGF3ILYiWlE9eI5YIf8q3XBJTM689rC
         WYMw1Sogx+/KVgmgbUebZxkiaFJmHg/vlDWHZb1Y6FOmXElaZpj1dZ9hPALiH6HaSIRI
         DKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749544177; x=1750148977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMlat8lbNcsoqwayvBcfjTHOSYmT+YK59//M7S4qiX4=;
        b=eYYt5ZAXFmuTJAdxP1uGKbrMhdxtKYsMXOUnapyg0G8m2AZcysZJXwWyhGb2JxRdAF
         Bg1la+FYhpDPnlO2ymcEZNRnv4/oorBIWFAGe4ymaMVxWAHwVVLtIY7syi/4izclJ2cd
         24s1N7OOuAineT86Thzq5tjcd35fkusuWEQTLBY6Vhm6OvSAPC9d69iklSxKNKbfEEO0
         6AJP5ihUgq6WeGM+NlEo2YXU2VugIkbHLYkYevDuqzm6aFxtP6rDzFiQjiKQWByE5+t9
         LO847GjFYZ88WADT4e1Pg1OUuxDpCCbrjhbnn0NpoOsi6zyWrnzRm2t9Z5J2s7rRmW4T
         fO0g==
X-Gm-Message-State: AOJu0YwGyX89ksFanfZdh8RpRjC8KMNmwHh+xmBCMcZfcZ2t1zKZxWvl
	3UounYnVJi2dX7zCnq4uUw7dLWvC+w7z2M9Lmw1zDJGjs8BfNbqwf8mxWBaFdw==
X-Gm-Gg: ASbGncto8Z00aUSIYEw7DZupKcK/VHG3Io/9SCdjC/rSVz3+L3jQsbLWM/LC582pbhl
	/7w7z2Bf+VjVSQzNmFcyjb8pwQPz2RIxgQlbJeYtNty2YXpTz/PBW7jmFJ4JoP0uMyXZid690Pk
	ecrpueEthyvq8sOXq4wArVWDHuUY2VEiqRry1C64ImD8s4BJG8Lmw7ThIcV5UIGT5diLyhMco7N
	ue7UqEtG3PH5jQZXVz7Qh4CkkrA5KCjqzMX6oAXAbN6/5zROUAeF1Hzm6oBMGnFO/MM0NBy8DTi
	vX78vICq02IQ3u5bEOsmUhUzy357IZkRjxNocG2ddMvsTaEiWzmX5T7ESQn1FSMR6JvI3bietQ=
	=
X-Google-Smtp-Source: AGHT+IGHmy+bwzmXcz8ROd2uXKMUrgq3YFTqdi7fBAVT3FtVXGIKbMgnvLUTvUkc8osGmxwwSqDNcg==
X-Received: by 2002:a05:600c:c4b7:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-4520137c932mr133611985e9.19.1749544176519;
        Tue, 10 Jun 2025 01:29:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de53sm11545905f8f.8.2025.06.10.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:29:35 -0700 (PDT)
Message-Id: <pull.1774.v5.git.1749544174590.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.v4.git.1745830037917.gitgitgadget@gmail.com>
References: <pull.1774.v4.git.1745830037917.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Jun 2025 08:29:34 +0000
Subject: [PATCH v5] gitk: add external diff file rename detection
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
Since moved or renamed file are handled the same way do this also
for moved files.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v4:

 1:  948b94bef5c ! 1:  0d28f189dc3 gitk: add external diff file rename detection
     @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {
                      "revision $diffid"]
       }
       
     -+proc check_for_renames_in_diff {filepath} {
     -+    global ctext
     ++proc check_for_renames_in_diff {diffidfrom diffidto filepath} {
     ++    global nullid nullid2
      +
     -+    set renamed_filenames [list {}]
     -+    set filename [file tail $filepath]
     -+    set rename_from_text_identifier_length 12
     -+    set rename_to_text_identifier_length 10
     -+    set reg_expr_rename_from {^rename from (.*$filename)}
     -+    set reg_expr_rename_from [subst -nobackslashes -nocommands $reg_expr_rename_from]
     -+    set rename_from_text_index [$ctext search -elide -regexp -- $reg_expr_rename_from 0.0]
     -+    if { ($rename_from_text_index != {})} {
     -+        set reg_expr_rename_to {^rename to (.*)}
     -+        set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to $rename_from_text_index]
     -+        if { ($rename_from_text_index != {}) && ($rename_to_text_index != {}) } {
     -+            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
     -+            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
     -+        }
     -+        return $renamed_filenames
     ++    if {$diffidfrom eq $nullid} {
     ++        set rev [list $diffidto -R]
     ++    } elseif {$diffidfrom eq $nullid2} {
     ++        set rev [list $diffidto --cached -R]
     ++    } elseif {$diffidto eq $nullid} {
     ++        set rev [list $diffidfrom]
     ++    } elseif {$diffidto eq $nullid2} {
     ++        set rev [list $diffidfrom --cached]
     ++    } else {
     ++        set rev [list $diffidfrom..$diffidto]
      +    }
     -+    set reg_expr_rename_to {^rename to (.*$filename)}
     -+    set reg_expr_rename_to [subst -nobackslashes -nocommands $reg_expr_rename_to]
     -+    set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to 0.0]
     -+    if { ($rename_to_text_index != {})} {
     -+        set reg_expr_rename_from {^rename from (.*)}
     -+        set rename_from_text_index [$ctext search -backwards -elide -regexp -- $reg_expr_rename_from $rename_to_text_index]
     -+        if { ($rename_to_text_index != {}) && ($rename_from_text_index != {}) } {
     -+            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
     -+            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
     ++
     ++    set renames [list {}]
     ++    if {[catch {eval exec git diff $rev --find-renames --stat --raw --diff-filter=R} cmd_result]} {
     ++        error_popup "[mc "Error getting file rename info for file \"%s\" from commit %s to %s." \
     ++                            $filepath $diffidfrom $diffidto] $cmd_result.\n\n"
     ++    }
     ++    set filename [file tail $filepath]
     ++    set regex_ren {\d+\s\d+\s\S+\s\S+\s\S+\s+(\S+)\s+(\S+)}
     ++    set regex_ren [subst -nobackslashes -nocommands $regex_ren]
     ++    if {[regexp -line -- $regex_ren $cmd_result whole_match ren_from ren_to]} {
     ++        if {$ren_from ne {} && $ren_to ne {}} {
     ++            lappend renames $ren_from
     ++            lappend renames $ren_to
      +        }
     -+        return $renamed_filenames
      +    }
     ++    return $renames
      +}
      +
       proc external_diff {} {
     @@ gitk-git/gitk: proc external_diff {} {
           # gather files to diff
      -    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
      -    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
     -+    set renamed_filenames [check_for_renames_in_diff $flist_menu_file]
     ++    set renamed_filenames [check_for_renames_in_diff $diffidfrom $diffidto $flist_menu_file]
      +    set rename_from_filename [lindex $renamed_filenames 1]
      +    set rename_to_filename [lindex $renamed_filenames 2]
      +    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {


 gitk-git/gitk | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 19689765cde..f97904f5fa2 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3775,6 +3775,38 @@ proc external_diff_get_one_file {diffid filename diffdir} {
                "revision $diffid"]
 }
 
+proc check_for_renames_in_diff {diffidfrom diffidto filepath} {
+    global nullid nullid2
+
+    if {$diffidfrom eq $nullid} {
+        set rev [list $diffidto -R]
+    } elseif {$diffidfrom eq $nullid2} {
+        set rev [list $diffidto --cached -R]
+    } elseif {$diffidto eq $nullid} {
+        set rev [list $diffidfrom]
+    } elseif {$diffidto eq $nullid2} {
+        set rev [list $diffidfrom --cached]
+    } else {
+        set rev [list $diffidfrom..$diffidto]
+    }
+
+    set renames [list {}]
+    if {[catch {eval exec git diff $rev --find-renames --stat --raw --diff-filter=R} cmd_result]} {
+        error_popup "[mc "Error getting file rename info for file \"%s\" from commit %s to %s." \
+                            $filepath $diffidfrom $diffidto] $cmd_result.\n\n"
+    }
+    set filename [file tail $filepath]
+    set regex_ren {\d+\s\d+\s\S+\s\S+\s\S+\s+(\S+)\s+(\S+)}
+    set regex_ren [subst -nobackslashes -nocommands $regex_ren]
+    if {[regexp -line -- $regex_ren $cmd_result whole_match ren_from ren_to]} {
+        if {$ren_from ne {} && $ren_to ne {}} {
+            lappend renames $ren_from
+            lappend renames $ren_to
+        }
+    }
+    return $renames
+}
+
 proc external_diff {} {
     global nullid nullid2
     global flist_menu_file
@@ -3805,8 +3837,16 @@ proc external_diff {} {
     if {$diffdir eq {}} return
 
     # gather files to diff
-    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
-    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
+    set renamed_filenames [check_for_renames_in_diff $diffidfrom $diffidto $flist_menu_file]
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

base-commit: 14de3eb34435db79c6e7edc8082c302a26a8330a
-- 
gitgitgadget
