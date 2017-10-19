Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75C4202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbdJSQGW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:06:22 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:55335 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbdJSQGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:06:19 -0400
Received: by mail-qk0-f193.google.com with SMTP id x82so10973645qkb.12
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wy/Ch3aooRHa29rlWLMfV674hGg6mPZe0jwOrN3dYPo=;
        b=Ue+wA7fFH/u0oLX6Oy5ScNtoo3O+33LKhQlS7Ytx4nlvH9Rm4Xk0AYusr1qGxQUmwp
         fzrSaIxHM0VbNwSBiD5XpkVO5P8CD/KZhdrYSzstsOTjO8gVklJ4VWFKt5Tjk+R3myhs
         5ikO/1LqPh9RZf3dt2nZo1q8VCPciKhGDBK5SWToVCCUdseO5jNabPjj3vDZx0hfyqb5
         NpnK+0F4l8qHygePa8ahBENLtspkR7qlKjZmgAUghQTlSqtbeTzSfezPH9xnYvteGrfN
         8U6WYczhj3ZCXAHXCsIpqBClJThOK41Kp0Hv/Ce9ysi2J5D6o56YwpWWlwR+ZadRnb/T
         zQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wy/Ch3aooRHa29rlWLMfV674hGg6mPZe0jwOrN3dYPo=;
        b=gT+xn4/NNzpL59WMxjuPFEbZb4KnRRwSfBs+qN811s3nPhxm+xJ0AoF726eTffMUH9
         y3YMAo1KknbXLZSsv9uMPUhIm6cFYyyDTv23ypvrP70T5fTNi5NS3pabvEuF8+l5yGQU
         sMOtf+u2P3OjNNM3fYRvXMilOieFXr9wem7MJTXgoIKdSPm+dQFtrvwFwcAHQfJd57D6
         bOe9PPkKuIZVzV0zOr+wazA9kRWhnYfGMnXGRYZ0WS8wnZGwlCCQC4lCh7i8gLhoR93c
         AyN0L9+k2aP3z24q7cf1Wq8my8TLLtx1zlxjt98XH2Flv5K40+1AliCixlIzJdWZgo/y
         cajw==
X-Gm-Message-State: AMCzsaXiEewIuqlZ+wxuAdJ3jriiXdGc9v1aUhWlZUokPwo4IbXxFAyF
        6ZwtnU5zBtLKySEUZjm2kw4=
X-Google-Smtp-Source: ABhQp+SagwwzblBaOUu6zu8+QEy7VL2r0nmxYJ9yHWYiBPHAM3SE6n35MRC2fCcZNL9n/jG1UZwXKg==
X-Received: by 10.55.15.139 with SMTP id 11mr2595242qkp.141.1508429179119;
        Thu, 19 Oct 2017 09:06:19 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id c13sm9377085qka.50.2017.10.19.09.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 09:06:18 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v3 3/4] status: document options to show matching ignored files
Date:   Thu, 19 Oct 2017 12:06:00 -0400
Message-Id: <20171019160601.9382-4-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171019160601.9382-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171019160601.9382-1-jamill@microsoft.com>
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

