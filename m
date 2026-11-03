Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721158;
	b=U9MLbmfU8PkuLd6pqkFZwZqf0l5TVwAV1GBduIojfYTJj7ylkv8Ed+9ztjbkGqQXCvNj
	 vp0+jmdTQSOzFSJ6QkzOAsfm6HCsOAdDUkcJIYIsRLoy8HLIHlJw3LYISyszI62fE8QSM
	 SXadGFxqNV63GMXBS2QwSwJ41iJZsJfAqp35N/pozjcYV4+R9Uf6VWI8Iar12uiI+Usfk
	 9U1zaHh/+CQvVrRoOYL2bnt/5JBlhmoBvHkCJ0/nFZepYE76BKETuZjo4EXfhTNVCjW+u
	 O6AFbZ2G8OM/6ReBlpC6Le732p4Ozu5iaPhJpORyH72XKLjyLIHhha2V9opVVAYAWmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+vmwrBwvnlhKjlmA3sZ3/BfOp3VQyLJ0lqofJsP7w1U=;
	b=3+B82vJUyFVfpCDWmYu7w46ny8IBvFsiDdCkZYJGfLY/IvM0EW1guNe/vnZLzXSP4Lcc
	 Bbm0XijUeGtMnUyzzZc+imON3ZCw+EXbQ4TksUgwlnHdxqEZZlcHF/oV2+pGSFgOp3+4l
	 gOSSdAApHGJcboMQQGQ19i4iHIPpJW086q2UQKnvVi917OGW4VjgK3N9qsiDUnQ9340f6
	 0050rjdXq+3pemx7G3m95ajVAYvRVmQI6vbkW3mLYcmOmecCqm4RZ5zCq/ZPR2pH+s22r
	 NuhQRz/r1SNVW8Cj6JQyGjBAZYKd1RgxKD2MV9nU9dbRw/qjGfSk+3WgDfvosNq4NSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MoUtV9NI;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8D606D805
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB8D606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MoUtV9NI
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so5729200c88.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721157; x=1794325957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vmwrBwvnlhKjlmA3sZ3/BfOp3VQyLJ0lqofJsP7w1U=;
        b=MoUtV9NI0UVnpxc4uOyFi34zAQ/22xfUZVypdUxOIvWEGIIt+1N42FxxykZ27S+o5+
         Ed16M+8WVSMDZhLuBlPbWEMy4ZMT5vxxPr4fHLqMAUIQHuTkmb4etN+1VnM9SjasNdfm
         EKR/aRdjihwEEGLRdXBSmgXHc5Hqnu7fNZeuU8JsU2EwdxgbnJhyM8Pj8kI2PPBLERQl
         tsSq4N7sz1gT5N0WCNvDds4NQoAjPyPLoaQPGBJN8+VBWK8R5lLUSmfYp0fukPbLurZp
         tVAicT15BCXSPdZfkEx9idZnJ9awiFUvJ+G8d4Qgw9up5SG1uJG4pucNwegwKM5qIt+F
         dJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721157; x=1794325957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vmwrBwvnlhKjlmA3sZ3/BfOp3VQyLJ0lqofJsP7w1U=;
        b=IAC1s0LVKd6Oe4w2lqQ+Y87fsI8h7eAkGuGvc/znnSGmaMAavpIROF4my6uXRAlXlQ
         dJOCj+EB4cwWP4WWB5cXMF0PeDN3Mny/DprBZn7B6+5au3lWF/XdxGhXdWFtAKIQD2sO
         p3aLLHCAu4yuLGPrqWNEPvmukORy0tl9mfFetU1Px400lsTfyJ/eeRRCyS6DWkv+fEN6
         kiFOXIZsR2RgCDqa4qbSf44REB+zRoe8JjskGrpro+mUfV9yhNuvISuD8KN5EmZphyUF
         KJJdGojaF7OJ6/+pBMYodmhNLWPVsxsV8BgZHOtyCfMrIlUXqG9h7oN/tBqzFFOUqOa0
         /QlA==
X-Gm-Message-State: APuU4Z9u7tb3hQSJr45zIeGuvLB2fVxGzZ3wj9QxzReqSCDtL/8f09cd
	9AiH0aWZYsz5Xa5AvOzOOhDchGdG/BbxVkcm9EvuIg1NogpLgQCnOqMUadDGImRNxEk=
