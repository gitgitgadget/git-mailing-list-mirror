Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE01D1F406
	for <e@80x24.org>; Thu, 10 May 2018 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935514AbeEJMnb (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:43:31 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40770 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935509AbeEJMn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:43:29 -0400
Received: by mail-wm0-f49.google.com with SMTP id j5-v6so4128219wme.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5zXVVea9+X5lujwtwdUlZl+DneA3osSRmjXKIiJ3Q2s=;
        b=WUTrKyNepQp2hw8HjszdXuor0XnSnr1Yt/rJbOIzZpwuWI+OFkddY1dq2vTS2orZ/c
         NBQTC4OACm7lVZffO/t2hxNRZm+5QRV5swei0MOwZrxMMs9P6w/Y5+y/uWUOEMrXhFau
         kFovmrA6w5OGWdNIKYHdNhWpIQ36W3INHzTy4Wdis0/sLR927rzpdEcvloxRZ1goFq9k
         LRpv4d07zLCBeNWQnWG1Z62olLKOSmYwQrZ/X7h+tfohX/oTmdhoQ++qg1V68Oijd4DD
         1Y2L5oaxHcxXxEQjur/0MqrE50gqmNi4GgkNNgNiZ5X0eCTpCZflpAaTXzDfNfWrWuki
         P1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5zXVVea9+X5lujwtwdUlZl+DneA3osSRmjXKIiJ3Q2s=;
        b=sfS0yCYEMUeaflfkPjSEV2a1Hwvsv81kRwql7xs94ooX8GOLF4C1gs3uvdQflfhZcu
         BFnTeCux1Q/ikErbWHktJQPmRCyk6vE1oc0PjN1vuHiNhZri3XSDvo7tJT+c7sEXhNm+
         jEbe+ovcpvNzLHF/HUchi2owVgTNd9xpXyRMWPwiIGe6hlFn+B0dnFKsc/et6UOa+mxN
         pSPTyqrtX12xsXfyZMFxfbYhAv2w9Pi1If3p9BkDHclup0PdhpegaoF+7h7fmdwq0UNG
         AWFTGf9W1otc2NwDnbs2WEF86+5AZN6eQH108Cf86CKG7RPIB+DL8lOVfk+PHlYtVWZ9
         xkZA==
X-Gm-Message-State: ALKqPwc+CIKqvKPpZtS7EqdKVlDBFdvAMlQcxWdtdsds6n9YnWfdE7xq
        RsDhWvEWHSMu31OKy2AGCLxLioCS
X-Google-Smtp-Source: AB8JxZqM1xtLOV1oSkrS4m44dDND0UU33S29KsAZOVqoOKBTnbZqaT9RpwXzWqOic8DvyB8jfFPqKw==
X-Received: by 2002:a1c:b4c3:: with SMTP id d186-v6mr1108459wmf.4.1525956207083;
        Thu, 10 May 2018 05:43:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q7-v6sm1203303wrf.49.2018.05.10.05.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:43:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] get_short_oid: sort ambiguous objects by type, then SHA-1
Date:   Thu, 10 May 2018 12:43:02 +0000
Message-Id: <20180510124303.6020-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g4ac3413cc8
In-Reply-To: <20180510124303.6020-1-avarab@gmail.com>
References: <20180510124303.6020-1-avarab@gmail.com>
In-Reply-To: <20180501184016.15061-10-avarab@gmail.com>
References: <20180501184016.15061-10-avarab@gmail.com>
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

A note on the implementation: Derrick rightly pointed out[1] that
we're bending over backwards here in get_short_oid() to first
de-duplicate the list, and then emit it, but could simply do it in one
step.

The reason for that is that oid_array_for_each_unique() doesn't
actually require that the array be sorted by oid_array_sort(), it just
needs to be sorted in some order that guarantees that all objects with
the same ID are adjacent to one another, which (barring a hash
collision, which'll be someone else's problem) the sort_ambiguous()
function does.

I agree that would be simpler for this code, and had forgotten why I
initially wrote it like this[2]. But on further reflection I think
it's better to do more work here just so we're not underhandedly using
the oid-array API where we lie about the list being sorted. That would
break any subsequent use of oid_array_lookup() in subtle ways.

I could get around that by hacking the API itself to support this
use-case and documenting it, which I did as a WIP patch in [3], but I
think it's too much code smell just for this one call site. It's
simpler for the API to just introduce a oid_array_for_each() function
to eagerly spew out the list without sorting or de-duplication, and
then do the de-duplication and sorting in two passes.

1. https://public-inbox.org/git/20180501130318.58251-1-dstolee@microsoft.com/
2. https://public-inbox.org/git/876047ze9v.fsf@evledraar.gmail.com/
3. https://public-inbox.org/git/874ljrzctc.fsf@evledraar.gmail.com/

Helped-by: Derrick Stolee <dstolee@microsoft.com>
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
index 466a926aa3..265941fbf4 100644
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
2.17.0.410.g4ac3413cc8

