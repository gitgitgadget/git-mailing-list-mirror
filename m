Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694298;
	b=3f6fH82Olt+leAYTevrsEzC9nq+X6nVyRP/MiXxUuWHBVM66icFqKffhmFBX3gczCKOg
	 8+Q7bdIigwypM1XACwc7cDFo+/YdPo8IArit7AB8yQqlsayNl+9BLHdC2gxzQJpSdJ5Pe
	 iIGhc3j+fiIjwh0JDg/o5w+DHOzRgiEwJvTte8XLDwyWWYraXr7eUtwVGiwXKNOdwjL6e
	 MvPbpgLSa1eNyxkm2ovevvxewOUjIO68+Z2V7WwXqh97fKcWaofvDnMVj0KA4eP1Kfl1r
	 dLZuueCQaQijjtGMuH167tC0TDmGOf/I3BZcLJfNWc2tvBOurBD9bUI2XgIlu0A+PwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kBxV8Fm+wGNMmpkRMnbzIPCp5mO5+bgDQOoXhQn3NMk=;
	b=cNxjKgb6iIEuFETRWalsNO8iZr9OWtJnVedZHk8iOH5pCRZ+NzTXW0OAJFxW3KMk8c5D
	 se+73HM0kpeoOKkyeDSRJcj3qcPHxrNJ6JqOE6uGhnRJY0EVY9X5mBRNFBUOF1cxDGcQL
	 t5ODUaam4RugD/w2RrQ2oktECgNFIYHqJwUOFRn4tFv8ykPM6RLhWK7CiYIyN3jxSgo6z
	 A5dR7LoxWcZvOo9ATZWVFJRfQyzfc73/RkEAHa2u7oodiZqwBOoQtlzN0FThLkTo46nEL
	 X/ozug8K+00fNbPMGbutKSZO4S6lyMYqqB5aKY2AEOkX80bN9fkRB8AdMKRZab8Cxbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cDsy3/Ni";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A0606A326
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 11:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 282A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDsy3/Ni
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38190551625so13476241eec.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 03:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795694297; x=1796299097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBxV8Fm+wGNMmpkRMnbzIPCp5mO5+bgDQOoXhQn3NMk=;
        b=cDsy3/NiSWvecPCW+/pvsWfXLz/0yyHH0YSBm38CRN6rVNLpd/EBevo70WyAxMwt+R
         rexzE2h2JReysRTyvmLkjFIix7OI2cr9TYFf+F0sVhdCuNiSFvsyolOvwYdKQTA6EwBE
         jB0xGq6R7JwrapunYPy6eiIlTehnV4RN5nFXZcF5UAepnbi3Y7VtCSEXeDavn/f7nMy+
         mcVWmyDuezNr7xmxVI0AO+viSGTPo3VVnfv750fq0kalkjVEME9opxCnh3ubtJRTpYx9
         EYrNklAdqVSvAG07MMUrk1HtMztnw8e5A1JuwrwBLi8VBeSHRbPMAK3CpNRBTFzuCeeh
         xPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795694297; x=1796299097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBxV8Fm+wGNMmpkRMnbzIPCp5mO5+bgDQOoXhQn3NMk=;
        b=YfQSW4Bb/sfoYTIu7VmAF3sK+cg3Y+0s1sVq36Ky8TOdNpYDjciXdukwHermdxseBZ
         d2aK8AWSyUlhb1PLWGoq0z92ytAYTcYrlllllyz8BtXC6G5rpDFrl/UwKK4YBvq6iZCV
         xfk6XUFz8jw9WhdB3IXa0WO+f873aSqFzbdSRebfq8uY4z+COtfnOKsMiys9QAfyrjfs
         8tzR9RbOwyIKJOg6ILBdOB8oKWXm1fvL38u4g7ZPFzDQeY1FnkzMPVPhCRTmMJpOPeHW
         eTJYbUMUmkdyk8n6LcwacSuaLID8QLcCFaWTWCDym6TAYd8IXvAH9Tm/WABKR52ZPgI6
         3dbQ==
X-Gm-Message-State: APuU4Z/szIjxfu7OcFKCXXlBDmPNSmOUnNgIjKQs/1V6JeM1kXlmc4Ae
	/f0hcyTtGUhaIA9fzlYZzvfCS93d9SolxKwomJY1XDQdo8zNMIHfZPbpH/G83VUi
