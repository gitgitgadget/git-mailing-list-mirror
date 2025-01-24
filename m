Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D010A21B18B
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721370; cv=none; b=Qceco3MK7wtKq2jLfCqQsyNICcfgArk5u+NDkxiw/MP6zzYgyV7fODciw14bqUYzRLiwzsEHnYbcixY+dx3vqpKkPqHOwPDqOPpe8Bb6CA8lSAPx+C+VRrJifylqsqY5DrRxS3WUMazDP8DYD7+WEVNEkk0/PePG/LlEsLrMc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721370; c=relaxed/simple;
	bh=XDzP5FUTHWcW9VdhuboD9tkdIe3EIlJJFBQ/2AMpNwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwUdI97aXMY5+oNrgjMkyQxiCIcjtpZRZE8f2MBL7A/qbiuPybDb3w0NZHAStSTp8NAV4QICxpWdeoUAEF3aGSH1IdcY2iAayDvJ0RDNJ8XE4xWgYiBEO1lq8vj/XoPr/xPhod7tomRzAwJ4IEhQxqFBbN3FtXW0DinGddAbubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/TMJdLZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/TMJdLZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so2844728a91.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737721368; x=1738326168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0RGhRZj7ahTqaxMDHxR33RmBZ+Rn4bY4D0TfaAF3YM=;
        b=b/TMJdLZDPirCdAR1VhrPRY68Yu4JFcp6DqUuay3TtLx8J/hJ3o9BZ8YVZ7vs3CmQt
         nGZf4e/P3TpmVZXrK6CRgwn5OUwN3xEHBuEpLPitMc5av6hGtU67upXH/9U/AWpyAjkT
         +7evy2ed2Vo9fxy0XM9zuZA4u2xVvIIr1OGxuABHWO1NUyCdcbj3xvBN5QvZYA08IGdl
         zP/qHWqtXNU4dz2qeW0cAAPEeGL6xFBeNjZeaqZn/9A8QyIHcz+PhsxBDfH7I+YqOPN3
         I261juiKooQJX8WDpJNLteLhZ+j29mDXWnqpQd3RNp1226gjec0ZlCkm+eN29vves7SC
         oNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721368; x=1738326168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0RGhRZj7ahTqaxMDHxR33RmBZ+Rn4bY4D0TfaAF3YM=;
        b=NkNR2+W85PUdT4UCh2g06/1HUyy1i73Didjx5fISKskOtXpjKsWz241Djy5SB57Q9d
         /MREFnAQPfNPnXDLRaTBa1Xvg0tEExbOcjhes/bfNL2eQOolAJU4zBy7AEVD8vmJKpBu
         PMelWI56Pr5yWYvSzJndihpTMGRAVNspaadUu8EwCLNDJSLDiX459TyITgcJq5fr36tq
         FJrxX8N7fSnBuqVBIGYn75WmjB81GlPrfdmR9knVYDM0lVLEtd8VqVKyvVUWLYH9JuSW
         3I83HsPLLV6CAxrn41d6aEQGLJBDS23uS/LZPL8UHvr1ghqG3VLsHRM/wLErjFeD5gVq
         eEsw==
X-Gm-Message-State: AOJu0YzLuGbYHK7sL57irPB75vSkorgqhGADKibKtTadg4QKXHwjxyW0
	tx/6GqlWKRN5wGi3l6K95WCSDQXWXOrkRmqZ9ycP9UlIBHBXNm+5DEk5DqE80TM=
X-Gm-Gg: ASbGncsU7p+f+MjqUMHPUbNkRf1Tvai2cAO39rW//6kGcmaRGzBg65AUrLzy3WNODmy
	QXubrA+S91StmIeJywihqHBAcQC1clg0MwmnUYdDR05HKkrXilj7q2F1NYUyv6Uu9r/mC4Yyu45
	3n23WW2aiFxamvJfXzm+XwGYEbMtTP9em5qlUHZZcOEnvXyPg9nvk+e5uhUDjt4nfGk+E9WzAxd
	Od3Oz0Ka5/45jmzhx093SjV7rLOeLnjw1bSdxTzO9ITn7oiVN8wmvnwved0Fmjwl4YqwL3jqXgE
	YXvDWxHmncjtjgdFcIAhS9fc1gjwMw==
X-Google-Smtp-Source: AGHT+IHH9iMp5RB2ftMPGSjS5/+eqST7JB0MheopLQjS6mqi7okFPksuqbQG4qT3+6ddqCMHm3iclA==
X-Received: by 2002:a17:90b:5249:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2f782c4c9f0mr38749421a91.1.1737721367641;
        Fri, 24 Jan 2025 04:22:47 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb1dc56sm1685056a91.49.2025.01.24.04.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 04:22:47 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	ps@pks.im,
	johncai86@gmail.com,
	Johannes.Schindelin@gmx.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/6] connect: advertise OS version
