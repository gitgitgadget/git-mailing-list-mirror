Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297600;
	b=hLwiRKWuGqfe1WyHlsAu9tatq4YoXF/kBA2sHV33x0vpKR47ObpZnp+/7Wre9m1pL1Pg
	 Z0kXqQa5sVYdjvXr0PIcIQ3BI2A3fkszeSvFAzglGBZ9pxxZSlQog3dl6PkR5hUc6m3jQ
	 TwEo1YtOPsb39tjipbfwmcadlw3ZmaH573CMaUPkTfqoQfuouNvweuAodk76WHyrHZwlw
	 jUAtSGuRbXreiwCQUkqZTjmANCWUkZ+UFfORcwYKClh6F0p7bTtiZXo2jTGX/xUFO9CwN
	 c4FgEuscQJp9oNN14briC8hFrFCXYCsaSNBUYzEaUYmQKDiDyv187l98ao8dEt+aArg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hx18S/Fi9iJt8Wg2yUNtMqHYIlsmUWyspD+UETNHAJs=;
	b=Ar53K+jnuQ64VSuoNH98W3Vol6qOjFl3QaqFcjLjDzmwWy63GETDdAKUISTXmUnj+7Bd
	 KTsPLPqATWixuZsvHI1FI0ny0ZnqK8p8I1zUpuM3DlO4ogIDzoRjWuCiwvDj8SNCeplv5
	 VMxk+Ol6w/L9h2sOBSOinL7RR/xTE1hbnVvqX60iZl9rrYJNNiumwSis7omGjcAaGxCmK
	 1iFDs5YmNJez0SPE3ZXtWTPQ4C41QxeKKdQGo7HSsBm8HKCzXeM3BFmhJ0tqbIqsMiJ34
	 6hH39lx+k7vMnj64UsvNBZhu/YiV2ZQ1b/raiIIs71Bk7eU9fTtWSX0bEgHzLHsr7ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAU57RRo;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF59606A32C
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 21:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF59606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAU57RRo
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so15039705e9.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 13:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795297599; x=1795902399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hx18S/Fi9iJt8Wg2yUNtMqHYIlsmUWyspD+UETNHAJs=;
        b=aAU57RRodjPg/nIpeo4BRsifQVHOeTD08GvyA9cpClfvYWYum4oLFS0JzIOjNNBJe7
         gs8GSOHc+959tnnvt6KE7U2k8R7zhI8sZ56NSciucXgTLJhOpPZRC476ISsmnrfZI0U9
         tWS47dZCsbdWg/X/TFBhdK7kVJK0MwaWtfgDa4hKJzejEqc6UPBimpqMyMKQ8fZPy+rg
         IEilPOg6oX33bPbVSRm76aES0tsiOl5nK+GyYhQ8cGhtGvSOOgBwI70zN0M9/JAn9izH
         OOxwJyYIoAKQfx6iqFf0sI8au3YwcIY9kJL4QTQ0RC5iOfyOh9F63gxnXUuMqfgUwFJq
         odbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795297599; x=1795902399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hx18S/Fi9iJt8Wg2yUNtMqHYIlsmUWyspD+UETNHAJs=;
        b=JJhJ+zl9ar4D1JZx+hIN7sD+HbeB5RuLSttTJjDU1PcXm3hJYzdHreycBS9u7KIyvb
         7CyYc10K0UwTsXf2Ux7nbYyCY/+GXBmUhzYkpv9TW52TYkZiKmmVwcZ50jxMT0bPm3bg
         E+K+aT9oimXaUbLdaYI0e5CbXHbCQAEdUV4P1H13fu/490AFxuTRZiGkETtwvDTzuZfm
         gNC8+/cbFg4pX5tCGSO9BokyzA5lacXy7z3V5ysoL6XhGRaUz7jWXD8PIPdB7117R8XI
         4cTLnfTCFT4DIs4esHyu1KSKnjM0pLtGbLXe+oWC0stTJ6GJa+EpD4YqsmYc2nc8NV7e
         I3pQ==
X-Gm-Message-State: APuU4Z/XXpQdhKH1uETIsSjl+QwxGh4PlP8tqhgfTXR6TKAlc+K2haNh
	5qemHDnMsVl5jdk+lx0T1AJK3+SgHNzBBPg+OFuBBSieTQgs7kvkqaUv65+susN6
X-Gm-Gg: AZFdTZcjbKb4qHkAuyP+LiY1dnJKZDdKmfqlIs0KF82U6o07M9AL7N1L/jbrndWS49X
	4xWiGmBpQ06w2qrMb2PIK92F544qCU4/GqbyI83xXwG9pFrsG1/HyNU9tzlRAzb2sixxdWuXGIL
	CecS9TMxtA3hk3cLm5HTwJn4ShSU/c3tycVumaMMjFGAkcKr6m/VCRHzn7ZxWi2pzDyoa2zG7dN
	HpzBYXXPgSETl7TtONvrN1kBnk4AqxaBAYGWUgQKUk51FuikY8My5OAJnMEYCCr4Rw2+LHxIpGE
	lToSLkmgwZMCT+d9dIjLrfkFV9lUfadvK1rZyAnkoTVjsonrmLCTivDWk9AHvJcLJCv5TOTibnD
	3p+WfYQzMetfzdfu2NkT2RlC6ouFYPZVIpAkWkTPV1sq4ltlWj1yOB7MGYesXdYoDRiB8Jzc6Ee
	nZClPsllfedo6XK8gJws34Kz8jn1xZGNdN1HrB7JoHt/1TWxD0U5qj5+JJogflnshUjWpuh3aFy
	WZTuWBMqB6C/PQLWrsmrepfnbqIiKePixsoDMip0Fp69YWsOmiXk+qw+caJSSVIhCp4zF+2TSxg
	W5cAymDGsF/pSJN/ZZn+bisjzn+/w4ypF0po7M8E6VcAMz5bBjoJKWye+liBzGtSDQB1tYLcDqf
	UpxoI68GFNYWMQMhfhu5M9awBqju2DCcPjNs1PgjwngYH6oY=
