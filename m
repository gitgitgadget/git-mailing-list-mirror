Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116190;
	b=tevvZ4Ki+h+Bpt40vP/LbIhQ1QVMPXrMs9E/BynFDtth9riOukNghSDPVOpiykw8i/gw
	 k9apSf4+3pMvAf3MLXTwPqlHeKPp1PcDTsVfLuCkeV4MBXqPdoBoAQZkul4pwCOUjpqjf
	 T/m8xOrnFMCkp2g9TkC+4wizNIy5gqonTW/CFH8fvOqXwO5O0tCcifY6XJzJOvDGvXi0L
	 M1P3ySLIL7epYwoKv7Mh8fb/lGHkLqud1XHLLlHabtqtoHibRlKo+SnGGuHNqCR+vjAUg
	 mYFRPxsEXCvf9utICkMxGeczqX81yUe+X4+6B/I72+tz2+Tt3dlmkbkRJVhWXV5WrOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=bl6b335osx2VBSN1AlnDLapOZX2b75tgBaDszQ9n0hg=;
	b=cH/k2KKDgakUIjDxNq2Nw2/ODcjmNoO4p9NoMWwezAwcb2qGQeWhmakssmQqSKGxf5w/
	 xYeCOo0aTgVtYOdpgtL0uir0Kvk8UoA6NM2mahhG9SH78sVbaKLDL3K0mS/ZIiF1KnmFU
	 T9g+MQeKen21CIHMSasM31AvT0jMqXpXrcB75xGxvNS4HVvi53lxx2QRJDN4yDwbDuYAR
	 //5N56Z8S3ZeuGyOTWZwrcJx4gm+vKG+nwXLv9EhMBKV4etnOc9kgNFswvHUmNIo3W3FJ
	 uvVWKmW846xLX1UsTE4jq1VHz8Y1U+70N8bzDgC9kpBfc4SDNx3DxfWID0RtuOV0I7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gOlsLzKF;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767C606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3767C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gOlsLzKF
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso337835e9.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116189; x=1795720989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bl6b335osx2VBSN1AlnDLapOZX2b75tgBaDszQ9n0hg=;
        b=gOlsLzKF/SkyuJaxWQpifoAmBItI/9yhkczr9x7t5xDzN3Ym9oq2jVdWxQBOVeZBOm
         Rr4FbPf9PcJfHdhsqeNL+hRJF9dM3Bwu+BDNlqz2NRarE0cjBmEd1BsKQCzZZkHIMiT4
         As26s4JLDni4ayBWI8BZ4tPBORlW89rN6dEzmzG7m02Ie8i07B7GTSrVffhL3cQL6oGL
         xo7xcVtCwshYDisjVe7EL8XqzQ2dFlGm5I9JN5i1eZhgQQ+Ffi6MMYsQcpxEgRWaJNbW
         3TYTo1qSyH7sUx7JT7Yihh6fPmTDgL5lUXF79NR55GWioXe8kOEretRMGbNxzbigHMy8
         U7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116189; x=1795720989;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bl6b335osx2VBSN1AlnDLapOZX2b75tgBaDszQ9n0hg=;
        b=jtG6/d2L4W5xe0wUbxKKJTQmTOkVSAySqYfpZMgk9D+i5y/M5dSteT3q2nrGkeamM6
         1QWkpYrjSMY06Od3WYRxvSdD7SyE10dYIfPQw4RMZZqTnDOuvg4kVVoo07hqtPk+3nkx
         IBz6SrySd0purUlDMpoUa8PhO/Bf7e0U54PzLAl3+mudoMiaj4pfR0VyWZMNlWxQNka6
         NK6svpKs3BfWUsZ78iPgIKSjPdyOPDLLwtioh2MX1eP7zWKykRYEEuwLVZ8bwrS8K+e6
         WGY/owEMvD8xr3nnF7+wF9ZnHnf1/bdff5LPjkzPRDH1sPlmXyNr0wHMyNV4gHayAe/+
         z/3w==
X-Gm-Message-State: APuU4Z9cABUvsfaf3ep0TugvIYRBLwckpR5pGHWRKeV75Hkt0Ie4H8wX
	qw4eItLsPHey0sG8AVvGSo0EpzhtMGLKDdoqLVfWLFPLeanpcS/a8075Cd3Szo4+NTx2iVRsJVT
	R5ApnKOuxwupLsAQeJ99t9xNIXlSevg6cSxNr4RtGm6PE1zkCeJvG7Zl2pXkuQnx/vXO6H6KYJr
	G4jSOoQuw/oHwn2haI1BH41Q==
X-Received: from wmdn7.prod.google.com ([2002:a05:600c:2947:b0:4a2:8ef:a5af])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ecd:b0:4a3:12fb:1ef1
 with SMTP id 5b1f17b1804b1-4bb8881e81cmr11388395e9.29.1795116188411; Thu, 19
 Nov 2026 11:23:08 -0800 (PST)
Date: Thu, 19 Nov 2026 20:23:07 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192307.2683812-1-dmnk@google.com>
Subject: [PATCH] config: skip continued lines when matching section
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

repo_config_copy_or_rename_section_in_file() scans the config file line
by line and treats any line whose first non-whitespace character is '['
as the start of a new section, without tracking backslash-continued
values across lines.

When a value in the target section spans multiple lines via a trailing
backslash and a continuation line begins with '[other]', removing or
renaming the section stops early at '[other]' and leaves the remainder
of the continued value behind as an unquoted '[other]' section.

Track backslash value continuations (including quoted subsections and
quote state across continued lines so '#' or ';' inside quotes are not
mistaken for comments) and only treat '[' as a section header at the
start of a logical line.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 config.c          | 101 ++++++++++++++++++++++++++++++++++++++++++++--
 t/t1300-config.sh |  33 +++++++++++++++
 2 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 215dacb6b3..f5fcbd9b84 100644
