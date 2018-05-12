Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722731F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbeELItu (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:49:50 -0400
Received: from mout.web.de ([217.72.192.78]:60347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELItt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:49:49 -0400
Received: from [192.168.178.36] ([91.20.55.213]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0Q4-1ela1W0tAi-00VvD9; Sat, 12
 May 2018 10:49:38 +0200
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
 <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
 <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
 <654fac2a-8dca-7bee-2bab-a3986aa7e52d@web.de>
 <xmqqbmdnhr8b.fsf@gitster-ct.c.googlers.com>
 <xmqq7eoahk49.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AN4nssu1+x0x9Kmz1BB1aXO7_UBFCjpyULMeC5K-Fzvw@mail.gmail.com>
 <20180511085634.GC22086@sigill.intra.peff.net>
 <CACsJy8CnJYsgDe11tK4JzH2sDRuLwgoUz=HCso5qOhEfyZNH5Q@mail.gmail.com>
 <20180511133419.GA2170@duynguyen.home>
 <20180511174237.GA19670@sigill.intra.peff.net>
 <80397e16-8667-e0cd-4049-aad453d35e6f@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <01bb1946-df79-6448-663b-21a85cd44312@web.de>
Date:   Sat, 12 May 2018 10:49:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <80397e16-8667-e0cd-4049-aad453d35e6f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MaEJJU+/WFtAUztGjyxSJ5bR9tj5H8ZOjAANwVHZG9K+PNaLGyJ
 e2jqgoMZYIN37DhtSr5RGxm57spV10yRpsSUPfMEWJSuWlFIgtCP2Q5pOHe2vz4VV4WBSQV
 0ZjSxkfbSju7mZMHjPVT/0QU5jHyiIyQ5P2YwGS2qxsGBKWtNX4B0oIe440l26At3QHHfa1
 9mss5xF8n/b0EDA6pSlbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xXGoyX34/ro=:hj/bhz8rfY+aKarAlDq6OW
 7VuOAStDuAmrWRGEAfasS9YP+vCysdkI1K+tydbJ5EEbXB7MvpaCg4mwVWDMmRSCxsaF8lJzp
 Xw/JkZoZgHKFTjjCg8I0ANuF47QG9VRdfKxAqEbURndMcOCvgKxPSPRU3/i9K3ZGPVMA6aK5v
 1sNzWdKpgIn8q884M6iOq8r2YhtBnLhIZu0YAws4BhKj6aM6xyRqg04UPoiy1MNavz3GpMrkh
 rkBi68JVOe9Qz1mlxm9aDQJhpA7Bg8FmMqEUvbxPludCq1GVyXxBq9dDCRknksvaSFoIoNdji
 3oj3LPcgeLAJuuBSYDH0OViLasF1/qi0wiZEBzY2dE+WrJBHFzTp7yDiqJ74lfamQ0N7B2uk8
 AjFmyXqFoKN1sVVVPlDSJSK8Ql5vx6RLnKudKpx7CEXzQii6hEi5zOdsnSLO47NWDMl8Hi+iK
 OgVlsyrkw+6xCKsMJflzBb5ur+mDkp32VwQJzdKtVv/73jyisnTxxNCe3SB1Ggij7RB8MF+UD
 eDBlvXsYWdEKCmrXCuolX1hcFOEs73ylhOl4CObNTCCOyTZ/SQdHuZxrGPlOdofI7JxnDY/xl
 QClL8y6KSY+NkAATTPgWsmO3TFt1C5KCFNn0xPCPu8c5MnA4nOtL21+ueFFQ970Rv9PanXEf3
 ErvTg69HOjIIVIwrbxVLSotIm1GlfoS78nW281QB4YDbChPrVBp72h/ozgYx+ub3VAOlwK1Ql
 H6bq0/+YLCv4l2UhXzmyvVisYo+vd3YhHf7ztIvRaFcyQ4pKbE2eNHlqitl5JUaDUxNOitqOw
 8hvl3ja
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.05.2018 um 10:45 schrieb René Scharfe:
> Or we could roll our own custom hash map, as I mused in an earlier post.
> That would duplicate quite a bit of code; are there reusable pieces
> hidden within that could be extracted into common functions?

At least it would allow us to save four bytes of padding per object on
x64 by using a separate array for the hash map values; not sure how that
would impact performance, though.

---
 builtin/fast-export.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 627b0032f3..086fcaf9ea 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -72,13 +72,13 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 
 struct object_mark_entry {
 	const struct object *base;
-	uint32_t mark;
 };
 
 struct object_marks {
 	unsigned int size;
 	unsigned int nr;
 	struct object_mark_entry *entries;
+	uint32_t *marks;
 };
 
 static struct object_marks idnums;
@@ -98,14 +98,14 @@ static void set_object_mark(struct object_marks *n, const struct object *base,
 
 	while (entries[j].base) {
 		if (entries[j].base == base) {
-			entries[j].mark = mark;
+			n->marks[j] = mark;
 			return;
 		}
 		if (++j >= size)
 			j = 0;
 	}
 	entries[j].base = base;
-	entries[j].mark = mark;
+	n->marks[j] = mark;
 	n->nr++;
 }
 
@@ -114,19 +114,22 @@ static void grow_object_marks(struct object_marks *n)
 	unsigned int i;
 	unsigned int old_size = n->size;
 	struct object_mark_entry *old_entries = n->entries;
+	uint32_t *old_marks = n->marks;
 
 	n->size = (old_size + 1000) * 3 / 2;
 	n->entries = xcalloc(n->size, sizeof(n->entries[0]));
+	n->marks = xcalloc(n->size, sizeof(n->marks[0]));
 	n->nr = 0;
 
 	for (i = 0; i < old_size; i++) {
 		const struct object *base = old_entries[i].base;
-		uint32_t mark = old_entries[i].mark;
+		uint32_t mark = old_marks[i];
 
 		if (mark)
 			set_object_mark(n, base, mark);
 	}
 	free(old_entries);
+	free(old_marks);
 }
 
 static int has_unshown_parent(struct commit *commit)
@@ -236,7 +239,7 @@ static int get_object_mark(struct object *object)
 	for (;;) {
 		struct object_mark_entry *ref = idnums.entries + j;
 		if (ref->base == object)
-			return ref->mark;
+			return idnums.marks[j];
 		if (!ref->base)
 			return 0;
 		if (++j == idnums.size)
@@ -966,7 +969,7 @@ static void export_marks(char *file)
 
 	for (i = 0; i < idnums.size; i++) {
 		if (entry->base && entry->base->type == 1) {
-			if (fprintf(f, ":%"PRIu32" %s\n", entry->mark,
+			if (fprintf(f, ":%"PRIu32" %s\n", idnums.marks[i],
 				    oid_to_hex(&entry->base->oid)) < 0) {
 			    e = 1;
 			    break;
-- 
2.17.0

