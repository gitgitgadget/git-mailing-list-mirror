Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03961F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeCSNeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38457 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933347AbeCSNco (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id l16so6367366wmh.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WpBi2XsIkRJs64qRK8ySdhoU5+Fq6iHGBy/bgf783AI=;
        b=lF3Z34H22TnJPj+QhLUJOf1l4QYRNgYZOvu5TFYYBdaGKRM9xM6Md3AvoEOx9vCXjq
         tkqfK7gxLYLyA9AZOFIE5gCrh0w7KeYsGPrPW2QCW5dLH4y8W1+oBz2UEdtKoTDvrhpQ
         m4Ec5p9s/gQPMEPeYUIzDAzO7zIkvQ+yt3xLE/cf1OFTC4O9XCsaMh5azigYhb8PuRhq
         xL7evuUt9/9mTFIFHWEKLHJo7NcSqcCuDykr4myU2jE1bZ3zvEiwwfWJbFXUTbYlB7ZT
         wlqmtWc20oGPeUBJwxPFnrO2RsSy7qNgB4+uNTgduqT0+TYaSMPPOhuchAL5oeZp3TEN
         cfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WpBi2XsIkRJs64qRK8ySdhoU5+Fq6iHGBy/bgf783AI=;
        b=uCnGyj6zfkT+D4V0TflYRshsDv0P5Q08vXJSNXQ+TxFCSHmWEl0p5r/yH+p4I4m6qK
         nQtAZWof5OpHcZiJGpt9TYlJoR5mVlJbRemkfnA6Js3MPRLRSJxL3vEykkmfowrAsdrh
         I76LqP1naOshpWB7jbvwWxWFCHtvI3v56DyLmCufVg0qQ7T70nGd/xXxHqLCS+m777Om
         2CeXMpvR0pCs3E1bSqw27lX0s5idBL9OijlS7FYD/h9dBQbLLAy8JK4nyLGYubhz7CTM
         8Ayyhj8rfqy0Qk1R0NJrnygZVGCRgyKh9NOjRuwokeXY5Pluon7fboMQc3Cyl+8289Zv
         spmA==
X-Gm-Message-State: AElRT7FEdqbaOYI5PSLnX1sQGN0cEe8LfCmEG4VVvBo7NyaGiPuFEws5
        XtsviWWoOFnPuw81foZqOLst4MFZ
X-Google-Smtp-Source: AG47ELvsAmC4YPnfkP9lnF6tAT3hFLW0APGo8HFSfb5MvKezO4qgaxNrPN2Q7te+3BgZdJj+8mu7GA==
X-Received: by 10.28.50.69 with SMTP id y66mr9255640wmy.35.1521466362988;
        Mon, 19 Mar 2018 06:32:42 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:41 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 25/36] odb-helper: add odb_helper_get_raw_object()
Date:   Mon, 19 Mar 2018 14:31:36 +0100
Message-Id: <20180319133147.15413-26-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing odb_helper_get_object() is renamed
odb_helper_get_git_object() and a new odb_helper_get_raw_object()
is introduced to deal with external objects that are not in Git format.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 2734af793b..fdd062ec8d 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -235,8 +235,107 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
 	return !!odb_helper_lookup(o, sha1);
 }
 
-int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
-			    int fd)
+static int odb_helper_get_raw_object(struct odb_helper *o,
+				     const unsigned char *sha1,
+				     int fd)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+	unsigned long total_got = 0;
+
+	char hdr[32];
+	int hdrlen;
+
+	int ret = Z_STREAM_END;
+	unsigned char compressed[4096];
+	git_zstream stream;
+	git_SHA_CTX hash;
+	unsigned char real_sha1[20];
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, 0, "get_raw_obj %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	/* Set it up */
+	git_deflate_init(&stream, zlib_compression_level);
+	stream.next_out = compressed;
+	stream.avail_out = sizeof(compressed);
+	git_SHA1_Init(&hash);
+
+	/* First header.. */
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(obj->type), obj->size) + 1;
+	stream.next_in = (unsigned char *)hdr;
+	stream.avail_in = hdrlen;
+	while (git_deflate(&stream, 0) == Z_OK)
+		; /* nothing */
+	git_SHA1_Update(&hash, hdr, hdrlen);
+
+	for (;;) {
+		unsigned char buf[4096];
+		int r;
+
+		r = xread(cmd.child.out, buf, sizeof(buf));
+		if (r < 0) {
+			error("unable to read from odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			git_deflate_end(&stream);
+			return -1;
+		}
+		if (r == 0)
+			break;
+
+		total_got += r;
+
+		/* Then the data itself.. */
+		stream.next_in = (void *)buf;
+		stream.avail_in = r;
+		do {
+			unsigned char *in0 = stream.next_in;
+			ret = git_deflate(&stream, Z_FINISH);
+			git_SHA1_Update(&hash, in0, stream.next_in - in0);
+			write_or_die(fd, compressed, stream.next_out - compressed);
+			stream.next_out = compressed;
+			stream.avail_out = sizeof(compressed);
+		} while (ret == Z_OK);
+	}
+
+	close(cmd.child.out);
+	if (ret != Z_STREAM_END) {
+		warning("bad zlib data from odb helper '%s' for %s",
+			o->name, sha1_to_hex(sha1));
+		return -1;
+	}
+	ret = git_deflate_end_gently(&stream);
+	if (ret != Z_OK) {
+		warning("deflateEnd on object %s from odb helper '%s' failed (%d)",
+			sha1_to_hex(sha1), o->name, ret);
+		return -1;
+	}
+	git_SHA1_Final(real_sha1, &hash);
+	if (hashcmp(sha1, real_sha1)) {
+		warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
+			o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
+		return -1;
+	}
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+	if (total_got != obj->size) {
+		warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
+			o->name, sha1_to_hex(sha1), total_got, obj->size);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int odb_helper_get_git_object(struct odb_helper *o,
+				     const unsigned char *sha1,
+				     int fd)
 {
 	struct odb_helper_object *obj;
 	struct odb_helper_cmd cmd;
@@ -383,6 +482,16 @@ int odb_helper_get_many_direct(struct odb_helper *o,
 	return res;
 }
 
+int odb_helper_get_object(struct odb_helper *o,
+			  const unsigned char *sha1,
+			  int fd)
+{
+	if (o->supported_capabilities & ODB_HELPER_CAP_GET_RAW_OBJ)
+		return odb_helper_get_raw_object(o, sha1, fd);
+	else
+		return odb_helper_get_git_object(o, sha1, fd);
+}
+
 int odb_helper_put_object(struct odb_helper *o,
 			  const void *buf, size_t len,
 			  const char *type, unsigned char *sha1)
-- 
2.17.0.rc0.37.g8f476fabe9

