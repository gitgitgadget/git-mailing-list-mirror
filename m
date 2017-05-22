Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644712023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934675AbdEVOSQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:16 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59631 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbdEVOSO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:14 -0400
X-AuditID: 12074411-cafff70000003efd-62-5922f3231a4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C6.B4.16125.323F2295; Mon, 22 May 2017 10:18:12 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24B023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:09 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/25] refs.h: clarify docstring for the ref_transaction_update()-related fns
Date:   Mon, 22 May 2017 16:17:32 +0200
Message-Id: <0bfff2359006ff97858da2f86c2b6a8dbdee6e7d.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqKvyWSnSYPdtQ4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxoOW2oK3XBV/
        d5k1MP5g72Lk5JAQMJHY/6yRqYuRi0NIYAeTxMzLv9kgnFNMEtt27WMDqWIT0JVY1NPMBGKL
        CKhJTGw7xAJSxCywgVnizfTVYAlhgQSJ20evsYDYLAKqEvMe7wdr5hWIknhw6jcTxDp5iV1t
        F1lBbE4BC4nfsw6AxYUEzCV6/61mmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqle
        bmaJXmpK6SZGSBgK7mCccVLuEKMAB6MSD6/GY6VIIdbEsuLK3EOMkhxMSqK8R98AhfiS8lMq
        MxKLM+KLSnNSiw8xSnAwK4nwat8FyvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQW
        wWRlODiUJHj1PgE1ChalpqdWpGXmlCCkmTg4QYbzAA1f8wFkeHFBYm5xZjpE/hSjopQ4rwFI
        swBIIqM0D64XliZeMYoDvSLMWwhSxQNMMXDdr4AGMwENtn4mDzK4JBEhJdXAaBET5p6+0l7j
        jfZpLrtdP/O7ujo4fnkGnDKMm6A7f2H/D6vnNo9St+SlVPVu/J612Svl4ZPGHOmt2wpM+F4W
        32QvXd7uy9lc+vNwQptdq930B0rBP/mfdm2/rbnz/euZsw1LF7tcCipnT6nM71Hd0Vl8bXOy
        4/nnXcrHQzT3HrH3P3VlwzJPJZbijERDLeai4kQAZSV1c+4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular, make it clear that they make copies of the sha1
arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/refs.h b/refs.h
index 685a979a0e..ec8c6bfbbb 100644
--- a/refs.h
+++ b/refs.h
@@ -427,6 +427,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *
  *     refname -- the name of the reference to be affected.
  *
+ *     new_sha1 -- the SHA-1 that should be set to be the new value of
+ *         the reference. Some functions allow this parameter to be
+ *         NULL, meaning that the reference is not changed, or
+ *         null_sha1, meaning that the reference should be deleted. A
+ *         copy of this value is made in the transaction.
+ *
+ *     old_sha1 -- the SHA-1 value that the reference must have before
+ *         the update. Some functions allow this parameter to be NULL,
+ *         meaning that the old value of the reference is not checked,
+ *         or null_sha1, meaning that the reference must not exist
+ *         before the update. A copy of this value is made in the
+ *         transaction.
+ *
  *     flags -- flags affecting the update, passed to
  *         update_ref_lock(). Can be REF_NODEREF, which means that
  *         symbolic references should not be followed.
-- 
2.11.0

