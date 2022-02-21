Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FFFC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiBUSrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:47:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBUSql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:46:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41A195
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so96387wrb.6
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MNyfzPgLuL1AhBGd7/JnxDDNU29085If/CkNixlO+Tg=;
        b=DY7U1Vmku5NJcly5rG9M7kKdIaeR0YULptyMOUXoQYwePDQL+1rBLsjMTGCQYYRC6N
         fuufd2MdQnvzgWn3storXe29bhp3UvjX5EXNVEMVToqQvRc2ZBhx0RF4kp8MNZ0AgMFb
         JRRdyNmigDP5QrdTckwHd8qwwObplYy9P6LnOFgxLnpHZDqdk7mtwvORCd9/5IKi7/nZ
         svgD/BUKnqSiKfGr2Um5YhWEc1q2yUl/VsTGer/p8H3aopKLabZFhU8pCPTgHeOxWR+7
         tDyeQYZwC3dK+DNY7Uuamb3NfeZpdCmxOcY4LyNVR4Pok5alyurlAb5ng5HiQzTOydG6
         gz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MNyfzPgLuL1AhBGd7/JnxDDNU29085If/CkNixlO+Tg=;
        b=7czh8h2oklTgN0N/hd8HKn+89NuVfjUbRzbOgr9Ab8hFuXLqLAe9VncN6omuDWfY6L
         FVZzLguoYiaeq/UrMoyVpglUCRgMqVhX49qrfjBdtksdv8PhzIOvuzh+M2vAkwKjuDT7
         XCNKjAY2EQSAT1ESWKY6f4d4cI3RaqFdNExR28ckHdc0v1P0F3T1ZjwBMce0subR+V/q
         L+wT/pFgd8PBOmY/D4c5QzhU3dhGVNhizA5lNrisd16F+IodVZYXAGeLDFQ5rDVI+w0+
         E0p3APUjuRDgJK005MrumCvDayMnnKPX5nX9eLE2yMn9qQSvnycwNcjQYLukcMdYJZ0u
         omjw==
X-Gm-Message-State: AOAM533BuvjUkcbgeIybicrcIK6vKLLx18laS6Y2WAIhbam4L97jHGfu
        A9t6vHilb2eS3I6Yjv70PKk/mn2UvQY=
X-Google-Smtp-Source: ABdhPJxCN5qI/YtniP3nfejk0i+O55URRs5OwpiLZl5pu4VpoKJ/5eJG/6i+ZjZyDNVXrd5bKDULcQ==
X-Received: by 2002:adf:d20c:0:b0:1e5:952c:34b5 with SMTP id j12-20020adfd20c000000b001e5952c34b5mr17251873wrh.82.1645469175120;
        Mon, 21 Feb 2022 10:46:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm22958057wri.33.2022.02.21.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:14 -0800 (PST)
Message-Id: <0b8a42399dd7aa04fdc791d25969a3b085190c6f.1645469170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
        <pull.1185.v3.git.git.1645469170.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 18:46:08 +0000
Subject: [PATCH v3 5/7] reftable: ensure that obj_id_len is >= 2 on writing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

When writing the same hash many times, we might decide to use a
length-1 object ID prefix for the ObjectID => ref table, which is out
of spec.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 37 +++++++++++++++++++++++++++++++++++++
 reftable/writer.c         |  4 +++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index fd5922e55f6..35142eb070e 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -667,6 +667,42 @@ static void test_write_empty_table(void)
 	strbuf_release(&buf);
 }
 
+static void test_write_object_id_min_length(void)
+{
+	struct reftable_write_options opts = {
+		.block_size = 75,
+	};
+	struct strbuf buf = STRBUF_INIT;
+	struct reftable_writer *w =
+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
+	uint8_t hash[GIT_SHA1_RAWSZ] = {42};
+	struct reftable_ref_record ref = {
+		.update_index = 1,
+		.value_type = REFTABLE_REF_VAL1,
+		.value.val1 = hash,
+	};
+	int err;
+	int i;
+
+	reftable_writer_set_limits(w, 1, 1);
+
+	/* Write the same hash in many refs. If there is only 1 hash, the
+	 * disambiguating prefix is length 0 */
+	for (i = 0; i < 256; i++) {
+		char name[256];
+		snprintf(name, sizeof(name), "ref%05d", i);
+		ref.refname = name;
+		err = reftable_writer_add_ref(w, &ref);
+		EXPECT_ERR(err);
+	}
+
+	err = reftable_writer_close(w);
+	EXPECT_ERR(err);
+	EXPECT(writer_stats(w)->object_id_len == 2);
+	reftable_writer_free(w);
+	strbuf_release(&buf);
+}
+
 static void test_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
@@ -772,5 +808,6 @@ int readwrite_test_main(int argc, const char *argv[])
 	RUN_TEST(test_write_empty_key);
 	RUN_TEST(test_write_empty_table);
 	RUN_TEST(test_log_overflow);
+	RUN_TEST(test_write_object_id_min_length);
 	return 0;
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index d54215a50dc..5e4e6e93416 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -515,7 +515,9 @@ static void object_record_free(void *void_arg, void *key)
 static int writer_dump_object_index(struct reftable_writer *w)
 {
 	struct write_record_arg closure = { .w = w };
-	struct common_prefix_arg common = { NULL };
+	struct common_prefix_arg common = {
+		.max = 1,		/* obj_id_len should be >= 2. */
+	};
 	if (w->obj_index_tree) {
 		infix_walk(w->obj_index_tree, &update_common, &common);
 	}
-- 
gitgitgadget

