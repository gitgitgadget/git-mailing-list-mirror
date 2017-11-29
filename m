Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0CA20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 23:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbdK2XwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 18:52:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:50406 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbdK2XwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 18:52:10 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKt5A-1eKC950Odk-0005TD; Thu, 30
 Nov 2017 00:52:03 +0100
Date:   Thu, 30 Nov 2017 00:51:41 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] hashmap: adjust documentation to reflect reality
Message-ID: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WXBMnXM8jijUVqAMtNWh4opPjkNUneHzVKaZXNV2ZmHiZp90zwD
 /EwziYtjhOpw0fRKj6s0uUhZ1mVdGP6JlviVs4mDDdjfZsKQJPx8ZQHKsbabzdqTPC3vw4O
 vsc+0wd50WWZkjuBbTinTTEz4yiCUPA1J5rMF5TNTFSRSu15fmlUkRnH2/TAzYvuzDA6zrA
 SsF3NFUzhwd8San8Tavtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zjM1XYi/Cms=:sOe+euwsC1OrZwJnKRb46t
 FN4Jrikd/egOAqFE7nnok6thtZGmmeCuKEgyzeWaDjufOqkm0rdETJCM+fjNch0yiqz6MAKHo
 vHpCmz5AjS0t6QSjlAf7d51QpZj75kTYcT+QZyaFoGNkhAfTpx0heJy6r7SC8koL1JDZAC3ST
 qni8AC3VBj+aX0qHej1m3BIsvqlOAHU6PKB9J7Q8/9QdJSFamzdyyVwgTU/4b0eUQLs8KtO1M
 kQcLZCmExk0OXDNKpOm+KS9mzbk6jiX/lqKTJqM712VD5/qCQg5g2Tvw/vnPwx8OetxlXRPVt
 gCdwLIkee5Of782XLne4y43M8szVotgxpfcQn1hH8fX+Lgnt0k0tUok/rpHO5v23YL7OmcmSw
 0m6wtnra7TyEni8sDsb9Qsq6aZkpNwkRt1ylA21KmDNvvCXOh7MlUDSt/AfrD3PtXF1orD+/L
 vNO/0jvwMof3ISg4iFJP/qK9jKq5/zE7vngS3eYEEO5kFhpqi3o9/T/mjj4mmmen9tg1i/JqU
 fYjRGhhEZwgjQJ87lJHdHAvFy1ztcgWrHN4BXYhrdpl3bJiQBNjyGVRGyMOlMRXF1k/gGL/pj
 /m2fwgjagS1PaQxwaLV0WfSq24Eh9mFy0abnTOMaZ7UJyDeO5srPIYdJ3VxzrcoizjLDDrQtZ
 IpZUXf3xkrHGFvdnnIZMuOcVL2jbWUt81VQiEjJSRBOaP3wIc0FCgYgF/k/qQ/kvAizludTGE
 oW+vIzLv/b/BhspQbSbMHnqBOVfaxj6cFEP4DLm+qdf2YvcUxydRCbmmHiEk4ANoa4erk4MlR
 fEF5GlSmDX/Nj0A09YuR7t8V+zqYNgwONr4yn1Ztv85lMIDMcb6TeQZyUQDzQshFjNvmuIE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hashmap API is just complicated enough that even at least one
long-time Git contributor has to look up how to use it every time he
finds a new use case. When that happens, it is really useful if the
provided example code is correct...

While at it, "fix a memory leak", avoid statements before variable
declarations, fix a const -> no-const cast, several %l specifiers (which
want to be %ld), avoid using an undefined constant, call scanf()
correctly, use FLEX_ALLOC_STR() where appropriate, and adjust the style
here and there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hashmap.h | 60 +++++++++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/hashmap.h b/hashmap.h
index 7cb29a6aede..7ce79f3f72c 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -18,75 +18,71 @@
  *
  * #define COMPARE_VALUE 1
  *
