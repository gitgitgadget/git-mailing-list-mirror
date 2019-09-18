Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4261F463
	for <e@80x24.org>; Wed, 18 Sep 2019 20:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfIRU1m (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 16:27:42 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55861 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbfIRU1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 16:27:42 -0400
Received: by mail-pf1-f201.google.com with SMTP id w126so585964pfd.22
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=pjkR/nGYbrsW3q9roD475+fduZUc3sYM4QgLgtsbGoU=;
        b=HM3jSd+Snbg5G9GZIr7jxBFAWC4pW4/4S85yegDZ64mCDB+ZqqLd/CY5nzx8Q82WDT
         q61L47jBt9hDECmuvUgcZHwaipVXmFjukKBTQoOv8zoBYbLu9FlbT0D0rK+KGTavpKNN
         h5UlisxnjECB2aMgYTh5auXx62D7t15ZKjF27AIHLj43R+R+poYX6V4gbhXFZlhtaTwU
         Ax1HmpZjSRyhThjzMOAJZHHoFyRkHlfduP6Px+J8nU0cSgajVUvCcpkVTSj6/uUWT8FQ
         9WqeFfjWkMkK8bLi53NAPsVcqOnDk4AG1V+dMWQhAlaH8mDscmQyyimpxlJNVpFiwd9K
         4TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=pjkR/nGYbrsW3q9roD475+fduZUc3sYM4QgLgtsbGoU=;
        b=NXxMf0CtE/kLNsZxlH6H0fmNgT5sLdLCl+S4nCPxdwvuRg2jD1Zg+I52ii6l6Gy3Zm
         IFeMmkOuTkIchLB1SNPq1l7QzRipdUuHH+t+bISCYG/ygQsh5AV1Gtm9efoNLtYS+vqY
         y7UZ6pZ+JcopvhP/X2RXrcRaikGdY9WUCyC9oW2cqZ7M4JfrG4R1L6wgHni7s8JH5Mi8
         HF94scg4Qf2EIUgTKylLscr1OHM8NXfOw2Lp0KUkbj28di6c5Joa0PJrmISs5QGKqRvF
         STVZRFSfqx5yg+mg2khqLarLL2wXaRWjrZjXGABrvhwNAcjNnMRZx6OKvdcloIgMaAuF
         z7yA==
X-Gm-Message-State: APjAAAUbFRVsIw9Q5MHa8sQ0y82c4tSa36Mi5PNT0Ej4E9z83nXP05OX
        J3VfZVtK6zmfaAv/GxKRG5lEohI6kCZljG5BoaUq05Pghg0OyF8UX6SiK0p4ojqnt4dueaeD/xX
        EmZqDwgQRX6Hi6geB2M0LPs4uPtbH4hWDBVYtYHb4ElDThLVR3lo6UQPGi+Y0N5XOFyjbdgq//v
        RS
X-Google-Smtp-Source: APXvYqxcM2PHp9J/QKix/Uxq4d6ZqZiHd+c7vRsrp0m/eXNmm6So5Z3VfXi+t7mvIOLptLHTxEQtyc5hqFTyjrDyRhwH
X-Received: by 2002:a63:1521:: with SMTP id v33mr5772601pgl.9.1568838461107;
 Wed, 18 Sep 2019 13:27:41 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:27:38 -0700
In-Reply-To: <https://public-inbox.org/git/20190917215040.132503-1-jonathantanmy@google.com/>
Message-Id: <20190918202738.57273-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <https://public-inbox.org/git/20190917215040.132503-1-jonathantanmy@google.com/>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH v2] merge-recursive: symlink's descendants not in way
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com,
        gitster@pobox.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the working tree has:
 - bar (directory)
 - bar/file (file)
 - foo (symlink to .)

(note that lstat() for "foo/bar" would tell us that it is a directory)

and the user merges a commit that deletes the foo symlink and instead
contains:
 - bar (directory, as above)
 - bar/file (file, as above)
 - foo (directory)
 - foo/bar (file)

the merge should happen without requiring user intervention. However,
this does not happen.

This is because dir_in_way(), when checking the working tree, thinks
that "foo/bar" is a directory. But a symlink should be treated much the
same as a file: since dir_in_way() is only checking to see if there is a
directory in the way, we don't want symlinks in leading paths to
sometimes cause dir_in_way() to return true.

Teach dir_in_way() to also check for symlinks in leading paths before
reporting whether a directory is in the way.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Changes from v1:

- Used has_symlink_leading_path(). This drastically shortens the diff.
- Updated commit message following suggestions from Junio, Szeder G=C3=A1bo=
r,
  and Elijah Newren.
- Updated test to add prereq and verification that the working tree
  contains what we want.
---
 merge-recursive.c          |  3 ++-
 t/t3030-merge-recursive.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6b812d67e3..22a12cfeba 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -764,7 +764,8 @@ static int dir_in_way(struct index_state *istate, const=
 char *path,
=20
 	strbuf_release(&dirpath);
 	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode) &&
-		!(empty_ok && is_empty_dir(path));
+		!(empty_ok && is_empty_dir(path)) &&
+		!has_symlink_leading_path(path, strlen(path));
 }
=20
 /*
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..faa8892741 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -452,6 +452,34 @@ test_expect_success 'merge-recursive d/f conflict resu=
lt' '
=20
 '
=20
+test_expect_success SYMLINKS 'dir in working tree with symlink ancestor do=
es not produce d/f conflict' '
+	git init sym &&
+	(
+		cd sym &&
+		ln -s . foo &&
+		mkdir bar &&
+		>bar/file &&
+		git add foo bar/file &&
+		git commit -m "foo symlink" &&
+
+		git checkout -b branch1 &&
+		git commit --allow-empty -m "empty commit" &&
+
+		git checkout master &&
+		git rm foo &&
+		mkdir foo &&
+		>foo/bar &&
+		git add foo/bar &&
+		git commit -m "replace foo symlink with real foo dir and foo/bar file" &=
&
+
+		git checkout branch1 &&
+
+		git cherry-pick master &&
+		test_path_is_dir foo &&
+		test_path_is_file foo/bar
+	)
+'
+
 test_expect_success 'reset and 3-way merge' '
=20
 	git reset --hard "$c2" &&
--=20
2.23.0.237.gc6a4ce50a0-goog

