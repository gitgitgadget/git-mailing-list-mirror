Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F825E093
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690802; cv=none; b=VM0FozX1jA0TzStyIieNarM5qSRol7XzAuWioJy/dNd4xeN+v3xNsnJPgRmXBMJu0cliZ2VXiwjuQVJ5C47QKGnTz2cT5yHphuO9uKq31Uft4Zz+x/re9ZwZhszzgJyj3UMLW7koxA5/qJAYDE3+t4QzxGn6BpnvDpbXg/wkcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690802; c=relaxed/simple;
	bh=1wfN1PvDvz5iTZJF2f2VCPBFjgWGYxl32jry2DY15CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5jwU5++/0mVajDg7N8VDpJ5biMlQsztUOqs0g67dHUYVTGbOUvrJTEZkyHjtCWIGCde1C+lPZWqAvnRo0l6ZgjIPUA0yH6l9kfibnQzPk/0a/wDscxmjOk9Qlhm1GOq4jqBqHlteBBQ8MAICV7J+S34MfoqEboaxvrWDdZCw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDgAVoLq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDgAVoLq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so317131f8f.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720690798; x=1721295598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV/x3M9n9VYCKA0Yd7ZDGgn6c6eEW+bIB+6gar8Vhi8=;
        b=nDgAVoLq/U/b6pDNSws6ytWQlMYmBWqqeJ6+smyg2zr0PY/kEIcXEQgnREUWGfCL7N
         Njm0G4SncYoQ5unYGpys2MpvK+FHTJG6/dflCDpcMwee+6wom4o2RSwiwFyiHH+n1Xjy
         n/PPU/4cZPQ5oxYHnTHdZ0v3WlfkzN4/3qm7jRm9fyNSFnGkbuO0H4uYFrzYaGsImKKt
         S9BLhuPgTemPPQwCz9UXRsnHF0WXG+nVcayx7rWHFoYvEOALzcF+hWTWV9nsa9CrYSQl
         /gVYcNLAYyhf3I8heGAl1Y8D4Vv6rMafrLXKMaY/FjsGh2JdQ684N1c/b4xXA7u2cGEB
         /0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720690798; x=1721295598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV/x3M9n9VYCKA0Yd7ZDGgn6c6eEW+bIB+6gar8Vhi8=;
        b=O8YfVrqiv8Ix5zNYWvSzG0rZnDAmqjyhgCxYuVKg/JPg5AXJjEMvC9ccjnKjYnx1R0
         mKc8jc5t4BnlIi2vRQ11w6qHyl4warbml2PcXOqY+eAwhB+gv9RP3Cz77unxmG4YOP5C
         J0JPkB8KdXG5EjYnkzccuZewcrgp7sARxKezuqIPeIG0sIeOFnI22U/JtUKJT1TaOUWl
         q8o0QCBtZ++MiC1YABn9AB0EJ6Eq/qfzzjEji8ogFTfZqHrlgqkGlZqNHtlmA/bCOYdh
         +CIhVcXn3mNWBr27PwpmfpCBnGcr0HU8yuQMBuOfie+0tJIiDIpR2gsViTKeQnhINyKZ
         Zp7g==
X-Gm-Message-State: AOJu0YzHh5AzH8XMSMMCXcFU6RsZu5HjZry+dZfZoo4VoQLyh5OBuDn5
	dgtla2944Os/SX6KFerMl0t6FtaEh90DTRbWnq3S6Nbx1I5mI7QQ
X-Google-Smtp-Source: AGHT+IHxNx17BKoy94EY3EVvKQUOjwJlDQuB3b3v4s5Vb6v3glrmjiN9vzy88zoBYZQeWs7URlDJAA==
X-Received: by 2002:adf:f70e:0:b0:367:9b22:28cb with SMTP id ffacd0b85a97d-367cead87fbmr5243452f8f.59.1720690798172;
        Thu, 11 Jul 2024 02:39:58 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:a0b1:9848:4b88:d770])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367fba1b15esm799390f8f.22.2024.07.11.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 02:39:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	peff@peff.net,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] builtin/push: call set_refspecs after validating remote