X-Gm-Gg: AZFdTZcJmVMUyA04i8ZOirLAom8+Ews/YNPrGY15Y5l4nFFnz+OiL5wtspSmcTPhy7f
	h0Bw6jy4/fnC92nbOfbqojlMBP3E8JuiKnNj9MOMo8kMFcK8iio89pSdVFTLJ9dRYTwlZVabMTw
	VDaT1IGPMVavHNdBx8j2lXf6gYFxtLLOmaWkmx5bmBkD6rEWBannSpDsj1o5iXZFyhpNbTYIzUq
	AD/nuTJ+creOxrQ+hjUBQRt1JAbOXlarZHq+fWITqtcrnv3DjMkHjeu3LxbudKF5mruXuR1kEP6
	MR8nSxI1Z2aNUtFoFc/2Zas2IxzUp9K6bt6eF8/hWS9aEgvK7+TM6VaHYDS5mQNLLNAoEChNlum
	2Z7A7mPihz+PGxIb0TsZ4JY0eIUw/R+wDTmWBMnAhDQmTCQvxWEahYGOWfDqy0LnNEPbuU/j8qk
	En3lAiN4CWJEGczg/wRhkjFokWbASMSRp1p7RoG50GRAJ4/s1KNfaK6C/TZtQkKl9iya8Mwdzdk
	2aSLjbDq76hNpy19nK98cSjic63UYHBwRLOQhteX7VhaFBCnclhYxoeZxQF+wrBPvZK4ZKGhgfZ
	jaAwEND8z711Sg6sNdoHbH4HlvzcPiM8nrpQO6xsJfqAsl7mMp7+bHNfeMSxlLht1b97tY2xQie
	nSVSNSB6xVL/huj+m8zBCs1A=
X-Received: by 2002:a05:693c:65d0:b0:386:b7d0:adb3 with SMTP id 5a478bee46e88-386b7d0aef3mr10469703eec.30.1795694297177;
        Thu, 26 Nov 2026 03:58:17 -0800 (PST)
Received: from localhost.localdomain ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm33614470eec.0.2026.11.26.03.58.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 03:58:16 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 3/3] bundle-uri: do not die on unresolvable relative URIs
Date: Thu, 26 Nov 2026 17:28:03 +0530
Message-ID: <20261126115803.30015-4-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126115803.30015-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
 <20261126115803.30015-1-aniketgupta3001@gmail.com>
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
--bundle-uri", may contain relative URIs. They are resolved with
relative_url(), which calls die() when there are more "../" components
than the base can absorb, so one bad entry aborts the whole clone.

Resolve them with relative_url_gently() instead. When that fails,
bundle_list_update() reports the problem as an error, drops the bundle,
which has no URI to use, and stops parsing the list. Dropping it keeps
the clone from complaining a second time that the bundle has no URI.

What happens then depends on where the list came from. For a list
advertised by a server, the bundles before the bad entry are still
used and the ones after it are not. A list given to "--bundle-uri" is
read from a file and rejected as a whole. In both cases the clone
carries on and fetches what is missing from the remote.

This resolves the TODO in t5750, so update the test to match.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 bundle-uri.c                | 13 ++++++++++++-
 t/t5558-clone-bundle-uri.sh | 16 ++++++++++++++++
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 41c817eefb..3b54622532 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -214,11 +214,22 @@ static int bundle_list_update(const char *key, const char *value,
 	strbuf_release(&id);
 
 	if (!strcmp(subkey, "uri")) {
+		struct strbuf err = STRBUF_INIT;
+
 		if (!value)
 			return config_error_nonbool(key);
 		if (bundle->uri)
 			return -1;
-		bundle->uri = relative_url(list->baseURI, value, NULL);
+		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
+						  &err);
+		if (!bundle->uri) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			hashmap_remove(&list->bundles, &bundle->ent, NULL);
+			clear_remote_bundle_info(bundle, NULL);
+			free(bundle);
+			return -1;
+		}
 		return 0;
 	}
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index e86ed7d30c..e7a3e17775 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -1351,6 +1351,22 @@ test_expect_success 'bundles advertised with empty URI' '
 	test_grep ! "expected packfile" err
 '
 
+test_expect_success 'bundles advertised with unresolvable relative URI' '
+	git clone --no-local --mirror clone-from \
+		"$HTTPD_DOCUMENT_ROOT_PATH/bad-relative-uri.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bad-relative-uri.git" config uploadpack.advertiseBundleURIs true &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bad-relative-uri.git" config bundle.version 1 &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bad-relative-uri.git" config bundle.mode all &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bad-relative-uri.git" config bundle.bundle-1.uri ../../../../../../../../bundle.bdl &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/bad-relative-uri.git" config bundle.bundle-1.creationToken 1 &&
+
+	git -c transfer.bundleURI=true clone \
+		"$HTTPD_URL/smart/bad-relative-uri.git" target-bad-relative-uri 2>err &&
+	test_grep "cannot strip one component off url" err &&
+	test_grep ! "has no uri" err &&
+	git -C target-bad-relative-uri fsck
+'
+
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index a91c1b428d..02b9b38c19 100755
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
2.54.0 (Apple Git-157)

