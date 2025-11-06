Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BC33FE2B
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440137; cv=none; b=tvlORhVh0VsliuSqvKPBnJCYyUs1RFNOrsiVPcDa59I61XpdzQFBi4gM/ZhREhyCKcPs06U17BIX5Gz0KHU68Z38aufpAZ9mDyTK81EB/nsyW+HmaUXM34NIouTTxP3p+/OUlEaPGekfKq8fqpvMgWzdK20udK5Wdqqw4No2JfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440137; c=relaxed/simple;
	bh=NbCNTL8WVoC9r0T09lURmPS1hZEC7Ko8JxtAg3HQO3k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PKIcPeLxMGaQahbfmqyDNnqJECXoJv+RKPEE+dXTyq7ATkyAXlFJeFH9n2wN6ciFESWLkEkKqqPh15xiJigVh2soXJGFUpauiZ8uUb2WyxfiI+5OWaInYSbQ36iZz/u0G209DSGrz7elbix/41ImWttKWv4gkcVT7qBYaYcAPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyPe198D; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyPe198D"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b1bfd4b3deso97490885a.2
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762440133; x=1763044933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTt5N4ad0dodTJ8/mg5uhClJwqvVS8tC6YkDynPt7nI=;
        b=MyPe198DtM1jcoyjzsH8MGp/5nYt1FJ+xReuaknaX5J5WWcxTu3zFgj/m9B0hUT4Rc
         rZnB+FSHh5aCkubLs+nkmOjDbIiqN/1aAumNNgwzQw+9s1ILh1f6tep8OeWyLqMyE0ua
         3eNqJ8UA87uMj6laRmvB5DxH7RexUs9gBfZ00N+6+M23vK9CTWi0LbrdLcI7BfA01L7v
         P2pvPSDzpChbodIvLcxALyVX4wdHeIFN2NLmcR2FVpgHjzidy74zGu0is9CmqfytSJAG
         r7YODKb//5wMhQd7MIuDMYiKEfl1fENCwYqjpZ4D97jNIKixe6VTVkM5YyxtogpJR5ps
         VD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440133; x=1763044933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTt5N4ad0dodTJ8/mg5uhClJwqvVS8tC6YkDynPt7nI=;
        b=HrTmb1fzpLTjpCqqaL4BTVm3RJPW0EgSgguuWHwbvUeLPDJiiDehJwrG3KNVrWeJIa
         aVkvEBlYigKSIERmsOKKcIgl8yvc6i/ISkS2mOG89KjYfjH3xXIAqqfduvbz45KGxEOq
         1kvP96zjvZgQ3YlxfRbRFKDcGDDxcc+3qZ02IQG6iIzziv8JVHZW09B7ttfuDB30FUik
         JuanF2nNM0MzzLjWlTLAzuqGruMd5shD0C7qfLPjRmM4XXO/xOe4z0wGlMEzNQ3vZi65
         1+X9PnJT5ChUbLfhjnWOUnP9wVlgw56NRaobcWR08v2Mdmatidnd6OQIdoGvGrQE0nJ2
         k+MA==
X-Gm-Message-State: AOJu0YxUVWB2O0cPtUTiqzlX7ab3hoG5On6DcHWADCecLJ7AjM3FLhAX
	5vNNT3fvEO/6c4SP165vlbi/LYYihytk5Ym/yn49eqx1dpum3L9Fa1fV6K6WUQ==
X-Gm-Gg: ASbGncvU6sP62w+Qh1okVxXK9XoinvTKc/NV5b6aJRlLs47d0LNce2VvpziusLUmcCm
	QGsbCtdHEmJmQsLN3Ky1WcFLSWvNrhS02+UdN8K5lbFNhUv9SIFjAGuOFAZX5rJP3tzpsZ+mUIv
	MSq+1EOeUSGPIx9x+gvTWLhL02PGOMgbl7MYLRVfDcS8lFrh4GE/gDK/zR/FaRWYo+wJwDpXIGv
	Tm0tZSdFvukB4S2oc9y63dpM1i3G10akUQBqTw9Z+77Za/FU/peehFha0id8U8LnybORBinf+Ht
	q1VKQMaNrcVsMqiLTXb++f/m/sikUWmfzI5xxqZDJHSR26RV7LY+1vRlVDOnT0Xj9Czh4jhm4Nj
	7oqTJNGWe+Ie8Es5kBzYHb2LFlfVjLkVpiWSETHMLGveRDKFYUOsoIvf3npZdyPL9cETFnraQdO
	Ll2Rw+FU+d6k7FNg==