Date: Fri, 24 Jan 2025 17:51:41 +0530
Message-ID: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250124122217.250925-1-usmanakinyemi202@gmail.com>
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As some issues that can happen with a Git client can be operating system
specific, it can be useful for a server to know which OS a client is
using. In the same way it can be useful for a client to know which OS
a server is using.

Let's introduce a new protocol (`os-version`) allowing Git clients and
servers to exchange operating system information.

Having the `os-version` protocol capability separately from other protocol
capabilities like `agent` is beneficial in ways like:

- It provides a clear separation between Git versioning and OS-specific,
concerns making troubleshooting and environment analysis more modular.
- It ensures we do not disrupt people's scripts that collect statistics
from other protocol capabilities like `agent`.
- It offers flexibility for possible future extensibility, allowing us to
add additional system-level details without modifying existing `agent`
parsing logic.
- It provides better control over privacy and security by allowing
selective exposure of OS information.

Add the `transfer.advertiseOSVersion` config option to address
privacy concerns. It defaults to `true` and can be changed to
`false`. When enabled, this option makes clients and servers send each
other the OS name (e.g., "Linux" or "Windows"). The information is
retrieved using the 'sysname' field of the `uname(2)` system call or its
equivalent.

However, there are differences between `uname(1)` (command-line utility)
and `uname(2)` (system call) outputs on Windows. These discrepancies
complicate testing on Windows platforms. For example:
  - `uname(1)` output: MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64\
  .2024-02-14.20:17.UTC.x86_64
  - `uname(2)` output: Windows.10.0.20348

On Windows, uname(2) is not actually system-supplied but is instead
already faked up by Git itself. We could have overcome the test issue
on Windows by implementing a new `uname` subcommand in `test-tool`
using uname(2), but except uname(2), which would be tested against
itself, there would be nothing platform specific, so it's just simpler
to disable the tests on Windows.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/config/transfer.txt |  7 +++++++
 Documentation/gitprotocol-v2.txt  | 17 +++++++++++++++++
 connect.c                         |  3 +++
 serve.c                           | 14 ++++++++++++++
 t/t5555-http-smart-common.sh      | 10 +++++++++-
 t/t5701-git-serve.sh              | 22 +++++++++++++++++++---
 t/test-lib-functions.sh           |  8 ++++++++
 version.c                         | 29 +++++++++++++++++++++++++++++
 version.h                         | 15 +++++++++++++++
 9 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index f1ce50f4a6..016eb27430 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -125,3 +125,10 @@ transfer.bundleURI::
 transfer.advertiseObjectInfo::
 	When `true`, the `object-info` capability is advertised by
 	servers. Defaults to false.
+
+transfer.advertiseOSVersion::
+	When set to `true` on the server, the server will advertise its
+	`os-version` capability to the client. On the client side, if set
+	to `true`, it will advertise its `os-version` capability to the
+	server only if the server also advertises its `os-version` capability.
+	Defaults to true.
diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 1652fef3ae..62f7ae3423 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -190,6 +190,23 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
 
+os-version
+~~~~~~~~~~
+
+In the same way as the `agent` capability above, the server can
+advertise the `os-version` capability to notify the client the
+kind of operating system it is running on. The client may optionally
+send its own `os-version` capability, to notify the server the kind
+of operating system it is also running on in its request to the server
+(but it MUST NOT do so if the server did not advertise the os-version
+capability). The value of this capability may consist of ASCII printable
+characters(from 33 to 126 inclusive) and are typically made from the
+result of `uname -s`(OS name e.g Linux). The os-version capability can
+be disabled entirely by setting the `transfer.advertiseOSVersion` config
+option to `false`. The `os-version` strings are purely informative for
+statistics and debugging purposes, and MUST NOT be used to
+programmatically assume the presence or absence of particular features.
+
 ls-refs
 ~~~~~~~
 
