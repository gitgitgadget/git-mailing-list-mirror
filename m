Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069DB1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162480AbeBNTAr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:00:47 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:53320 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162210AbeBNTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:00:45 -0500
Received: by mail-yw0-f202.google.com with SMTP id n70so27363952ywd.20
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=M9hakpMl9rtAorH2CfwqdKrhiMq81BzsKpEeMp5fC+I=;
        b=UwBmkJ8q9ve+9CWYABYhOvJsGVoURD3O2LNUBip+ZFRmppTywq1Q+JyeysTpjOSbjR
         K8I3xFXIVUNz16RLIOcVDZuKMgvB+BInJ4/FEY1RzoYeAdVLyuFJFPQVxtT3cJeWqv98
         soUcYJRC3q71Mkh3I51t33KMvVjgc+dLW2l7+7AXJFKt0+NIgnoMRXNeAS67HJaHrFZk
         UH6hjgu2wJB0Vj9GnSFAodd48kdBSeDBfvoeyylbQ6NxDRRgRxj9ilZfPVgd/6YCAbPU
         gXWAH5v/hd4247omlbrD0gK3g2Z5cYWXHZB4ONraEEOu28SdRIKGajE5dP7z6Vtd7JYr
         oYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=M9hakpMl9rtAorH2CfwqdKrhiMq81BzsKpEeMp5fC+I=;
        b=g3sxcct+UBzxXHwj/4ko2xe9NZhkpiaz0thRyIkEIna8LoX19v4AnR4ebsRLxzxZqV
         kHtAf1PHh+DNdI9ouronckP84jyV7pMVf5piylre+qhJx4vJx8M4Bw1qf1+3nvEqDOq+
         AKFVxbmNH8V1EVsttN/5y3RRnwdpo0rMxF3U++b4LaAb135oo3Xv3MnUQTq0OJ+83B9G
         pyW/duUBLCdUEQ4PPFzdLOa96xABYUIKoYB49eTRvEQgMNqVcpbvnjkmLddRu5CsF7TD
         gMf2DuEG1cuo4WtxqBhVs/vDrvSpug5ppdDPz2TB5igfYoM5+N84ywRz2dG0WRVMHP7P
         eXVA==
X-Gm-Message-State: APf1xPD0TDEEXfCLk+pxSppEMePhOOLxF25KhAX/ZkrVu/1iOafIkg34
        FKP/Jb+DUcIaroTzHQKVfOxznYfG25ebjG0jGdzU+bTXrro2IpJVbh19Y/A/x6qJN9Um3Wma8eZ
        I0pgjb6Z41QhKe5wqfZkH00odyt6K2Os64+kd+nZ2lxTP442BfI1Pi5CsVg==
X-Google-Smtp-Source: AH8x224wvGj0FTixJQLf8EoEvBNTXIjoZ5qjxw3m0tJOoB9ymhd/YscJRxQM8Z+ta4BDTrIdDvvNkqE76vA=
MIME-Version: 1.0
X-Received: by 10.37.125.1 with SMTP id y1mr2946649ybc.13.1518634844892; Wed,
 14 Feb 2018 11:00:44 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:23 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-2-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 01/37] object_info: change member name from 'typename' to 'type_name'
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/cat-file.c |  2 +-
 cache.h            |  2 +-
 packfile.c         |  6 +++---
 sha1_file.c        | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75..d06c66c77 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -76,7 +76,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	buf = NULL;
 	switch (opt) {
 	case 't':
-		oi.typename = &sb;
+		oi.type_name = &sb;
 		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
diff --git a/cache.h b/cache.h
index d8b975a57..69b5a3bf8 100644
--- a/cache.h
+++ b/cache.h
@@ -1744,7 +1744,7 @@ struct object_info {
 	unsigned long *sizep;
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
-	struct strbuf *typename;
+	struct strbuf *type_name;
 	void **contentp;
 
 	/* Response */
diff --git a/packfile.c b/packfile.c
index 4a5fe7ab1..6657a0a49 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1350,16 +1350,16 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (oi->typep || oi->typename) {
+	if (oi->typep || oi->type_name) {
 		enum object_type ptot;
 		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
 					     curpos);
 		if (oi->typep)
 			*oi->typep = ptot;
-		if (oi->typename) {
+		if (oi->type_name) {
 			const char *tn = typename(ptot);
 			if (tn)
-				strbuf_addstr(oi->typename, tn);
+				strbuf_addstr(oi->type_name, tn);
 		}
 		if (ptot < 0) {
 			type = OBJ_BAD;
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac65..2c03458ea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1087,8 +1087,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	}
 
 	type = type_from_string_gently(type_buf, type_len, 1);
-	if (oi->typename)
-		strbuf_add(oi->typename, type_buf, type_len);
+	if (oi->type_name)
+		strbuf_add(oi->type_name, type_buf, type_len);
 	/*
 	 * Set type to 0 if its an unknown object and
 	 * we're obtaining the type using '--allow-unknown-type'
@@ -1158,7 +1158,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
+	if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
 		if (stat_sha1_file(sha1, &st, &path) < 0)
@@ -1239,8 +1239,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 				*(oi->disk_sizep) = 0;
 			if (oi->delta_base_sha1)
 				hashclr(oi->delta_base_sha1);
-			if (oi->typename)
-				strbuf_addstr(oi->typename, typename(co->type));
+			if (oi->type_name)
+				strbuf_addstr(oi->type_name, typename(co->type));
 			if (oi->contentp)
 				*oi->contentp = xmemdupz(co->buf, co->size);
 			oi->whence = OI_CACHED;
-- 
2.16.1.291.g4437f3f132-goog