X-Google-Smtp-Source: AGHT+IH3wg11DnJ1SagEjxrBMvIht9ZBNFRlEa1XbNCk51g+kgLrpD4RU/VnLlaKks5ru1DDvkIM/g==
X-Received: by 2002:a05:620a:4709:b0:8b1:d8f5:6d08 with SMTP id af79cd13be357-8b2207ef0femr983138285a.0.1762440133103;
        Thu, 06 Nov 2025 06:42:13 -0800 (PST)
Received: from [127.0.0.1] ([48.211.212.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357ddd7fsm214588085a.27.2025.11.06.06.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:42:12 -0800 (PST)
Message-Id: <pull.1774.v8.git.1762440131635.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.v7.git.1761905371163.gitgitgadget@gmail.com>
References: <pull.1774.v7.git.1761905371163.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Nov 2025 14:42:11 +0000
Subject: [PATCH v8] gitk: add external diff file rename detection
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
    
    Changes since v7:
    
     * Find renames by checking the file names extracted from the "renamed
       from" and "renamed to" diff lines instead of the separator line (make
       rename detection also work when the original file was selected) (I
       checked this, but only in a repo where a file move occurred - that
       worked since the filename didn't change)
     * Change "string match" and wildcard to "string equal" with length
       parameter
     * Change empty list detection to use "ne" instead of "!=" and reduce
       parenthesis

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v7:

 1:  7c09a28951 ! 1:  6fe99eb5a3 gitk: add external diff file rename detection
     @@ gitk-git/gitk: proc external_diff_get_one_file {diffid filename diffdir} {
      +    
      +    foreach loc $difffilestart {
      +        set loclineend [string map {.0 .end} $loc]
     -+        set ctextline [$ctext get $loc $loclineend]
     -+        if {[string first $filename $ctextline] != -1} {
     -+            set fromlineloc "$loc + 2 lines"
     -+            set tolineloc "$loc + 3 lines"
     -+            set renfromline [$ctext get $fromlineloc [string map {.0 .end} $fromlineloc]]
     -+            set rentoline [$ctext get $tolineloc [string map {.0 .end} $tolineloc]]
     -+            if {[string match "rename from *" $renfromline]
     -+                && [string match "rename to *" $rentoline]} {
     -+                set renfrom [string range $renfromline 12 end]
     -+                set rento [string range $rentoline 10 end]
     -+                lappend renames $renfrom
     -+                lappend renames $rento
     ++        set fromlineloc "$loc + 2 lines"
     ++        set tolineloc "$loc + 3 lines"
     ++        set renfromline [$ctext get $fromlineloc [string map {.0 .end} $fromlineloc]]
     ++        set rentoline [$ctext get $tolineloc [string map {.0 .end} $tolineloc]]
     ++        if {[string equal -length 12 "rename from " $renfromline]
     ++            && [string equal -length 10 "rename to " $rentoline]} {
     ++            set renfrom [string range $renfromline 12 end]
     ++            set rento [string range $rentoline 10 end]
     ++                if {[string first $filename $renfrom] != -1
     ++                    || [string first $filename $rento] != -1} {
     ++                    lappend renames $renfrom
     ++                    lappend renames $rento
      +                break
      +            }
      +        }
     @@ gitk-git/gitk: proc external_diff {} {
      +    set renames [check_for_renames_in_diff $flist_menu_file]
      +    set renamefrom [lindex $renames 0]
      +    set renameto [lindex $renames 1]
     -+    if { ($renamefrom != {}) && ($renameto != {}) } {
     ++    if {$renamefrom ne {} && $renameto ne {}} {
      +        set difffromfile [external_diff_get_one_file $diffidfrom $renamefrom $diffdir]
      +        set difftofile [external_diff_get_one_file $diffidto $renameto $diffdir]
      +    } else {


 gitk-git/gitk | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index c02db0194d..90cbfd4ec1 100755
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
+        set fromlineloc "$loc + 2 lines"
+        set tolineloc "$loc + 3 lines"
+        set renfromline [$ctext get $fromlineloc [string map {.0 .end} $fromlineloc]]
+        set rentoline [$ctext get $tolineloc [string map {.0 .end} $tolineloc]]
+        if {[string equal -length 12 "rename from " $renfromline]
+            && [string equal -length 10 "rename to " $rentoline]} {
+            set renfrom [string range $renfromline 12 end]
+            set rento [string range $rentoline 10 end]
+                if {[string first $filename $renfrom] != -1
+                    || [string first $filename $rento] != -1} {
+                    lappend renames $renfrom
+                    lappend renames $rento
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
+    if {$renamefrom ne {} && $renameto ne {}} {
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
