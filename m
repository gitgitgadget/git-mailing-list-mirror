Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F512B94
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160113; cv=none; b=FaFELjZGrZNTB0h2azw4R7FMyjxGJBSTM0HtPO7sS8bt08e2IJ5UAFpq68Y7R8zx3Oiv42Cnog/gv35LJTuiShbmefwYIagw+gmxcl0HrfjbvR6mbTS1Mb5ZJtXCfYmad08SuGQ7cHD1SzW/fIMDD007YyJST2i3hWOBouCYeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160113; c=relaxed/simple;
	bh=lcRMM5LLLb8VJTKHdjczRT25EV6xWirWnG1mmIig5Pk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jj1Bp7PmBHdVVyAjXBeoYJDKJ6Pt0qG+W5XGZKRn/+kx+3ueEZP3CCQ2a+RD8e8rak2nUnD49zQhDm8ctfE80PJAe9Rex5zGeRFCeRPhtTCsXqOVYyAcdBuHXdghJYPaRU57+biYgXpwBBq60pfwyGbuGbnZrWnd6Vy1U9XxET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1XbPdT/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1XbPdT/"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so2399319b3a.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766160110; x=1766764910; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7tvL0IVEa1KXlyCbJk7wlqVi2n7fLbN9ol/gld39ns=;
        b=E1XbPdT/UyyqIHr1ZXhWXIgW3lVqCpAr4DNoz0uELJexf8ot4Mo2POMS6evjc4mW6M
         uKgOeeclZOxq07CHMAMoQF2F62jCDKVaElluFr4oeh0DN9oZvb6uCSCsTHf5VlAkDLrc
         X/B2v/g+KUsGjqgw9yOeektjcn/3t3RPVeiM048ZqgyU8maqbzOUJEIES9Hef9og+VlA
         l2oAK7GuqU+C9aYLILQudjBaUcDeRajidrB/zXF+okWkFU6tlQnLHR9g/BxitMWEAn9/
         YmXTx9ywcJzknikQsmtAJ+X/wgQuA/RoaaZlDoRtMaGKntVkfC1h1y2o78XNSuu9HGMy
         r5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160110; x=1766764910;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7tvL0IVEa1KXlyCbJk7wlqVi2n7fLbN9ol/gld39ns=;
        b=AiIaDo/I32Y8+OfGfLDS0UXdEwCcvN6Z39uU8zsj3Z0bxeuwvR2TGMsaWTpuGVIAip
         RWz2MWm80LjvQmpO/sCxBHD3HIjaQzBXKa4DupAfG4QFNjjjBMObDRqXIA0ltmdY6hon
         9kpphaC871Xv8h0sn5pPbNZ2qXUwt1gfGPBBvJA877G5uT3BXpUL0L5BaRevicBUPwf0
         jCDh+qGr4ITT4Jsli7jn002PKo0fHn2V9OiHaZC6tkCoL+XDgRcs9EKRQAGyVzUl6IbF
         lMQZZ2s2x3+hWI6IqmWRzyYyzP/eqkgFl0fFLGp0rKWK1TMIPuaNcPnkkpDzEuXHAqmv
         uuCA==
X-Gm-Message-State: AOJu0Yx+YRKY075TZbiVSwchMF6q2OM/gn1nZD50oDzbMsGLX9PybprU
	lby2YaxfIwZRyAbQN1TsXx2tn2Hd2U8WKewpZW0bVaTnAg55c+KwnzpNLc0EOQ==
X-Gm-Gg: AY/fxX7HL5149zgacfKVquTN4INEsgeS8473VwBbJ9W8RYpR/x+XMmg5AtVsNkGJTzq
	ygLJgVv6aCJA+sN41xENQdgimYL14Sd4nIeB8cJGry6DfWMDDZYuX/FgpDn38CvS9TaK7eiu0qK
	1F2sv/Hk1BF/U2H6Tq4M1B2vUYZnhrf9MTrmUsp5V59+zBVXcGS/geBkJ1SDBAtvNb1whSW3eCF
	dinDnLC0Jj0uG1KMhjfvcwzE5mjVF23JkArhX78THE4qxUH4OAZsaNxfqSjyjUkysMv1qR6ET/C
	jT3DOZxkVzezau2WUrW0TjBa/kLrOQKqENgfLU9nTG67jxFx2js1Q6mf1lDNxWgIC9VbLPNl4bD
	Lpei3E2dk0gQNBNvhVv1BSIlAaYk0vm/XDp80UAjO9dq9onwDYd30eYrsmDL1RNabpbX57lyXcd
	FQz8j//MnRGMZhB+C7NrE8wv0kCg==
