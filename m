Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188705;
	b=3dAiOu4QpH9jHESRfuepkZO9rdRK79cueQAvwUdfPQudR4CcV3ZKLDw1Yq0edyVg53/H
	 Z0MTy/jSEe7mo2B6KzC1VzatEb6nrTEs6v05llSBo3d2tHR+n2K5ygAWXePFVrKcSlvG5
	 q4mm0Gki5Hi7Cd3JEVRbGW9ZE0UrCQm0fUXdNdvB1Aczcd6uL/9n91eMm9M6RbGKgZz9R
	 +K1RjpbsFVozbCEACd8gxJVlWI7xwGdI8/99lBtEuuppoJgYQpLB3itmJhQtei7P5R/BL
	 rheyxwQ1ZbCMC9Z9jLvQpvRAuSXxDgYOF45wwST1axH5knoHFM6jl6aTOJID0mZCDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DxJKrT6pzFPTX8TAZpP/e0YopQtok4sFndqGgkVHx5k=;
	b=OL5JUB3I3unj+b99nyO7boEUj1ss+TVSumdG3293bDtBi4HKoq4wxEvPdjQiNhDYRjKA
	 0IpZeKxBmfJ7eFnjVGkB+JHblQn0hj32hK0szVBXFUJ7uUZbeUXVCc21Q+9K7FBjVOaYH
	 zR8dk4W1CADg8v+1djpba0/ssHpT274lKyTKnqNZKVm+B4ubfzmzUs9GvzJ0tbOyirGJW
	 E2ypRZn3MZO7aYNyUYjlNGp7IQwM4dncCEYX/fFoUVXqSMNr6Z8xWYz1SmqqGhvMWHw4d
	 BLEQr7c1bAgrLT5BGC4MwmYTncoDXqFDqOi8W8rYIamzHcfmkqOgycyQMwszdxdsMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5QPDUec;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CE606A320
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 556CE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p5QPDUec
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35829219da8so2512103eec.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188704; x=1793793504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DxJKrT6pzFPTX8TAZpP/e0YopQtok4sFndqGgkVHx5k=;
        b=p5QPDUecCpXVj7Bf2OGtzWSgyeimPqag+Npm8tpx9jAmYmbmhK/TsRECwGHCQxmZn9
         HdsdrceVk0ROYqAUeJarGenKXzOlIL8vNwBc3xaOpfxxZ/1MNERQwSeC88YRzeQV4k3l
         cSPUGaQ4V6ct7Shv1GFWFGc50Xo6Bqb4NMAdNZeG2WeKZFBDtVKvyE3mx9/woNwNLIei
         BrVUJj+PYdyigJdodW6OM/b1WJHLAPEXwLMvbA4m7/RZ9Ns0aTtqFYtMShj962OlyJWR
         VBhSXRikT1xQI71W9VtblTOmcLtVO0hcg6MDsq3pJFORJjD3L13GXodkIGvY7xac6uCZ
         YNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188704; x=1793793504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DxJKrT6pzFPTX8TAZpP/e0YopQtok4sFndqGgkVHx5k=;
        b=KzQ+S8cQIJyj9d3TurA1bI38dYYhw2cydKTNK+ejTtKiji/N4sDOGdUPTTBQYSa020
         0dCMyPDqYzqvcdGHTErhF+bRqbnHGZK7CDOXoNYx0vFTKL5+XWAoxj2/2LrR30fUZZkz
         DAk6tZT+qn2wewRu2Eu+mK3IgHcllaQx2vB8xBxS+SuXPFTDnE6gt0Nehoygt997p8rw
         XCXEIGxXlBX7hUd7Xjr5f2vOud5sqUbk5hcvdxEcDbVVzWCTRnBZ54GgxbnzUm0lR8DI
         eTgJEKvZBOUP7h4jWh1xkaMuzYaZL7TOzrLYITD5eGKHjwzZtyZo+TQGxCE9CbUoQ1Vh
         LcWg==
