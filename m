Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0051F462
	for <e@80x24.org>; Sat, 25 May 2019 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfEYO24 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 10:28:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfEYO24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 10:28:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id e2so3866018wrv.6
        for <git@vger.kernel.org>; Sat, 25 May 2019 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HilLtGwH1old4HRSjnje9ppchVovE3rt/8kZ6rUEKxk=;
        b=MY69hu7ffVFhYPKpR/sO9NcUplb9eYq8Qw5DOJn2GXQKg+VGS4iQgfRI+e6nNCOV24
         iBlpibglYPtise/MXb2P1ajaXvAVeZZnsim5lbh3/UpsSaAQBoKeQV7XcittSrww7Oqy
         dmx78KcBZqIYXAJk7nox3+KJv1hExV6+4scD+D0H7dyOmcdix4hxfYjqU/IwFk50zd2i
         ddYkYJO+1AUZzYcdf6Kb/z7U1PpDJg5+nTEtOogLDMe6zw4+x65oRysiGeWbtp4I6Ua0
         HeEMl3XwR5B9tBLIIZ1VYNoHfanN0yWnwpwaSDxjUk7KB9e5wxw9Ab197dOrQWkRl2vY
         clqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HilLtGwH1old4HRSjnje9ppchVovE3rt/8kZ6rUEKxk=;
        b=S3hCZKfxSbhfmhTirpaX4S7XS3LTcesqh1zVf3mofOpyMJN3Sqsw998lr1frshyqkt
         3yohkIYBsu3BXc0d5lFT0DogdRZjZqNH+YAT+dsYR4SvPWvGIk4b9eN2Hu1oHJMVdji1
         /7k2+c0FoZnxals3Q2kh7uh63j9uCnMJnrqzC5KQdOxvJK/0pjTXMlzcWyNLvRJxWHT0
         DP36kkqBJV6UMWqT8IzrHmLTI8fpFsgEjUh8SXrxYYMNEwrvLAzaPaDos4B0lLst6ng/
         bhDu56EJygt4ZOSAAZej0EdvqY9LKq7aFyT4aX/X1IpzGUitth6H2T4bnFlqjeSjqdtt
         DHsQ==
X-Gm-Message-State: APjAAAVgf7QXbAGO7m5VGN0fYpQg0dYGa3SOyrJpK+RcpTBwM3EOUrm4
        sqIe92qyVWM5tWzPjoZL/iEmHvNa7LU=
X-Google-Smtp-Source: APXvYqxvWGxGVfBNVYMNmK+fyFPFGFCC+dGXu/0JMSJzYz4bHm9w8JYd/AJeZUphR/qfT5cSFvPYAQ==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr3934249wrs.340.1558794533607;
        Sat, 25 May 2019 07:28:53 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:104e:f376:c9e6:e2b9:41e4:ce48])
        by smtp.gmail.com with ESMTPSA id e15sm4353964wme.0.2019.05.25.07.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 07:28:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] list-objects-filter: disable 'sparse:path' filters
Date:   Sat, 25 May 2019 16:28:34 +0200
Message-Id: <20190525142834.6168-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.rc1.1.ge905c6e19a.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---

Changes since the RFC version are the following:

  - improved the error message when 'sparse:path' is used,
  - updated "git-completion.bash",
  - freed "sparse_path_value" field in list_objects_filter_release(),
  - updated tests (t5317 and t6112).

Thanks to Matthew and Jeff for the suggestions.

 contrib/completion/git-completion.bash |  2 +-
 list-objects-filter-options.c          | 10 ++--
 list-objects-filter-options.h          |  2 -
 list-objects-filter.c                  | 22 --------
 t/t5317-pack-objects-filter-objects.sh | 71 +++++---------------------
 t/t6112-rev-list-filters-objects.sh    | 39 +++++---------
 6 files changed, 33 insertions(+), 113 deletions(-)

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
2.22.0.rc1.1.ge905c6e19a.dirty

