Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4C31F404
	for <e@80x24.org>; Sat,  3 Mar 2018 02:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935840AbeCCCrQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 21:47:16 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:43222 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935762AbeCCCrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 21:47:15 -0500
Received: by mail-pf0-f175.google.com with SMTP id j2so2627101pff.10
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 18:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVXl63DR7vM5ZCSirDlGIfiAloqd19Ueo4mA28OfF9c=;
        b=CaJfOdpmfrjnaDgcPgkwtyt/J/3ixmUN7FHvjgh8+8nVAyrbSvbrRHrdEwz76MLFuE
         0OyXiGLTLeGuW8JT6wUVv/aixWBWnWDLYTO2WaT3sz0uyjlk9IWpuxXw0zUK/yJQ3dPR
         ggfv4C63err18ligHbTlqKF+NfUNJMBYspicm3oJ28GsEX0TmOQgjOjTtLIDb+7mTIWE
         IlpRozlO3WZk/jLhQ0YDPflZG5qMx28g8u3M1TCB649gSy3xTVAIce/HwSk0k0O0ZMzb
         w5nDNNfKvmyRWtAkSY6Vo8Pa9+fKu4vN0mMiVJdr85XD4cneICBlLahTw7Hfc3D7VSJi
         9R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVXl63DR7vM5ZCSirDlGIfiAloqd19Ueo4mA28OfF9c=;
        b=EnoVd5uwKWGgzlwKaEQ5+FGtT17OaRNcmNjZx+kAvXlDuLxo2WQNmf3cB0gnRx4564
         hUuKHGadLc1Cmj3+AZUoBQZuNPiyji8ePeJLVk8+0eA3wwhVKnKq7MGFxmbSLwFYb6TS
         m1qCWO/v/6dCeOY9YgDVpqKm5K5UaqNySAANg+jDnnjYGOZDAWGe05JLVqfkVudww0MJ
         E7FRhHe4Y0srhFEjsVCcS8/SlIAxqdWQ2vboKw0bvH7V2Mo6YVg99rAMC9RhkQLWwK2P
         Y6NomcFO1eEpXKzTogXGUOF/mVvRnH5xumspC9c6SAzjHgsavqQipSHtaaPltMeZ4vzV
         apJA==
X-Gm-Message-State: APf1xPALL+HMNg/YoDh5QauGUJ85jlGfePa5VEpKv6melrEq4Hc0m2j2
        6bxowvmRre1t3gWmd+5NsJaVPw==
X-Google-Smtp-Source: AG47ELuiDCjz8fUYLc6fJwz4XGqyvARK16QJLG2LUMJWQuTl+tCqP1Zx8hYXj4QuBFD0R5SDSFMaGw==
X-Received: by 10.99.119.72 with SMTP id s69mr6140852pgc.224.1520045234126;
        Fri, 02 Mar 2018 18:47:14 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id x9sm11763919pgc.81.2018.03.02.18.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 18:47:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:47:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC v2 0/9] Reduce pack-objects memory footprint
Date:   Sat,  3 Mar 2018 09:46:57 +0700
Message-Id: <20180303024706.31465-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The array of object_entry in pack-objects can take a lot of memory
when pack-objects is run in "pack everything" mode. On linux-2.6.git,
this array alone takes roughly 800MB.

This series reorders some fields and reduces field size... to keep
this struct smaller. Its size goes from 136 bytes to 96 bytes (29%) on
64-bit linux and saves 260MB on linux-2.6.git.

v2 only differs in limits, documentation and a new escape hatch for
the pack file limit.

Now the bad side:

- the number of pack files pack-objects can handle is reduced to 16k
  (previously unlimited, v1 has it at 4k)
- max delta chain is also limited to 4096 (previously practically
  unlimited), same as v1
- some patches are quite invasive (e.g. replacing pointer with
  uint32_t) and reduces readability a bit.
- it may be tricker to add more data in object_entry in the future.

In v1, if the total pack count is above the 4k limit, pack-objects
dies. v2 is a bit smarter and only count packs that do not have the
companion .keep files. This allows users with 16k+ pack files to
continue to use pack-objects by first adding .keep to reduce pack
count, repack, remove (some) .keep files, repack again...

While this process could be automated at least by 'git repack', given
the unbelievably high limit 16k, I don't think it's worth doing it.

Interdiff

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10c..9bd3f5a789 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2412,6 +2412,7 @@ pack.window::
 pack.depth::
 	The maximum delta depth used by linkgit:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
+	Maximum value is 4095.
 
 pack.windowMemory::
 	The maximum size of memory that is consumed by each thread
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..b8d936ccf5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -96,7 +96,9 @@ base-name::
 	it too deep affects the performance on the unpacker
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
@@ -267,6 +269,15 @@ Unexpected missing object will raise an error.
 	locally created objects [without .promisor] and objects from the
 	promisor remote [with .promisor].)  This is used with partial clone.
 
