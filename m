Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECC220248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCHKRn (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36102 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCHKRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so13832017pfa.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a38HKszuSmZqEVm5Uq0mzyLgQChS8fKkj5Kuso24wVo=;
        b=NvNt6umbPa/kCB8Tyohsrev1hWzxKS45yi8e9tLkL27v6DbKOQQy1vPCkAkNknVmzt
         r21LilpzM/SOpojDlk+2fi4i+PWVo98JIAmoXH2kkr7rSuZbomNcAofBj2YPZXKbqSHS
         ae+m5Gk0WiB4i6Agb9w087X9jCbJBVEu8Pas3ZUeQkiUL4DipJlomHIW0G9jN5khUc+L
         MKqISIqSv18Y3GSHGi1XFtmViZRytmPd4HWymXNtDLtUwdas72LwIuD+gTscOZHlLWd1
         UOcxAHrM+DU7XhYP9vVXxnEU7UNKBn9m7OFnYiq/bU0drUpjqFcCApYHXIJGUoEdSRUa
         3eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a38HKszuSmZqEVm5Uq0mzyLgQChS8fKkj5Kuso24wVo=;
        b=G9ildYGFlnHWbo9QRiwR+Vg1KIlWcPppCyG304AlatH7idXVo/Fs1qztUVRfmB9/E7
         I6Sx1qjicnAHZsJZQJspMXwM6Pg0XVTGqjvIjjAmSb0AKqQoPQHMEHzUUv2vlNnPa7vK
         e3xkAOmJ/zbyvGX63vq1glBCagEK8bi513in1nOYVkrbeRyPH2lEG/kS+i4GsRGnZJ96
         s3HLwn/x7V/6xW5fFr8Xb7v+/1ZT4rFSOWxhixsTCN637u/autUGtTqu0M8CNof0hejK
         UCm320rUBzszvw80jfEF7fNrsMybjXljKVacajwYmSe6SSbRXOCxugu9HsR7RH3GSd/O
         C0jQ==
X-Gm-Message-State: APjAAAXT/q4p4zDxIPbWgByQtWPG6gRJYPoo7QqlEVq8q3WkcywKD96+
        FTH9Ewp2BkwBEEZTfmNSDQfqY/74
X-Google-Smtp-Source: APXvYqxXZ2VSxx3awnZOMmI9fpxZkesYoufkpj+6WXRy7Nk6OLYteA9puuNdmYFORZo53Yd0zrL+Aw==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr16017092pgq.146.1552040262586;
        Fri, 08 Mar 2019 02:17:42 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k125sm25478398pgc.51.2019.03.08.02.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 08/11] restore: support --patch
Date:   Fri,  8 Mar 2019 17:16:52 +0700
Message-Id: <20190308101655.9767-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-restore is different from git-checkout that it only restores the
worktree by default, not both worktree and index. add--interactive
needs some update to support this mode.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c        |  5 ++--
 git-add--interactive.perl | 52 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f06439dbeb..73de110d42 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -436,9 +436,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 			patch_mode = "--patch=checkout";
 		else if (opts->checkout_index && !opts->checkout_worktree)
 			patch_mode = "--patch=reset";
+		else if (!opts->checkout_index && opts->checkout_worktree)
+			patch_mode = "--patch=worktree";
 		else
-			die(_("'%s' with only '%s' is not currently supported"),
-			    "--patch", "--worktree");
+			BUG("either flag must have been set");
 		return run_add_interactive(revision, patch_mode, &opts->pathspec);
 	}
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..3dfb3629c9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -149,6 +149,20 @@ sub colored {
 		FILTER => undef,
 		IS_REVERSE => 0,
 	},
+	'worktree_head' => {
+		DIFF => 'diff-index -p',
+		APPLY => sub { apply_patch 'apply -R', @_ },
+		APPLY_CHECK => 'apply -R',
+		FILTER => undef,
+		IS_REVERSE => 1,
+	},
+	'worktree_nothead' => {
+		DIFF => 'diff-index -R -p',
+		APPLY => sub { apply_patch 'apply', @_ },
+		APPLY_CHECK => 'apply',
+		FILTER => undef,
+		IS_REVERSE => 0,
+	},
 );
 
 $patch_mode = 'stage';
@@ -1049,6 +1063,12 @@ sub color_diff {
 marked for discarding."),
 	checkout_nothead => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
+marked for applying."),
+	worktree_head => N__(
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for discarding."),
+	worktree_nothead => N__(
+"If the patch applies cleanly, the edited hunk will immediately be
 marked for applying."),
 );
 
@@ -1259,6 +1279,18 @@ sub edit_hunk_loop {
 n - do not apply this hunk to index and worktree
 q - quit; do not apply this hunk or any of the remaining ones
 a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file"),
+	worktree_head => N__(
+"y - discard this hunk from worktree
+n - do not discard this hunk from worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file"),
+	worktree_nothead => N__(
+"y - apply this hunk to worktree
+n - do not apply this hunk to worktree
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
 d - do not apply this hunk or any of the later hunks in the file"),
 );
 
@@ -1421,6 +1453,16 @@ sub display_hunks {
 		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
 		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
 	},
+	worktree_head => {
+		mode => N__("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+	},
+	worktree_nothead => {
+		mode => N__("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
+		deletion => N__("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
+		hunk => N__("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
+	},
 );
 
 sub patch_update_file {
@@ -1756,6 +1798,16 @@ sub process_args {
 						       'checkout_head' : 'checkout_nothead');
 					$arg = shift @ARGV or die __("missing --");
 				}
+			} elsif ($1 eq 'worktree') {
+				$arg = shift @ARGV or die __("missing --");
+				if ($arg eq '--') {
+					$patch_mode = 'checkout_index';
+				} else {
+					$patch_mode_revision = $arg;
+					$patch_mode = ($arg eq 'HEAD' ?
+						       'worktree_head' : 'worktree_nothead');
+					$arg = shift @ARGV or die __("missing --");
+				}
 			} elsif ($1 eq 'stage' or $1 eq 'stash') {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die __("missing --");
-- 
2.21.0.rc1.337.gdf7f8d0522

