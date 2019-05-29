Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F191F462
	for <e@80x24.org>; Wed, 29 May 2019 12:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2Mox (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 08:44:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39176 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfE2Mox (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 08:44:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so3590299edq.6
        for <git@vger.kernel.org>; Wed, 29 May 2019 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuoX0tqP1K4DrwBg+f2hDLwHAsLGFE+fvik88snsT+M=;
        b=ZYbgWMJwI0DCS4PFa9+PwDuhLI3EoYcJIo+ZHGvcWoYUFhK31voONTAGURMdNOXN2g
         P0I+3tsd1se+KiVBIHW1khycktJzq8gwwSaLeZLbg8t3pS4eJP5nqT/7xNvnN+3ngPIA
         Fb1W/WfuBe9SRlmzNrh7aNeSzEefHTZnUVFxBhUrrqrR2VBYTYseFp2RwL3kTilzXzp8
         jpYROGBFsNgEtR8KsV7pigR5vnCaC+GhE1dsGJMh40VDTk2PoZEzoyKNjg1+UxHPWt4k
         543t66OpFbiyskw7Yb92vJR0wIE3nNMG3FiRxrVS7g6OpoNJK+jKCAXSMlabS6BIbL9s
         1AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuoX0tqP1K4DrwBg+f2hDLwHAsLGFE+fvik88snsT+M=;
        b=F3YGOzngOQ2f9PAsyaAQSFVnCTtyA5bFn3RF1fNV6aZ1gd8A7AxqpLgdmXhWeFBJjY
         DqbuVSfj0mnWdzGDhJER0w3QNYD3QqLw9ly1dlkl+3vtxJgjg0aWqyykR3n4pIS4yq22
         O671poYZpEuhwESf3+AJP6vnUtecvhEeMX4JkQVDsqYKWDV2TmeYn4DjUiuf1C+x0uJr
         z1wdx7f5mjR56a95TTFfQFg8W3ZLp5AMt336GwgUGs/IhLOXruN11BWuVqQAHkOzIWgL
         /y6xSPtAELcmUmN+eFjfCYgDnLtOOJdop6CJ++3F5KEbcqi9yBuGMUtyLjGMNPmP8fbw
         BQpg==
X-Gm-Message-State: APjAAAVJg5NIIz02Q3wSQ86qkkJOXdPM+9GXVvxhpPcXJe6rbMQmiMv5
        Z/KTPw9SGJfn440d3O8VZODGYdtWEfc=
X-Google-Smtp-Source: APXvYqw6A6PjsAVb5LYC7udU4Jid3gtnR8NApCsgxd0fJt7rKOjY9thy6ijMSsPzCwhbwvo8c5Lyfg==
X-Received: by 2002:a17:906:7053:: with SMTP id r19mr28856346ejj.101.1559133890630;
        Wed, 29 May 2019 05:44:50 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id l18sm2792938ejs.44.2019.05.29.05.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:44:49 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3] list-objects-filter: disable 'sparse:path' filters
Date:   Wed, 29 May 2019 14:44:32 +0200
Message-Id: <20190529124432.5707-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.rc1.7.gaa5a13be45.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

If someone wants to use as a filter a sparse file that is in the
repository, something like "--filter=sparse:oid=<ref>:<path>"
already works.

So 'sparse:path' is only interesting if the sparse file is not in
the repository. In this case though the current implementation has
a big security issue, as it makes it possible to ask the server to
read any file, like for example /etc/password, and to explore the
filesystem, as well as individual lines of files.

If someone is interested in using a sparse file that is not in the
repository as a filter, then at the minimum a config option, such
as "uploadpack.sparsePathFilter", should be implemented first to
restrict the directory from which the files specified by
'sparse:path' can be read.

For now though, let's just disable 'sparse:path' filters.

Helped-by: Matthew DeVore <matvore@google.com>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Changes since version 2 are the following:

  - added changes to Documentation/rev-list-options.txt, as
    discussed with Junio.

 Documentation/rev-list-options.txt     |  7 +--
 contrib/completion/git-completion.bash |  2 +-
 list-objects-filter-options.c          | 10 ++--
 list-objects-filter-options.h          |  2 -
 list-objects-filter.c                  | 22 --------
 t/t5317-pack-objects-filter-objects.sh | 71 +++++---------------------
 t/t6112-rev-list-filters-objects.sh    | 39 +++++---------
 7 files changed, 37 insertions(+), 116 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ddbc1de43f..71a1fcc093 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -725,9 +725,6 @@ specification contained in the blob (or blob-expression) '<blob-ish>'
 to omit blobs that would not be not required for a sparse checkout on
 the requested refs.
 +
-The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
-specification contained in <path>.
-+
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
@@ -737,6 +734,10 @@ tree and blobs which are referenced directly by a commit reachable from
 <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
++
+Note that the form '--filter=sparse:path=<path>' that wants to read
+from an arbitrary path on the filesystem has been dropped for security
+reasons.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3eefbabdb1..9f71bcde96 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1536,7 +1536,7 @@ _git_fetch ()
 		return
 		;;
 	--filter=*)
