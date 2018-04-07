Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5911F404
	for <e@80x24.org>; Sat,  7 Apr 2018 04:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbeDGE6i (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 00:58:38 -0400
Received: from mout.web.de ([212.227.15.14]:40409 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbeDGE6h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 00:58:37 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MbMg8-1eo6S7211I-00IncU; Sat, 07
 Apr 2018 06:58:27 +0200
Subject: Re: [RFC PATCH 00/19] object-store refactoring 3 (replace objects,
 main ref store)
To:     Stefan Beller <sbeller@google.com>, jonathantanmy@google.com
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20180406232136.253950-1-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <38962a15-1081-bbdb-b4c4-6b46222b5f64@web.de>
Date:   Sat, 7 Apr 2018 06:58:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yQdm5aINjRY7Rhdq6LRQ+BKZkQLg/7Gi7D0b1j6oj/W8d5helaa
 TGE/AgL+bWbigzZq6KBcRI94KHcUAvISwtv+ImkkWqzWceOUm5eiuDUsZgjFtvcE6B80s82
 HSnVQEvINtFwfIOzb1gu/gyGdM77FnZHDprLFFCFwnTdS6ozX4jHLhXGvUzq+RY8PtkYvDY
 opdbFF6L8rnXTtf+Fb4eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XC7XuxmUMKI=:GVpjJSlJN6KDfE0r6pe64c
 PNkWoOlsoNTCxNXXSGsya26s+PR1i9lE8Kbbm6ZRjzG9fsqRrdoooef4BGOaigfqFC2zAiCRW
 J9GeVPdlaa8H4xLVd+dNGSbMo075ffDDwdn4+wRYZJCEuNZhfZ1/2SEF2gnRy0E8zMJBcn9Ga
 9egQ7Fx2sLUqkKjviebR6mRJ+W4z8o588PBi86MF0xjX5RZd/EMN696Jk4UkvLS5qRVW6PraT
 AMTCwpSXzk+9gS45Tzj38I65JtmVM5Izd8PPz7aS23/Q3KdbEWE0KU43dAmrFBeKgzfyANyLE
 B9UI6Z8Q8L5MVVq1g2vVcgO2SqT9BQZGc4mfrJ7+lHH8E6/mbw1QKtQruuICjKB1Mo++HH56T
 H95Yp/QTxY9UnYx2o8Kd+CJd1BulmgD3A0bYsbmvvu6oh42QPw/SD0xRQFxoHl/C54owt37Fg
 W/6Je7WHUsaMlhlPlWaV5k4zcopgPs4LNGLOrDj8xuaEPNk8QvbBPAXxfYVBdxhW0m++lkrd4
 5PkIXwXrOC0b57ztrE6W599jTNgKTTzQzb6AG2F8lavdb1fDck19ym/eEgtkukjo1ATNUde7s
 OicWlyA4PAB6slulIPBrClNyxbJlseRMbdOgBFEniJEcUmlxgICq1X9DAFH4vT0WGRifLQ5CD
 fHRE1wrOfkiLqIckP738NuG3/KKl1WiVR6lqowBs3wcVrbQWgvIx81j6izOyw3ig190EXHqth
 i3Z/waez3X/D8lgrICMxp9pIpBkDcQ80x76st1Mvg1wg3NUiaVmu7XliP4W7IUGMi1udSTepA
 0M0qQOgazQ3J6ReZDz0SdDTjrh8MBc7LReqJ7RDVu59mrFIqdg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.2018 um 01:21 schrieb Stefan Beller:
> This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
> (sb/packfiles-in-repository).
> It is also available at https://github.com/stefanbeller/git/tree/object-store-3

This series conflicts with 1731a1e239 (replace_object: convert struct
replace_object to object_id) and b383a13cc0 (Convert
lookup_replace_object to struct object_id), which are in next.

> This series will bring the replacement mechanism (git replace)
> into the object store.

Good idea.

>   $ git diff 464416a2eaadf84d2bfdf795007863d03b222b7c..HEAD -- object-store.h repository.h
> diff --git a/object-store.h b/object-store.h
> index fef33f345f..be90c02db6 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -93,6 +93,22 @@ struct raw_object_store {
>          struct alternate_object_database *alt_odb_list;
>          struct alternate_object_database **alt_odb_tail;
>   
> +       /*
> +        * Objects that should be substituted by other objects
> +        * (see git-replace(1)).
> +        */
> +       struct replace_objects {
> +               /*
> +                * An array of replacements.  The array is kept sorted by the original
> +                * sha1.
> +                */
> +               struct replace_object **items;
> +
> +               int alloc, nr;
> +
> +               unsigned prepared : 1;
> +       } replacements;

An oidmap would be a better fit -- lookups should be quicker and
memory consumption not much worse.  I meant to submit something like
this eventually after Brian's series lands:

-- >8 --
Subject: [PATCH] replace_object: use oidmap

Load the replace objects into an oidmap to allow for easy lookups in
constant time.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This is on top of next.

 replace_object.c | 76 ++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 60 deletions(-)

diff --git a/replace_object.c b/replace_object.c
index 336357394d..a757a5ebf2 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -1,54 +1,14 @@
 #include "cache.h"
-#include "sha1-lookup.h"
+#include "oidmap.h"
 #include "refs.h"
 #include "commit.h"
 
-/*
- * An array of replacements.  The array is kept sorted by the original
- * sha1.
- */
-static struct replace_object {
-	struct object_id original;
+struct replace_object {
+	struct oidmap_entry original;
 	struct object_id replacement;
-} **replace_object;
-
-static int replace_object_alloc, replace_object_nr;
+};
 
-static const unsigned char *replace_sha1_access(size_t index, void *table)
-{
-	struct replace_object **replace = table;
-	return replace[index]->original.hash;
-}
-
-static int replace_object_pos(const unsigned char *sha1)
-{
-	return sha1_pos(sha1, replace_object, replace_object_nr,
-			replace_sha1_access);
-}
-
-static int register_replace_object(struct replace_object *replace,
-				   int ignore_dups)
-{
-	int pos = replace_object_pos(replace->original.hash);
-
-	if (0 <= pos) {
-		if (ignore_dups)
-			free(replace);
-		else {
-			free(replace_object[pos]);
-			replace_object[pos] = replace;
-		}
-		return 1;
-	}
-	pos = -pos - 1;
-	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
-	replace_object_nr++;
-	if (pos < replace_object_nr)
-		MOVE_ARRAY(replace_object + pos + 1, replace_object + pos,
-			   replace_object_nr - pos - 1);
-	replace_object[pos] = replace;
-	return 0;
-}
+static struct oidmap replace_map = OIDMAP_INIT;
 
 static int register_replace_ref(const char *refname,
 				const struct object_id *oid,
@@ -59,7 +19,7 @@ static int register_replace_ref(const char *refname,
 	const char *hash = slash ? slash + 1 : refname;
 	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
 
-	if (get_oid_hex(hash, &repl_obj->original)) {
+	if (get_oid_hex(hash, &repl_obj->original.oid)) {
 		free(repl_obj);
 		warning("bad replace ref name: %s", refname);
 		return 0;
@@ -69,7 +29,7 @@ static int register_replace_ref(const char *refname,
 	oidcpy(&repl_obj->replacement, oid);
 
 	/* Register new object */
-	if (register_replace_object(repl_obj, 1))
+	if (oidmap_put(&replace_map, repl_obj))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
@@ -84,7 +44,7 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	replace_object_prepared = 1;
-	if (!replace_object_nr)
+	if (!replace_map.map.tablesize)
 		check_replace_refs = 0;
 }
 
@@ -100,21 +60,17 @@ static void prepare_replace_object(void)
  */
 const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 {
-	int pos, depth = MAXREPLACEDEPTH;
+	int depth = MAXREPLACEDEPTH;
 	const struct object_id *cur = oid;
 
 	prepare_replace_object();
 
 	/* Try to recursively replace the object */
-	do {
-		if (--depth < 0)
-			die("replace depth too high for object %s",
-			    oid_to_hex(oid));
-
-		pos = replace_object_pos(cur->hash);
-		if (0 <= pos)
-			cur = &replace_object[pos]->replacement;
-	} while (0 <= pos);
-
-	return cur;
+	while (depth-- > 0) {
+		struct replace_object *repl_obj = oidmap_get(&replace_map, cur);
+		if (!repl_obj)
+			return cur;
+		cur = &repl_obj->replacement;
+	}
+	die("replace depth too high for object %s", oid_to_hex(oid));
 }
-- 
2.17.0
