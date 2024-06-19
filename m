Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803C132129
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801863; cv=none; b=axtG8SvKR98cYK34aSkHgoiDol2JfzYPvypPmoz6mWPB/8mWgq7Y3D3+Ety3jXWhz/X8NNgcnh4UOFTLI5TDAnMgTRfeTEFXV5aZsBygu6Q+zp4aNrtKIcxqKbrKn1S189BKY2iljyNRZCQ5fm/iHLSoZ+/sJBHtqVBZ5R8RhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801863; c=relaxed/simple;
	bh=T94oAFeaIShInpAiaP8NoYqdNWoPQdNMAEfOHedoiEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0yoaKFeGbmuxvg5jmGgb4OELqQyE0f0Z/7h7fCF54IGudJWOTw7ybzOieSyPkfOjP/ubH49hwwIM/od85gw3eKJHF/d+Qt6Kdd/ZIiNxxLD+sKN6WgFf+vkp51rhZRPgFGAMdwwpA7nmG3IvSekTzYfdbaHg0QAG2kfTJigSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6iA4E3k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6iA4E3k"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso764630a12.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718801859; x=1719406659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJu7sWV1L1yI/qyDA1EYDBBiXOi+diiR8oNs5nUQX1E=;
        b=V6iA4E3kvBgjBhvw24pM5qvL/WICCeSXUmcKBilII9JnGtawjW20VJf609iXZjilaS
         ChBD5qscI6YkeIPGjCQ3ibhl+7JHHpWBAf0wxUoQz/eEBwzhmIYOZFYCqcdPmLHYrmI7
         o69xH2Wkyve01ktM+8pXAkgi0s6vSLmBq64eWVNgOQq0mylcosmH0PM4QDXUxhgbZC77
         bJQp/ccWkny7LWXjug9R4AJMvAdwbU2qBlyRoTmVF37OKT6O1zJ4LobGRSARCSpvIgpR
         cdf0/AnD+gYTcH6ACmxqWOkN0N8tP9SAXZbqNNx36/3L6hk+DHLBbUqm3dpHeBpdU1rI
         GMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801859; x=1719406659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJu7sWV1L1yI/qyDA1EYDBBiXOi+diiR8oNs5nUQX1E=;
        b=cc/yCiLHEhjZGV7Ii9X9GZRjgEcyyyIE3T2mTbpOaWZD8KlctSj2YeXO7DqGxjKwhX
         SAk0n39kAFgZpKS07wsnJ3g56GYXeTXOUbK8g8ZP7iKMeJLw0XLtWCL9rLOiOS1djJD+
         MLiV124qcohHLPWGpv2hT8msGHDZ/tYpTzgwzaK6SYZe1oohhkSqfFXq1/AgHvOMKL5+
         LZwma0ukDfshCIZkbGuK8klR5JdUuz00hZWDyV7X0dM7x7pD1EuSMcy/6NNFJyJl5XWw
         eg9Ped1xFPWII4C+E2Qi4L5bZZ62Dt1WeuundbXpaHitBDTXAWtzI/DhVE0IqzNkyfim
         k9MQ==
X-Gm-Message-State: AOJu0YwxviNa3sg7xRv2+AonxnLilRa/sy3bGAvR4C74lfFJ3GcE8jK3
	cRni5AalmvziRO2j4/CDTbbkldXTds6CffzaTfBWPymvrN1xfkSwJuxc/w==
X-Google-Smtp-Source: AGHT+IEsLigic3W6b7wDg7CeP8KG5HeO/Vhn48RhQYtYUs5566/q/BYIUlMFO5EeSfrVH3fEDnRDeg==
X-Received: by 2002:a50:c309:0:b0:57a:3424:b36e with SMTP id 4fb4d7f45d1cf-57d07e5aac1mr1550737a12.13.1718801858989;
        Wed, 19 Jun 2024 05:57:38 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e95d7sm8334237a12.47.2024.06.19.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:57:38 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] connect: advertise OS version
Date: Wed, 19 Jun 2024 14:57:08 +0200
Message-ID: <20240619125708.3719150-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.45.2.564.g3a7d533bde
In-Reply-To: <20240619125708.3719150-1-christian.couder@gmail.com>
References: <20240619125708.3719150-1-christian.couder@gmail.com>
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

