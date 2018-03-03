Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EE61F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeCCLgr (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:36:47 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:41169 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeCCLgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:36:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id f80so5136860pfa.8
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJkgctl5uBnp1sBgrIQzbi6GLN9U8CHxZ6t064IUPfs=;
        b=XVamM/t8dh0QKGmp0JjIkJMDU8uTrv64rg/ufNnFcv9Hn6Wjv3+B6zMP5xSFmEFDG6
         R6wWqfwZWs12cy1MIUQjWDI0Cv4BaQRTguvf/xsIWEBwn1s4OU0BIbDA4SuylahRMlx7
         7NWdSH3T1mLGOfgxjIGqEt7hDV/6wBEBb1IlmfCoz2UaejNrHhnp7h5WfYWurRAcYt00
         bhzc/mrSSOi6zJ7lHvg8b9xILvUrZAQ37L/dlh8h9ODiSUx8qN510MqFE0qziW952psP
         EIG46Yl2+TY+XI5GoS+DzSew7Oa6tgp34DWN/e4cYbj+OXNo57kOndeM2vMwuFJU9EM0
         i6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJkgctl5uBnp1sBgrIQzbi6GLN9U8CHxZ6t064IUPfs=;
        b=nXUEz9/6QorPkhQrjJ69Z7WTC69Nh5EPy/4i/lMjwE2Coic3u46CQj71E2/TDHrz0J
         kOiSnCKKVWPrpwbKCnX9sVDepYULwBr1l8rbYjJuVxjedN6g2tBtljXuBUQ1SZ4v0dI9
         96sBJJb17XDL1zSzilQrTWf9SsvAjwAkA6SF83Wj6Fzv9HmdEOZma0/fFL/T9o67gXu1
         GLLEqRfHXwJrxzPGzQB+pDWnhCZNdfKY/P2qd3zpWNMtg+0dtZLMCC79YVdhBAtIx1Uc
         w8xVEZZYKvnNLGSytVQ/hhkzEO2W6f8LduStSr4/0+r4QEI4hrfxXUraGXglCfy8Yimg
         4B9w==
X-Gm-Message-State: APf1xPBr9iHGblCB+cdSHpjNCqRIdmDzh6XpUfcWRdy243FraR3D+5f1
        GcKBNX7SGmSRlGmb5gSc/+WhQA==
X-Google-Smtp-Source: AG47ELsO9vKiwHeVV0L+LXt3/WrgHxSQ3ChxyR7jCr9+7k4j/aMm3wirDALVKXt3XTw/mN0JnXM5oQ==
X-Received: by 10.98.202.23 with SMTP id n23mr8831205pfg.52.1520077004675;
        Sat, 03 Mar 2018 03:36:44 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l19sm14938702pgn.31.2018.03.03.03.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:36:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:36:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/44] reroll nd/remove-ignore-env.. sb/object-store and sb/packfiles..
Date:   Sat,  3 Mar 2018 18:35:53 +0700
Message-Id: <20180303113637.26518-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 9:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 2:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Wed, Feb 28, 2018 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>>
>>>>> Looking at the full-series diff though, it makes me wonder if we
>>>>> should keep prepare_packed_git() private (i.e. how we initialize the
>>>>> object store, packfile included, is a private matter). How about
>>>>> something like this on top?
>>>>
>>>> Yup, that looks cleaner.
>>>
>>> I agree that it looks cleaner. So we plan on just putting
>>> it on top of that series?
>>
>> We tend to avoid "oops, that was wrong and here is a band aid on
>> top" for things that are still mushy, so it would be preferrable to
>> get it fixed inline, especially if there are more changes to the
>> other parts of the series coming.
>
> I agree with this. Stefan, if you're getting bored with rerolling
> refactor patches, I can update this series and send out v2.

Since Stefan is traveling, I take this opportunity to reroll it.
Unfortunately, I think the fix should go in 46cd557bd9 (object-store:
move packed_git and packed_git_mru to object store - 2018-02-23) where
we start removing the global "packed_git". But that's in
sb/object-store, so.. I'm rerolling all three

