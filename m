Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58441F453
	for <e@80x24.org>; Thu, 18 Oct 2018 19:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeJSDOJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 23:14:09 -0400
Received: from mout.web.de ([217.72.192.78]:49991 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeJSDOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 23:14:09 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6DuI-1fOwEu2ecM-00y6e9; Thu, 18
 Oct 2018 21:11:42 +0200
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6DuI-1fOwEu2ecM-00y6e9; Thu, 18
 Oct 2018 21:11:42 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] index_bulk_checkin(): Take off_t, not size_t
Date:   Thu, 18 Oct 2018 21:11:40 +0200
Message-Id: <20181018191140.23318-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ka17EbJN/7GMyn7Kf6jbHHl+9/ZsxFo2hGaxYIRJh0OdwDEA9JE
 dSCb23Zn1hHmpBYGg5h7CwFgCn0ko4JluX+7Nq1PIUy69b1glcEPV8egn/7YkfT80+3I+iW
 cxbpD8Gy8sJZuMD6LReKhh2xNGbwp/rCWvpmc8kQeoGsnZibE3XVyJakXjvsePOZ71BrBPr
 AA6bOWtgeodD8JoOYUOCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LBSTzfN406E=:ZS4SbpGE7dnrXDwlZbx1vB
 yE45xVky5MM2QhzUNvdIf7UAPoS72ej/W1mxoQDGeuaH6RBwHaMCYzAw0OtH1acxpW9JHZDNV
 Bx6Mz7hdeBTupn9HBRj7aaxQkTu5MqMY+k6NGIC4G9h6yPgZcNz7v26i0HyuwokcusJ60IbYr
 ZtV3id+IH/3KRfrjJqpLyLeu0NYwu4JDg9Fx/hT5nfouGvkFBtF72Vxgw1ZXN6PNGEak5W8kR
 VOm5juaoNg1qHyaLLrn9qZ7tHI/XnCuxcTCtT/ccLmh1ylf72g5KB49mK/t5K9e22cncNrwkK
 exfro/Pvi0gQf8XkVvvjLNsJNRCgySDipSwzJ2MI8/MPemqXHs3AU+T0AquizNLd9UAw7PsmL
 ObN7hzZTPKCYpAgX5pOPB9MoEh06Urn69llXqM4yrGG8I3Tf0jKwStKsVWB2gBgV0UcYYyeY4
 QANZbcTAts25ENKSTXkiWI0KaN2XTTL4oOM/5cHjYiUFJ3yzBG9Wwx/9zFoWaSPAvkhrfpJfv
 YSur75/1CvWOPj3ZTJn16amLC8bgPvau899L/dLfIqfslvvkGFPqQFhPLFqowERA/I9XOcbL5
 OqKlSqA/XnqS9ZsFkNXxgFviVlybrHz8gXAxQmjVU88Mwxvy8DUYDQISZC73hkI0hGSp6sEg+
 9QrwFVZlRV6PZmX9dQqioxM/kTqJqO+F1sH1HjfnOKULoC4aGx+AV7cn22nq2Jaq69WSs1SsR
 m2k3MxHvAuFvSAyzDue5xvnwKqAmidwrYYIYXEJhxYlCjgUfx+dENQQvnOeU2dkhrJd0NPXyg
 5YSQKp4GF6VEtjkFPrWIIGMpKx8CkGKRhWbkjs7auoJAX2ZxTw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When streaming data from disk into a blob, use off_t instead of
size_t, which is a better choice for file length.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

This is based on an old patch from 2017, which never made it to the list.
I think it make sense to have off_t/size_t more consistent,
reviews/comments are welcome.

bulk-checkin.c | 4 ++--
 bulk-checkin.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 409ecb566b..2631e82d6c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -189,7 +189,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
 
 static int deflate_to_pack(struct bulk_checkin_state *state,
 			   struct object_id *result_oid,
-			   int fd, size_t size,
+			   int fd, off_t size,
 			   enum object_type type, const char *path,
 			   unsigned flags)
 {
@@ -258,7 +258,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 }
 
 int index_bulk_checkin(struct object_id *oid,
-		       int fd, size_t size, enum object_type type,
+		       int fd, off_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
 	int status = deflate_to_pack(&state, oid, fd, size, type,
diff --git a/bulk-checkin.h b/bulk-checkin.h
index f438f93811..09b2affdf3 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -7,7 +7,7 @@
 #include "cache.h"
 
 extern int index_bulk_checkin(struct object_id *oid,
-			      int fd, size_t size, enum object_type type,
+			      int fd, off_t size, enum object_type type,
 			      const char *path, unsigned flags);
 
 extern void plug_bulk_checkin(void);
-- 
2.19.0.271.gfe8321ec05