Date: Thu, 11 Jul 2024 11:39:54 +0200
Message-ID: <20240711093954.20317-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709144931.1146528-1-karthik.188@gmail.com>
References: <20240709144931.1146528-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an end-user runs "git push" with an empty string for the remote
repository name, e.g.

    $ git push '' main

"git push" fails with a BUG(). Even though this is a nonsense request
that we want to fail, we shouldn't hit a BUG().  Instead we want to give
a sensible error message, e.g., 'bad repository'".

This is because since 9badf97c42 (remote: allow resetting url list,
2024-06-14), we reset the remote URL if the provided URL is empty. When
a user of 'remotes_remote_get' tries to fetch a remote with an empty
repo name, the function initializes the remote via 'make_remote'. But
the remote is still not a valid remote, since the URL is empty, so it
tries to add the URL alias using 'add_url_alias'. This in-turn will call
'add_url', but since the URL is empty we call 'strvec_clear' on the
`remote->url`. Back in 'remotes_remote_get', we again check if the
remote is valid, which fails, so we return 'NULL' for the 'struct
remote *' value.

The 'builtin/push.c' code, calls 'set_refspecs' before validating the
remote. This worked with empty repo names earlier since we would get a
remote, albeit with an empty URL. With the new changes, we get a 'NULL'
remote value, this causes the check for remote to fail and raises the
BUG in 'set_refspecs'.

Do a simple fix by doing remote validation first. Also add a test to
validate the bug fix. With this, we can also now directly pass remote to
'set_refspecs' instead of it trying to lazily obtain it.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes from v2:
- Updated the commit message to talk more about the user
experience at the start.
- Added another test to also check targeted refspec.

Range-diff against v2:
1:  fd9a9387e9 ! 1:  845be99dd6 builtin/push: call set_refspecs after validating remote
    @@ Metadata
      ## Commit message ##
         builtin/push: call set_refspecs after validating remote
     
    -    Since 9badf97c42 (remote: allow resetting url list, 2024-06-14), we
    -    reset the remote URL if the provided URL is empty. When a user of
    -    'remotes_remote_get' tries to fetch a remote with an empty repo name,
    -    the function initializes the remote via 'make_remote'. But the remote is
    -    still not a valid remote, since the URL is empty, so it tries to add the
    -    URL alias using 'add_url_alias'. This in-turn will call 'add_url', but
    -    since the URL is empty we call 'strvec_clear' on the `remote->url`. Back
    -    in 'remotes_remote_get', we again check if the remote is valid, which
    -    fails, so we return 'NULL' for the 'struct remote *' value
    +    When an end-user runs "git push" with an empty string for the remote
    +    repository name, e.g.
    +
    +        $ git push '' main
    +
    +    "git push" fails with a BUG(). Even though this is a nonsense request
    +    that we want to fail, we shouldn't hit a BUG().  Instead we want to give
    +    a sensible error message, e.g., 'bad repository'".
    +
    +    This is because since 9badf97c42 (remote: allow resetting url list,
    +    2024-06-14), we reset the remote URL if the provided URL is empty. When
    +    a user of 'remotes_remote_get' tries to fetch a remote with an empty
    +    repo name, the function initializes the remote via 'make_remote'. But
    +    the remote is still not a valid remote, since the URL is empty, so it
    +    tries to add the URL alias using 'add_url_alias'. This in-turn will call
    +    'add_url', but since the URL is empty we call 'strvec_clear' on the
    +    `remote->url`. Back in 'remotes_remote_get', we again check if the
    +    remote is valid, which fails, so we return 'NULL' for the 'struct
    +    remote *' value.
     
         The 'builtin/push.c' code, calls 'set_refspecs' before validating the
         remote. This worked with empty repo names earlier since we would get a
    @@ Commit message
         'set_refspecs' instead of it trying to lazily obtain it.
     
         Helped-by: Jeff King <peff@peff.net>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/push.c ##
    @@ t/t5529-push-errors.sh: test_expect_success 'detect missing sha1 expressions ear
      	test_cmp expect rp-ran
      '
      
    -+# We need to use an existing local_ref so that the remote is mapped to
    -+# it in 'builtin/push.c:set_refspecs()'.
    -+test_expect_success 'detect empty remote' '
    ++# We use an existing local_ref, since it follows a different flow in
    ++# 'builtin/push.c:set_refspecs()' and we want to test that regression.
    ++test_expect_success 'detect empty remote with existing local ref' '
     +	test_must_fail git push "" main 2> stderr &&
     +	grep "fatal: bad repository ${SQ}${SQ}" stderr
     +'
    ++
    ++# While similar to the previous test, here we want to ensure that
    ++# even targeted refspecs are handled.
    ++test_expect_success 'detect empty remote with targeted refspec' '
    ++	test_must_fail git push "" HEAD:refs/heads/main 2> stderr &&
    ++	grep "fatal: bad repository ${SQ}${SQ}" stderr
    ++'
     +
      test_expect_success 'detect ambiguous refs early' '
      	git branch foo &&

 builtin/push.c         | 21 +++++++--------------
 t/t5529-push-errors.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 8260c6e46a..7a67398124 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -96,9 +96,8 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 	refspec_append(refspec, ref);
 }
 
