Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F75D20281
	for <e@80x24.org>; Sat,  4 Nov 2017 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756562AbdKDJGE (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 05:06:04 -0400
Received: from mout.web.de ([212.227.15.4]:51336 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756555AbdKDJGB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 05:06:01 -0400
Received: from [192.168.178.36] ([91.20.50.17]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRRay-1diQDF3Trs-00Shzr; Sat, 04
 Nov 2017 10:05:41 +0100
Subject: Re: [PATCH 2/3] http-push: use hex_to_bytes()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
 <31ce5c1c-cab3-80aa-623b-43f91ddd2162@web.de>
 <20171101195530.odscytks7jvgukbs@sigill.intra.peff.net>
 <0e7f821a-94ae-3946-fb99-c508a06a6847@web.de>
 <20171101221541.6dwezd4t4hweuis2@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <abf7c219-880b-790f-78ef-18c7cdd54ad6@web.de>
Date:   Sat, 4 Nov 2017 10:05:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171101221541.6dwezd4t4hweuis2@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:MUVGArryjpKRjTCzhx/rbZsBokaBz7sywT3T7JU8L0wN0LfIDN8
 21ptU3pO/xq04yyzNdBYoJueiye5Hu4kT5ntRRGslMkF7bgAfPizigHQ1vaK6/DAszVLxDE
 g3BijSBoA+7FdHQo0AB+ggoCjTFCEUAdysjHzuMNTOcUdjNvG1T2kJDZb1yUdAfWRoA1XL3
 RPM2QSqjjhXg0/JuQ+Ydw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ry5BigK7FuI=:WJLs3LXVF7Mt1JFyYsGg90
 5HsdLGF5NnCHFwVioX0o4vzhxY9tij9v4GZro2OpCbOqcUxzhlIfZUUuVvE13L3ShFMACHFjl
 A1ZGviMHkKDpkZH8PdKFCwR/ME7B3/84c1b2WQlRNB0hSorUBAWJSEsCjJmdIChkSQMDOM5FZ
 61w8GnDkoW7c+DVAdvhzLJpm548ZlgJhAijR1GtrjS3r2JIDo6B9fs6k+8pqb4vbX1bB5adGs
 DuAjzIaYV2S8BLp9JFpg/LpoVjD6E3RAU1tBp1OGWJ5pxvpjDLHZnZw/sgp1CqTKJZqkLJ/Q6
 NtOdTzY+5egGQW2oFmqU0J4zDCaK0MjPpMWlFv/VAsMOWKrNkI+Q5vvLgqQsCdScLgLqPF7C5
 b3Szcxcn43oJaXPTemy2oxqVBaSiwb5QKUeCOTzyrWySSRFNCPso1Sh1Ff2N1LO4DAd/MyrYB
 TrbJtifNJNuKXeV5QRD3jhFCVe/USnwTpusaz3o+AQpBuCzjxnVOFtpwkYr3vsnZd8RVviGrF
 iSm54cglfmhAVo9mB//FM83Ek7jBuocqiuiZxNIaFynRJCp2O850oiFObJkf8pTwV41zQZ6mN
 FJaRIev8c/c/zM43AOlLLJBcu1ovGnITQpFqqKudPzo2klSP7YB1MFZahkL6THoIeNwcsxwxZ
 1w9Vo5e24Tf22lCo8opTzgprLxGOEVZbj6wOwZpTdpS/M5+RL/A61/cChFTKErvXn9ScCeoXs
 edUCzczVRaG1A4OTOJYPJ4DP+9uyDBrWqH9OATXP1oTL0qosr0yDaLRjEWf8BWuuPNraQkL+0
 XMTi8s0CqG2rBCjdCk6rrfscR9ryxzP2Yw25PqfpFYOhHSTfj0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.2017 um 23:15 schrieb Jeff King:
> On Wed, Nov 01, 2017 at 10:59:49PM +0100, René Scharfe wrote:
> 
>>> The hex_to_bytes() function requires that the caller make sure they have
>>> the right number of bytes. But for many callers, I think they'd want to
>>> say "parse this oid, which might be truncated; I can't tell what the
>>> length is supposed to be".
>>
>> I'm confused by the word "many".  After this series there are three
>> callers of hex_to_bytes() and I don't expect that number to grow.
> 
> I meant only that most callers that parse oids, both in-file and not,
> would want to stop knowing about the length ahead of time.

That's a good idea.

> I'm not sure we know 100%
> yet what "new"-style hashes will look like, nor how their loose-object
> filenames would look.

So it's too early to implement a solution, but here's how a patch for
reducing dependency on hash lengths could look like today:

---
 cache.h     |  2 ++
 hex.c       | 13 +++++++++++++
 http-push.c |  7 +++----
 notes.c     |  6 +-----
 sha1_file.c |  4 +---
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index f06bfbaf32..acd3804c21 100644
--- a/cache.h
+++ b/cache.h
@@ -1317,6 +1317,8 @@ extern int set_disambiguate_hint_config(const char *var, const char *value);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern int get_oid_hex(const char *hex, struct object_id *sha1);
 
+extern int get_oid_hex_tail(const char *hex, struct object_id *oid, size_t offset);
+
 /*
  * Read `len` pairs of hexadecimal digits from `hex` and write the
  * values to `binary` as `len` bytes. Return 0 on success, or -1 if
diff --git a/hex.c b/hex.c
index 8df2d63728..3e6abe4d5e 100644
--- a/hex.c
+++ b/hex.c
@@ -47,6 +47,19 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 	return 0;
 }
 
+int get_oid_hex_tail(const char *hex, struct object_id *oid, size_t offset)
+{
+	for (; offset < GIT_SHA1_RAWSZ; offset++, hex += 2) {
+		int val = hex2chr(hex);
+		if (val < 0)
+			return -1;
+		oid->hash[offset] = val;
+	}
+	if (*hex)
+		return -1;
+	return 0;
+}
+
 int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
diff --git a/http-push.c b/http-push.c
index 14435ab65d..a5512616b9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1007,18 +1007,17 @@ static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData);
 
-/* extract hex from sharded "xx/x{38}" filename */
+/* extract hex from sharded "xx/x{N}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 {
-	if (strlen(path) != GIT_SHA1_HEXSZ + 1)
+	if (strnlen(path, 3) < 3)
 		return -1;
-
 	if (hex_to_bytes(oid->hash, path, 1))
 		return -1;
 	path += 2;
 	path++; /* skip '/' */
 
-	return hex_to_bytes(oid->hash + 1, path, GIT_SHA1_RAWSZ - 1);
+	return get_oid_hex_tail(path, oid, 1);
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)
diff --git a/notes.c b/notes.c
index 04f8c8613c..ff6ce57022 100644
--- a/notes.c
+++ b/notes.c
@@ -410,17 +410,13 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct leaf_node *l;
 		size_t path_len = strlen(entry.path);
 
-		if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
+		if (!get_oid_hex_tail(entry.path, &object_oid, prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
 
 			if (!S_ISREG(entry.mode))
 				/* notes must be blobs */
 				goto handle_non_note;
 
-			if (hex_to_bytes(object_oid.hash + prefix_len, entry.path,
-					 GIT_SHA1_RAWSZ - prefix_len))
-				goto handle_non_note; /* entry.path is not a SHA1 */
-
 			type = PTR_TYPE_NOTE;
 		} else if (path_len == 2) {
 			/* This is potentially an internal node */
diff --git a/sha1_file.c b/sha1_file.c
index a3c32d91d1..0486696b0b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1911,9 +1911,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		strbuf_setlen(path, baselen);
 		strbuf_addf(path, "/%s", de->d_name);
 
-		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
-		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  GIT_SHA1_RAWSZ - 1)) {
+		if (!get_oid_hex_tail(de->d_name, &oid, 1)) {
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)
-- 
2.15.0
