Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E174215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755124AbeEAMHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:39 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44656 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754952AbeEAMHd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:33 -0400
Received: by mail-wr0-f177.google.com with SMTP id o15-v6so10636823wro.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/XJtxM2MD9J26yZfXsAwwhRUKb5FtpMHZQquERgh6tQ=;
        b=qRKU/L2NdZjSnT/97VsyYBewIq6XCDsTnUSlskGI3p9YXus3RnvOBtKAOX4ls7sVn7
         3zL7W/5ea502cor5P9CFV4sEOqZk+zWlDzU71qlwBISWE8issqrWXoPDaSIHORBuStr2
         cE+xjjUUh1Av5GYZtwoBwQNVT6zkEvPobED7ZKYfJPQ/CvkjZD3mjhy4S/A5wceEvFLJ
         OdKO1GyO1aqo/NPgtCmhORmweU1Li1EJr7m3JSxVsXWLTdD5HmVrCK/EZO2TH1IqAlMH
         6r4WWgACl6xeBsWGR5/eadCOqJRkg9KKxm7Rwx1h07vIVWsop5jQEmd9fRmQCLorCgJU
         v4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/XJtxM2MD9J26yZfXsAwwhRUKb5FtpMHZQquERgh6tQ=;
        b=eity0Lkc8otrIX6rCCDJvfgtYNaULmep+5J3Gn4A+OOds3tJs0WVGoPrgYvm8zPei8
         SnLJGTMLX6smhuXVvybU0aTKrJosVxUi5MZ6bGxZq0qRhs+FtMCe/hadOlDAgpvy6sC6
         HL2B7/L/BqwIQcRV/3WgHg9TJnoKwqhD+EArPu/5xjxeUfH0AkK7AoirERr91RNKPcFK
         Dm7URF7b9C6KkTqYEXSnUR2L8tm3iOOgcKLphbeSZ1M8VYDTraNheEr58Q13FYRV6LAH
         5S83FVfExxX9tWkhJjgYdASlzrsnDjxm6snVfVr5E3sMWSWUvVyGCp+4IydZzNPoG9Bh
         vO4w==
X-Gm-Message-State: ALQs6tCMGH2iySmvRm3Qnd9q1v/c7dBThayttAIEEW5RVkZqb+4av3bW
        1woOSUGqrNMaKzK/puYvjIgSIOZL
X-Google-Smtp-Source: AB8JxZo6nHQBAocwwZU8RdfNYlCfZPxbVhummQmWUtxxbfnA9OuDuee8j24G8uGbQWPkpoeiv3ZnIg==
X-Received: by 2002:adf:8e44:: with SMTP id n62-v6mr11545815wrb.159.1525176452105;
        Tue, 01 May 2018 05:07:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/12] get_short_oid: sort ambiguous objects by type, then SHA-1
Date:   Tue,  1 May 2018 12:06:45 +0000
Message-Id: <20180501120651.15886-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output emitted when an ambiguous object is encountered so
that we show tags first, then commits, followed by trees, and finally
blobs. Within each type we show objects in hashcmp() order. Before
this change the objects were only ordered by hashcmp().

The reason for doing this is that the output looks better as a result,
e.g. the v2.17.0 tag before this change on "git show e8f2" would
display:

    hint: The candidates are:
    hint:   e8f2093055 tree
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f25a3a50 tree
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f2867228 blob
    hint:   e8f28d537c tree
    hint:   e8f2a35526 blob
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2cf6ec0 tree

Now we'll instead show:

    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob

Since we show the commit data in the output that's nicely aligned once
we sort by object type. The decision to show tags before commits is
pretty arbitrary. I don't want to order by object_type since there
tags come last after blobs, which doesn't make sense if we want to
show the most important things first.

I could display them after commits, but it's much less likely that
we'll display a tag, so if there is one it makes sense to show it
prominently at the top.

