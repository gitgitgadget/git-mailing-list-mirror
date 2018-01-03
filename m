Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB461F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeACQfL (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45498 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbeACQe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so3636133wme.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1U9dk3x7n9A3fitgrGj9CMeaeYEC4lcCaOqHsm3TdA=;
        b=tFf5oOxIfkIMA2b3ZvxCJ9jAC0mraEI1nRtH2FlCswylPzL5TsntS9g6tDH/16+alW
         OYszqb759Lwc+nOPhEsvFT0iXwoyLrGSTRgay+W84JUQtWKq40DLp6aYHBF2856yzc2V
         mecw9bS2QU7/3Q1HBQl4mLhBNxAWHrkcz5aWarHjkTmLXDbzRwx6QjOtpV20DTW3IUQ6
         0YHBYdmWXlftTXvvSBmkUNmr4dF98n6WeaS9IqeDV6D8U4Nd0633PcolRoZtCBHZGmD0
         CX20c7jD27+q9jNq8kxbdiDUtcG3KIqeBoaxb5YWL/NEiIpUlLVgK6EWRNFJUKXUHLwU
         pnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F1U9dk3x7n9A3fitgrGj9CMeaeYEC4lcCaOqHsm3TdA=;
        b=lUEn4owp+tT0sW/I+PXpLU1FBFGGCDNgJQX541gge1aOvdjINb8UE7Osx2KSxS4QHS
         lmyOTKwpL2dvt43tAI7YXbPMVQ0Sfpyz0th+XXZ17hyo2J3rLzshNXtA9k0sYTq8DKH7
         Kj01e/XGpQ4W9T929R44uNVCsVg+WuIdwj5iWvDR1ecLEmabbSQn73Qtpp/wfZDiUzMN
         tgxpFIB13uQybOT//9clngrg/Ssl6GfLGQsUAjofvvxD3WJ7Hxpdzcau4rMFCpEeDZCs
         3fOhjAwRE9IClMCgKgfhewIfqvqfUjzSjxYAsIUPGphmdAjl74hxiNVtl1KXNyomfyr5
         BZag==
X-Gm-Message-State: AKGB3mIED99jL4B1U3l3JoqDiPJXB06PPkcyVigd9+tJ4dT3hwOjK9y5
        4Q8DoVTHtFqhoJ34QANWfTVGCorA
X-Google-Smtp-Source: ACJfBouOqZmMG2yD6x0ZT52VzGE9PFKQ24T9eSopvvCJVPtMikDTzRvLWLoiAHXGyLyh6nIiV3oz2g==
X-Received: by 10.28.51.21 with SMTP id z21mr1917237wmz.94.1514997298075;
        Wed, 03 Jan 2018 08:34:58 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:57 -0800 (PST)
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
Subject: [PATCH 27/40] odb-helper: add odb_helper_get_raw_object()
Date:   Wed,  3 Jan 2018 17:33:50 +0100
Message-Id: <20180103163403.11303-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing odb_helper_get_object() is renamed
odb_helper_get_git_object() and a new odb_helper_get_raw_object()
is introduced to deal with external objects that are not in Git format.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index 6f56f07b38..fc30c2fa57 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -222,8 +222,107 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
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
+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj->type), obj->size) + 1;
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
@@ -340,6 +439,16 @@ int odb_helper_get_direct(struct odb_helper *o,
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
2.16.0.rc0.16.g82191dbc6c.dirty