diff --git a/connect.c b/connect.c
index 10fad43e98..6d5792b63c 100644
--- a/connect.c
+++ b/connect.c
@@ -492,6 +492,9 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	if (server_supports_v2("agent"))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
+	if (server_supports_v2("os-version") && advertise_os_version(the_repository))
+		packet_write_fmt(fd_out, "os-version=%s", os_version_sanitized());
+
 	if (server_feature_v2("object-format", &hash_name)) {
 		int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
diff --git a/serve.c b/serve.c
index c8694e3751..5b0d54ae9a 100644
--- a/serve.c
+++ b/serve.c
@@ -31,6 +31,16 @@ static int agent_advertise(struct repository *r UNUSED,
 	return 1;
 }
 
+static int os_version_advertise(struct repository *r,
+			   struct strbuf *value)
+{
+	if (!advertise_os_version(r))
+		return 0;
+	if (value)
+		strbuf_addstr(value, os_version_sanitized());
+	return 1;
+}
+
 static int object_format_advertise(struct repository *r,
 				   struct strbuf *value)
 {
@@ -123,6 +133,10 @@ static struct protocol_capability capabilities[] = {
 		.name = "agent",
 		.advertise = agent_advertise,
 	},
+	{
+		.name = "os-version",
+		.advertise = os_version_advertise,
+	},
 	{
 		.name = "ls-refs",
 		.advertise = ls_refs_advertise,
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index e47ea1ad10..b1af37a4a2 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -123,9 +123,17 @@ test_expect_success 'git receive-pack --advertise-refs: v1' '
 '
 
 test_expect_success 'git upload-pack --advertise-refs: v2' '
+	printf "agent=FAKE\n" >agent_and_osversion &&
+	if test_have_prereq WINDOWS
+	then
+		git config transfer.advertiseOSVersion false
+	else
+		printf "os-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
+	fi &&
+
 	cat >expect <<-EOF &&
 	version 2
-	agent=FAKE
+	$(cat agent_and_osversion)
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9394235fa0..2616132b95 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -23,13 +23,29 @@ test_expect_success 'setup to generate files with expected content' '
 	server-option
 	object-format=$(test_oid algo)
 	EOF
-	cat >expect.trailer <<-EOF
+	cat >expect.trailer <<-EOF &&
 	0000
 	EOF
+
+	if test_have_prereq WINDOWS
+	then
+		git config transfer.advertiseOSVersion false
+	else
+		printf "os-version=%s\n" $(uname -s | test_redact_non_printables) >>agent_and_osversion
+	fi &&
+
+	cat >expect_osversion.base <<-EOF
+	version 2
+	$(cat agent_and_osversion)
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	EOF
 '
 
 test_expect_success 'test capability advertisement' '
-	cat expect.base expect.trailer >expect &&
+	cat expect_osversion.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
@@ -357,7 +373,7 @@ test_expect_success 'test capability advertisement with uploadpack.advertiseBund
 	cat >expect.extra <<-EOF &&
 	bundle-uri
 	EOF
-	cat expect.base \
+	cat expect_osversion.base \
 	    expect.extra \
 	    expect.trailer >expect &&
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab50..3465904323 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -2007,3 +2007,11 @@ test_trailing_hash () {
 		test-tool hexdump |
 		sed "s/ //g"
 }
+
+# Trim and replace each character with ascii code below 32 or above
+# 127 (included) using a dot '.' character.
+# Octal intervals \001-\040 and \177-\377
+# correspond to decimal intervals 1-32 and 127-255
+test_redact_non_printables () {
+    tr -d "\n\r" | tr "[\001-\040][\177-\377]" "."
+}
diff --git a/version.c b/version.c
index d95221a72a..083154a6cb 100644
--- a/version.c
+++ b/version.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "sane-ctype.h"
 #include "gettext.h"
+#include "config.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -69,3 +70,31 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
 	     strbuf_addf(buf, "%s\n", uname_info.sysname);
 	return 0;
 }
+
+const char *os_version_sanitized(void)
+{
+	static const char *os = NULL;
+
+	if (!os) {
+		struct strbuf buf = STRBUF_INIT;
+
+		get_uname_info(&buf, 0);
+		/* Sanitize the os information immediately */
+		redact_non_printables(&buf);
+		os = strbuf_detach(&buf, NULL);
+	}
+
+	return os;
+}
+
+int advertise_os_version(struct repository *r)
+{
+	static int transfer_advertise_os_version = -1;
+
+	if (transfer_advertise_os_version == -1) {
+		repo_config_get_bool(r, "transfer.advertiseosversion", &transfer_advertise_os_version);
+		/* enabled by default */
+		transfer_advertise_os_version = !!transfer_advertise_os_version;
+	}
+	return transfer_advertise_os_version;
+}
diff --git a/version.h b/version.h
index 5eb586c0bd..300ee73df5 100644
--- a/version.h
+++ b/version.h
@@ -1,6 +1,8 @@
 #ifndef VERSION_H
 #define VERSION_H
 
+struct repository;
+
 extern const char git_version_string[];
 extern const char git_built_from_commit_string[];
 
@@ -14,4 +16,17 @@ const char *git_user_agent_sanitized(void);
 */
 int get_uname_info(struct strbuf *buf, unsigned int full);
 
+/*
+  Retrieve, sanitize and cache system information for subsequent
+  calls. Return a pointer to the sanitized system information
+  string.
+*/
+const char *os_version_sanitized(void);
+
+/*
+  Retrieve and cache whether os-version capability is enabled.
+  Return 1 if enabled, 0 if disabled.
+*/
+int advertise_os_version(struct repository *r);
+
 #endif /* VERSION_H */
-- 
2.48.0

