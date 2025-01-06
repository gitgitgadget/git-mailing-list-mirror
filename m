Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CD1DB92A
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159857; cv=none; b=Q/3gkUyKbLnCOVuesz+WX4XU1NFaxgFnDXfaYxX/JW56voFg0wFmlYhxPR78gBv/RCwqPKUrMEtO/arZ8Nh0MMZXgPmLQ/y/2aDyE2OxJDr85ah7wv441nUpVWgddvd8RWTn2fleh3Yq+uLo6hFEBWv+uPne51SCZW8/GB9lcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159857; c=relaxed/simple;
	bh=8/PDchkR/KMRquoK5FityImFgPDfszfA29AUIdbJGKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu2TaE6IFhQg3xZIbJZ3SliKUEJt3RvVsh+LpQF/ZUp7eubmR+1LYFctqU7XBZkMKbcco5CqhyhZCUEUzQvThTNMGXlh9UAOjQms/SAEbe+xerHkcDAAgf2HaoKTKoYN4lSjmAstyIYXYIcnqxZ/CAns0zu23TZ9pv258ih/j10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpIkSsSN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpIkSsSN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21675fd60feso2463745ad.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 02:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736159854; x=1736764654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ak2KvSyKXuyYal8G0OJ/TdfdcBHWAxOYRWEb3+u+sM=;
        b=PpIkSsSNlWOsFpR2zCid7yNLFtPOz+Ni52Dv7gOmeJNuBxk5a/0qe6A1ijAVgIhPVI
         CT2NJ4NqpsxLxVcTkSsO8Kma82dsFiKgIwODSa3sxTEIDevf+EqAF6Q2cTmv9mlH2V7I
         11qDtwvAUFg7gae/B6s3xI8BiCeXFLlJC2kbjI56bwCQnOd7USf1V7fwrctD5n5c7ieY
         eEG7HQq8m3Tasleceiqaue8DRyyQ70GrFCyK490JSC6sbN9h7AUIdK8yCcCu9iBH2FC7
         /64kN8b58H0aFgpViJiHePKbTe5Fw88lS19Nk/z45O1I2URf7mw0i5SXmEaDIVHywRuy
         PWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736159854; x=1736764654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ak2KvSyKXuyYal8G0OJ/TdfdcBHWAxOYRWEb3+u+sM=;
        b=Aqx8hwU2Q25yncNRMKmNxRjQqyO7T8UfRdiNEyFbFmdF+dEVlqfEli2v8mWq48hskK
         Qnh1DAFD67fj2CHDf+UtrLE0WE94kXDhfV75OP4hdGaE15HwaH5D5XzMPNHeVlFtj6zp
         9GJggpNFidkXYvKhokORHyrnkTZMMRMAWkJlkHjmPs2brt4DQTNMg89tb8J8lMge2pV9
         ComtoEM5h9q1h+upYeKMUTMFnb0tTWJQgg3ARWmNj/0PV9mRRnHXFcVs76Gu/jbs4FzK
         XaT7W74d4/lD9cyCFw4SVmizO2zbt3o4fRWJyrCiiUW3no+tx34iJ5SeRz8x4wgQew40
         eNdg==
X-Gm-Message-State: AOJu0Yz9/ASvxhmCKQQWhPcSRZ9O5i9pNxKEdCcims59RUIChZnh/vH9
	3sZ9HMsAHApyvK2ib/D+w1eRp96kWA2JmJwaHrNjZHFS2awIJ0TzjFmwDeDItTk=
X-Gm-Gg: ASbGncvrq/ZAGJw+PNl3iPUt4AhIgSvxgOmwua48f0bsWaHQhaADbYplgzhsKCg5IrL
	qoGqAteTRN/P7z9PPDb/WW+Qrb7cdf2BHJq9dRJNRFzhLoHhIuRZNHXRqeOkLvl8p44JvCvHamm
	8PF59D4noZ6JszFqm1OcZCrde4vPzM2oHEdj0z9JJ4IVIQ4syHl/mfBDX4hM+FAzBxcO7r+99+T
	Hgn+2FXIfKOFTRBbHiSVYLd7V2rGIT9s+8YWm6u/zYxf1YK7RXxi+WiNOIg4QFz2+Td7QsVUbbN
	IMwa3g==
X-Google-Smtp-Source: AGHT+IFV29saUT06l7D3q67/HDEzXAzR/BOryFAr/4e6v2s+ZexmOnkxS/i7Mauv/q6vLCD3H6jwpA==
X-Received: by 2002:a17:902:e5c7:b0:215:3fb9:5201 with SMTP id d9443c01a7336-219e6f14834mr789772555ad.44.1736159854118;
        Mon, 06 Jan 2025 02:37:34 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b85f00f9sm28774281a12.43.2025.01.06.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 02:37:33 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] version: introduce osversion.command config for os-version output
Date: Mon,  6 Jan 2025 16:00:52 +0530
Message-ID: <20250106103713.1452035-5-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently by default, the new `os-version` capability only exchange the
operating system name between servers and clients i.e "Linux" or
"Windows".

Let's introduce a new configuration option, `osversion.command`, to handle
the string exchange between servers and clients. This option allows
customization of the exchanged string by leveraging the output of the
specified command. If this is not set, the `os-version` capability
exchange just the operating system name.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/config/transfer.txt | 11 ++++++-
 Documentation/gitprotocol-v2.txt  | 13 ++++----
 t/t5555-http-smart-common.sh      | 29 ++++++++++++++++++
 t/t5701-git-serve.sh              | 33 ++++++++++++++++++++
 version.c                         | 51 ++++++++++++++++++++++++++++++-
 5 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index e2d95d1ccd..28a08f21fc 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -131,4 +131,13 @@ transfer.advertiseOSVersion::
 	servers. It makes clients and servers send to each other a string
 	representing the operating system name, like "Linux" or "Windows".
 	This string is retrieved from the 'sysname' field of the struct returned