X-Gm-Message-State: AFq9FYJLTNe2Tx+R936uCVVsRpiCbPxusd01Lo6aEZBa2jRhMY8qafxK
	ewcl81u6DEa/XgotiToJp1ezi8QwYEIvDBBQQRtVD4YQVbqo/A9RWb4MUguc0eQU
X-Gm-Gg: AYBFou1YprY5/K4A9h4yvlDtTwcZJ49Opm7KIQuxnL/qqFeNPFyH6DG52FFAfeIExq4
	9P9EPc+8BnckBcHPjQbDZx8rzjx5vBzZtlQe3PvN+VwlvmFnfa+RLs8BpiZXW5iOh0NI8bUOolF
	h2cn9SzoyZj5OYWCE4QdEtrlE/MXtO98FtJzVvJpihwvOgcxQ7X6BxwEX+UyfSjjtt/mJF8meJ9
	GhEvSwSoXOeZBCbWitubaQoShgxQEadcyTsqkdMkJsCLEzXoIrhBH2UlqgvycnGalUcvhspppQx
	CN09+hv1A/7CV0jt4ZGwlHiswaqEFaOdTbPC1Jeh/q63LRekmHq/bzpFxbqwsuQC+9VjxuB3Nao
	lFuaTtPCuiGXwOqKqOnreW6+meisHiCZ8Gaf+NIYv6aXLx/yT1wz5ssRkn4EXoMC5NPeVHOaKHM
	QvUREx0FBJiW97HAcD5ThAF/Hp+9MFzHNzGcsbJRQPC339Z0KsKByd0iLDRE+dLnD/jK4bwRRF6
	6pQNicArQ7qNX/yjQO3Bime1QXqzAojmPhUktRviV2pegITkKB15gZoFyexFwDmP/MPgUjAK/xQ
	krUGfe0I9naJIgPG+WvcwGMLt42eKJq1FMKmdGLKgmq98ZrWVwGS3iK5UzC3hA/71lTx5x68
X-Received: by 2002:a05:7022:2609:b0:159:d448:dd1c with SMTP id a92af1059eb24-1a3c904ca8dmr8861400c88.19.1793188704149;
        Wed, 28 Oct 2026 04:58:24 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.84.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm6920358eec.0.2026.10.28.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:58:23 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] bundle-uri: do not die on unresolvable relative URIs
Date: Wed, 28 Oct 2026 11:58:18 +0000
Message-ID: <20261028115818.410-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.278.g37b3475fb5.dirty
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

relative_url() calls die() when the relative URL has more "../"
components than the remote URL can absorb. bundle_list_update() calls
it on URIs taken from a bundle list and a single bad entry takes down
the whole command.

Add relative_url_gently() which returns NULL and records the reason in
a strbuf instead of dying. This will keep relative_url() as a wrapper
that dies so the submodule callers are unchanged. Use the new function
in bundle_list_update() and report the problem as an error like the
other malformed lines in a bundle list.

Update the test in t5750 accordingly and drop its TODO.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 bundle-uri.c                | 10 +++++++++-
 remote.c                    | 39 +++++++++++++++++++++++++++++--------
 remote.h                    |  8 ++++++++
 t/t5750-bundle-uri-parse.sh | 15 +++++++-------
 4 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..1f198ef9a9 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -210,9 +210,17 @@ static int bundle_list_update(const char *key, const char *value,
 	strbuf_release(&id);
 
 	if (!strcmp(subkey, "uri")) {
+		struct strbuf err = STRBUF_INIT;
+
 		if (bundle->uri)
 			return -1;
-		bundle->uri = relative_url(list->baseURI, value, NULL);
+		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
+						  &err);
+		if (!bundle->uri) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			return -1;
+		}
 		return 0;
 	}
 
