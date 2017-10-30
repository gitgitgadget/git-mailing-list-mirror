Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D67C1FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbdJ3RWA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:22:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:52909 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbdJ3RV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:21:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id b15so17069262qkg.9
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fSOuiDME45n2JYV4IRkdBrfPRWJheXBlRSRAgWCyco=;
        b=VqJaDtFqWqmk/VSFxoCy7F6wkksQrXwundh/jQjDnybPzZsWIorfILg/q/xjAcJb80
         1wG9nzXDzj20xoXuou9gIPd1GN/mDXK+1Nvxu7OT8BYO1UQ1NWeBpG2Qyjk1ZgtY+0Gz
         Vwuv/Sma5o+xdDxKhe6SQchAwwkrUNWia07w26TS3IWPM6AzLjHHH0Ep6bC6/RmnM0bX
         qxp391Mrl5DJwzk4XbN77DePXoa61ZTLC5I3Euf0L4XC8Ko3USgl2IvBu61jqkE1VHLM
         zYTm0MFH6RnjY6DORj4AFGzavQXUhxI1a94iUcOnmjF6RUH6hokqY7yE0cqFrGzEvOpY
         CSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fSOuiDME45n2JYV4IRkdBrfPRWJheXBlRSRAgWCyco=;
        b=hpUfmgcNzediRvLlmx18XTFMPCiAF4P72x2uzmhJng9iQMY5YaFqMmSXe/aKwhNKIu
         a5brs7t1hFj8cw4p5vsMh6cMq0MCG1JCUoPbMwbERvInvitrDkMLemM/jEtwFloNTHp4
         9kDGQr0vKogyXHSaiwOCe0vtXKDVO1ZZmcnZmvRwzKnAtildIHz5qN1jk8IISuuux4AO
         E6CGhpLrwxW4L77+Zoc5UPVRhGgLS6XHJbGNfYWB7UOQhGRhKPONdvRirwaVm9WSb3CE
         R1Fczu4IHInc/jxa2wUIw+nTT5uMwavfdhWxe81FI4DqkcWqWFAJo+xKGKorXY1LBLUB
         J9IA==
X-Gm-Message-State: AMCzsaW7BXGlcHKpKypBUfGMb6CNgMN4qI5AC+9TPcW+t4eouQKGw/9q
        YW+7nrGaZQVP4/MmeWcs64M=
X-Google-Smtp-Source: ABhQp+TMChYrX96/5JDS7ma9NxQw5yTmdJNfOFaDCVL6xCv5tUYC98V+KJiX9j4aRRg3+XoNKP2C+g==
X-Received: by 10.55.15.32 with SMTP id z32mr14593993qkg.2.1509384117928;
        Mon, 30 Oct 2017 10:21:57 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id n23sm9670119qka.1.2017.10.30.10.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 10:21:57 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v5 3/4] status: document options to show matching ignored files
Date:   Mon, 30 Oct 2017 13:21:39 -0400
Message-Id: <20171030172140.235797-4-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171030172140.235797-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171030172140.235797-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

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