-		__gitcomp "blob:none blob:limit= sparse:oid= sparse:path=" "" "${cur##--filter=}"
+		__gitcomp "blob:none blob:limit= sparse:oid=" "" "${cur##--filter=}"
 		return
 		;;
 	--*)
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0036f7378..a15d0f7829 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -78,9 +78,12 @@ static int gently_parse_list_objects_filter(
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
-		filter_options->choice = LOFC_SPARSE_PATH;
-		filter_options->sparse_path_value = strdup(v0);
-		return 0;
+		if (errbuf) {
+			strbuf_addstr(
+				errbuf,
+				_("sparse:path filters support has been dropped"));
+		}
+		return 1;
 	}
 	/*
 	 * Please update _git_fetch() in git-completion.bash when you
@@ -136,7 +139,6 @@ void list_objects_filter_release(
 {
 	free(filter_options->filter_spec);
 	free(filter_options->sparse_oid_value);
-	free(filter_options->sparse_path_value);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index e3adc78ebf..c54f0000fb 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -13,7 +13,6 @@ enum list_objects_filter_choice {
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
-	LOFC_SPARSE_PATH,
 	LOFC__COUNT /* must be last */
 };
 
@@ -44,7 +43,6 @@ struct list_objects_filter_options {
 	 * choice.
 	 */
 	struct object_id *sparse_oid_value;
-	char *sparse_path_value;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
 };
diff --git a/list-objects-filter.c b/list-objects-filter.c
index ee449de3f7..53f90442c5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -478,27 +478,6 @@ static void *filter_sparse_oid__init(
 	return d;
 }
 
