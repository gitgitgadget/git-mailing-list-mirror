Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91951F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeKBPLK (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:11:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40308 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeKBPLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:11:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id i17-v6so757966wre.7
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=suEkrI/ISCMsvAgxbxyn2lELXeMSbjLZrKakeL2un08=;
        b=f09pFQFxVNYY+NkGwmiXHkeFSdzUmxCZzQG7ffaiw/yQxp0QVJUSG5IKkf1VeDCeJL
         N4gwlGcZA97SfJ8+oc6ZjJAMQJPw77p3gcqKqq0Tmk4Wrh7JyJYgQxSpUBswHGiXSVy5
         UwxznGFzd+fFB9gT5Dg4ekJKKlTyNIH+UogbenR9S18rn4lLZtYE7ZqmNqorJsDB+i69
         8TVyyw1G2YjGmC5orhyODu19PYeg1RIlRyMF3hWjOBzqAWaCL+nXDNhWLFb6TYOuliK8
         FYK0/3QqAxlQa/VQomKOLXVEYP8RXJjQi5xgX9WQRUOfKdpkOfaKo9KFmEQnPGk/Ax5G
         rOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=suEkrI/ISCMsvAgxbxyn2lELXeMSbjLZrKakeL2un08=;
        b=h5RyNMsTbzs/daRsfbSdGNJRRXz8LpiAvXeG9wtrBkgQl9vfUtxzyQ9pdE/oEe6wi5
         8506MIzre0cUvCGkqK8wtw5GvhxdYJ+wc4HSlath3Vk5tSukp9TFlfy7P7KQKcU2QjR7
         5LJM3L1Rrd1SG/P1oxx0XV424yUs1ZDTx5g4T5GigG24VCcLpkyVqOPCcXWOFPAPQ7Zn
         sjO2O3O0YPjzN0DbLFsFP1DWSe3+xdGHA6VFSQye/f/JL8oRB+qtgCoYXMVbSaWxfz4t
         G3FHWrXzogFIKbEShC+zdELDaNz/Kw50Sh+6gVCAGoqRZ1LY9QWyj7uBVQuSipNWJ3pr
         qtTg==
X-Gm-Message-State: AGRZ1gI2DkETvra1LInJUchBUoG2tAmDNUIOyNV9XyOMv0DyGOq/EsAy
        wxH/UjN8XtraeiVfxTc2F+QMD2LuB/4=
X-Google-Smtp-Source: AJdET5e5bp8C/9VQz1SYUY/HhHZ0P8oNlRFpyVhXQBK8VRR2eQji3zOQyUwgBCKnqhCuPLh6q4k3dg==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr8632480wrw.136.1541138707983;
        Thu, 01 Nov 2018 23:05:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g10-v6sm5758842wru.39.2018.11.01.23.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 23:05:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] it's called read_object_file() these days
Date:   Fri, 02 Nov 2018 15:05:03 +0900
Message-ID: <xmqqpnvoovzk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remnant of the old name of the function still remains in comments.
Update them all.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c       | 2 +-
 builtin/gc.c  | 2 +-
 fast-import.c | 4 ++--
 notes.c       | 2 +-
 object.h      | 2 +-
 sha1-file.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index 073d5f0451..ef1a1b2c4e 100644
--- a/apply.c
+++ b/apply.c
@@ -3254,7 +3254,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		result = read_object_file(oid, &type, &sz);
 		if (!result)
 			return -1;
-		/* XXX read_sha1_file NUL-terminates */
+		/* XXX read_object_file NUL-terminates */
 		strbuf_attach(buf, result, sz, sz + 1);
 	}
 	return 0;
diff --git a/builtin/gc.c b/builtin/gc.c
index 871a56f1c5..a682a0f44e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -285,7 +285,7 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
 	/* revindex is used also */
 	heap += sizeof(struct revindex_entry) * nr_objects;
 	/*
-	 * read_sha1_file() (either at delta calculation phase, or
+	 * read_object_file() (either at delta calculation phase, or
 	 * writing phase) also fills up the delta base cache
 	 */
 	heap += delta_base_cache_limit;
diff --git a/fast-import.c b/fast-import.c
index 95600c78e0..f73b2ae0a6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1298,13 +1298,13 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
  * oe must not be NULL.  Such an oe usually comes from giving
  * an unknown SHA-1 to find_object() or an undefined mark to
  * find_mark().  Callers must test for this condition and use
- * the standard read_sha1_file() when it happens.
+ * the standard read_object_file() when it happens.
  *
  * oe->pack_id must not be MAX_PACK_ID.  Such an oe is usually from
  * find_mark(), where the mark was reloaded from an existing marks
  * file and is referencing an object that this fast-import process
  * instance did not write out to a packfile.  Callers must test for
- * this condition and use read_sha1_file() instead.
+ * this condition and use read_object_file() instead.
  */
 static void *gfi_unpack_entry(
 	struct object_entry *oe,
diff --git a/notes.c b/notes.c
index 25cdce28b7..6a430931a3 100644
--- a/notes.c
+++ b/notes.c
@@ -858,7 +858,7 @@ static int string_list_add_note_lines(struct string_list *list,
 	if (is_null_oid(oid))
 		return 0;
 
-	/* read_sha1_file NUL-terminates */
+	/* read_object_file NUL-terminates */
 	data = read_object_file(oid, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
diff --git a/object.h b/object.h
index 0feb90ae61..4cabc9f278 100644
--- a/object.h
+++ b/object.h
@@ -136,7 +136,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid);
  */
 struct object *parse_object_or_die(const struct object_id *oid, const char *name);
 
-/* Given the result of read_sha1_file(), returns the object after
+/* Given the result of read_object_file(), returns the object after
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..31c2b926fe 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -124,7 +124,7 @@ const char *empty_blob_oid_hex(void)
 
 /*
  * This is meant to hold a *small* number of objects that you would
- * want read_sha1_file() to be able to return, but yet you do not want
+ * want read_object_file() to be able to return, but yet you do not want
  * to write them into the object store (e.g. a browse-only
  * application).
  */
