Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7DC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbiBQNz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbiBQNzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA7272DA3
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so9196109wrb.5
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MNyfzPgLuL1AhBGd7/JnxDDNU29085If/CkNixlO+Tg=;
        b=Pg0udte9IQFcqcsixdxh3iAkpKkZvmb1/7at0TY93/8OYw5jaIvvhcMUMcG4YnK/WA
         6MYvqY2kHW1+h4L4lxGkdvLCUPcBHajQRQ+iORRoagPRdhJqpvOwWfjB40XGOaBjF/il
         E81Sdq9ZHF997hcz3TClG+144PWE22QXMD9k4GUnZdee+6WgpGGJJ9bfextEL2LlAfMv
         LY4gpW60Heh1Pscz+kZ2cSFXbYt5whrdYogcoSEVtnBRiAf/ML8QXOMxqlSdEm8ZtPCe
         ktmIwEvQJkozUD1+rN3NTASZSq+wpDmckS+VcdCnukOCvN1cfRKkwKZ7BrwV5sVQCha5
         KLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MNyfzPgLuL1AhBGd7/JnxDDNU29085If/CkNixlO+Tg=;
        b=PrJiaRI3Ch6Yo83pZv4WNPRv7mWs/cOYj1CjaSSyKDbcLjiNLm//QBUG8h9j2w+wu+
         ddgDcOjjgzGnR8wQhQNRACxqChCgfJigjjAbAGk0MJiQi7dfNHtEn5gpCcUEKZN+JB04
         j+R9oT/SWY1tqNgy3pmgOBnGLHn1x+4UZZuhgxRqsuyC1pMjm00fohJ4uAsXu15AgxuS
         +EaFStvZ2lDVr8N+LlVVwnrUR/Alwd3/Vowi7MvPZ01K8D2ZvdeIqSgAtoxRdYMeVYuf
         3O90+wvQCJJIXFRXC0YK8lfjwfbfcfqcm3jBCOt8eddcziVUL7C1nMFXNzxMcGLJf/rN
         C+Gw==
X-Gm-Message-State: AOAM533hppiw+9+a6/76HIdyO5UiLyt9jwWV3Yowa7d6haxScObMGs4Z
        mlXoi1rMms95L6e3xi1/ilv9UNMD8vg=
X-Google-Smtp-Source: ABdhPJze3++BcbDH2DcS8qefgAjU/K2ilbycq/PHSs9HlOJqP4jqMjY6Pi716p1t21PAzQtR3wZ3sg==
X-Received: by 2002:a5d:62c3:0:b0:1e3:2d29:fc3f with SMTP id o3-20020a5d62c3000000b001e32d29fc3fmr2414795wrv.331.1645106132023;
        Thu, 17 Feb 2022 05:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm9949734wrn.12.2022.02.17.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:31 -0800 (PST)
Message-Id: <2bd3d44ba57ddb43c09367b45a8f056233d465e9.1645106124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:22 +0000
Subject: [PATCH v2 5/7] reftable: ensure that obj_id_len is >= 2 on writing
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

