Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE11FE45F
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110833; cv=none; b=HCb0/RhrwbXjdZ/W/lsyV5KNzuusD6TEoEld5Y9QxIIhr50/zGIodDcrVd4J1Xbl0yut/OTgQ1RyIFcC+UB233HAh/ZwbtdQAfB5meFCyGWm8pjkdZ5ziEpoOCEVnYXTVKcUWms6KqozsWG4XZfT65WO0UbbYlaZmGPVo+PTfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110833; c=relaxed/simple;
	bh=txFqAgWoxMb9+c/YDLVNHrSgvAu/TcuZ/0wLfr9hZGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSU6hQfEBYxNOq1U280Z5bYAlR0YPxrL+Gm/7EeYZ3FQUMlnFpWrFheM2yIurWZKy/7RxisaP6Hux4t0LnSuNCcdJ2kusdggxFklfEiOeFQVq/d70q0IbsXlSQtzimgr2g/9M+HYgnZhxy815yNlEaAUbwvIKSuxVoQA7NYAqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkhlLCx0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkhlLCx0"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2165448243fso43889935ad.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110829; x=1737715629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJjCr56AkspfPUzAjUTbLKGGegoWBg6FQj9MU7c/c98=;
        b=NkhlLCx0AQ7PvRcgA91lPO7H83ceTEQguSZunhFz8nTyAhA4ttipilBtuDvwTJUJW3
         ynoXICNgVTqaOtuTNHTCkB2tFL0fYx6j6es+JEoB1sUfg3iihVq/3Cr5ijdcTzYJnN68
         0DwcKfmcK9S+PXsr6CM4VTF8kJK5CsmowHyybnK6MTu5uduaUMzj+iI8XY1sq9NGR33l
         9NEtqgrGbNGljD+ByuKgiJMlfdS2XpCSpZXbh6b8gWzbEb5EByZxv/3ubUM57tptRAgv
         6IKEU3BeQYwdzDwgcNnbhEuk4yUizDhHJgkyrbf93a95kr3QR+XUsSGf+kOGIypp3uGq
         RWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110829; x=1737715629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJjCr56AkspfPUzAjUTbLKGGegoWBg6FQj9MU7c/c98=;
        b=VIH6TjbLlsvF0mjCqL7y/JbBMB6taIQolIH/lOpF0pUi63t8GHdZRFCWhry6U1CzlE
         X/pQKguav1oM1CzXUYD6hcjHCVpnsPhH6mfmfY7TicAYKgVBPFypTFAyEnraeGHz29Rs
         YnOgdI59Ord8hKazNHicFuIg20YyQCCkl0qW/Gz7uIJLzkf94NpxVopg8NVooiMOrIbK
         HZ12/HFyx3JJaeImpHn207onlnKZh0idQ7uIrYgOYcqly7tLy7nU2s+57RD/w8MeEDm7
         cLi8f3NV+evzsy658yEHjqmpA/J3X5m/1OCVHdafIuVF9TWuyzPs461tuCbRCPg4Ryui
         SSmQ==
X-Gm-Message-State: AOJu0Yx6Un3DVfJGpdse/Xz22kA65Ifcp86kBD8z8KV6GDAFjwQrRAT9
	yeMBBe6WRHXjJyreTiTQqpzZfZSUVwSp33wR6XKXmJbrF0P0ZKM7XCbU4r29yzc=
X-Gm-Gg: ASbGncvEPESbbmk2qcwaVuqz05qFpnynOzOsPwkH/hT0bLAGlBoaNLnIEGld9QhdJh3
	F44cqq/w+wi8Wiw8anL1X9WHbKeGxVI3ZMlpLYSVUc8xu0sImfTWRsnKo5FwF0VKjFTavetusg/
	RbVN3BrWT0CQ4/I9gZoIxMg30Dg2dPB4sw/uK6IutsABjfS3XxUN2Kg4eG8Zsn20c3hqJl/yKGv
	lF+/GlTPf6SuG0U9+nIxtOoQ6+yyK9UzhOIsDWT5HaO4mumu1BQ0IPzjhbq7zfivxgV8UTjxwSk
	OVRAxg==
X-Google-Smtp-Source: AGHT+IH3RnQf9snHzpyfrp/+/aL+IrOShafATxzGKtGsubZSxRWHvmFP/kXpVTalrX23/RtCWyTDTg==
X-Received: by 2002:a05:6a00:340c:b0:728:e906:e446 with SMTP id d2e1a72fcca58-72dafbda6ddmr3798434b3a.24.1737110829204;
        Fri, 17 Jan 2025 02:47:09 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm1574985b3a.136.2025.01.17.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:47:08 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	sunshine@sunshineco.com,
	rsbecker@nexbridge.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 6/6] version: introduce osversion.command config for os-version output
