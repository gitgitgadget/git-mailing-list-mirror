Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01054321F26
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747678; cv=none; b=E1lYZbcWTMO5PUmomJKNBLYgECXGLboWTZ/aTr1hPTlxNUASB/xXfRm9oWdS95p/nQa4bEDMDykj1LTLxXHtwZZ4JKxBeub72G7pcfkOKZI5Q2m9wZaZ/6oLDFIUgAwXgDojxZVOQPofJLJNivW0z81zMrrVc64dtPCOS3hR4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747678; c=relaxed/simple;
	bh=6VImYP5Ufp9cVc6ljr0zJlyE2otASXMAj04Q5ST+Y1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kZR0pRaTlKaFDO23teI8N+7GoSGzc7FAv53U3MD/MbmsAnroiDrl4i4i9LoQ+pKNqzjrRbAOKK/xghs3VNCybiJllAO1EKUurixJrBixTXjVk1k6R7IVUfA0xYMFXhP0+RLbogmRVJiS4X6faEBj4nBOj0YPdHO564uLJRRmWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju195vel; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju195vel"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8961144a9f8so235903241.0
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756747676; x=1757352476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QB1nUCthmXUg9J+Du6YDyZ8jeD126Z96bzkSnK+Fks=;
        b=Ju195vel0JWir9zrQQ9sdoZnqzzoyb8rWJYO118n/tc+BQatQSc91e6Io/GWR0r86E
         b/8HyU8WnQ3yoFBSLfzOJCQUxZALkl0Kjr7Y9crlo8Yk4mMTURhmREYtQw2gXBg3OyhP
         jSHTQ7d9vvZOwAg+Yh1gsLXq30SswXkNvGNK35EmEuNVoN/G9XOTISsuj/79pcERTn50
         h+w/0Bw1qH5uBJH5BwYUf/DeOnkSrai5hrCMZWp6kamBshjiMoF+XO1rS6tHb2hgx9S5
         RH+r+R4Y2M84BZMjQ9ZTqkTT9PPZmsi88zdjJHc91FN3stwcMnAtBS3mzUhycc8fhz2I
         eGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756747676; x=1757352476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QB1nUCthmXUg9J+Du6YDyZ8jeD126Z96bzkSnK+Fks=;
        b=A+T1GQLEoFQTNBkqY13Qolh1Q0jyyCZ0VGx7klO6/J8zPrJhoS1NwXhRXha4KwPevG
         tgvh2vpsEkCRlDcywMyJaLilnRkThQThryV/sZuBWQLmFYU86f5wjMi0fjKeMAF+5QRY
         ZjnOBOMmVtA2juyIJI7uRqkchtqTV4MOwVn6zDDS+F+0S2qOXnzvQ/nbR7w0eV/bA0ba
         KTMwtclFda92br3OX698ZeT68n/Jv/PaYgDuWZtYV4Llv/g2kxOwgdpC9a19l1tOdtmH
         wN6145V4bul+TnyhB95pfC9T7ACmXNvETVcv21Oy+kI04uPMYxKIkLxLs9jWKqF8G3Ob
         q5bQ==
X-Gm-Message-State: AOJu0YwjYyYqFbhiugKiMmu7cSnkUJ2CigveQrii+bLvt25am7MsFKfg
	aOtR11al6k0GXDEwbv7UK3Y42ap0M7Jknjn+NvMMa2l4le3hzYycoc3kxNlR5g==
X-Gm-Gg: ASbGncuvIqmDQjRXHFu3e3zfvxNIcE2zPVinSSN8j584wxxivZ3zaN6s1nn6FErtH8q
	KJE9GgLDmUwpeB/opyNjKTTlfAZPwmN5KRlm1UG6EYrFdfREcF/penStx/GoXvh36OLONVMWK7P
	b9vFlVY4y7Tyi4arAsAU7z7ingiBQB5C3UoD/ZoVdUaPKoYNF78XnoXn9D1fSv8AWP8YX89R1Tx
	nR/Q0Oorkjm11dhoU9rQmJrJslknnBgazbE43Tv6Mo2h2eHKhQxR9rqU8d6mPcuOKaMtZ6qQ7AK
	WW4aH8N4EM0FUB0S8X4tNYiHb15utBJOa28q+6osHT7kQihqQwDRP7djtkekUGf8HU3kqiclnqi
	dGPDxFLoboEBovXeSE75xa9JEo7TLJVp32sx0w7tcvpbzlEkI1578olltbWs9qeo=
X-Google-Smtp-Source: AGHT+IG9Q6x12xPjs0brmt4Rnb+AMAwzxEKc5yuyvnhuhIi7ipb3FN8bRaw3jLaF9GdFMA/zHy9j/w==
X-Received: by 2002:a05:6102:5089:b0:4e7:b728:e34b with SMTP id ada2fe7eead31-52b19531cf8mr2391279137.3.1756747675689;
        Mon, 01 Sep 2025 10:27:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:8aa:edea:fa75:64b3:34fd])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7c2c42sm3973283241.4.2025.09.01.10.27.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 10:27:55 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v3 2/2] repo: add the field objects.format
Date: Mon,  1 Sep 2025 14:27:32 -0300
Message-Id: <20250901172732.98845-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901172732.98845-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250901172732.98845-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag `--show-object-format` from git-rev-parse is used for
retrieving the object storage format. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Add a new field `objects.format` to the git-repo-info subcommand
containing that information.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 3 +++
 builtin/repo.c              | 7 +++++++
 t/t1900-repo.sh             | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 6f5ee88215..209afd1b61 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -55,6 +55,9 @@ values that they return:
 `layout.shallow`::
 	`true` if this is a shallow repository, otherwise `false`.
 
+`object.format`::
+	The object format (hash algorithm) used in the repository.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 13a34f68a5..9b519426fe 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -38,6 +38,12 @@ static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_object_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo->hash_algo->name);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -49,6 +55,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
+	{ "object.format", get_object_format },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index ddf788d5a2..2beba67889 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -63,6 +63,12 @@ test_expect_success 'setup remote' '
 test_repo_info 'shallow repository = true is retrieved correctly' \
 	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
 
+test_repo_info 'object.format = sha1 is retrieved correctly' \
+	'git init --object-format=sha1' 'sha1' 'object.format' 'sha1'
+
+test_repo_info 'object.format = sha256 is retrieved correctly' \
+	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.39.5 (Apple Git-154)