--- a/config.c
+++ b/config.c
@@ -3427,6 +3427,97 @@ static int section_name_is_ok(const char *name)
 
 #define GIT_CONFIG_MAX_LINE_LEN (512 * 1024)
 
+static const char *skip_section_header(const char *line)
+{
+	const char *p = line;
+
+	if (*p != '[')
+		return line;
+	for (p++; *p && *p != '\r' && *p != '\n'; p++) {
+		if (*p == ']')
+			return p + 1;
+		if (*p == ' ' || *p == '\t') {
+			while (*p == ' ' || *p == '\t')
+				p++;
+			if (*p != '"')
+				return NULL;
+			for (p++; *p && *p != '\r' && *p != '\n'; p++) {
+				if (*p == '\\') {
+					p++;
+					if (!*p || *p == '\r' || *p == '\n')
+						return NULL;
+					continue;
+				}
+				if (*p == '"') {
+					for (p++; *p == ' ' || *p == '\t'; p++)
+						; /* skip trailing space before ']' */
+					return (*p == ']') ? p + 1 : NULL;
+				}
+			}
+			return NULL;
+		}
+	}
+	return NULL;
+}
+
+static void update_line_continuation(const char *p, int *continued,
+				     int *in_quote)
+{
+	int in_value = *continued;
+
+	if (!in_value) {
+		while (isspace(*p))
+			p++;
+		if (*p == '[') {
+			p = skip_section_header(p);
+			if (!p) {
+				*continued = 0;
+				*in_quote = 0;
+				return;
+			}
+		}
+		for (; *p && *p != '\r' && *p != '\n'; p++) {
+			if (*p == '#' || *p == ';') {
+				*continued = 0;
+				*in_quote = 0;
+				return;
+			}
+			if (*p == '=') {
+				p++;
+				in_value = 1;
+				break;
+			}
+		}
+		if (!in_value) {
+			*continued = 0;
+			*in_quote = 0;
+			return;
+		}
+	}
+
+	for (; *p && *p != '\r' && *p != '\n'; p++) {
+		if (!*in_quote && (*p == '#' || *p == ';')) {
+			*continued = 0;
+			return;
+		}
+		if (*p == '"') {
+			*in_quote = !*in_quote;
+			continue;
+		}
+		if (*p == '\\') {
+			if (!p[1] || p[1] == '\n' ||
+			    (p[1] == '\r' && (!p[2] || p[2] == '\n'))) {
+				*continued = 1;
+				return;
+			}
+			p++;
+		}
+	}
+
+	*continued = 0;
+	*in_quote = 0;
+}
+
 /* if new_name == NULL, the section is removed instead */
 static int repo_config_copy_or_rename_section_in_file(
 	struct repository *r,
@@ -3434,7 +3525,7 @@ static int repo_config_copy_or_rename_section_in_file(
 	const char *old_name,
 	const char *new_name, int copy)
 {
-	int ret = 0, remove = 0;
+	int ret = 0, remove = 0, continued = 0, in_quote = 0;
 	char *filename_buf = NULL;
 	struct lock_file lock = LOCK_INIT;
 	int out_fd;
@@ -3496,9 +3587,12 @@ static int repo_config_copy_or_rename_section_in_file(
 			goto out;
 		}
 
+		int was_continued = continued;
+
 		for (i = 0; buf.buf[i] && isspace(buf.buf[i]); i++)
 			; /* do nothing */
-		if (buf.buf[i] == '[') {
+		update_line_continuation(buf.buf, &continued, &in_quote);
+		if (!was_continued && buf.buf[i] == '[') {
 			/* it's a section */
 			size_t offset;
 			is_section = 1;
@@ -3550,8 +3644,9 @@ static int repo_config_copy_or_rename_section_in_file(
 					strbuf_release(&copystr);
 					copystr = store_create_section(new_name, &store);
 				}
+			} else {
+				remove = 0;
 			}
-			remove = 0;
 		}
 		if (remove)
 			continue;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 876d376cc7..3b323f95f8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -3049,4 +3049,37 @@ test_expect_success POSIXPERM 'refuse to "overwrite" a read-only file' '
 	)
 '
 
+test_expect_success 'remove-section and rename-section ignore bracketed continuation lines' '
+	test_when_finished "rm -f multiline.cfg rename.cfg subbracket.cfg" &&
+	cat >multiline.cfg <<-\EOF &&
+	[old]
+		key = "first \
+	[smuggled] \
+	# quoted hash \
+		evil = yes"
+	[keep]
+		ok = true
+	EOF
+	cp multiline.cfg rename.cfg &&
+
+	git config --file=multiline.cfg --remove-section old &&
+	test_must_fail git config --file=multiline.cfg --get smuggled.evil &&
+	test "$(git config --file=multiline.cfg --get keep.ok)" = true &&
+
+	git config --file=rename.cfg --rename-section old renamed &&
+	test_must_fail git config --file=rename.cfg --get smuggled.evil &&
+	git config --file=rename.cfg --get renamed.key >actual &&
+	grep "\[smuggled\]" actual &&
+	test "$(git config --file=rename.cfg --get keep.ok)" = true &&
+
+	cat >subbracket.cfg <<-\EOF &&
+	[keep "a] = \""] k = v ; \
+	[old]
+		secret = should_be_removed
+	EOF
+	git config --file=subbracket.cfg --remove-section old &&
+	test_must_fail git config --file=subbracket.cfg --get old.secret &&
+	test "$(git config --file=subbracket.cfg --get "keep.a] = \".k")" = v
+'
+
 test_done
-- 
2.56.1.750.gf70dc682cf-goog

