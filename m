Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784127A448
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537174; cv=none; b=cPXwFUEkWeMYco/98x/c8k+1FuJGjU89z59oVVT/I7QcpamO80XXXFU0n1Z5S489ZdE743DeXw8mpDBOeIn1KBCxENsnhgsnf9PFQNORydSQxr7jEDQScYYYSckQxQCNlZU33g49ES2N4Bg25kg3A7/5EzxmQkNpV437ZEqeVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537174; c=relaxed/simple;
	bh=xBzNmweNNZ7YWN2YLlS0oyMLa8OOJk6/Vl7IG0zdoAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ia2l+0Zez8hcfi/6StiP/Flmx13Qr5g3iC43zbLoe6F8cqlYGgbXV4pQ2oeKN9VYSDb1G97uLnOoyCdHnatLFpLfL9tzDhmzXY2GHeb8JdrIAZe3hwflGwvG6UghRCkhVs0xowF2wviAUf9+jz/6wtHD2Azgb7obX50HJfSNCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmWPHu6N; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmWPHu6N"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-535ae7eeebeso4359236e0c.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537171; x=1753141971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl+MVPTNEMiTMbKjFdDWI/0QqQ8pL7T+Ii8xvLfaQv0=;
        b=RmWPHu6N6ZdRHsuZ0zBjMulPhaAiLntNHb77K6xtey52RNEb2uwC1Lg/KIRSe6GiP+
         llp2kIS0vPaXEWQwGw/f/n49nEHjLVorFvva8+8ME6zZSP2pamzXHYQUMkHliAS9v9GO
         zJBJqyTn2HBr8b6nhZO7I9pWCU2PoIxBQHGuQp6loZnPBmN8I6gLQGGSx0cXJPXihaD5
         z79henaqv8hl9fi3Da1mQFvRLNXg7s1pV093W+RU9xf89jWCKMlF6a0swui10rRNdFlH
         mwbEb3QrTBBlaMagV6If/NfOeluMBLytpcLqyR9fYT2wmMlFqdmpGR3WjqRB6uHrJ9V8
         9HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537171; x=1753141971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl+MVPTNEMiTMbKjFdDWI/0QqQ8pL7T+Ii8xvLfaQv0=;
        b=uEqDUvM9iQlo8E4otvq3+qk1r71V29uKtgD5hmF4FCe8S5u/3FSIR2UzhLwQWpYbH2
         KPT2ur4XA554SPE3KTNngmos5l9aMd1m7S4BUdh89LRvZSEd9M1N2/x5pkW4hWw1jEEf
         c6TCxWzizjbNx7Mo4R5eNmlcYwfJWC3cb0Dl2NQZ3sL37yUk5nscrEKL8GKmT0UksMo+
         MrzQ1AU5wQL2J8Ah+Co38mdu0c4Q11k8mL2XZUULlAnqkvJcluG1ifuP5ceedInmi3Dp
         Ps6aIGD8E0QwCTrN3YHT/LgPOwkunUScvWeNUc+nFqTYKIeZ8PKSdaEjZkK/Qh+FddCp
         /M9g==
X-Gm-Message-State: AOJu0YxH5sm8VjWAyNOBjl1c2S8Rzbp7Q9wWBcreITe5X8e5hH7w2b9m
	pyhyEZyF8JpztjWEUGFHoBW/UnjYXgSEL2dU5t+nrzcIfnFw1wssi9L9xO5B8VUu
