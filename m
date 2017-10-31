Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F5A20437
	for <e@80x24.org>; Tue, 31 Oct 2017 13:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbdJaNuP (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 09:50:15 -0400
Received: from mout.web.de ([217.72.192.78]:62026 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbdJaNuO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 09:50:14 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8fq-1dkfl80ha2-00SA3N; Tue, 31
 Oct 2017 14:50:00 +0100
Subject: [PATCH 2/3] http-push: use hex_to_bytes()
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <31ce5c1c-cab3-80aa-623b-43f91ddd2162@web.de>
Date:   Tue, 31 Oct 2017 14:49:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7GAa/eyXYH2lbC9f+/gpwY1Gxsz+3dhKXKJwKeeE8HSKQoxQO+f
 58Pc2GbgiveLWBg/dTNViuEpDSMkWWSxjtzKXo6jgEOIyqBRx8N6H76zWpzNMZuwALMx61E
 P2gYnZjus2/pZ+bwgWV6uw6WI7G84nX0YCGawMndy8taLyWXKnFYmlaHhdYup8EctN09mhA
 ICkidrJptoixbPoJuLuOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pJVybEE/lro=:ZRLTkiICpT7pc3bSVItcGC
 LTVSz8K6wZOTqs4vd80chHpvI+4cWCKfwqp1SdmXEygMht6gluWy+aGgw2S8pTTtSpT2hDENE
 kpArBWz03AjIawzztr/R1jXp4/ZZW1GkkZ7N8gPT7gyOhlCMrW0gFmD/AHLJbOnFZ6RhQfiP0
 wTa+S8FuMQESM87IrIyW7cFPLU+7J1gYgz9EYmW38X7sTxtPHnlun0xTfcbwvg7f9nVmmG5X8
 tAIOCyX0bcQGTv7oH6NA7Bqxx31Dkdtjy1qys4gg+VxCrdsqJTFRia0f12d3EEUuQzMH2XsaH
 yvd3qbkuQ2JoOllWlot01ANAH/SSFMV8ZT1YTXFVhZT8uoVT7N4SPvDCQArPFMosDSIUrM1Sl
 I3bbu5NtSxWUme/n0Ovwyn7ErN/M5tEwhETANsUhKIDE9iXbzx3Jr/xmXIlF5DDYM8oFlF84k
 wr3chDIZ/UyTZqxfAv/fdOfTQCQwkJkeyfBRm04o4pUKTnx/ZeU1djcqHyeTUacr6rTErM7Vy
 FVzsJ4t+7auvT48zf70+UEbkIEygLRFD5iVej1FuPOGFI8HfnpzrYhf2HC65nVpslmZMBm5hh
 hWtxKkiGdV2t/5ahk0zizcLB5S40866Jh/bqF+NGJ6DJcLqd7A5VV3qUPskbT0rmydfqjslAR
 Ftgr/IFOSJgHgracXqbXON12d7DUYT+M4olIedpS9Q0peUwUpo1b9Q5ke2F3S5rmFXnppJqpk
 WkVDGLXU1dgnMDgEpV5g6N0Leex6SSf86cTZ+puji3hec3WT8f3e/9ZY1mXFbmi/jTeBiqC8C
 AKR8LAeCFQJtmDnxIS+ZWZBVrJqUMkrWF2Soazhs5NFfZiqziA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The path of a loose object contains its hash value encoded into two
substrings of hexadecimal digits, separated by a slash.  The current
code copies the pieces into a temporary buffer to get rid of the slash
and then uses get_oid_hex() to decode the hash value.

Avoid the copy by using hex_to_bytes() directly on the substrings.
That's shorter and easier.

While at it correct the length of the second substring in a comment.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 http-push.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/http-push.c b/http-push.c
index 493ee7d719..14435ab65d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1007,20 +1007,18 @@ static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData);
 
-/* extract hex from sharded "xx/x{40}" filename */
+/* extract hex from sharded "xx/x{38}" filename */
 static int get_oid_hex_from_objpath(const char *path, struct object_id *oid)
 {
-	char hex[GIT_MAX_HEXSZ];
-
 	if (strlen(path) != GIT_SHA1_HEXSZ + 1)
 		return -1;
 
-	memcpy(hex, path, 2);
+	if (hex_to_bytes(oid->hash, path, 1))
+		return -1;
 	path += 2;
 	path++; /* skip '/' */
-	memcpy(hex + 2, path, GIT_SHA1_HEXSZ - 2);
 
-	return get_oid_hex(hex, oid);
+	return hex_to_bytes(oid->hash + 1, path, GIT_SHA1_RAWSZ - 1);
 }
 
 static void process_ls_object(struct remote_ls_ctx *ls)
-- 
2.15.0