X-Received: by 2002:a05:600c:1d08:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4bb8882bd7bmr153559555e9.28.1795297598881;
        Sat, 21 Nov 2026 13:46:38 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm211800125e9.15.2026.11.21.13.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:46:37 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 2/2] fetch: make --prune-tags clobber changed tags
Date: Sat, 21 Nov 2026 21:46:33 +0000
Message-ID: <20261121214633.1523706-3-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121214633.1523706-1-orgads@gmail.com>
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
 <20261121214633.1523706-1-orgads@gmail.com>
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

The docs say --prune-tags will "force-update those tags that differ",
and the option help says "clobber changed tags", but it doesn't do
that. When a tag changes on the remote, fetch fails with:

   ! [rejected]        t1         -> t1  (would clobber existing tag)

When --prune-tags was added in 97716d217c (fetch: add a --prune-tags
option and fetch.pruneTags config, 2018-02-09), fetch always updated
changed tags, so the docs were right. Later, 0bc8d71b99 (fetch: stop
clobbering existing tags without --force, 2018-08-31) required "+" or
--force for that, and --prune-tags was missed: its refspec
"refs/tags/*:refs/tags/*" has no "+". That commit doesn't mention
--prune-tags at all, so I don't think it was intentional.

Fix it by adding "+" to the refspec, and update the docs that quote it.

Fetching a tag by name is not affected. --prune-tags is ignored when
refspecs are given on the command line, so "git fetch origin tag foo"
still needs --force, even with fetch.pruneTags set.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 Documentation/config/fetch.adoc |  2 +-
 Documentation/git-fetch.adoc    |  2 +-
 builtin/fetch.c                 |  4 ++--
 t/t5516-fetch-push.sh           | 22 ++++++++++++++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index 00435e9a16..0dc4a11706 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -44,7 +44,7 @@
 
 `fetch.pruneTags`::
 	If true, fetch will automatically behave as if the
-	`refs/tags/*:refs/tags/*` refspec was provided when pruning,
+	`+refs/tags/*:refs/tags/*` refspec was provided when pruning,
 	if not set already. This allows for setting both this option
 	and `fetch.prune` to maintain a 1=1 mapping to upstream
 	refs. See also `remote.<name>.pruneTags` and the PRUNING
diff --git a/Documentation/git-fetch.adoc b/Documentation/git-fetch.adoc
index 61fed797af..4c18e2b144 100644
--- a/Documentation/git-fetch.adoc
+++ b/Documentation/git-fetch.adoc
@@ -161,7 +161,7 @@ with `fetch.pruneTags` or `remote.<name>.pruneTags` in the config. See
 linkgit:git-config[1].
 
 The `--prune-tags` option is equivalent to having
-`refs/tags/*:refs/tags/*` declared in the refspecs of the remote. This
+`+refs/tags/*:refs/tags/*` declared in the refspecs of the remote. This
 can lead to some seemingly strange interactions:
 
 ------------------------------------------------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c646bc6698..291c5ce91b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2520,10 +2520,10 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 
 	maybe_prune_tags = prune_tags_ok && prune_tags;
 	if (maybe_prune_tags && remote_via_config)
-		refspec_append(&remote->fetch, TAG_REFSPEC);
+		refspec_append(&remote->fetch, "+" TAG_REFSPEC);
 
 	if (maybe_prune_tags && (argc || !remote_via_config))
-		refspec_append(&rs, TAG_REFSPEC);
+		refspec_append(&rs, "+" TAG_REFSPEC);
 
 	for (i = 0; i < argc; i++) {
 		if (!strcmp(argv[i], "tag")) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 68e0e2de27..c20fd1eebf 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1191,6 +1191,28 @@ test_force_fetch_tag () {
 			check_child1_tag
 		)
 	"
+
+	test_expect_success "fetch --prune-tags clobbers an existing $tag_type_description" "
+		mk_test testrepo heads/main &&
+		mk_child testrepo child1 &&
+		(
+			cd testrepo &&
+			git tag testTag &&
+			git -C ../child1 fetch origin tag testTag &&
+			>file1 &&
+			git add file1 &&
+			git commit -m 'file1' &&
+			git tag $tag_args testTag &&
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 fetch --prune --prune-tags origin &&
+			check_child1_tag &&
+			git tag $tag_args testTag HEAD^ &&
+			test_must_fail git -C ../child1 -c fetch.pruneTags=true \
+				fetch --prune origin tag testTag &&
+			git -C ../child1 -c fetch.pruneTags=true fetch --prune origin &&
+			check_child1_tag
+		)
+	"
 }
 
 test_force_fetch_tag "lightweight tag" "-f"
-- 
2.53.0