X-Gm-Gg: AYBFou0xS3cbBY9ardlY1KpwqGOuwnhGXESy/uPM6vKOHo/Df47eHSopYnmR/dqvz+T
	Ex3viI5POYajcDwvOS5HHHi0B2hgxK2WwAtSwI75Hi78ziIehlwMPeCQDR0CjRkFI9Zf2PpbAiY
	WDM1atNv5JSD318s5Kxk28ZMiP6P4jey8/ujj4lCfhJ2AqGpobvc0PAETffc6ZPDY4JKynW0XWx
	nGbolWldhFX7fuF/LYYMaeQHBzNJJ6URI0Wn4UeNpfoW2WWXah0GaI8yDpoNZBoe3ANTWxbo9v/
	+ugDKyPhRRb2EBaD5vS8R7A37k1xKIXpEHOg9wh+pn8gbTd0YJkWr0TQEFta++xZHcsr+8xsyN3
	heQNWLfg/EgSrUd5+VlUG5FirtsG3EFwDzKifpo2CDbQxPvwhxmRxO1NF4dfR0zhhT06a7CbsC2
	JaPPii9W1QLwdrI0qJY+5zzgaVZAJYzeLdRnodPvnFj4ddn12Sq9PoaeNludC/KT9hwilo0qEnI
	yPrzP2SQNSPxlO02HUgdgyogf8GN7v7QpJOQrxGWQ6MqIx6QpOj6ilOBuwnuYcsfTFQABoOCH6n
	VxqgnpOD5SR6gE04MvBiN77sdUGx/ieIvRrj/tG589FpGgIIgJuAP41b4RjKqeNyJlAFBb9S80K
	3eHyCH5Jzthu3KmogCqEjyd9lf43VF7HY31/R
X-Received: by 2002:a05:7022:1112:b0:190:596:4071 with SMTP id a92af1059eb24-1ac5cb1c1ebmr20071792c88.11.1793721156560;
        Tue, 03 Nov 2026 07:52:36 -0800 (PST)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1d4dsm40187883c88.3.2026.11.03.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:52:35 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] bundle-uri: do not die on unresolvable relative URIs
Date: Tue,  3 Nov 2026 15:52:31 +0000
Message-ID: <20261103155231.381-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.342.gea0b8383c0.dirty
In-Reply-To: <20261028115818.410-1-aniketgupta3001@gmail.com>
References: <20261028115818.410-1-aniketgupta3001@gmail.com>
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

A bundle list, either advertised by a server or given to "git clone
--bundle-uri", may contain relative URIs. relative_url() resolves them
and calls die() when there are more "../" components than the base can
absorb, so one bad entry aborts the whole clone.

Add relative_url_gently() which returns NULL and records the reason in
a strbuf instead of dying. relative_url() keeps dying, so the submodule
callers are unchanged. bundle_list_update() reports the problem as an
error and leaves the bundle without a URI. The download code already
skips such a bundle, so the clone carries on with the others.

Name the URL in the error message, without any credentials, and update
the tests.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
Changes since v1:
 - the commit message says which lists are meant and why carrying on
   is fine
 - the error now names the URL that could not be resolved, with any
   credentials removed
 - add a test for that in t0060

 bundle-uri.c                | 10 +++++++++-
 remote.c                    | 37 +++++++++++++++++++++++++++++++------
 remote.h                    |  8 ++++++++
 t/t0060-path-utils.sh       |  7 +++++++
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 5 files changed, 62 insertions(+), 15 deletions(-)

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
index 49ee2ea318..36834b129c 100644
--- a/remote.c
+++ b/remote.c
@@ -3005,7 +3005,8 @@ void remote_state_clear(struct remote_state *remote_state)
 }
 
 /*
- * Returns 1 if it was the last chop before ':'.
+ * Returns 1 if it was the last chop before ':', or -1 if there is
+ * nothing left to chop.
  */
 static int chop_last_dir(char **remoteurl, int is_relative)
 {
@@ -3022,16 +3023,15 @@ static int chop_last_dir(char **remoteurl, int is_relative)
 	}
 
 	if (is_relative || !strcmp(".", *remoteurl))
-		die(_("cannot strip one component off url '%s'"),
-			*remoteurl);
+		return -1;
 
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
@@ -3073,8 +3073,22 @@ char *relative_url(const char *remote_url, const char *url,
 	 */
 	while (*url) {
 		if (starts_with_dot_dot_slash_native(url)) {
+			int chopped;
+
 			url += 3;
-			colonsep |= chop_last_dir(&remoteurl, is_relative);
+			chopped = chop_last_dir(&remoteurl, is_relative);
+			if (chopped < 0) {
+				char *anon = transport_anonymize_url(remote_url);
+
+				strbuf_addf(err,
+					    _("cannot strip one component off url '%s'"),
+					    anon);
+				free(anon);
+				free(remoteurl);
+				strbuf_release(&sb);
+				return NULL;
+			}
+			colonsep |= chopped;
 		} else if (starts_with_dot_slash_native(url))
 			url += 2;
 		else
@@ -3102,6 +3116,17 @@ char *relative_url(const char *remote_url, const char *url,
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
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 56faf5fe73..50cc37bc98 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -394,6 +394,13 @@ test_submodule_relative_url "../" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
+test_expect_success 'relative_url() does not show credentials when it fails' '
+	test_must_fail test-tool submodule resolve-relative-url "" \
+		"https://user:secret@host.example/a" ../../../../../../x 2>err &&
+	test_grep "cannot strip one component off url" err &&
+	test_grep ! secret err
+'
+
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c/" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 70ae94c4d0..8abf8f31ae 100755
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
+	error: cannot strip one component off url '\''<uri>'\''
+	error: bad line: '\''bundle.three.uri=../../bundle.bdl'\''
+	EOF
+
 	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
-	test_grep "fatal: cannot strip one component off url" err
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
 '
 
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
-- 
2.43.0