- * static int long2string_cmp(const struct long2string *e1,
+ * static int long2string_cmp(const void *hashmap_cmp_fn_data,
+ *                            const struct long2string *e1,
  *                            const struct long2string *e2,
- *                            const void *keydata, const void *userdata)
+ *                            const void *keydata)
  * {
- *     char *string = keydata;
- *     unsigned *flags = (unsigned*)userdata;
+ *     const char *string = keydata;
+ *     unsigned flags = *(unsigned *)hashmap_cmp_fn_data;
  *
  *     if (flags & COMPARE_VALUE)
- *         return !(e1->key == e2->key) || (keydata ?
- *                  strcmp(e1->value, keydata) : strcmp(e1->value, e2->value));
+ *         return e1->key != e2->key ||
+ *                  strcmp(e1->value, string ? string : e2->value);
  *     else
- *         return !(e1->key == e2->key);
+ *         return e1->key != e2->key;
  * }
  *
  * int main(int argc, char **argv)
  * {
  *     long key;
- *     char *value, *action;
- *
- *     unsigned flags = ALLOW_DUPLICATE_KEYS;
+ *     char value[255], action[32];
+ *     unsigned flags = 0;
  *
  *     hashmap_init(&map, (hashmap_cmp_fn) long2string_cmp, &flags, 0);
  *
- *     while (scanf("%s %l %s", action, key, value)) {
+ *     while (scanf("%s %ld %s", action, &key, value)) {
  *
  *         if (!strcmp("add", action)) {
  *             struct long2string *e;
- *             e = malloc(sizeof(struct long2string) + strlen(value));
+ *             FLEX_ALLOC_STR(e, value, value);
  *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
  *             e->key = key;
- *             memcpy(e->value, value, strlen(value));
  *             hashmap_add(&map, e);
  *         }
  *
  *         if (!strcmp("print_all_by_key", action)) {
- *             flags &= ~COMPARE_VALUE;
- *
- *             struct long2string k;
+ *             struct long2string k, *e;
  *             hashmap_entry_init(&k, memhash(&key, sizeof(long)));
  *             k.key = key;
  *
- *             struct long2string *e = hashmap_get(&map, &k, NULL);
+ *             flags &= ~COMPARE_VALUE;
+ *             e = hashmap_get(&map, &k, NULL);
  *             if (e) {
- *                 printf("first: %l %s\n", e->key, e->value);
- *                 while (e = hashmap_get_next(&map, e))
- *                     printf("found more: %l %s\n", e->key, e->value);
+ *                 printf("first: %ld %s\n", e->key, e->value);
+ *                 while ((e = hashmap_get_next(&map, e)))
+ *                     printf("found more: %ld %s\n", e->key, e->value);
  *             }
  *         }
  *
  *         if (!strcmp("has_exact_match", action)) {
- *             flags |= COMPARE_VALUE;
- *
  *             struct long2string *e;
- *             e = malloc(sizeof(struct long2string) + strlen(value));
+ *             FLEX_ALLOC_STR(e, value, value);
  *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
  *             e->key = key;
- *             memcpy(e->value, value, strlen(value));
  *
- *             printf("%s found\n", hashmap_get(&map, e, NULL) ? "" : "not");
+ *             flags |= COMPARE_VALUE;
+ *             printf("%sfound\n", hashmap_get(&map, e, NULL) ? "" : "not ");
+ *             free(e);
  *         }
  *
  *         if (!strcmp("has_exact_match_no_heap_alloc", action)) {
- *             flags |= COMPARE_VALUE;
- *
- *             struct long2string e;
- *             hashmap_entry_init(e, memhash(&key, sizeof(long)));
- *             e.key = key;
+ *             struct long2string k;
+ *             hashmap_entry_init(&k, memhash(&key, sizeof(long)));
+ *             k.key = key;
  *
- *             printf("%s found\n", hashmap_get(&map, e, value) ? "" : "not");
+ *             flags |= COMPARE_VALUE;
+ *             printf("%sfound\n", hashmap_get(&map, &k, value) ? "" : "not ");
  *         }
  *
  *         if (!strcmp("end", action)) {
@@ -94,6 +90,8 @@
  *             break;
  *         }
  *     }
+ *
+ *     return 0;
  * }
  */
 

base-commit: 1a4e40aa5dc16564af879142ba9dfbbb88d1e5ff
-- 
2.15.0.windows.1.22.g2b9dc9b294f

Published-As: https://github.com/dscho/git/releases/tag/fix-hashmap-documentation-v1
Fetch-It-Via: git fetch https://github.com/dscho/git fix-hashmap-documentation-v1