X-Google-Smtp-Source: AGHT+IHZupUjYhrtQ92D1PX66yo1k8e08pVORSboGBEW6jv5amVuYoshhRLI1RCRJdJFkdYjWyr9Fg==
X-Received: by 2002:a05:6a00:1f04:b0:7e8:43f5:bd26 with SMTP id d2e1a72fcca58-7ff67455837mr3219460b3a.59.1766160108578;
        Fri, 19 Dec 2025 08:01:48 -0800 (PST)
Received: from [127.0.0.1] ([172.184.220.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b5236b5sm2818949b3a.29.2025.12.19.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:01:47 -0800 (PST)
Message-Id: <pull.2134.v2.git.git.1766160106521.gitgitgadget@gmail.com>
In-Reply-To: <pull.2134.git.git.1766097223647.gitgitgadget@gmail.com>
References: <pull.2134.git.git.1766097223647.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 16:01:46 +0000
Subject: [PATCH v2] bundle-uri: validate that bundle entries have a uri
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

When a bundle list config file has a typo like 'url' instead of 'uri',
or simply omits the uri field, the bundle entry is created but
bundle->uri remains NULL. This causes a segfault when copy_uri_to_file()
passes the NULL to starts_with().

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
    bundle-uri: validate that bundle entries have a uri
    
    Changes since v1:
    
     * Updated summarize_bundle() to print # uri = (missing) as a comment
       instead of silently omitting the line.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2134%2Fsambostock%2Fvalidate-bundle-uri-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2134/sambostock/validate-bundle-uri-v2
Pull-Request: https://github.com/git/git/pull/2134

Range-diff vs v1:

 1:  3d8a014490 ! 1:  fb66352093 bundle-uri: validate that bundle entries have a uri
     @@ bundle-uri.c: static int summarize_bundle(struct remote_bundle_info *info, void
      -	fprintf(fp, "\turi = %s\n", info->uri);
      +	if (info->uri)
      +		fprintf(fp, "\turi = %s\n", info->uri);
     ++	else
     ++		fprintf(fp, "\t# uri = (missing)\n");
       
       	if (info->creationToken)
       		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);


 bundle-uri.c                | 24 +++++++++++++++++++++++-
 t/t5750-bundle-uri-parse.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 57cccfc6b8..3b2e347288 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -89,7 +89,10 @@ static int summarize_bundle(struct remote_bundle_info *info, void *data)
 {
 	FILE *fp = data;
 	fprintf(fp, "[bundle \"%s\"]\n", info->id);
-	fprintf(fp, "\turi = %s\n", info->uri);
+	if (info->uri)
+		fprintf(fp, "\turi = %s\n", info->uri);
+	else
+		fprintf(fp, "\t# uri = (missing)\n");
 
 	if (info->creationToken)
 		fprintf(fp, "\tcreationToken = %"PRIu64"\n", info->creationToken);
@@ -267,6 +270,19 @@ int bundle_uri_parse_config_format(const char *uri,
 		result = 1;
 	}
 
+	if (!result) {
+		struct hashmap_iter iter;
+		struct remote_bundle_info *bundle;
+
+		hashmap_for_each_entry(&list->bundles, &iter, bundle, ent) {
+			if (!bundle->uri) {
+				error(_("bundle list at '%s': bundle '%s' has no uri"),
+				      uri, bundle->id ? bundle->id : "<unknown>");
+				result = 1;
+			}
+		}
+	}
+
 	return result;
 }
 
@@ -751,6 +767,12 @@ static int fetch_bundle_uri_internal(struct repository *r,
 		return -1;
 	}
 
+	if (!bundle->uri) {
+		error(_("bundle '%s' has no uri"),
+		      bundle->id ? bundle->id : "<unknown>");
+		return -1;
+	}
+
 	if (!bundle->file &&
 	    !(bundle->file = find_temp_filename())) {
 		result = -1;
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 80a3f83ffb..294f9d9c64 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -286,4 +286,30 @@ test_expect_success 'parse config format edge cases: creationToken heuristic' '
 	grep "could not parse bundle list key creationToken with value '\''bogus'\''" err
 '
 
+test_expect_success 'parse config format: bundle with missing uri' '
+	cat >input <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "missing-uri"]
+		creationToken = 1
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config input 2>err &&
+	grep "bundle '\''missing-uri'\'' has no uri" err
+'
+
+test_expect_success 'parse config format: bundle with url instead of uri' '
+	cat >input <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "typo"]
+		url = https://example.com/bundle.bdl
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config input 2>err &&
+	grep "bundle '\''typo'\'' has no uri" err
+'
+
 test_done

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