-static void set_refspecs(const char **refs, int nr, const char *repo)
+static void set_refspecs(const char **refs, int nr, struct remote *remote)
 {
-	struct remote *remote = NULL;
 	struct ref *local_refs = NULL;
 	int i;
 
@@ -124,17 +123,10 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 				local_refs = get_local_heads();
 
 			/* Does "ref" uniquely name our ref? */
-			if (count_refspec_match(ref, local_refs, &matched) != 1) {
+			if (count_refspec_match(ref, local_refs, &matched) != 1)
 				refspec_append(&rs, ref);
-			} else {
-				/* lazily grab remote */
-				if (!remote)
-					remote = remote_get(repo);
-				if (!remote)
-					BUG("must get a remote for repo '%s'", repo);
-
+			else
 				refspec_append_mapped(&rs, ref, remote, matched);
-			}
 		} else
 			refspec_append(&rs, ref);
 	}
@@ -630,10 +622,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		refspec_append(&rs, "refs/tags/*");
 
-	if (argc > 0) {
+	if (argc > 0)
 		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1, repo);
-	}
 
 	remote = pushremote_get(repo);
 	if (!remote) {
@@ -649,6 +639,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		    "    git push <name>\n"));
 	}
 
+	if (argc > 0)
+		set_refspecs(argv + 1, argc - 1, remote);
+
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 0247137cb3..17d7257892 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -2,6 +2,9 @@
 
 test_description='detect some push errors early (before contacting remote)'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
@@ -38,6 +41,20 @@ test_expect_success 'detect missing sha1 expressions early' '
 	test_cmp expect rp-ran
 '
 
+# We use an existing local_ref, since it follows a different flow in
+# 'builtin/push.c:set_refspecs()' and we want to test that regression.
+test_expect_success 'detect empty remote with existing local ref' '
+	test_must_fail git push "" main 2> stderr &&
+	grep "fatal: bad repository ${SQ}${SQ}" stderr
+'
+
+# While similar to the previous test, here we want to ensure that
+# even targeted refspecs are handled.
+test_expect_success 'detect empty remote with targeted refspec' '
+	test_must_fail git push "" HEAD:refs/heads/main 2> stderr &&
+	grep "fatal: bad repository ${SQ}${SQ}" stderr
+'
+
 test_expect_success 'detect ambiguous refs early' '
 	git branch foo &&
 	git tag foo &&
-- 
2.45.2