Let's add OS information exchange to the protocol in the same way some
git version exchange is performed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/gitprotocol-v2.txt | 18 ++++++++++++++++++
 connect.c                        |  3 +++
 serve.c                          | 12 ++++++++++++
 t/t5555-http-smart-common.sh     |  3 +++
 t/t5701-git-serve.sh             |  3 +++
 version.c                        | 29 +++++++++++++++++++++++++++++
 version.h                        |  3 +++
 7 files changed, 71 insertions(+)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 414bc625d5..f676b2dc7a 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -190,6 +190,24 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
 
+os-version
+~~~~~~~~~~
+
+In the same way as the `agent` capability above, the server can
+advertise the `os-version` capability with a value `X` (in the form
+`os-version=X`) to notify the client that the server is running an
+operating system that can be identified by `X`. The client may
+optionally send its own `os-version` string by including the
+`os-version` capability with a value `Y` (in the form `os-version=Y`)
+in its request to the server (but it MUST NOT do so if the server did
+not advertise the os-version capability). The `X` and `Y` strings may
+contain any printable ASCII characters except space (i.e., the byte
+range 32 < x < 127), and are typically made from the result of
+`uname -srvm`. The os-version strings are purely informative for
+statistics and debugging purposes, and MUST NOT be used to
+programmatically assume the presence or absence of particular
+features.
+
 ls-refs
 ~~~~~~~
 
diff --git a/connect.c b/connect.c
index 0d77737a53..3a48806ddc 100644
--- a/connect.c
+++ b/connect.c
@@ -489,6 +489,9 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	if (server_supports_v2("agent"))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
+	if (server_supports_v2("os-version"))
+		packet_write_fmt(fd_out, "os-version=%s", os_version_sanitized());
+
 	if (server_feature_v2("object-format", &hash_name)) {
 		int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
diff --git a/serve.c b/serve.c
index aa651b73e9..77eb5ebdaa 100644
--- a/serve.c
+++ b/serve.c
@@ -29,6 +29,14 @@ static int agent_advertise(struct repository *r UNUSED,
 	return 1;
 }
 
+static int os_version_advertise(struct repository *r UNUSED,
+			   struct strbuf *value)
+{
+	if (value)
+		strbuf_addstr(value, os_version_sanitized());
+	return 1;
+}
+
 static int object_format_advertise(struct repository *r,
 				   struct strbuf *value)
 {
@@ -121,6 +129,10 @@ static struct protocol_capability capabilities[] = {
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
index 3dcb3340a3..c67739236f 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -124,9 +124,12 @@ test_expect_success 'git receive-pack --advertise-refs: v1' '
 '
 
 test_expect_success 'git upload-pack --advertise-refs: v2' '
+	# Octal intervals \001-\040 and \177-\377
+	# corresponds to decimal intervals 1-32 and 127-255
 	cat >expect <<-EOF &&
 	version 2
 	agent=FAKE
+	os-version=$(uname -srvm | tr -d "\n" | tr "[\001-\040][\177-\377]" ".")
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index c48830de8f..9c9a707e6a 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -13,9 +13,12 @@ test_expect_success 'test capability advertisement' '
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
+	# Octal intervals \001-\040 and \177-\377
+	# corresponds to decimal intervals 1-32 and 127-255
 	cat >expect.base <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
+	os-version=$(uname -srvm | tr -d "\n" | tr "[\001-\040][\177-\377]" ".")
 	ls-refs=unborn
 	fetch=shallow wait-for-done
 	server-option
diff --git a/version.c b/version.c
index 10b9fa77d1..5b20ea0d7c 100644
--- a/version.c
+++ b/version.c
@@ -61,3 +61,32 @@ int get_uname_info(struct strbuf *buf)
 		    uname_info.machine);
 	return 0;
 }
+
+const char *os_version(void)
+{
+	static const char *os = NULL;
+
+	if (!os) {
+		struct strbuf buf = STRBUF_INIT;
+
+		get_uname_info(&buf);
+		os = strbuf_detach(&buf, NULL);
+	}
+
+	return os;
+}
+
+const char *os_version_sanitized(void)
+{
+	static const char *os_sanitized = NULL;
+
+	if (!os_sanitized) {
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addstr(&buf, os_version());
+		strbuf_sanitize(&buf);
+		os_sanitized = strbuf_detach(&buf, NULL);
+	}
+
+	return os_sanitized;
+}
diff --git a/version.h b/version.h
index afe3dbbab7..349952c8f2 100644
--- a/version.h
+++ b/version.h
@@ -14,4 +14,7 @@ const char *git_user_agent_sanitized(void);
 */
 int get_uname_info(struct strbuf *buf);
 
+const char *os_version(void);
+const char *os_version_sanitized(void);
+
 #endif /* VERSION_H */
-- 
2.45.2.563.g6aa460b3cb