diff --git a/remote.c b/remote.c
index 49ee2ea318..7472c426aa 100644
--- a/remote.c
+++ b/remote.c
@@ -3005,9 +3005,11 @@ void remote_state_clear(struct remote_state *remote_state)
 }
 
 /*
- * Returns 1 if it was the last chop before ':'.
+ * Returns 1 if it was the last chop before ':', or -1 (and records the
+ * reason in `err`) if there is nothing left to chop.
  */
-static int chop_last_dir(char **remoteurl, int is_relative)
+static int chop_last_dir(char **remoteurl, int is_relative,
+			 struct strbuf *err)
 {
 	char *rfind = find_last_dir_sep(*remoteurl);
 	if (rfind) {
@@ -3021,17 +3023,19 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 		return 1;
 	}
 
-	if (is_relative || !strcmp(".", *remoteurl))
-		die(_("cannot strip one component off url '%s'"),
-			*remoteurl);
+	if (is_relative || !strcmp(".", *remoteurl)) {
+		strbuf_addf(err, _("cannot strip one component off url '%s'"),
+			    *remoteurl);
+		return -1;
+	}
 
 	free(*remoteurl);
 	*remoteurl = xstrdup(".");
 	return 0;
 }
 
-char *relative_url(const char *remote_url, const char *url,
-		   const char *up_path)
+char *relative_url_gently(const char *remote_url, const char *url,
+			  const char *up_path, struct strbuf *err)
 {
 	int is_relative = 0;
 	int colonsep = 0;
@@ -3073,8 +3077,16 @@ char *relative_url(const char *remote_url, const char *url,
 	 */
 	while (*url) {
 		if (starts_with_dot_dot_slash_native(url)) {
+			int chopped;
+
 			url += 3;
-			colonsep |= chop_last_dir(&remoteurl, is_relative);
+			chopped = chop_last_dir(&remoteurl, is_relative, err);
+			if (chopped < 0) {
+				free(remoteurl);
+				strbuf_release(&sb);
+				return NULL;
+			}
+			colonsep |= chopped;
 		} else if (starts_with_dot_slash_native(url))
 			url += 2;
 		else
@@ -3102,6 +3114,17 @@ char *relative_url(const char *remote_url, const char *url,
 	return strbuf_detach(&sb, NULL);
 }
 
+char *relative_url(const char *remote_url, const char *url,
+		   const char *up_path)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *out = relative_url_gently(remote_url, url, up_path, &err);
+
+	if (!out)
+		die("%s", err.buf);
+	return out;
+}
+
 int valid_remote_name(const char *name)
 {
 	int result;
diff --git a/remote.h b/remote.h
index cca02033b9..940474fa71 100644
--- a/remote.h
+++ b/remote.h
@@ -478,6 +478,14 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 char *relative_url(const char *remote_url, const char *url,
 		   const char *up_path);
 
+/*
+ * Like relative_url(), but if `url` cannot be resolved against
+ * `remote_url`, return NULL and add the reason to `err` instead of
+ * dying. `err` must not be NULL.
+ */
+char *relative_url_gently(const char *remote_url, const char *url,
+			  const char *up_path, struct strbuf *err);
+
 int valid_remote_name(const char *name);
 
 #endif
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 70ae94c4d0..0f0ac29565 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -68,17 +68,16 @@ test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
 		uri = <uri>/bundle.bdl
 	[bundle "two"]
 		uri = bundle.bdl
-	[bundle "three"]
-		uri = <uri>/../bundle.bdl
 	EOF
 
-	# TODO: We would prefer if parsing a bundle list would not cause
-	# a die() and instead would give a warning and allow the rest of
-	# a Git command to continue. This test_must_fail is necessary for
-	# now until the interface for relative_url() allows for reporting
-	# an error instead of die()ing.
+	cat >err.expect <<-\EOF &&
+	error: cannot strip one component off url '\''.'\''
+	error: bad line: '\''bundle.three.uri=../../bundle.bdl'\''
+	EOF
+
 	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
-	test_grep "fatal: cannot strip one component off url" err
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
 '
 
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '

base-commit: 37b3475fb530c14109211faca33716a173db61ed
-- 
2.43.0