-static void *filter_sparse_path__init(
-	struct oidset *omitted,
-	struct list_objects_filter_options *filter_options,
-	filter_object_fn *filter_fn,
-	filter_free_fn *filter_free_fn)
-{
-	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
-	d->omits = omitted;
-	if (add_excludes_from_file_to_list(filter_options->sparse_path_value,
-					   NULL, 0, &d->el, NULL) < 0)
-		die("could not load filter specification");
-
-	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
-	d->array_frame[d->nr].defval = 0; /* default to include */
-	d->array_frame[d->nr].child_prov_omit = 0;
-
-	*filter_fn = filter_sparse;
-	*filter_free_fn = filter_sparse_free;
-	return d;
-}
-
 typedef void *(*filter_init_fn)(
 	struct oidset *omitted,
 	struct list_objects_filter_options *filter_options,
@@ -514,7 +493,6 @@ static filter_init_fn s_filters[] = {
 	filter_blobs_limit__init,
 	filter_trees_depth__init,
 	filter_sparse_oid__init,
-	filter_sparse_path__init,
 };
 
 void *list_objects_filter__init(
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 4c0201c34b..2d2f5d0229 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -277,6 +277,10 @@ test_expect_success 'verify normal and blob:limit packfiles have same commits/tr
 '
 
 # Test sparse:path=<path> filter.
+# !!!!
+# NOTE: sparse:path filter support has been dropped for security reasons,
+# so the tests have been changed to make sure that using it fails.
+# !!!!
 # Use a local file containing a sparse-checkout specification to filter
 # out blobs not required for the corresponding sparse-checkout.  We do not
 # require sparse-checkout to actually be enabled.
@@ -315,73 +319,24 @@ test_expect_success 'verify blob count in normal packfile' '
 	test_cmp expected observed
 '
 
-test_expect_success 'verify sparse:path=pattern1' '
-	git -C r3 ls-files -s dir1/sparse1 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
-	sort >expected &&
-
-	git -C r3 pack-objects --revs --stdout --filter=sparse:path=../pattern1 >filter.pack <<-EOF &&
+test_expect_success 'verify sparse:path=pattern1 fails' '
+	test_must_fail git -C r3 pack-objects --revs --stdout \
+		--filter=sparse:path=../pattern1 <<-EOF
 	HEAD
 	EOF
-	git -C r3 index-pack ../filter.pack &&
-
-	git -C r3 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	test_cmp expected observed
-'
-
-test_expect_success 'verify normal and sparse:path=pattern1 packfiles have same commits/trees' '
-	git -C r3 verify-pack -v ../all.pack >verify_result &&
-	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
-	sort >expected &&
-
-	git -C r3 verify-pack -v ../filter.pack >verify_result &&
-	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	test_cmp expected observed
 '
 
-test_expect_success 'verify sparse:path=pattern2' '
-	git -C r3 ls-files -s sparse1 dir1/sparse1 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
-	sort >expected &&
-
-	git -C r3 pack-objects --revs --stdout --filter=sparse:path=../pattern2 >filter.pack <<-EOF &&
+test_expect_success 'verify sparse:path=pattern2 fails' '
+	test_must_fail git -C r3 pack-objects --revs --stdout \
+		--filter=sparse:path=../pattern2 <<-EOF
 	HEAD
 	EOF
-	git -C r3 index-pack ../filter.pack &&
-
-	git -C r3 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	test_cmp expected observed
-'
-
-test_expect_success 'verify normal and sparse:path=pattern2 packfiles have same commits/trees' '
-	git -C r3 verify-pack -v ../all.pack >verify_result &&
-	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
-	sort >expected &&
-
-	git -C r3 verify-pack -v ../filter.pack >verify_result &&
-	grep -E "commit|tree" verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	test_cmp expected observed
 '
 
 # Test sparse:oid=<oid-ish> filter.
-# Like sparse:path, but we get the sparse-checkout specification from
-# a blob rather than a file on disk.
+# Use a blob containing a sparse-checkout specification to filter
+# out blobs not required for the corresponding sparse-checkout.  We do not
+# require sparse-checkout to actually be enabled.
 
 test_expect_success 'setup r4' '
 	git init r4 &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 9c11427719..acd7f5ab80 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -157,6 +157,10 @@ test_expect_success 'verify blob:limit=1m' '
 '
 
 # Test sparse:path=<path> filter.
+# !!!!
+# NOTE: sparse:path filter support has been dropped for security reasons,
+# so the tests have been changed to make sure that using it fails.
+# !!!!
 # Use a local file containing a sparse-checkout specification to filter
 # out blobs not required for the corresponding sparse-checkout.  We do not
 # require sparse-checkout to actually be enabled.
@@ -176,37 +180,20 @@ test_expect_success 'setup r3' '
 	echo sparse1 >pattern2
 '
 
-test_expect_success 'verify sparse:path=pattern1 omits top-level files' '
-	git -C r3 ls-files -s sparse1 sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
-	sort >expected &&
-
-	git -C r3 rev-list --quiet --objects --filter-print-omitted \
-		--filter=sparse:path=../pattern1 HEAD >revs &&
-	awk -f print_1.awk revs |
-	sed "s/~//" |
-	sort >observed &&
-
-	test_cmp expected observed
+test_expect_success 'verify sparse:path=pattern1 fails' '
+	test_must_fail git -C r3 rev-list --quiet --objects \
+		--filter-print-omitted --filter=sparse:path=../pattern1 HEAD
 '
 
-test_expect_success 'verify sparse:path=pattern2 omits both sparse2 files' '
-	git -C r3 ls-files -s sparse2 dir1/sparse2 >ls_files_result &&
-	awk -f print_2.awk ls_files_result |
-	sort >expected &&
-
-	git -C r3 rev-list --quiet --objects --filter-print-omitted \
-		--filter=sparse:path=../pattern2 HEAD >revs &&
-	awk -f print_1.awk revs |
-	sed "s/~//" |
-	sort >observed &&
-
-	test_cmp expected observed
+test_expect_success 'verify sparse:path=pattern2 fails' '
+	test_must_fail git -C r3 rev-list --quiet --objects \
+		--filter-print-omitted --filter=sparse:path=../pattern2 HEAD
 '
 
 # Test sparse:oid=<oid-ish> filter.
-# Like sparse:path, but we get the sparse-checkout specification from
-# a blob rather than a file on disk.
+# Use a blob containing a sparse-checkout specification to filter
+# out blobs not required for the corresponding sparse-checkout.  We do not
+# require sparse-checkout to actually be enabled.
 
 test_expect_success 'setup r3 part 2' '
 	echo dir1/ >r3/pattern &&
-- 
2.22.0.rc1.7.gaa5a13be45.dirty

