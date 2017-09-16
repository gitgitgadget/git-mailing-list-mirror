Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC7C20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdIPIJ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35221 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdIPIIO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id n64so2375322wrb.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MChFu5QWGRv6uixtSE1Nkf11qEYFsyicoEwa8pio1A=;
        b=nTvspp1g/3PTMGd+LUD83voOGUuDkwf/V7dGPoF/HVLpGSTxWotzoJjREUVa5+uYI9
         IbnBC5KnQfMUEQfpH8jIP1yvh9GSwxskShT8dy1BxBv57tURFncjSIRW62BNcRDHWrV2
         +96rAfT/i9iVb2dp5I9oT9mWjt/oOTT3jmOORZQ9QcVzbB7KG4BJuwQ+KrJb8JmIOeLF
         AQuxnZEUPvu8TdJpUaF4996tV/kutTo1hCc6pOrWcgs6IzAoaVY5Yf1lCOX9x9RqgNGS
         LzR4Hi4VzjmDpJnkHvtNni2LzKbqrlsts8RJHMNRmYdrKKbtm3FpjH7uiLQmgHeEeomM
         WEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MChFu5QWGRv6uixtSE1Nkf11qEYFsyicoEwa8pio1A=;
        b=BfUk3sTtH111yuelRfYv2mU309gSr7oUGknluMNfvEJm6xcmub+KIu7nJeNHE91dqU
         6gwVqczA5hlvmHIyPOxjlJyna9KaNYNSfSRGwhsoSBbh9+PIAcIuj6FygePXR4FypRir
         NL4Cm9VbR7g2kJQhHhBcVdBiETgdhwA3F0k2xmamj+KcbKiRwI9gJhs7W7BJcyzyPqZk
         Xa0hk1ycScHG8J6KsTsEe0qfNnPNZEUAZhno03ntCt9yImo0SUgfUWmkFobtc4EdUiKr
         Byadons7dGpHOjJ2jhMNrZ/FjzmneHSamI1NR/bla2BpdALyhNqFT2WB8VUMb2d9yspd
         8Edw==
X-Gm-Message-State: AHPjjUirLvINsBU3P9glrPHeuXp0F9QdCLEdt4a8dQvYiH9H2Jqt1DmH
        YvE8dAaKW+Xb3tvz
X-Google-Smtp-Source: ADKCNb4JqFZjUInZ5Ne9rUqlMIyPEA8HpU5vnANovf8CQcowVX+oZbil0mLZpOPVh+Knv3j9bT0B5w==
X-Received: by 10.223.159.6 with SMTP id l6mr25607381wrf.156.1505549292679;
        Sat, 16 Sep 2017 01:08:12 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:12 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 21/40] odb-helper: add odb_helper_get_raw_object()
Date:   Sat, 16 Sep 2017 10:07:12 +0200
Message-Id: <20170916080731.13925-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index 39d20fdfd7..1f4666b349 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -221,8 +221,107 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
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
@@ -326,6 +425,16 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 	return 0;
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
2.14.1.576.g3f707d88cd

