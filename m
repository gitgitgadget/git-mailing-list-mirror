Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB9F1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbdJEUzT (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:50174 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdJEUzC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:02 -0400
Received: by mail-qt0-f196.google.com with SMTP id o3so27937744qte.6
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FUFDs2ffc0NQb/+kkaQBbsUqhPHCzs+RBig9DS98Hbc=;
        b=b5z1tDxGrj14ai7prFISStzQ7PS1U3wwIwZICIEeTjBrg7R1amrQ4gIo09mFpF2c76
         RfAj/PN7oDmr8XTmDBlGO08qBTbgZV+1+jZGydF8FFLtk8WEJsUjP0PZByESqZR5j2+0
         2vkin78cgp64x7TuIEw+pIwN//iRsD4DSqO0CHr7omqXl7zpGVnfUk3H8KIAzyJv1xLh
         +mHVxbFwdqRego5chAeRra/kBovFsdtm9foU9dNGp96RpwGh3EqwS1OTODRg0MbaPSlE
         o+PfOxfHW9cLfKG2Y0UzNOdlxBvteWPOQqnHV9RNDJo4eL3W5c3n5drYxb2EF+kd14vS
         QhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FUFDs2ffc0NQb/+kkaQBbsUqhPHCzs+RBig9DS98Hbc=;
        b=kq/OiETjFAxAfVLp7mlypRJ93a3tPfN6ctp3uGGp2X+uJHhSCUr00fqPIB9BN4yClS
         /VvCv9j1g+rSq37Pu1CMY8+vJmGdvPzN5HaF7pnV9S65b46e1TN9FjDIaF6rvv0IoZ5y
         aX6fiV+X9gVMG8lpNRmadAUQAjCbdFlWDoDK1wJVK+Pae90gyG7kMRxuR61bfjFBMcaJ
         pki+337iT5YZUxc/GCWOa0PLVAXSenE2nl4SNvCtsBmkg9H3mekfZbiXylk+u38wRnUL
         Kynj/s64F5+jdGECkoIFLru/aEFpNFPb0XR6w8qbtXhu5HGuJyEgfQmapsOMuZoSi2W8
         Wwew==
X-Gm-Message-State: AMCzsaV4UvzEaYTmYCuwNaY3rQRFE1Vi42qQOhHp7fao9ZRD6uBTVFV9
        I1ERDpWuqDD1cea4GjyNapmS5K5cDH4=
X-Google-Smtp-Source: AOwi7QCOfqPDjekhiCdYe0Et9i9k0t1f9sWwjkkkhDqYp1sq9cPdYhDda61LzCdNSfoNfEC6sdb5aA==
X-Received: by 10.200.34.28 with SMTP id o28mr451995qto.184.1507236901455;
        Thu, 05 Oct 2017 13:55:01 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:55:01 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 2/6] Update documentation for new directory and status logic
Date:   Thu,  5 Oct 2017 16:54:39 -0400
Message-Id: <20171005205443.206900-3-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Documentation/git-status.txt                      | 22 +++++++++++++++++-
 Documentation/technical/api-directory-listing.txt | 28 +++++++++++++++++++----
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f3a78a36c..7d1410ff3f 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -97,8 +97,28 @@ configuration variable documented in linkgit:git-config[1].
 	(and suppresses the output of submodule summaries when the config option
 	`status.submoduleSummary` is set).
 
---ignored::
+--ignored[=<mode>]::
 	Show ignored files as well.
++
+The mode parameter is used to specify the handling of ignored files.
+It is optional: it defaults to 'default', and if specified, it must be
+stuck to the option (e.g. '--ignored=default`, but not `--ignored default`).
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
index 6c77b4920c..86c981c29c 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -22,16 +22,20 @@ The notable options are:
 
 `flags`::
 
-	A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
+	A bit-field of options:
 
 `DIR_SHOW_IGNORED`:::
 
-	Return just ignored files in `entries[]`, not untracked files.
+	Return just ignored files in `entries[]`, not untracked
+	files. This is flag is mutually exclusive with
+	`DIR_SHOW_IGNORED_TOO`.
 
 `DIR_SHOW_IGNORED_TOO`:::
 
-	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
-	in addition to untracked files in `entries[]`.
+	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
+	`ignored[]` in addition to untracked files in
+	`entries[]`. This flag is mutually exclusive with
+	`DIR_SHOW_IGNORED`.
 
 `DIR_KEEP_UNTRACKED_CONTENTS`:::
 
@@ -39,6 +43,22 @@ The notable options are:
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
+
+If this is set, files and directories
+	that explicity match an ignore pattern are reported. Implicity
+	ignored directories (directories that do not match an ignore
+	pattern, but whose contents are all ignored) are not reported,
+	instead all of the contents are reported.
+
 `DIR_COLLECT_IGNORED`:::
 
 	Special mode for git-add. Return ignored files in `ignored[]` and
-- 
2.13.6

