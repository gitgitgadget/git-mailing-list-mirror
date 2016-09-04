Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578B01F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbcIDQKR (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:17 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54246 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753766AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074412-1afff70000000931-68-57cc47178b9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id C5.47.02353.7174CC75; Sun,  4 Sep 2016 12:08:58 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5N026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:08:54 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/38] resolve_gitlink_ref(): eliminate temporary variable
Date:   Sun,  4 Sep 2016 18:08:07 +0200
Message-Id: <fbd7038a70da3306ba684d636302cb43d1fa4742.1473003902.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqCvlfibc4Oh3Q4uuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGbdX/2cuuMBe0bB9DVMD4xq2LkZO
        DgkBE4nZlxaygthCAlsZJT6/Ze5i5AKyTzJJ9M7dyAiSYBPQlVjU08wEYosIqElMbDvEAlLE
        DFI0a+JMdpCEsICvRPOFG8wgNouAqsTBlxOANnBw8ApESTz4XQuxTE7i0rYvYCWcAhYSZ3bP
        ZQYpERIwl2h/kT2BkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJBw
        E9rBuP6k3CFGAQ5GJR5eC+0z4UKsiWXFlbmHGCU5mJREeWcdPBkuxJeUn1KZkVicEV9UmpNa
        fIhRgoNZSYRX2wWonDclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgjfK
        DahRsCg1PbUiLTOnBCHNxMEJMpwHaHgfSA1vcUFibnFmOkT+FKMux4Ift9cyCbHk5eelSonz
        vnQFKhIAKcoozYObA0sTrxjFgd4S5lUEGcUDTDFwk14BLWECWrJu92mQJSWJCCmpBkbvX0J/
        sy7s/jYl0EtuwVS9v1dd16Xp2zrkvnbYnleguOjgrftLHIWPnP4jcP6zshRT1C7DbqY/jzSE
        2j6drFo7uzlCu2f9rQcfzPnf3TZ24Tj/fdpKK6/YCn7mSw+9T8/Ie1U67fbUJXmy/AzTU16k
        LtyWtvO812GDib+PbvRcXLn4WGH3wh+XlViKMxINtZiLihMBL6nlwu4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 12290d2..74c2c47 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1387,7 +1387,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
-	int len = strlen(path), retval;
+	int len = strlen(path);
 	struct strbuf submodule = STRBUF_INIT;
 	struct ref_cache *refs;
 
@@ -1404,8 +1404,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	}
 	strbuf_release(&submodule);
 
-	retval = resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-	return retval;
+	return resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
 }
 
 /*
-- 
2.9.3

