Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05EF1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756968AbdLVX4G (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:56:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:53604 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753008AbdLVX4E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:56:04 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEtba-1eDgvz0e2U-00G148; Sat, 23
 Dec 2017 00:56:01 +0100
Date:   Sat, 23 Dec 2017 00:56:00 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 5/5] sequencer: do not invent whitespace when transforming
 OIDs
In-Reply-To: <cover.1513986836.git.johannes.schindelin@gmx.de>
Message-ID: <da288dac49ac1e54db99349a50a7cd684956671c.1513986836.git.johannes.schindelin@gmx.de>
References: <cover.1513986836.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l4s0ZaYQd5xuKf8TzMDZh/+7fbbhAe6x0eXSufrEfspxQW4B4/d
 EZ2XdB8BTYBLdMy1S4s8gy1kpFrNjcgH8SQJwXNwwYKKa5pa6NgnTa96JutuUhEusFaCL3i
 t2de13FUeGAZ6jBHsIxfRNuZz4A0keiHbKrCK9lXiId3MY/ZCpUDNoIFTJYzljdenOMhnyo
 fUqzkirArZNHSST1Y+ZRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vFQItFLusOg=:AWPPAV9LJzCrRkkvSiplG2
 tplR1pprdoQFyyTIVApuIgI478r4AQC9Sv4/f8iZujSeP4fZwvsSRGKI9AVpTTJ7tGAWEkHoz
 0JfsNCA42Fk/9SH1/Bm8VLfwOal5ytKIWX6zn8v2lrwTm1LTQE31aJKYo1TqEW4bnWTsvVZ2Q
 o82HB2QcBbJpSdSyoBNviqGJ90SH4eQyy01Qy/FRwW24WhvaqUYOdFZhTauEd1Q8/iHYBT1BM
 fafWilpgr/F6/XH4g/kOVL37YuUKb8v33TnCO8ieuim2aAi4Lm5gbuP1QnqU6LWpxlB555lks
 +nTA7zg8+DV4/AhuFgDhcFWCXwRQDEvoiQFtnxG92ZSxchEq5k1sEFTZwWO4/UgqxrsNGdJOE
 YJnJJsEHpa6KF3nf7V334gERT1KB5x6JdgplY6qvJ0Y5fSmtz/b0JHLw+ZOu8eS8UQBFueouf
 1Wa1YGLqkbMFQy7iP5x/9vidvHYv9l0XtQaJNwlTyT7QQ3cqUooXShO2mpY6u1q6u6Jg9CJdf
 L/hiqtMdjdwbKqpmeM6RTQGAOdGWut0gCfIq1d4K+Mm0roNIJ2yVQDQ6rVyi9RwB8nvZayRnb
 5irVyXZ0DVmFFyQNDSUHn/eq9tzjX4XLG9fvFZYZpuc3bPq8Pd12dblFsYfp6BJwfx2osohLC
 LmUdbsPBCpnG7TToUpLbtqTp+7zJD88PgNmR6nq0JDgkQytl00fvkxXs794gnaTAkwiZ9UPbh
 hSA8twumPojTWiseVpsWBhjWw0WNiL71dhsJHXFtBc4M2U26VDgtm1N7agCtulWfM+CleChju
 syOGKNx50g570Kv1akjepBgKf1vYihSV+d/3v4owOI4YJmlGdI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For commands that do not have an argument, there is no need to append a
trailing space at the end of the line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 5632415ea2d..970842e3fcc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2584,7 +2584,10 @@ int transform_todos(unsigned flags)
 			strbuf_addf(&buf, " %s", oid);
 		}
 		/* add all the rest */
-		strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
+		if (!item->arg_len)
+			strbuf_addch(&buf, '\n');
+		else
+			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
 	}
 
 	i = write_message(buf.buf, buf.len, todo_file, 0);
-- 
2.15.1.windows.2
