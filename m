Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7AA1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 21:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752287AbdA1VkZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 16:40:25 -0500
Received: from mout.web.de ([212.227.15.3]:62738 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbdA1VkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 16:40:23 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfVe5-1c9ITr2bHN-00p3oN; Sat, 28
 Jan 2017 22:40:18 +0100
Subject: [PATCH 2/5] apply: use SWAP macro
To:     Git List <git@vger.kernel.org>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <943fb53f-c602-7c04-ca9a-7d2b1bd68e77@web.de>
Date:   Sat, 28 Jan 2017 22:40:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0x7YS9Q48uZxLBDlOZtCIwdNlt8FIaPwCv/NooG0Cq+d/zaS+I7
 Hcx4gzmESip+PoSwKKYwcLQyhf5cQ+8k7PLNfPxdy8F3Ul6vHRDnqmIB9PzN+/su3+FQ8X0
 g9PuBX2zdMqN9sXChBNJOjdEBTNZerzHfEQtZcyvaOgoW9Y+q84M7IrAzYods8qnQXFnO2x
 haXpVLCnNJoFSqETVhAnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MPbasnwrJSk=:PwlSc1z6c5hjf+0eUr5mML
 ADUHeDZj5h59TyPwu7sYCtA3We8mF+txyJjo6s0lC7Pab5pGMMQ4ssXxAyd8xVHWYyc312v+o
 Bx5KnwtbCFN8ymbfBrFo/YUMepMYsLWyQGk5r07ZDTq8FoRDc/iO+xxLp+gjatxRD01q5Dxht
 7RPpJLSTiuq7vcxsGc7quqeBfAi5npecH3yJ3MdMWiCfUCefZ9e0i2jHTHGz9rY1EabqLdqnE
 SyvfDB9wAoHrtiQnyzCqFlsF1brbUJSQs+fckvZFrj2z3dvFuGiUpCvaEC7DOxe9ugS8Z36L+
 CmC38S28sNxjo1mIFNj7pzV1CQl/DmTj8urrH3h3iZPh4iv1Ytj8DmvAcB6MadTtHdrdwKpf/
 Yry1y/xux8VemYXxMn8/vO1nuSsCJbh4pluTPoq9uxH/1jTC/mFx+8N+5pB+PQVB7DAY2hC3F
 i1Mnkml9cmq6eXtzrE9TdPys1j0CyKjqYQ/DQ4WjNHE6sryLCD7+euNhen31OxsVg+mI0oplr
 S+aHDxQL3V0DjNPEBmHhxAwErfq8Q6kJErZAbu8hJC+AO7dez//5JmmrF07mlmp96uhK1kSzF
 p0WBNXXMvcMUr7en3R7TShCnNy9xDNisXvyzlDeQb7WcChsZdqpOcWMomiWX/1cbqH++FRorM
 aH3yAzRNnu66mUETLVTolU8nPLsNZsQKpSdk30fvDtpZQTtbf6fN1q88Vlg4OgISODl42bvVm
 PFp+jA6G3UA02hu3pp+pN3YaOl6vyB1jtXRVGFAwqofN4FaciFFnstkBqBWgdEfoxOGZI8jgN
 41Uj7WY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the exported macro SWAP instead of the file-scoped macro swap and
remove the latter's definition.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/apply.c b/apply.c
index 2ed808d429..0e2caeab9c 100644
--- a/apply.c
+++ b/apply.c
@@ -2187,29 +2187,20 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 	return offset + hdrsize + patchsize;
 }
 
-#define swap(a,b) myswap((a),(b),sizeof(a))
-
-#define myswap(a, b, size) do {		\
-	unsigned char mytmp[size];	\
-	memcpy(mytmp, &a, size);		\
-	memcpy(&a, &b, size);		\
-	memcpy(&b, mytmp, size);		\
-} while (0)
-
 static void reverse_patches(struct patch *p)
 {
 	for (; p; p = p->next) {
 		struct fragment *frag = p->fragments;
 
-		swap(p->new_name, p->old_name);
-		swap(p->new_mode, p->old_mode);
-		swap(p->is_new, p->is_delete);
-		swap(p->lines_added, p->lines_deleted);
-		swap(p->old_sha1_prefix, p->new_sha1_prefix);
+		SWAP(p->new_name, p->old_name);
+		SWAP(p->new_mode, p->old_mode);
+		SWAP(p->is_new, p->is_delete);
+		SWAP(p->lines_added, p->lines_deleted);
+		SWAP(p->old_sha1_prefix, p->new_sha1_prefix);
 
 		for (; frag; frag = frag->next) {
-			swap(frag->newpos, frag->oldpos);
-			swap(frag->newlines, frag->oldlines);
+			SWAP(frag->newpos, frag->oldpos);
+			SWAP(frag->newlines, frag->oldlines);
 		}
 	}
 }
-- 
2.11.0

