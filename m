Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACAF120437
	for <e@80x24.org>; Tue, 31 Oct 2017 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdJaNuW (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 09:50:22 -0400
Received: from mout.web.de ([217.72.192.78]:63714 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753085AbdJaNuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 09:50:21 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGRZc-1dwHOC3wky-00DJ1s; Tue, 31
 Oct 2017 14:50:09 +0100
Subject: [PATCH 3/3] sha1_file: use hex_to_bytes()
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d8f73744-b3f5-0fca-d58c-1f60e79214e0@web.de>
Date:   Tue, 31 Oct 2017 14:50:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:p9J0wB78GaE/M4QcZ12rNThjrh3rQdSMXDCbQjrV8WEGjQuFZg2
 +TAZxwyx7aGb+1uNiHLJypKEry1BQA7DgfgkMz/HW74Ic4wuzJ/Tl+qCNxghUanc1+88zKi
 w2dCEu4H2jRJcBD9vcHLj9+XERTcu4kEgVJi492nhtJVit2bfSzrh9AMe0PTVHszxoUMIs3
 NLYA7u9jWT+a/JY23MaOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qRAqNTw1Kd4=:F2aNaMgbgj1/1dd13drIYI
 9eMhEU1TjKas8IkCGjw4xU+wS4eB/8M8Y2ZBlJDhAz8CAFLRmBk2mVHKTXelhHfhG2LtZuoEA
 ov0HPyWqDPHgWon9/xswSg1BKXjdWfakYICotRS6eIeIvclfM6Yb6/U9kAN47ztMJufUlKzoQ
 JyBAsvWmCGpA4grXUb325rUUyNAZTwW4k6bt+Ad51aSJwRSItPCtrMcoFZENe7bDczYDQgnPf
 97g0gvstS5PedFObNTQvMnFCeAYKWkfAPDJ7tyH4pVpgPALixm1688xgAGT+XNJG6OjLJP3GK
 rQ3ZMUaaPMUdt8rQrAYDxvsbQnfzX+dt5otHygWMFyvK+8aNDriNyDqmOlQBvCcy3Tg4gbOnx
 Nx6wa36heoCQ4cyKr9/nFGx61Ea/PjKywvOt5SjtcE4TbEgOy7d1kyzQSMWFlZFFbeHiREGKT
 UYkh+pN5Bn9cILxzTGwA+314Dca556pcQomuzVyJ64mSJQBECRS0kMv3HOzqis0f04YrVCJZp
 yCRAzDfTWWtdg7q3bnk5NJWZsr8DMFIWYYM47cBOhiSYH9/Iq3NHJLd1Zy/vRplOabgA/IEYU
 SJUyZsUg73ZD/XCfUT3d8qz7T+VOhTeJt0/gNCl9GXgetnSDZNi/f1NlohS3WMcDWTOK3p0im
 HLp6sEhaZYp8NafT3xfKtckFHKJ2HjHfbA5YCKJzhDVpbUhXi3mLn5lA3Z/reUQzPf9Zk1pmf
 D1eDi6P+MsJX/pBuLzN8eLmxgOfmzCz9YWkM3Y4/6d78Vi9W0oNx0LbaJyoyURSgO7WB94/KE
 jZvEcOVvW9V/neP7iT5t7MNKsKexDFf+bs+701W4jlma0SLqT8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The path of a loose object contains its hash value encoded into two
substrings of 2 and 38 hexadecimal digits separated by a slash.  The
first part is handed to for_each_file_in_obj_subdir() in decoded form as
subdir_nr.  The current code builds a full hexadecimal representation of
the hash in a temporary buffer, then uses get_oid_hex() to decode it.

Avoid the intermediate step by taking subdir_nr as-is and using
hex_to_bytes() directly on the second substring.  That's shorter and
easier.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 10c3a0083d..a3c32d91d1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1884,6 +1884,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	DIR *dir;
 	struct dirent *de;
 	int r = 0;
+	struct object_id oid;
 
 	if (subdir_nr > 0xff)
 		BUG("invalid loose object subdirectory: %x", subdir_nr);
@@ -1901,6 +1902,8 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		return r;
 	}
 
+	oid.hash[0] = subdir_nr;
+
 	while ((de = readdir(dir))) {
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
@@ -1908,20 +1911,15 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		strbuf_setlen(path, baselen);
 		strbuf_addf(path, "/%s", de->d_name);
 
-		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2)  {
-			char hex[GIT_MAX_HEXSZ+1];
-			struct object_id oid;
-
-			xsnprintf(hex, sizeof(hex), "%02x%s",
-				  subdir_nr, de->d_name);
-			if (!get_oid_hex(hex, &oid)) {
-				if (obj_cb) {
-					r = obj_cb(&oid, path->buf, data);
-					if (r)
-						break;
-				}
-				continue;
+		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
+		    !hex_to_bytes(oid.hash + 1, de->d_name,
+				  GIT_SHA1_RAWSZ - 1)) {
+			if (obj_cb) {
+				r = obj_cb(&oid, path->buf, data);
+				if (r)
+					break;
 			}
+			continue;
 		}
 
 		if (cruft_cb) {
-- 
2.15.0
