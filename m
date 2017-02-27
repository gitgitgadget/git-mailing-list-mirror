Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DCA1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbdB0Vd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:33:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:61061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbdB0VdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:33:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LevUh-1bxrmq38FL-00qj8g; Mon, 27
 Feb 2017 22:31:44 +0100
Date:   Mon, 27 Feb 2017 22:31:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] ref-filter: avoid using `unsigned long` for catch-all
 data type
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <bcc49c57cbe4c438d95cccd1cc94693431674e5b.1488231002.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4I1ZittwpwDxJiyl1/57sDP2YqADMsEj5htBy23Ga+lQO2LcYZn
 OI/YWF2fjby3O1E//iwVXuYU021xYgPTSXIbjklL3NvkaXXmxXamf9vzDz9Q7D/8wKjhVGn
 C7idUVmqwoRQgPuo7LGy4MsvzlnDaDa4d/VzgECT1JFGMl5TM98jnJPfpuipGAZ2TZINbk7
 h+bV3IpucmN3HxnvcNNBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OIDLlPKi8fY=:z97LB3MZFgic1c7t6h2Yeb
 N8sTlT+cE11vzvuc6ZMcC1OVAThk3jXOFq05Sprt++IhTpWsxFX4nQI9+7LCcPWa6QTDZN84O
 BMlm/S9cutzoNye0Yrt2iXZcU73zzteTJyi9Fz2al/pyOlfdKsL3JuKDPZLxSbIHeFY0Vds1f
 hmBhCfLzqC9wkxd/D/CSdZ5/b/I/aO++7ZCReQc/22PmaYVvAx2Q1Ekrrif4AvCatsQGYCkhF
 mmsg5vh+dzhM7MHKfoOjhOSkGS0pvR2UhGxopOWxKMQ4avz0+Y8QilTqY1zY2El1NGXymGeJE
 O39uEW4Jpl58P0PNUKVJulqAqv00b1Lg1sXWW1wjvxbfpQbXmRQRQgjqMsrw+QMM0EoWsAd5H
 c0HTMImr90O9uMCWIhv7BeCGZaY9SPB6jv8Gy0I044ZGfcGVnjpLWyyR/agmIXjBSnlTZuMgo
 LwEdhC5uGx38bHsy00ccELT6m3Lk8jAx2TaEZvpoGPOujn6y+sWbhuuJb+r6bOjXQK8Ob8BpJ
 dzNozTQH1xin29Fm6VUWd/wowK9gTrV/n0MWazAw3DLrCqbdj9Y6QIrN0j0i5qKTMguqNR0jO
 j7Q6XBSTZ8+i2fboYJFsR5gcNFT7XDAsPjjZGlaJhta8Wg+8cZrc7OgiWzGHO3Idpp3YLsIPK
 uZYbIam0z160xzSYAxsk4mXHEuEyGC/9vZgQYnAdJ0E4uBY26VcrCP1UcdvOlJlfc/Pu82w0a
 6+kLxrZZRyWjhUe/X8QHWDt1l2UJGeNWtbzzjg7QuIoeOdIyQDOeB078oesASMHfesuHHBTpg
 M4i/ao00BhD0fdVuS5azfBF2UGMJQU17rhXlolQwWiEYpKI2zgaNCHcIVRGrno+r09z5sD4GU
 +bEk4zjswgvop9d+froTeM4an/EtbC5+G3GFO2AIy5wen/Pj6h1ugLb+cvsqE7jtl9snDzs5o
 Kfrj7Mn9UVOFw08HemULUKo7j5VY5runR9EFlbfAi7xHNV7PVLfFzV2WntC5WmndXlF/EYvBM
 d0yjtkFyMuagk4ZMWKLUSIXJZsg/1/DmA9iQnx4PtIV7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In its `atom_value` struct, the ref-filter source code wants to store
different values in a field called `ul` (for `unsigned long`), e.g.
timestamps.

However, as we are about to switch the data type of timestamps away from
`unsigned long` (because it may be 32-bit even when `time_t` is 64-bit),
that data type is not large enough.

Simply use `uintmax_t` instead.

Unfortunately, this patch is larger than that because the field's name
was tied to its data type.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ref-filter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 07c1f372351..b8b34d4dd9e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -236,7 +236,7 @@ struct atom_value {
 		struct align align;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
-	unsigned long ul; /* used for sorting when not FIELD_STR */
+	uintmax_t value; /* used for sorting when not FIELD_STR */
 };
 
 /*
@@ -492,7 +492,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (!strcmp(name, "objecttype"))
 			v->s = typename(obj->type);
 		else if (!strcmp(name, "objectsize")) {
-			v->ul = sz;
+			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
@@ -539,8 +539,8 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
 		}
 		else if (!strcmp(name, "numparent")) {
-			v->ul = commit_list_count(commit->parents);
-			v->s = xstrfmt("%lu", v->ul);
+			v->value = commit_list_count(commit->parents);
+			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
 		else if (!strcmp(name, "parent")) {
 			struct commit_list *parents;
@@ -644,11 +644,11 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
 	v->s = xstrdup(show_date(timestamp, tz, &date_mode));
-	v->ul = timestamp;
+	v->value = timestamp;
 	return;
  bad:
 	v->s = "";
-	v->ul = 0;
+	v->value = 0;
 }
 
 /* See grab_values */
@@ -1583,9 +1583,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	else if (cmp_type == FIELD_STR)
 		cmp = cmp_fn(va->s, vb->s);
 	else {
-		if (va->ul < vb->ul)
+		if (va->value < vb->value)
 			cmp = -1;
-		else if (va->ul == vb->ul)
+		else if (va->value == vb->value)
 			cmp = cmp_fn(a->refname, b->refname);
 		else
 			cmp = 1;
-- 
2.11.1.windows.1.379.g44ae0bc