Date: Fri, 17 Jan 2025 16:16:18 +0530
Message-ID: <20250117104639.65608-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com>
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
specified command. This customization might be especially useful on some
quite uncommon platforms like NonStop where interesting OS information is
available from other means than uname(2).

If this new configuration option is not set, the `os-version` capability
exchanges just the operating system name.

Helped-by: Randall S. Becker <rsbecker@nexbridge.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/config/transfer.txt | 11 ++++++-
 Documentation/gitprotocol-v2.txt  | 25 ++++++++-------
 t/t5555-http-smart-common.sh      | 28 +++++++++++++++++
 t/t5701-git-serve.sh              | 29 ++++++++++++++++++
 version.c                         | 51 ++++++++++++++++++++++++++++++-
 5 files changed, 129 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index c368a893bd..c9f38c5796 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -131,4 +131,13 @@ transfer.advertiseOSVersion::
 	servers. It makes clients and servers send to each other a string
 	representing the operating system name, like "Linux" or "Windows".
 	This string is retrieved from the `sysname` field of the struct returned
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
index a332b55e4c..93a2e97ec0 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -193,20 +193,19 @@ the presence or absence of particular features.
 os-version
 ~~~~~~~~~~
 
-In the same way as the `agent` capability above, the server can
-advertise the `os-version` capability to notify the client the
-kind of operating system it is running on. The client may optionally
-send its own `os-version` capability, to notify the server the kind of
-operating system it is also running on in its request to the server
-(but it MUST NOT do so if the server did not advertise the os-version
-capability). The value of this capability may consist of ASCII printable
+In the same way as the `agent` capability above, the server can advertise
+the `os-version` capability to notify the client the kind of operating system
+it is running on. The client may optionally send its own `os-version` capability,
+to notify the server the kind of operating system it is also running on in its
+request to the server (but it MUST NOT do so if the server did not advertise the
+os-version capability). The value of this capability may consist of ASCII printable
 characters(from 33 to 126 inclusive) and are typically made from the result of
-`uname -s`(OS name e.g Linux). The os-version capability can be disabled
-entirely by setting the `transfer.advertiseOSVersion` config option
-to `false`. The `os-version` strings are purely informative for
-statistics and debugging purposes, and MUST NOT be used to
-programmatically assume the presence or absence of particular
-features.
+`uname -s`(OS name e.g Linux). If the `osVersion.command` is set, the value of this
+capability are made from the ouput of the command specified. The os-version capability
+can be disabled entirely by setting the `transfer.advertiseOSVersion` config option
+to `false`. The `os-version` strings are purely informative for statistics and
+debugging purposes, and MUST NOT be used to programmatically assume the presence or
+absence of particular features.
 
 ls-refs
 ~~~~~~~
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 6f357a005a..1a3df3d090 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -150,6 +150,34 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'git upload-pack --advertise-refs: v2 with osVersion.command config set' '
+	test_config osVersion.command "uname -srvm" &&
+	printf "agent=FAKE" >agent_and_long_osversion &&
+
+	if test_have_prereq !WINDOWS
+	then
+		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_osversion
+	fi &&
+
+	cat >expect <<-EOF &&
+	version 2
+	$(cat agent_and_long_osversion)
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
index 8a783b3924..1395ac4eba 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -53,6 +53,35 @@ test_expect_success 'test capability advertisement' '
 	test_cmp expect actual
 '
 
+test_expect_success 'test capability advertisement with osVersion.command config set' '
+	test_config osVersion.command "uname -srvm" &&
+	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_long_osversion &&
+
+	if test_have_prereq !WINDOWS
+	then
+		printf "\nos-version=%s\n" $(uname -srvm | test_redact_non_printables) >>agent_and_long_osversion
+	fi &&
+
+	test_oid_cache <<-EOF &&
+	wrong_algo sha1:sha256
+	wrong_algo sha256:sha1
+	EOF
+	cat >expect_long.base <<-EOF &&
+	version 2
+	$(cat agent_and_long_osversion)
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	EOF
+	cat expect_long.base expect.trailer >expect &&
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
index ea334c3e9c..2aa55e56b5 100644
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
@@ -71,6 +75,50 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
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
@@ -78,7 +126,8 @@ const char *os_version(void)
 	if (!os) {
 		struct strbuf buf = STRBUF_INIT;
 
-		get_uname_info(&buf, 0);
+		if (capture_os_version(&buf))
+			get_uname_info(&buf, 0);
 		os = strbuf_detach(&buf, NULL);
 	}
 
-- 
2.48.0