+LIMITATIONS
+-----------
+
+This command could only handle 16384 existing pack files at a time.
+If you have more than this, you need to exclude some pack files with
+".keep" file and --honor-pack-keep option, to combine 16k pack files
+in one, then remove these .keep files and run pack-objects one more
+time.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ae750e9e11..25c83c4927 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -90,7 +90,9 @@ other objects in that pack they already have locally.
 	space. `--depth` limits the maximum delta depth; making it too deep
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
-	The default value for --window is 10 and --depth is 50.
++
+The default value for --window is 10 and --depth is 50. The maximum
+depth is 4095.
 
 --threads=<n>::
 	This option is passed through to `git pack-objects`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 45076f2523..55f19a1f18 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1038,7 +1038,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (*found_pack) {
 		want = want_found_object(exclude, *found_pack);
 		if (want != -1)
-			return want;
+			goto done;
 	}
 
 	list_for_each(pos, &packed_git_mru) {
@@ -1061,11 +1061,27 @@ static int want_object_in_pack(const struct object_id *oid,
 			if (!exclude && want > 0)
 				list_move(&p->mru, &packed_git_mru);
 			if (want != -1)
-				return want;
+				goto done;
 		}
 	}
 
-	return 1;
+	want = 1;
+done:
+	if (want && *found_pack && !(*found_pack)->index) {
+		struct packed_git *p = *found_pack;
+
+		if (to_pack.in_pack_count >= (1 << OE_IN_PACK_BITS))
+			die(_("too many packs to handle in one go. "
+			      "Please add .keep files to exclude\n"
+			      "some pack files and keep the number "
+			      "of non-kept files below %d."),
+			    1 << OE_IN_PACK_BITS);
+
+		p->index = to_pack.in_pack_count++;
+		to_pack.in_pack[p->index] = p;
+	}
+
+	return want;
 }
 
 static void create_object_entry(const struct object_id *oid,
@@ -1088,6 +1104,8 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
+		if (found_pack->index <= 0)
+			die("BUG: found_pack should be NULL instead of having non-positive index");
 		entry->in_pack_idx = found_pack->index;
 		entry->in_pack_offset = found_offset;
 	}
@@ -2978,18 +2996,12 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 
 static void init_in_pack_mapping(struct packing_data *to_pack)
 {
-	struct packed_git *p;
-	int i = 0;
-
 	/* let IN_PACK() return NULL if in_pack_idx is zero */
-	to_pack->in_pack[i++] = NULL;
-
-	for (p = packed_git; p; p = p->next, i++) {
-		if (i >= (1 << OE_IN_PACK_BITS))
-			die("BUG: too many packs to handle!");
-		to_pack->in_pack[i] = p;
-		p->index = i;
-	}
+	to_pack->in_pack[to_pack->in_pack_count++] = NULL;
+	/*
+	 * the rest is lazily initialized only for packs that we want
+	 * in want_object_in_pack().
+	 */
 }
 
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
diff --git a/pack-objects.h b/pack-objects.h
index ec4eba4ee4..a57aca5f03 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -3,7 +3,7 @@
 
 #define OE_DFS_STATE_BITS 2
 #define OE_DEPTH_BITS 12
-#define OE_IN_PACK_BITS 12
+#define OE_IN_PACK_BITS 14
 
 #define IN_PACK_POS(to_pack, obj) \
 	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
@@ -60,7 +60,7 @@ struct object_entry {
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 96 */
+	/* size: 96, bit_padding: 18 bits */
 };
 
 struct packing_data {
@@ -71,6 +71,7 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
+	int in_pack_count;
 	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
 };
 

Nguyễn Thái Ngọc Duy (9):
  pack-objects: document holes in struct object_entry.h
  pack-objects: turn type and in_pack_type to bitfields
  pack-objects: use bitfield for object_entry::dfs_state
  pack-objects: use bitfield for object_entry::depth
  pack-objects: note about in_pack_header_size
  pack-objects: move in_pack_pos out of struct object_entry
  pack-objects: move in_pack out of struct object_entry
  pack-objects: refer to delta objects by index instead of pointer
  pack-objects: reorder 'hash' to pack struct object_entry

 Documentation/config.txt           |   1 +
 Documentation/git-pack-objects.txt |  13 +-
 Documentation/git-repack.txt       |   4 +-
 builtin/pack-objects.c             | 207 +++++++++++++++++++----------
 cache.h                            |   3 +
 object.h                           |   1 -
 pack-bitmap-write.c                |   8 +-
 pack-bitmap.c                      |   2 +-
 pack-bitmap.h                      |   4 +-
 pack-objects.h                     |  71 ++++++----
 10 files changed, 212 insertions(+), 102 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