-	by the uname(2) system call. Defaults to true.
+	by the uname(2) system call. If the `osVersion.command` is set, the
+	output of the command specified will be the string exchanged by the clients
+	and the servers. Defaults to true.
+
+osVersion.command::
+	If this variable is set, the specified command will be run and the output
+	will be used as the value `X` for `os-version` capability (in the form
+	`os-version=X`). `osVersion.command` is only used if `transfer.advertiseOSVersion`
+	is true. Refer to the linkgit:git-config[1] documentation to learn more about
+	`transfer.advertiseOSVersion` config option.
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index c28262c60b..53621c0bce 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -203,12 +203,13 @@ in its request to the server (but it MUST NOT do so if the server did
 not advertise the os-version capability). The `X` and `Y` strings may
 contain any printable ASCII characters except space (i.e., the byte
 range 32 < x < 127), and are typically made from the result of
-`uname -s`(OS name e.g Linux). The os-version capability can be disabled
-entirely by setting the `transfer.advertiseOSVersion` config option
-to `false`. The `os-version` strings are purely informative for
-statistics and debugging purposes, and MUST NOT be used to
-programmatically assume the presence or absence of particular
-features.
+`uname -s`(OS name e.g Linux).  If the `osVersion.command` is set,
+the `X` and `Y` are made from the ouput of the command specified.
+The os-version capability can be disabled entirely by setting the
+`transfer.advertiseOSVersion` config option to `false`. The `os-version`
+strings are purely informative for statistics and debugging purposes, and
+MUST NOT be used to programmatically assume the presence or absence of
+particular features.
 
 ls-refs
 ~~~~~~~
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index f9e2a66cba..8d5844eaf2 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -152,6 +152,35 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'git upload-pack --advertise-refs: v2 with osVersion.command config set' '
+	# test_config is used here as we are not reusing any file output from here
+	test_config osVersion.command "uname -srvm" &&
+	printf "agent=FAKE" >agent_and_long_os_name &&
+
+	if test_have_prereq !WINDOWS
+	then
+		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_os_name
+	fi &&
+
+	cat >expect <<-EOF &&
+	version 2
+	$(cat agent_and_long_os_name)
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=2 \
+	GIT_USER_AGENT=FAKE \
+	git upload-pack --advertise-refs . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
 test_expect_success 'git receive-pack --advertise-refs: v2' '
 	# There is no v2 yet for receive-pack, implicit v0
 	cat >expect <<-EOF &&
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index f4668b7acd..51d99cd62c 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -41,6 +41,39 @@ test_expect_success 'test capability advertisement' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test capability advertisement with osVersion.command config set' '
+	# test_config is used here as we are not reusing any file output from here
+	test_config osVersion.command "uname -srvm" &&
+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_long_os_name &&
+
+	if test_have_prereq !WINDOWS
+	then
+		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_os_name
+	fi &&
+
+	test_oid_cache <<-EOF &&
+	wrong_algo sha1:sha256
+	wrong_algo sha256:sha1
+	EOF
+	cat >expect.base_long <<-EOF &&
+	version 2
+	$(cat agent_and_long_os_name)
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	EOF
+	cat >expect.trailer_long <<-EOF &&
+	0000
+	EOF
+	cat expect.base_long expect.trailer_long >expect &&
+
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stateless-rpc flag does not list capabilities' '
 	# Empty request
 	test-tool pkt-line pack >in <<-EOF &&
diff --git a/version.c b/version.c
index 8242baf41c..b446232898 100644
--- a/version.c
+++ b/version.c
@@ -1,9 +1,13 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
 #include "gettext.h"
 #include "config.h"
+#include "run-command.h"
+#include "alias.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -72,6 +76,50 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
 	return 0;
 }
 
+/*
+ * Return -1 if unable to retrieve the osversion.command config or
+ * if the command is malformed; otherwise, return 0 if successful.
+ */
+static int fill_os_version_command(struct child_process *cmd)
+{
+	const char *os_version_command;
+	const char **argv;
+	char *os_version_copy;
+	int n;
+
+	if (git_config_get_string_tmp("osversion.command", &os_version_command))
+		return -1;
+
+	os_version_copy = xstrdup(os_version_command);
+	n = split_cmdline(os_version_copy, &argv);
+
+	if (n < 0) {
+		warning(_("malformed osVersion.command config option: %s"),
+			_(split_cmdline_strerror(n)));
+		free(os_version_copy);
+		return -1;
+	}
+
+	for (int i = 0; i < n; i++)
+		strvec_push(&cmd->args, argv[i]);
+	free(os_version_copy);
+	free(argv);
+
+	return 0;
+}
+
+static int capture_os_version(struct strbuf *buf)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	if (fill_os_version_command(&cmd))
+		return -1;
+	if (capture_command(&cmd, buf, 0))
+		return -1;
+
+	return 0;
+}
+
 const char *os_version(void)
 {
 	static const char *os = NULL;
@@ -79,7 +127,8 @@ const char *os_version(void)
 	if (!os) {
 		struct strbuf buf = STRBUF_INIT;
 
-		get_uname_info(&buf, 0);
+		if (capture_os_version(&buf))
+			get_uname_info(&buf, 0);
 		os = strbuf_detach(&buf, NULL);
 	}
 
-- 
2.47.1

