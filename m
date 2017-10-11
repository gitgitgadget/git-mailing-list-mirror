Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097EF1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757453AbdJKNf0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:35:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:55761 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbdJKNfV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:35:21 -0400
Received: by mail-qt0-f196.google.com with SMTP id x54so5102472qth.12
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wy/Ch3aooRHa29rlWLMfV674hGg6mPZe0jwOrN3dYPo=;
        b=GH1WqYlUiIjNvmdFx4+xpL5hluXKUPd7zUlqxmKp1OkvE2CfWSbR6P5zac2BdCcvQ8
         hjKgU1TX7Ya6aF6oU1fiN84XZtP0npwhyorkU/hnHSxVRUGbiQ6eHuIH9I1dtowDsOb2
         iIKOGgCSPVMOg9cr5PmiJMKTBdwHdFzvIgmwnqN83suWKmkMH5rJ6XhGMPPlsyIKjsOs
         TblUcxe4j21qwnNnQbCxRZPV59jm4x5GP7Ds65R778/GWJskp9u7h5k9ipX651lRsTjW
         jTE9kv8mmLOJvD6n7rf+zhI0QksgX2TurHdyurfUQgyHkXqObgw7pS1zj70WKC4OdTHP
         SZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wy/Ch3aooRHa29rlWLMfV674hGg6mPZe0jwOrN3dYPo=;
        b=Y/KhX21YLchhUsbwWq/urI9MAR7b0CGKi27ZlekDjuqV1BPPTJyCbX2mmUYOTtjzVP
         7F4SvQX3YErb/JO2k3bZYivuvjFdW/bJX2Gdolrix0h24dv1kniR4xBvGITO+1fsG7d5
         H3PMsz3FG5iDLLlPJ4JXUF1Lv2HCe+Ku55VtO62uZJIvt7aXFxHBxiUvfTaFfxMf39fr
         yM4WPHCB1SZ3nfnuyigTDFoh45mCJIt7wYe6A3k2wNita2XbHCkxVE0DPFc/K/HTh5bt
         sb2TihZwbf8Jrjs7vfRZyK8UL718KXKmElObe3x8WurpOKDOdZ39R91g7Yi/XwOO08Fo
         ah6w==
X-Gm-Message-State: AMCzsaUAuZ+I/jwA+L/p1W6RL2jfU1f9YtGOhvpA+r9gKqDkIMxxCJY1
        7HPOhShQ8jnGHjoM3lYGX/A=
X-Google-Smtp-Source: AOwi7QA7B4zDfNDhVkpmXwmHpusyPbkfEjH20c2YTcDIfm86D+G3dQny0/Aav4HgWua44GdlEb3O3w==
X-Received: by 10.200.34.28 with SMTP id o28mr25389451qto.184.1507728920947;
        Wed, 11 Oct 2017 06:35:20 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id i1sm8192685qta.19.2017.10.11.06.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 06:35:20 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v2 2/5] Update documentation for new directory and status logic
Date:   Wed, 11 Oct 2017 09:35:01 -0400
Message-Id: <20171011133504.15049-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171011133504.15049-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Documentation/git-status.txt                      | 21 +++++++++++++++++-
 Documentation/technical/api-directory-listing.txt | 27 +++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f3a78a36c..fc282e0a92 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -97,8 +97,27 @@ configuration variable documented in linkgit:git-config[1].
 	(and suppresses the output of submodule summaries when the config option
 	`status.submoduleSummary` is set).
 
---ignored::
+--ignored[=<mode>]::
 	Show ignored files as well.
++
+The mode parameter is used to specify the handling of ignored files.
+It is optional: it defaults to 'traditional'.
++
+The possible options are:
++
+	- 'traditional' - Shows ignored files and directories, unless
+			  --untracked-files=all is specifed, in which case
+			  individual files in ignored directories are
+			  displayed.
+	- 'no'	        - Show no ignored files.
+	- 'matching'    - Shows ignored files and directories matching an
+			  ignore pattern.
++
+When 'matching' mode is specified, paths that explicity match an
+ignored pattern are shown. If a directory matches an ignore pattern,
+then it is shown, but not paths contained in the ignored directory. If
+a directory does not match an ignore pattern, but all contents are
+ignored, then the directory is not shown, but all contents are shown.
 
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 6c77b4920c..7fae00f44f 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -22,16 +22,20 @@ The notable options are:
 
 `flags`::
 
-	A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
+	A bit-field of options:
 
 `DIR_SHOW_IGNORED`:::
 
-	Return just ignored files in `entries[]`, not untracked files.
+	Return just ignored files in `entries[]`, not untracked
+	files. This flag is mutually exclusive with
+	`DIR_SHOW_IGNORED_TOO`.
 
 `DIR_SHOW_IGNORED_TOO`:::
 
-	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
-	in addition to untracked files in `entries[]`.
+	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
+	`ignored[]` in addition to untracked files in
+	`entries[]`. This flag is mutually exclusive with
+	`DIR_SHOW_IGNORED`.
 
 `DIR_KEEP_UNTRACKED_CONTENTS`:::
 
@@ -39,6 +43,21 @@ The notable options are:
 	untracked contents of untracked directories are also returned in
 	`entries[]`.
 
+`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
+
+	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
+	this is set, returns ignored files and directories that match
+	an exclude pattern. If a directory matches an exclude pattern,
+	then the directory is returned and the contained paths are
+	not. A directory that does not match an exclude pattern will
+	not be returned even if all of its contents are ignored. In
+	this case, the contents are returned as individual entries.
++
+If this is set, files and directories that explicity match an ignore
+pattern are reported. Implicity ignored directories (directories that
+do not match an ignore pattern, but whose contents are all ignored)
+are not reported, instead all of the contents are reported.
+
 `DIR_COLLECT_IGNORED`:::
 
 	Special mode for git-add. Return ignored files in `ignored[]` and
-- 
2.13.6

