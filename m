Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A22A11F404
	for <e@80x24.org>; Mon, 29 Jan 2018 15:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeA2P70 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 10:59:26 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36426 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeA2P7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 10:59:20 -0500
Received: by mail-lf0-f66.google.com with SMTP id t79so10714994lfe.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=+g9ByEZ0mRXMVU0/c1Tn/7OkaeGuj694IO9HdEeu5Bg=;
        b=dHhZETqpJTBgAkTXibp0UFQ4S1tYda0ybuzCpJp4xx/VaEOEFtBitlj6cfi2ZVNfBO
         +kuZWzvhdM3A08wVNryrmTTig3hR2nU/TFTTRo0lK7Ia0Ej5tyqQR+YiQJ4Tsbx7yJVz
         An466lb+iQ4mspkHrGaagQniEoZTfuYGs5TbSO2CaXBq0XIZHIn4kJ6k3CV/3um7dUSo
         jEOFxJPtwEKva6w7gIsFu2+j8WA0CTnjgUjz8CWQiM2/IvA3NSgTYkE/YgJzgzmPUEsD
         byQ9l94SU7Rqpo5oViNd1EBrv6FPhRBlRXSrKKHc4GRnfIv49dNZbmQVl+K27V2jYmpW
         gKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+g9ByEZ0mRXMVU0/c1Tn/7OkaeGuj694IO9HdEeu5Bg=;
        b=EhE1w7Kn3VuiNPpDmiFljJ9F1suxTGVrLxCdD9ov1YTRyPMIRiAb/taa/K9P5xcYe3
         cAgFx6yH1wmRkruHDgxTSWwK+MhEa1TqJdz1luKn6c6kZUtJN6KLE7yJYf89s2kv0npo
         xP2eudra0/PIgBBjFwVvup46+ICy1WyaLqVdihYW0L88ES2HZfX5XLBUc4VZoYB7cwhv
         OXZVsJWDoMe4Mp5bm314cBMgPofhOpnQS1Hvl46qDpmfP87H9kvjDDiuDzEAuaaxZ5SS
         Ub64JJg5qnfdkIxjlp5V5vMUTQzD8zQ4CHutc/AvQyQuOj+KboDS0WmiAxRepwPn7xkw
         XV1Q==
X-Gm-Message-State: AKwxytcX7qDrm5qNCreB+fO4YQPS59bX8aa86VBc4QHRSV4de7PzX6x4
        xC/ZBFaZwsFu3cYMt81gtlSLwqlm
X-Google-Smtp-Source: AH8x2253xfDtfd+u9wFcgGPbJreL+vDf9qQ99ITQ1Gs9v8OxIx3SzDdbJc9hCJ1YeeBSpCS+a1XeoQ==
X-Received: by 10.25.27.71 with SMTP id b68mr12669268lfb.64.1517241558672;
        Mon, 29 Jan 2018 07:59:18 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id p74sm697995ljp.13.2018.01.29.07.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jan 2018 07:59:17 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.net
Subject: [PATCH v3 1/1] setup: recognise extensions.objectFormat
Date:   Mon, 29 Jan 2018 16:59:15 +0100
Message-Id: <ef3dacc7f0669a05987cd0a018926b9bdbf10aed.1517241235.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517241235.git.patryk.obara@gmail.com>
References: <cover.1517098675.git.patryk.obara@gmail.com>
 <cover.1517241235.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517241235.git.patryk.obara@gmail.com>
References: <cover.1517241235.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extension selects which hashing algorithm from vtable should be
used for reading and writing objects in the object store.  At the moment
it supports only single value (sha-1).

In case value of objectFormat is an unknown hashing algorithm, Git
command will fail with the following message:

  fatal: unknown repository extensions found:
	  objectformat = <value>

To indicate, that this specific objectFormat value is not recognised.

The objectFormat extension is not allowed in repository marked as
version 0 to prevent any possibility of accidentally writing a NewHash
object in the sha-1 object store. This extension behaviour is different
than preciousObjects extension (which is allowed in repo version 0).

Add tests and documentation note about new extension.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 Documentation/technical/repository-version.txt | 12 ++++++++++++
 setup.c                                        | 27 ++++++++++++++++++++++++++
 t/t1302-repo-version.sh                        | 15 ++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad37986e..7e2b832603 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,15 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`objectFormat`
+~~~~~~~~~~~~~~
+
+This extension instructs Git to use a specific algorithm for addressing
+and interpreting objects in the object store. Currently, the only
+supported object format is `sha-1`. At the moment, the primary purpose
+of this option is to enable Git developers to experiment with different
+hashing algorithms without re-compilation of git client.
+
+See `hash-function-transition.txt` document for more detailed explanation.
+
diff --git a/setup.c b/setup.c
index 8cc34186ce..9b9993a14e 100644
--- a/setup.c
+++ b/setup.c
@@ -405,6 +405,31 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
+static int find_object_format(const char *value)
+{
+	int i;
+	for (i = GIT_HASH_SHA1; i < GIT_HASH_NALGOS; ++i) {
+		if (strcmp(value, hash_algos[i].name) == 0)
+			return i;
+	}
+	return GIT_HASH_UNKNOWN;
+}
+
+static void detect_object_format(struct repository_format *data,
+				 const char *value)
+{
+	if (data->version == 0)
+		die(_("invalid repository format version '%d'"), data->version);
+
+	data->hash_algo = find_object_format(value);
+	if (data->hash_algo == GIT_HASH_UNKNOWN) {
+		struct strbuf object_format = STRBUF_INIT;
+		strbuf_addf(&object_format, "objectformat = %s", value);
+		string_list_append(&data->unknown_extensions, object_format.buf);
+		strbuf_release(&object_format);
+	}
+}
+
 static int check_repo_format(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -422,6 +447,8 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
+		else if (!strcmp(ext, "objectformat"))
+			detect_object_format(data, value);
 		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index ce4cff13bb..227b397ff2 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -107,4 +107,19 @@ test_expect_success 'gc runs without complaint' '
 	git gc
 '
 
+test_expect_success 'object-format not allowed in repo version=0' '
+	mkconfig 0 "objectFormat = sha-1" >.git/config &&
+	check_abort
+'
+
+test_expect_success 'object-format=sha-1 allowed' '
+	mkconfig 1 "objectFormat = sha-1" >.git/config &&
+	check_allow
+'
+
+test_expect_success 'object-format=foo unsupported' '
+	mkconfig 1 "objectFormat = foo" >.git/config &&
+	check_abort
+'
+
 test_done
-- 
2.14.3