X-Gm-Gg: ASbGncvX9d3rdl/urkUzuKsoV4jU0cV4OVbpGVSDCGCEHGkYo2ucj4Do0+eVIN5B8xn
	41gLfkBOo/W34oPQPXFc63fqDPbw3bajMm3uKDVupne5i00KXp7zFOnWb6i1wZvAmSO/Eq9BOu+
	reF6lzM2v2oYTZQhUXNeEx9dPMrEb5aMjt4Rv0NOM5pwCzRXRga8Domue8OVPuYW1EShsd3YOqD
	T/rO3+MWgtLGuvRaQt44kFyvax8GOUbx21LSV9T223cmQNTLqyhzeDg4zPuE+rt6uklcGLVwX5O
	4p6aIUmuHRj3gFalxGD5gYFS0fqGqs9TWlOo2UBLimku5Xan9EYWIq1+eG9n/OS74TOYAA37F/Q
	EstBgqurn+KubXVmUAK1BmH0SCAZoesjeQRC5vxLd4kUNLR9E4DfU/Ba05Dh9Lgc=
X-Google-Smtp-Source: AGHT+IEgtdVSYrlI4P4+HkEjqK5sJ6yF7wjaLid9ZByQKHNPN/6rpCuDfae3/j08lUsnWnfhRMwy0w==
X-Received: by 2002:a05:6122:4707:b0:535:aea0:795a with SMTP id 71dfb90a1353d-537323362a7mr224781e0c.1.1752537171166;
        Mon, 14 Jul 2025 16:52:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:fc3:f915:3491:9732:5741])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e73de3c8sm1999201e0c.48.2025.07.14.16.52.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 16:52:50 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v4 4/4] repo: add field layout.shallow
Date: Mon, 14 Jul 2025 20:52:31 -0300
Message-Id: <20250714235231.10137-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714235231.10137-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag `--is-shallow-repository` from git-rev-parse is used for
retrieving whether the repository is shallow. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field `layout.shallow` to the git-repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              |  7 +++++++
 t/t1900-repo.sh             | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index db185c5c91..864868993b 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -52,6 +52,7 @@ Reference-related data:
 `layout`::
 Information about the how the current repository is represented:
 * `bare`: `true` if this is a bare repository, otherwise `false`.
+* `shallow`: `true` if this is a shallow repository, otherwise `false`.
 
 SEE ALSO
 --------
diff --git a/builtin/repo.c b/builtin/repo.c
index 5eefe06918..d75417a48b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "refs.h"
 #include "environment.h"
+#include "shallow.h"
 
 typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
 
@@ -39,9 +40,15 @@ static void add_layout_bare(struct strbuf *buf, struct repository *repo UNUSED)
 	add_bool(buf, "layout.bare", is_bare_repository());
 }
 
+static void add_layout_shallow(struct strbuf *buf, struct repository *repo)
+{
+	add_bool(buf, "layout.shallow", is_repository_shallow(repo));
+}
+
 // repo_info_fields keys should be in lexicographical order
 static const struct field repo_info_fields[] = {
 	{"layout.bare", add_layout_bare},
+	{"layout.shallow", add_layout_shallow},
 	{"references.format", add_references_format},
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 6155e275b5..e0e2393247 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -42,6 +42,20 @@ test_repo_info 'bare repository = false is retrieved correctly' '
 test_repo_info 'bare repository = true is retrieved correctly' '
 	git init --bare repo' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' '
+	git init repo' 'layout.shallow' 'false'
+
+test_repo_info 'shallow repository = true is retrieved correctly' '
+	git init remote &&
+	cd remote &&
+	echo x >x &&
+	git add x &&
+	git commit -m x &&
+	cd .. &&
+	git clone --depth 1 "file://$PWD/remote" repo &&
+	rm -rf remote
+	' 'layout.shallow' 'true'
+
 test_expect_success "only one value is returned if the same key is requested twice" '
 	echo "references.format" > expected &&
 	git rev-parse --show-ref-format > ref-format &&
@@ -50,4 +64,12 @@ test_expect_success "only one value is returned if the same key is requested twi
 	test_cmp expected actual
 '
 
+test_expect_success 'output is returned correctly when two keys are requested' '
+	test_when_finished "rm -f expect" &&
+	printf "layout.bare\nfalseQlayout.shallow\nfalseQ" >expect &&
+	git repo info layout.shallow layout.bare >output &&
+	nul_to_q <output >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