01/44 - 05/44: nd/remove-ignore-env-field

  This series is moved up top. After this the patch that touch
  alternate-db in sha1_file.c looks natural because no env is involved
  anymore

  I also take this opportunity to introduce a new patch 01/44 to avoid
  struct initialization that makes it hard to read and update. Later
  patches are also simplified thanks to this.

06/44 - 32/44: sb/object-store

  06/44 is updated to introduce raw_object_store_init() instead of
  RAW_OBJECT_STORE_INIT macro. This function is now used to initialize
  both main repo and submodule ones.

  10/44 (moving "packed_git") also introduces two new access wrapper
  get_packed_git() and get_packed_git_mru()

33/44 - 44/44: sb/packfiles-in-repository

  The only thing new here is 44/44 which makes prepare_packed_git()
  internal. get_packed_git() and get_packed_git_mru() introduced
  earlier will call prepare_packed_git() automatically.

The whole thing is also available at

https://github.com/pclouds/git/tree/ignore-env-object-store-packfiles

And interdiff of all three, compared to what is currently in 'pu'.
Looks pretty good in my opinon:

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index d480301763..ee6ae35244 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -121,9 +121,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf loose_buf = STRBUF_INIT;
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
-		if (!the_repository->objects.packed_git)
-			prepare_packed_git(the_repository);
-		for (p = the_repository->objects.packed_git; p; p = p->next) {
+
+		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 030c7fb7a0..9911c52bc8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -726,10 +726,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git(the_repository);
-
 			if (show_progress) {
-				for (p = the_repository->objects.packed_git; p;
+				for (p = get_packed_git(the_repository); p;
 				     p = p->next) {
 					if (open_pack_index(p))
 						continue;
@@ -738,7 +736,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 				progress = start_progress(_("Checking objects"), total);
 			}
-			for (p = the_repository->objects.packed_git; p;
+			for (p = get_packed_git(the_repository); p;
 			     p = p->next) {
 				/* verify gives error messages itself */
 				if (verify_pack(p, fsck_obj_buffer,
diff --git a/builtin/gc.c b/builtin/gc.c
index 80d19c54d5..be63bec09c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -173,8 +173,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git(the_repository);
-	for (cnt = 0, p = the_repository->objects.packed_git; p; p = p->next) {
+	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 142ec223cb..435f091a69 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1026,7 +1026,7 @@ static int want_object_in_pack(const struct object_id *oid,
 		if (want != -1)
 			return want;
 	}
-	list_for_each(pos, &the_repository->objects.packed_git_mru) {
+	list_for_each(pos, get_packed_git_mru(the_repository)) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		off_t offset;
 
@@ -1045,7 +1045,7 @@ static int want_object_in_pack(const struct object_id *oid,
 			want = want_found_object(exclude, p);
 			if (!exclude && want > 0)
 				list_move(&p->mru,
-					  &the_repository->objects.packed_git_mru);
+					  get_packed_git_mru(the_repository));
 			if (want != -1)
 				return want;
 		}
@@ -2674,7 +2674,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 
 	memset(&in_pack, 0, sizeof(in_pack));
 
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		struct object_id oid;
 		struct object *o;
 
@@ -2738,7 +2738,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	struct packed_git *p;
 
 	p = (last_found != (void *)1) ? last_found :
-					the_repository->objects.packed_git;
+					get_packed_git(the_repository);
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep) &&
@@ -2747,7 +2747,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 			return 1;
 		}
 		if (p == last_found)
-			p = the_repository->objects.packed_git;
+			p = get_packed_git(the_repository);
 		else
 			p = p->next;
 		if (p == last_found)
@@ -2783,7 +2783,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
 	uint32_t i;
 	struct object_id oid;
 
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local || p->pack_keep)
 			continue;
 
@@ -3151,10 +3151,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
-		for (p = the_repository->objects.packed_git; p; p = p->next)
+		for (p = get_packed_git(the_repository); p; p = p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -3167,7 +3166,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		 * also covers non-local objects
 		 */
 		struct packed_git *p;
-		for (p = the_repository->objects.packed_git; p; p = p->next) {
+		for (p = get_packed_git(the_repository); p; p = p->next) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3b02f94248..02b5f0becc 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -572,7 +572,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p = the_repository->objects.packed_git;
+	struct packed_git *p = get_packed_git(the_repository);
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
@@ -587,7 +587,7 @@ static struct pack_list * add_pack_file(const char *filename)
 
 static void load_all(void)
 {
-	struct packed_git *p = the_repository->objects.packed_git;
+	struct packed_git *p = get_packed_git(the_repository);
 
 	while (p) {
 		add_pack(p);
@@ -630,8 +630,6 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git(the_repository);
-
 	if (load_all_packs)
 		load_all();
 	else
diff --git a/common-main.c b/common-main.c
index 6a689007e7..7d716d5a54 100644
--- a/common-main.c
+++ b/common-main.c
@@ -34,6 +34,8 @@ int main(int argc, const char **argv)
 
 	git_setup_gettext();
 
+	initialize_the_repository();
+
 	attr_start();
 
 	git_extract_argv0_path(argv[0]);
diff --git a/environment.c b/environment.c
index b2128c1188..c05705e384 100644
--- a/environment.c
+++ b/environment.c
@@ -13,8 +13,8 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
-#include "object-store.h"
 #include "argv-array.h"
+#include "object-store.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
diff --git a/fast-import.c b/fast-import.c
index d2032e4ade..2298bfcdfd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1112,7 +1112,7 @@ static int store_object(
 		duplicate_count_by_type[type]++;
 		return 1;
 	} else if (find_sha1_pack(oid.hash,
-				  the_repository->objects.packed_git)) {
+				  get_packed_git(the_repository))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1308,7 +1308,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		truncate_pack(&checkpoint);
 
 	} else if (find_sha1_pack(oid.hash,
-				  the_repository->objects.packed_git)) {
+				  get_packed_git(the_repository))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -3472,7 +3472,6 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index defa6ba350..22d2e1668e 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -518,14 +518,13 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git(the_repository);
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
 	}
 
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
diff --git a/object-store.h b/object-store.h
index 9b1303549b..521f5a1755 100644
--- a/object-store.h
+++ b/object-store.h
@@ -90,9 +90,9 @@ struct raw_object_store {
 	/* Path to extra alternate object database if not NULL */
 	char *alternate_db;
 
-	struct packed_git *packed_git;
+	struct packed_git *packed_git; /* private */
 	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru;
+	struct list_head packed_git_mru; /* private */
 
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
@@ -112,8 +112,7 @@ struct raw_object_store {
 	unsigned packed_git_initialized : 1;
 };
 
-#define RAW_OBJECT_STORE_INIT(o) { NULL, NULL, NULL, LIST_HEAD_INIT(o.packed_git_mru), NULL, NULL, 0, 0, 0 }
-
+void raw_object_store_init(struct raw_object_store *o);
 void raw_object_store_clear(struct raw_object_store *o);
 
 /*
diff --git a/object.c b/object.c
index 5317cfc390..60ca76b285 100644
--- a/object.c
+++ b/object.c
@@ -447,6 +447,12 @@ void clear_commit_marks_all(unsigned int flags)
 	}
 }
 
+void raw_object_store_init(struct raw_object_store *o)
+{
+	memset(o, 0, sizeof(*o));
+	INIT_LIST_HEAD(&o->packed_git_mru);
+}
+
 static void free_alt_odb(struct alternate_object_database *alt)
 {
 	strbuf_release(&alt->scratch);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index bcc04bc45e..2a007b5539 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -335,8 +335,7 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git(the_repository);
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
 	}
diff --git a/packfile.c b/packfile.c
index 1a045157d0..773cd99a13 100644
--- a/packfile.c
+++ b/packfile.c
@@ -802,6 +802,7 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
 	strbuf_release(&path);
 }
 
+static void prepare_packed_git(struct repository *r);
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -882,7 +883,7 @@ static void prepare_packed_git_mru(struct repository *r)
 		list_add_tail(&p->mru, &r->objects.packed_git_mru);
 }
 
-void prepare_packed_git(struct repository *r)
+static void prepare_packed_git(struct repository *r)
 {
 	struct alternate_object_database *alt;
 
@@ -904,6 +905,18 @@ void reprepare_packed_git(struct repository *r)
 	prepare_packed_git(r);
 }
 
+struct packed_git *get_packed_git(struct repository *r)
+{
+	prepare_packed_git(r);
+	return r->objects.packed_git;
+}
+
+struct list_head *get_packed_git_mru(struct repository *r)
+{
+	prepare_packed_git(r);
+	return &r->objects.packed_git_mru;
+}
+
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
diff --git a/packfile.h b/packfile.h
index 6f7b9e91d6..efda10329c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -34,10 +34,12 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(struct repository *r);
 extern void reprepare_packed_git(struct repository *r);
 extern void install_packed_git(struct repository *r, struct packed_git *pack);
 
+struct packed_git *get_packed_git(struct repository *r);
+struct list_head *get_packed_git_mru(struct repository *r);
+
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
  * for speed.
diff --git a/repository.c b/repository.c
index 4f44384dde..34c0a7f180 100644
--- a/repository.c
+++ b/repository.c
@@ -5,16 +5,17 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo = {
-	NULL, NULL,
-	RAW_OBJECT_STORE_INIT(the_repo.objects),
-	NULL, NULL, NULL,
-	NULL, NULL, NULL,
-	&the_index,
-	&hash_algos[GIT_HASH_SHA1],
-	0
-};
-struct repository *the_repository = &the_repo;
+static struct repository the_repo;
+struct repository *the_repository;
+
+void initialize_the_repository(void)
+{
+	the_repository = &the_repo;
+
+	the_repo.index = &the_index;
+	raw_object_store_init(&the_repo.objects);
+	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
+}
 
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
@@ -134,12 +135,14 @@ static int read_and_verify_repository_format(struct repository_format *format,
  * Initialize 'repo' based on the provided 'gitdir'.
  * Return 0 upon success and a non-zero value upon failure.
  */
-int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
+static int repo_init(struct repository *repo,
+		     const char *gitdir,
+		     const char *worktree)
 {
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
-	INIT_LIST_HEAD(&repo->objects.packed_git_mru);
+	raw_object_store_init(&repo->objects);
 
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
diff --git a/repository.h b/repository.h
index e05a77a099..6c383c05c6 100644
--- a/repository.h
+++ b/repository.h
@@ -93,7 +93,7 @@ extern void repo_set_gitdir(struct repository *repo,
 			    const struct set_gitdir_args *optional);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
-extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern void initialize_the_repository(void);
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
 			       const char *path);
diff --git a/server-info.c b/server-info.c
index f5e4d1cc89..af737acd24 100644
--- a/server-info.c
+++ b/server-info.c
@@ -200,8 +200,7 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git(the_repository);
-	for (p = the_repository->objects.packed_git; p; p = p->next) {
+	for (p = get_packed_git(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
@@ -211,7 +210,7 @@ static void init_pack_info(const char *infofile, int force)
 	}
 	num_pack = i;
 	info = xcalloc(num_pack, sizeof(struct pack_info *));
-	for (i = 0, p = the_repository->objects.packed_git; p; p = p->next) {
+	for (i = 0, p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		info[i] = xcalloc(1, sizeof(struct pack_info));
diff --git a/sha1_name.c b/sha1_name.c
index 773322ac81..f25a0970ca 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -195,8 +195,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git(the_repository);
-	for (p = the_repository->objects.packed_git; p && !ds->ambiguous;
+	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -566,8 +565,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git(the_repository);
-	for (p = the_repository->objects.packed_git; p; p = p->next)
+	for (p = get_packed_git(the_repository); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-- 
2.16.1.435.g8f24da2e1a

