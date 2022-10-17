Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE7C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJQCXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJQCXe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3A4448F
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j16so16438199wrh.5
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61z3BnFxwNixLm06cVJ5YahQgEauGr51Bc0NXdcN05U=;
        b=LJsPEpv/Pug0CQL0lw0yC82DUZC9OXluRc8T5jiLAGlAQl6NSb+M2eA0UUW4Yuzo4T
         ZaczVC84niM0OtWNT9wdRu2BAt/83OxN6BtvMOPEiGM1HBDu/0A5tkmBIFG3y8KRXWf8
         JqVVuj0zmoXemOKJ6pGrGm342HFv8QTRn5qAdzGadxZgbWosUEd+3QrplHMDlTTWljbD
         sHPA2fdQVWeLJuKLcuxupOuMkEhz5HPYEjXa+QQUUw4Vm1blQ/pgUD0xiQ6drCbP/9NW
         pwav8CRKLyWi8qk9a3MXX61Lc6vIioaj08TKx24yJ87Ik3BK8wNBCnpiQpjnJtQl/2b2
         EofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61z3BnFxwNixLm06cVJ5YahQgEauGr51Bc0NXdcN05U=;
        b=3UQZbHx9sI6/fOzY79BrslZIMv3rFJfHnyPyJ9/of4cLMvl1aJkfvgb30fbariWkuY
         UJW6Da1VrEbGG3cxbq6vqalhT1Gtw92Dffo85hx+ftTLDLAEBTy98MoDZ2d6X4k9VVzn
         0HxTpGQDOQsiBYVxmkKZo3nTvKtOw+94YqHlGd3mELBZIzMPRPVB4sKsUznvhnWb8+2Q
         DJfqXLlVrpF97dt6v5D71eoZiddZA/GLKB1qzGXdQ8gNh+ZJnWC5Y6fpEDw/Y1HGNTBB
         rhluyLZD7xTMT/mDzgCcmP7hnxkYWHpq5CSlTJrJsBQvQz2F8wiyr2UsGFrov9S8zGLk
         Hn0g==
X-Gm-Message-State: ACrzQf07oR9obWKkezHUuzzBHFsBL+DwwRKyGJbfD2ZZu/liYp55JQ5N
        01EWrJrvYt96G1qUtOxyx9Tn3pEtGJs=
X-Google-Smtp-Source: AMsMyM74H+lOHNaCMhImwCrA7DH99HIv1+FRm+z8uFQdD//C4ckyxN9bQCDjjrcO9qhwkElamBVXXQ==
X-Received: by 2002:adf:f407:0:b0:22e:5848:f6b with SMTP id g7-20020adff407000000b0022e58480f6bmr4627101wro.46.1665973411894;
        Sun, 16 Oct 2022 19:23:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003b47b913901sm24960799wms.1.2022.10.16.19.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:31 -0700 (PDT)
Message-Id: <f88ebbaf17cbf1a0b57336430bd43ade94406f38.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:21 +0000
Subject: [PATCH v3 9/9] archive: add tests for git archive
 --recurse-submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

Ensuring functionality works with and without submodules.
We expect --recurse-submodules to fail if there are uninitialized submodules
present.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 archive.c                     |  2 +-
 t/t5005-archive-submodules.sh | 83 +++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 t/t5005-archive-submodules.sh

diff --git a/archive.c b/archive.c
index f81ef741487..b0a3181f7f5 100644
--- a/archive.c
+++ b/archive.c
@@ -179,7 +179,7 @@ static int write_archive_entry(
 		err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		return READ_TREE_RECURSIVE;
 	}
 
 	if (args->verbose)
diff --git a/t/t5005-archive-submodules.sh b/t/t5005-archive-submodules.sh
new file mode 100755
index 00000000000..aad6cfd1082
--- /dev/null
+++ b/t/t5005-archive-submodules.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description='git archive --recurse-submodules test'
+
+. ./test-lib.sh
+
+check_tar() {
+	tarfile=$1.tar
+	listfile=$1.lst
+	dir=$1
+	dir_with_prefix=$dir/$2
+
+	test_expect_success ' extract tar archive' '
+		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
+	'
+}
+
+check_added() {
+	dir=$1
+	path_in_fs=$2
+	path_in_archive=$3
+
+	test_expect_success " validate extra file $path_in_archive" '
+		test -f $dir/$path_in_archive &&
+		diff -r $path_in_fs $dir/$path_in_archive
+	'
+}
+
+check_not_added() {
+	dir=$1
+	path_in_archive=$2
+
+	test_expect_success " validate unpresent file $path_in_archive" '
+		! test -f $dir/$path_in_archive &&
+		! test -d $dir/$path_in_archive
+	'
+}
+
+test_expect_success 'setup' '
+	rm -rf repo_with_submodules submodule1 uninited_repo_with_submodules &&
+	git init repo_with_submodules &&
+	git init submodule1 &&
+	(
+		cd submodule1 &&
+		echo "dir1/sub1/file1.txt" > "file1.txt" &&
+		git add file1.txt &&
+		git commit -m "initialize with file1.txt"
+	) &&
+	(
+	    cd repo_with_submodules &&
+	    echo "file2" > file2.txt &&
+	    git add file2.txt &&
+	    git commit -m "initialize with file2.txt" &&
+	    mkdir -p dir1 &&
+	    git submodule add ../submodule1 dir1/sub1 &&
+	    git commit -m "add submodule1"
+	) &&
+	git clone repo_with_submodules uninited_repo_with_submodules
+'
+
+test_expect_success 'archive without recurse, non-init' '
+	git -C uninited_repo_with_submodules archive -v HEAD >b.tar
+'
+
+check_tar b
+check_added b uninited_repo_with_submodules/file2.txt file2.txt
+check_not_added b uninited_repo_with_submodules/dir1/sub1/file1.txt
+
+# It is expected that --recurse-submodules will not work if submodules are not
+# initialized.
+test_expect_success 'archive with recurse, non-init' '
+	! git -C uninited_repo_with_submodules archive --recurse-submodules -v HEAD >b2-err.tar
+'
+
+test_expect_success 'archive with recurse, init' '
+	git -C repo_with_submodules archive --recurse-submodules -v HEAD >b3.tar
+'
+
+check_tar b3
+check_added b3 repo_with_submodules/file2.txt file2.txt
+check_added b3 repo_with_submodules/dir1/sub1/file1.txt dir1/sub1/file1.txt
+
+test_done
-- 
gitgitgadget
