Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB922202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdJCNsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:48:06 -0400
Received: from mout.web.de ([217.72.192.78]:51434 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbdJCNsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:48:05 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1nQ-1e8DFu1MWG-008s5t; Tue, 03
 Oct 2017 15:47:58 +0200
Subject: [PATCH] fsck: check results of lookup_blob() and lookup_tree() for
 NULL
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>
References: <20171003102215.9952-1-szeder.dev@gmail.com>
 <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
Date:   Tue, 3 Oct 2017 15:47:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:grAlZTvO9tvS0+qc+LQ7pO/7L5ytughYtFyO4rmIPj6LP2hugEW
 FkJJo3n8j607/5qloLcGzGKXhtA899Hn1QtVAhEZ93Q60DMuvlDIA/ByEyMSOk2r8EKmUkO
 vgmf/fMSjCj2TbSvgPJWcT69w2xrBiV84Jyllw2BT7ajIE+REnq9+mMwrm4C68hASOmUVsu
 pYE9PFP78kpwvikgxrkUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0GYihZnXVrw=:a9Db0fyffFjTNde3AJE713
 gmTmkqVriIaa+K/FxaDbHEl2M0iwVJBRDRsS/RWGsONkZQ964/IFvKZInVYW8a89+nZkHFQdv
 X3xuMbBASAB8lI3U5IXy5Hz4BkyAp7MKDUUGkyJzPcrSm3crdNBwFTszq43SVDtTjLi8djpch
 TZMzMt18oRQM1fVVyD+r7mR504lgIQNJwzu5CHjKIy1vHl0n47j3IP12BaTRWE6QHNEcVYLKt
 rsGPoWmOB18Y9tHfHLsTjq2YCKmEaKTdPtlXQrtu0JTMJE1lrgWUH+ogCmLKfkDiMtk5x+Rlh
 XIFhvEaLB6pFX5V7WsBovgruRWQSHEgiYeNvHSCK7+xaRtMWsokL6Slqah7wocHX+mbASnWYT
 OL5jLu9YAMlqiURTXQrjcK7mEmlWUzQH/gAWkKfO5oJFCGEtlL3T/ksojk6yc5UW9BauhM5G3
 blJ61VUj52K7ORYpWuDJcAL8vq2TTZn3B3AGsBh+Nzuoo4nlZk02nrSwTiufB5cGeTIpQ2cnU
 zt3BqR4yiGQS0mlNnEaw3wOoK0TT1ikFgkvbUYEY71GOlg5nZEAb6EQIfb6YRHRlhIQO8GmEi
 PFuety0yhhQgag6zK3F9k/4lY7HFr6kgLVVg3wWj/qJjtt15eevofA9vms5Ym8MV2CellCPP3
 UhSXEwv3dK/LEMUwxQmj6pp7Sh3c3g+el+bccgj5uNK4MYqlvhXut4nRifQi6zlWaFMowC5+d
 m0Ue8KAii46i7cZc/0AwK4VFFIPYyYwTMZtFDBhIaXYQ46UmAafAy1MiZyBZ5LoRB02PhXpQx
 PFMnbaAlTk0K1nxO7AXkqBSEgTcX2Xm8Q3/ZVf0iuM65cUp71U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2017 um 14:51 schrieb René Scharfe:
> Am 03.10.2017 um 12:22 schrieb SZEDER Gábor:
>> Furthermore, fsck.c:fsck_walk_tree() does the same "immediately
>> reference the object member in lookup_blob()'s and lookup_tree()'s
>> return value" thing.  I think those should receive the same treatment
>> as well.
> 
> Hmm, are put_object_name() and all the walk() implementations ready for
> a NULL object handed to them?  Or would we rather need to error out
> right there?
How about this?

-- >8 --
lookup_blob() and lookup_tree() can return NULL if they find an object
of an unexpected type.  Error out of fsck_walk_tree() in that case, like
we do when encountering a bad file mode.  An error message is already
shown by object_as_type(), which gets called by the lookup functions.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fsck.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 2ad00fc4d0..561a13ac27 100644
--- a/fsck.c
+++ b/fsck.c
@@ -358,14 +358,20 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = &lookup_tree(entry.oid)->object;
+			struct tree *tree = lookup_tree(entry.oid);
+			if (!tree)
+				return -1;
+			obj = &tree->object;
 			if (name)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = &lookup_blob(entry.oid)->object;
+			struct blob *blob = lookup_blob(entry.oid);
+			if (!blob)
+				return -1;
+			obj = &blob->object;
 			if (name)
 				put_object_name(options, obj, "%s%s", name,
 					entry.path);
-- 
2.14.2
