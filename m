Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F051F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeCCLjB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:01 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37924 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCCLjB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id l24so4865397pgc.5
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+ye0fDEu5DvSKIFWH3eI9HpMmGp8g/7szhQ+RSg7mg=;
        b=Qo6oIp66JRg7r36sifC3z8UAW91CKEu7HsgIjhmHo0eTaUIGuAp2hn+nRDxLi8XToL
         JhSTMLDTc0qZMWZ3v7VBk9L61cGwyiTBBsmKIWOoU+dUBtEO83iImGP4ltcrSlFz4xLh
         t1pxajqO3fljJSiony4EIFjyiGh2VSs9SBhZpnQvvoesVui0fXg6s7xSeEL6HVIpqAjM
         zUa3m02zNn1l1DG1E3LMaCI3qWf5t5edqeCQrucmN/pESYg2oAXJe3jZ4y8wrw2BFmV1
         jwVTGZtpSv122nZQPV/j/QEZnDMp9H/tjLLp+m70eCnqfHd7Ns1HWMULhcvEOzchdEzo
         +mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+ye0fDEu5DvSKIFWH3eI9HpMmGp8g/7szhQ+RSg7mg=;
        b=eHT+PtICGlulWLA0gQ21m9tX0JtHZHFuQf/YqBX5KWTu2deO34pgjeh18pfCZvsBe4
         H9ifTtSc8oQIc6od6mHqCrvTXa2XufQ5I/hYojtUd9Axmug0cGMsGT6Uf5V0O/tFc7U5
         i3R2cKUcoyn9vY9NX5drQR7pWUZPU4igfIjz6IculgWqRvTYCuJ51hRMJerzUVXpfSPS
         TfxQupN+d19l4fW2OrXbVKLUzLe9rp/VuN1kor10LnY6ktS1drC5c0uUY65fMw8p+8XN
         MJhAPmEEruIiD1cjebBGM75U1uY2HN62ItEmX32VCars7tDTP9Nl6JyXeK4eqw2ALj8N
         lhzQ==
X-Gm-Message-State: APf1xPAPghhzpsf99bycJZELeImWZ/7yYSw758q0uccbtIosnD4dm4tP
        cI3Cn2lTidAcrHmJLOk9xqXIfw==
X-Google-Smtp-Source: AG47ELsXi2uPVR2Q6RZz+RLiAL3jEgOIlHCtDTyt1AlM/cvbxFKvYyaJ6brS5BPwwVDDlf71QNIrKg==
X-Received: by 10.99.123.80 with SMTP id k16mr7308739pgn.134.1520077140392;
        Sat, 03 Mar 2018 03:39:00 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id d15sm19557911pfj.121.2018.03.03.03.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:38:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:38:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/44] sha1_file: allow sha1_file_name to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:20 +0700
Message-Id: <20180303113637.26518-28-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index ad4c7501d7..98622a2b98 100644
--- a/object-store.h
+++ b/object-store.h
@@ -119,8 +119,7 @@ void raw_object_store_clear(struct raw_object_store *o);
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified sha1.
  */
-#define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index ecbf846f12..e04e0587c2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,9 +323,9 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
+void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
 {
-	strbuf_addstr(buf, get_object_directory());
+	strbuf_addstr(buf, r->objects.objectdir);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 }
-- 
2.16.1.435.g8f24da2e1a

