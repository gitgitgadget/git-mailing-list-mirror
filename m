Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3222FE11
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830044; cv=none; b=uQo21vIDbyvTzV8DltnfhoxNC1ZAQJ2ozqblXhw137KWas4tfr9FX7r0f39g9lNFQjm/wM4dQvOlns9hLubgsniYKhV+OEfoPTfmn+itHciHPg6JvFe5SJ2/K3WcB3Vg1JvRv5vkLKyqn0ZzVf40NEOQTqLCCTANCUPq7vHhJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830044; c=relaxed/simple;
	bh=Zgf+BRvZ3qpYzxwL/l5kQILjQZ73yqQFpI3OLFkZaXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IfF3JpbUc4+QXLZwZ7TbxgaexIOOWPsLWvU+4+2AZxtxemoWEbxCmK+jivBsHFkxcvsIOyq25gpdAf11zF/6yV3mf1Zs5YNML9bGglA0GcF+YFdensk1AcIdz2L++Hw+Su3pbbckOO4qAK+Bno1ZW9kobqqJqiJTHG+qxvbGDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv+jrR2e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv+jrR2e"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso29824765e9.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745830040; x=1746434840; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZRZd0aKl7Wd052zx/2T6n3bvs2LoghL1HrPfoNJM6w=;
        b=kv+jrR2edINdP/dFcBiU+tbreqmfIlbc3c0oe3FVAHjHk506Y+L2IZwe0AfTlbANId
         saBr/KeI6fWXMKWvq1egMzc0tNO2sNd7nzFt6b//NHBElp/4q07LGPEmDv3H63Lgw5Zh
         hvgzzF4dEkSKeqS1tCU/fa2yrurJO524XdQMCRqRInCx73KV1Bm+OlQ86/UX7fWvrAu/
         nFf4QqrBCmvIS//fPvfmEtDEJIeRA1nNdL9+kyUQF2Obr3BjcpPljH09q1VM4dOSsafC
         RRbzw3ctq5+21aWhnzOONiDrRIjBrGfyA6XWPtFsSBmLlLEEkM9tAyPJg3lJRS5MSpXb
         px3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745830040; x=1746434840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZRZd0aKl7Wd052zx/2T6n3bvs2LoghL1HrPfoNJM6w=;
        b=DEoFVDRPBdBepj9n89QRhsA1LA30gVWTZpbrQNuJWFA3KCdGWq4k4+C/dxyLUv72W6
         aBedEEj0uu8/XgXyRISv4Ku8mOquIH7VvkQaMeZdkowXF1/POFW8q59OuYbkyppYyuy9
         XdSszGMg/ZSTN1LDpxyTgdoFYEV7fEHRzMhdzpLw63WqpCJhJAwFnUG11lQTcC4kBKgU
         jhGF07M9iwgxxYL1OV2321B64wvSCFzNLhoNgCOifiTobVE18W7Q+QStieZHawC4ZHD0
         anpVDCGrb+xPerJYY1DuCtW+/pATpclr9XFJNEpmnhGSp81eNYgh5gMlXM/pWat3M97h
         aufg==
X-Gm-Message-State: AOJu0YwraFfKySnojVYMml2fpCQbL9XYDpFzYmF0eX1GmNy7yNUi7pzY
	rtNt/qzsCHVGoAzT3s+KmZBehdZWTXhFHqkQ4nUMf4uboFFy9rRnUMG93w==
X-Gm-Gg: ASbGncvBNfGEYcsHkK/wuspgXBbPK7OS1oH84bQVOlaEBchuJ3jSPBepjfCQQ5JUIH/
	VAvsnSHxM2Cc6N6lvDTxyFbtZ1MpyhDDTRdGvmv0k3YBSS/jWt0dZsykRR7fhVJJyFdwpE9Xfcc
	0ppjV50kGreMceEjfnoawqUN6iur9STRDKaJMIdtTXhFS+EiGaE8gpffNVSvYgkxnB05n7bMWSU
	ByGiAPljjXhtJKaN1QAzhkrMPlrHxIv7IMVBVJ5qZNZVkYaL5SoHY+6LDSsA6Tj0JMSRNMq6fas
	XxbWQqJoz0uy0bT5zhybbOn6j+VnbZq+IMXVcjMEEg==
X-Google-Smtp-Source: AGHT+IHTBuuAIaw5PhvPd1WNrRD1ui+jBqWp+YI+yuAcXU8r+yA2w/R3qY3gQMMLSF0SlaEIF/WSwA==
X-Received: by 2002:a05:600c:1988:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-440a669ed2dmr76104125e9.21.1745830039593;
        Mon, 28 Apr 2025 01:47:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e00d8sm147356025e9.35.2025.04.28.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 01:47:19 -0700 (PDT)
Message-Id: <pull.1774.v4.git.1745830037917.gitgitgadget@gmail.com>
In-Reply-To: <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
References: <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 08:47:17 +0000
Subject: [PATCH v4] gitk: add external diff file rename detection
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1774%2FToBoMi%2Fdetect_renamed_files_when_opening_diff-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1774/ToBoMi/detect_renamed_files_when_opening_diff-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1774

Range-diff vs v3:

 1:  1a64e989713 ! 1:  948b94bef5c gitk: added external diff file rename detection
     @@ Metadata
      Author: Tobias Boesch <tobias.boesch@miele.com>
      
       ## Commit message ##
     -    gitk: added external diff file rename detection
     +    gitk: add external diff file rename detection
      
     -    * If a file was renamed between commits and an external diff is started
     -      through gitk on the original or the renamed file name,
     -      gitk was unable to open the renamed file in the external diff editor.
     -      It failed to fetch the renamed file from git, because it fetched it
     -      using its original path in contrast to using the renamed path of the
     -      file.
     -    * With this change gitk detects the rename and opens the external diff
     -      with the original and the renamed file instead of no file (it is able
     -      to fetch the renamed file path and name now from git).
     -    * Since git doesn't destinguish between move or rename this also works
     -      for moved files.
     -    * Showing the external diff with the original and the renamed file
     -      works when either of the files is selected in gitk.
     +    If a file is renamed between commits and an external diff is started
     +    through gitk on the original or the renamed file name,
     +    gitk is unable to open the renamed file in the external diff editor.
     +    It fails to fetch the renamed file from git, because it fetches it
     +    using its original path in contrast to using the renamed path of the
     +    file.
     +    Detect the rename and open the external diff with the original and
     +    the renamed file instead of no file (fetch the renamed file path and
     +    name from git) no matter if the original or the renamed file is
     +    selected in gitk.
     +    Since moved or renamed file are handled the same way do this also
     +    for moved files.
      
          Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
      


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

base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
-- 
gitgitgadget