A note on the implementation: I started out with something much
simpler which just replaced oid_array_sort() in sha1-array.c with a
custom sort function before calling oid_array_for_each_unique(). But
then dumbly noticed that it doesn't work because the output function
was tangled up with the code added in fad6b9e590 ("for_each_abbrev:
drop duplicate objects", 2016-09-26) to ensure we don't display
duplicate objects.

That's why we're doing two passes here, first we need to sort the list
and de-duplicate the objects, then sort them in our custom order, and
finally output them without re-sorting them. I suppose we could also
make oid_array_for_each_unique() maintain a hashmap of emitted
objects, but that would increase its memory profile and wouldn't be
worth the complexity for this one-off use-case,
oid_array_for_each_unique() is used in many other places.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/api-oid-array.txt | 17 +++++++----
 sha1-array.c                              | 17 +++++++++++
 sha1-array.h                              |  3 ++
 sha1-name.c                               | 37 ++++++++++++++++++++++-
 t/t1512-rev-parse-disambiguation.sh       | 21 +++++++++++++
 5 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
index b0c11f868d..94b529722c 100644
--- a/Documentation/technical/api-oid-array.txt
+++ b/Documentation/technical/api-oid-array.txt
@@ -35,13 +35,18 @@ Functions
 	Free all memory associated with the array and return it to the
 	initial, empty state.
 
+`oid_array_for_each`::
+	Iterate over each element of the list, executing the callback
+	function for each one. Does not sort the list, so any custom
+	hash order is retained. If the callback returns a non-zero
+	value, the iteration ends immediately and the callback's
+	return is propagated; otherwise, 0 is returned.
+
 `oid_array_for_each_unique`::
-	Efficiently iterate over each unique element of the list,
-	executing the callback function for each one. If the array is
-	not sorted, this function has the side effect of sorting it. If
-	the callback returns a non-zero value, the iteration ends
-	immediately and the callback's return is propagated; otherwise,
-	0 is returned.
+	Iterate over each unique element of the list in sort order ,
+	but otherwise behaves like `oid_array_for_each`. If the array
+	is not sorted, this function has the side effect of sorting
+	it.
 
 Examples
 --------
diff --git a/sha1-array.c b/sha1-array.c
index 838b3bf847..5b2793615b 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -41,6 +41,23 @@ void oid_array_clear(struct oid_array *array)
 	array->sorted = 0;
 }
 
+
+int oid_array_for_each(struct oid_array *array,
+		       for_each_oid_fn fn,
+		       void *data)
+{
+	int i;
+
+	/* No oid_array_sort() here! See the api-oid-array.txt docs! */
+
+	for (i = 0; i < array->nr; i++) {
+		int ret = fn(array->oid + i, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int oid_array_for_each_unique(struct oid_array *array,
 				for_each_oid_fn fn,
 				void *data)
diff --git a/sha1-array.h b/sha1-array.h
index 1e1d24b009..232bf95017 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -16,6 +16,9 @@ void oid_array_clear(struct oid_array *array);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
+int oid_array_for_each(struct oid_array *array,
+		       for_each_oid_fn fn,
+		       void *data);
 int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
diff --git a/sha1-name.c b/sha1-name.c
index 9d7bbd3e96..46d8b1afa6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -378,6 +378,34 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int sort_ambiguous(const void *a, const void *b)
+{
+	int a_type = oid_object_info(a, NULL);
+	int b_type = oid_object_info(b, NULL);
+	int a_type_sort;
+	int b_type_sort;
+
+	/*
+	 * Sorts by hash within the same object type, just as
+	 * oid_array_for_each_unique() would do.
+	 */
+	if (a_type == b_type)
+		return oidcmp(a, b);
+
+	/*
+	 * Between object types show tags, then commits, and finally
+	 * trees and blobs.
+	 *
+	 * The object_type enum is commit, tree, blob, tag, but we
+	 * want tag, commit, tree blob. Cleverly (perhaps too
+	 * cleverly) do that with modulus, since the enum assigns 1 to
+	 * commit, so tag becomes 0.
+	 */
+	a_type_sort = a_type % 4;
+	b_type_sort = b_type % 4;
+	return a_type_sort > b_type_sort ? 1 : -1;
+}
+
 static int get_short_oid(const char *name, int len, struct object_id *oid,
 			  unsigned flags)
 {
@@ -409,6 +437,8 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 	status = finish_object_disambiguation(&ds, oid);
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
+		struct oid_array collect = OID_ARRAY_INIT;
+
 		error(_("short SHA1 %s is ambiguous"), ds.hex_pfx);
 
 		/*
@@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 			ds.fn = NULL;
 
 		advise(_("The candidates are:"));
-		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
+		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
+		QSORT(collect.oid, collect.nr, sort_ambiguous);
+
+		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
+			BUG("show_ambiguous_object shouldn't return non-zero");
+		oid_array_clear(&collect);
 	}
 
 	return status;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 711704ba5a..2701462041 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -361,4 +361,25 @@ test_expect_success 'core.disambiguate does not override context' '
 		git -c core.disambiguate=committish rev-parse $sha1^{tree}
 '
 
+test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first, then hash order' '
+	test_must_fail git rev-parse 0000 2>stderr &&
+	grep ^hint: stderr >hints &&
+	grep 0000 hints >objects &&
+	cat >expected <<-\EOF &&
+	tag
+	commit
+	tree
+	blob
+	EOF
+	awk "{print \$3}" <objects >objects.types &&
+	uniq <objects.types >objects.types.uniq &&
+	test_cmp expected objects.types.uniq &&
+	for type in tag commit tree blob
+	do
+		grep $type objects >$type.objects &&
+		sort $type.objects >$type.objects.sorted &&
+		test_cmp $type.objects.sorted $type.objects
+	done
+'
+
 test_done
-- 
2.17.0.290.gded63e768a

