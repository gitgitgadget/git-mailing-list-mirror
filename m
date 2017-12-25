Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B071F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbdLYRpF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:45:05 -0500
Received: from mout.web.de ([212.227.17.12]:60599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdLYRpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:45:04 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilAv-1f5spS35ZN-00d2rt; Mon, 25
 Dec 2017 18:44:59 +0100
Subject: [PATCH v2 4/9] object: add clear_commit_marks_all()
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ec45f9a8-292a-53e2-52b6-44d744cb6c36@web.de>
Date:   Mon, 25 Dec 2017 18:44:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:S/dNRBtWDHgOtlTCLIulkyv0JfpWkVkEmBd1CzM+iWbyDULlN/1
 LtPHhI+KK16LrUt91PolglWg8cPkZd2siyczKqDPopIykZqoQZKnDV1E5XPEvjnQ+xHywgr
 Jm5VaEH997ljUWHdaXe1sHsu1dpvwZ/NYlHkSYMBWDGGSBpd9ig4XQRwG/rgFs5g4DcsiNk
 rhntdcWuSF6vWi/jYRX9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5lOcbAZ4vuA=:eVPboytMY/fXSB9ovVqGXA
 tqWV8Vbk+8ZKY9d7kpbY76WFe71k+81LYsKAMJ51uvegmk7D2R5J5dv0wIoobVR9K95xF9Ks4
 fsCsou+ehwyiWLHo/i7bV5TP2n5QT1M5q5+ltfWlNBcUKpFtCIbXgDbZCVnuXJsBOJW3X0QRW
 mY2QYcrOwE5a+If3oPACTpzRDZJNUPpjoBE7tKHt3xSrvz5gTKkapYAcFrQWRPCYdfUZHZGYy
 MvDo2EIyCmSEPtTjuRkUMgPEDeTYDti7OpBfqL3L6jiUzAuFiinEwfktVSm3gvCchwZGIQoC7
 80BaoCQOcsNw9x6ozIiAsEO0lWWve7eTcjrJLvu+6CWuZKINcEMEg1RWm0CmgHoD9kV9KFe+E
 XfDprZGlZ6lIskPWBgzdrumhEtkTbTgz4Wif6W7aII1XG3c0WZ25XTotZNiHhYVv9ObWabo5O
 6Y5VK18V1hM1wA1z9RXKvPZa5pebQRNwKOwFnQyu0R2BYXiAXoipWZlh1YtzyMfMN+6Ct0Epg
 inr1YZuk1Nam1EbPZDsz29nA2y3Xddxgp64xKu3hzqI22ddEnksZxtmU/radStbuCCTYKfaX4
 E4pQ8iDDSEUWg5FeKg3Zk+hEp58u55axLNOf+76t/XyocxcBTbqa1oyHRRu5d/tPnhiqurXl4
 Xwb5myfWyUEyTHXKwcy96pJA0Q8NdZ0pYERNjXW4Tvc1Vq1IMJRKAnfUZ9Q15PbW4ypOHy5Mx
 RASwEJSCu5EmjxQecCnpmgFgp9OCFTPhrF7y6hh9Eg84U3jT7slimTnWJJF0R2RyKeG2jkEh9
 avT3nEtt22IYu2wFyB/ID89/q8Wl7PBJinqGjiV9E9LTDVgriLe0UrsenvpZEsVkOO++z3z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for clearing the commit marks of all in-core commit
objects.  It's similar to clear_object_flags(), but more precise, since
it leaves the other object types alone.  It still has to iterate through
them, though.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 object.c | 11 +++++++++++
 object.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/object.c b/object.c
index b9a4a0e501..0afdfd19b7 100644
--- a/object.c
+++ b/object.c
@@ -434,3 +434,14 @@ void clear_object_flags(unsigned flags)
 			obj->flags &= ~flags;
 	}
 }
+
+void clear_commit_marks_all(unsigned int flags)
+{
+	int i;
+
+	for (i = 0; i < obj_hash_size; i++) {
+		struct object *obj = obj_hash[i];
+		if (obj && obj->type == OBJ_COMMIT)
+			obj->flags &= ~flags;
+	}
+}
diff --git a/object.h b/object.h
index df8abe96f7..1111f64dd9 100644
--- a/object.h
+++ b/object.h
@@ -148,4 +148,9 @@ void object_array_clear(struct object_array *array);
 
 void clear_object_flags(unsigned flags);
 
+/*
+ * Clear the specified object flags from all in-core commit objects.
+ */
+extern void clear_commit_marks_all(unsigned int flags);
+
 #endif /* OBJECT_H */
-- 
2.15.1
