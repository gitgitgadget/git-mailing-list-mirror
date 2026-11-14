Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674274;
	b=T77w4uTTWts+a9bzm2fEKgSsjl3wBBE9+vjx+vQJbUxAOjs69+w72/bbnUfTfQYroq0r
	 0jkfEFPNYbQHK32Eg2jvAlg/xkUiqZULliJaxNHYK9axptFwVDhw9pabc4HaUbKpjzz4l
	 JDbBkN+v58G7PHpPA7rlxJXH1oa3NU5RQmUma4chf/oECKfqQvY6vRw5+LTjwco6v6FQx
	 j6RlKEq7zCTgcQwzpQdHzY9bQ6FuhBEhPnQ58JASATykoIyX1lyfgdwqVzLAENRY5GyPa
	 uHSd0wlCFUOEngnTXMC1CXWSsnZpHIeNcBnlgPfD2uSa4yMfK9LR2BqBD5KluA91nng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x3j9JMRpQurM5MvB+O1Aa7WTVd97ug0p67PX7hXrmjo=;
	b=xVFpaC8H71GMouVfJ1maDE+VIxdVe4/pwEUcYjY4g4GIIhnCgn5S8xkR1ZBnpUdQfqDB
	 bzTPomISYhoKnzbKMMmyTOcDtvdZ1JmfWV4TSxzmbmoOEQXVoJZgl48f0tDazapNKE0ao
	 OjIgkogdnWn9eIikYCTeAo3Py6it53Cvfnv2ylJYvTGqLhuTxPytEB/LIrI7ObOgAWXm5
	 n8YIjBySRtPmD7tfii4vlInuj+0rBJgIjx9KuGiTa/cWGXDYs52Dx8E9BqS1H9XqyQg2C
	 0OREL5ga35QaUvLKiV9rJJecDdwwGMhgiCqfIqsF0ArF5/uuqLh8NtEN+VPYTzIGWnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iU/91DII";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9C606A32D
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F9C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iU/91DII
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1514463c88.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674274; x=1795279074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3j9JMRpQurM5MvB+O1Aa7WTVd97ug0p67PX7hXrmjo=;
        b=iU/91DIIO+dzeFGHC/O54NNnO3bgtvWj0u4xFaFiFmSL8NjACyHqAuimIAN87pnXJo
         hna2e8YIaSBgZRuIIRb4vHU1cF3bPMeTVW3lhtTJotDiwg0gB+E2MD+vdXZksSRiueZC
         wRKUNUNQvsunLGGLPDlZzQj+03P7TDTEi1fsqPJjDvwBIWo69MAtVdD3yijow8PfoB/x
         VCTkVbFaSOP/dOVEc69RLiUI2FTaAMDtCHnVDVXBv2EkhcmMcFyiVrQaUXYOhsQ4h7Sp
         Ww+1569dRL4rG+tLzkKz5+YjKEYru9Tmx1XsAKOajY6rjboJMheje756i9d1JEJUcD3T
         NXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674274; x=1795279074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3j9JMRpQurM5MvB+O1Aa7WTVd97ug0p67PX7hXrmjo=;
        b=BrtVB09QdTgWbI7UHLlR8eJlqkCMPmSMQfCfooDZX14xEaqUNm32RRyk7kWYxKG9vo
         j8O2g9BsbJvUrTAhGn0KUVW5yzG/itokJwOaIt+ctup3S2gbcOGMtjDf4yak/kM40tRc
         WFQ+3np3ovNpJmQVWBBvAYK1y6TnbOOUQFvci+a+LB7i+F0jVZblDx9FIOmHq2GuqQdw
         EJ4QXumgtb+onuYMxCsdHdVsRcj5WoqWeRaO82MR3VSKtPsnPAPFNNng7pjOAfascZC1
         wDl1k9nndw+iinu9enUW17w4UyzPlrwOqBgyA4H8mcIaXolw/qJZci5n+Hfpl6H4n4tN
         uj5Q==
X-Gm-Message-State: APuU4Z8nGljhl+unVgQ2yQ1gqejszUnrLMPQdX6YGlMMEvSj2+FV1SJh
	iZgTnCx8b4jqZ7xksVqBbXqv+v86LeS62D/IIW6BBe+SoR1k47C2K1Qt
X-Gm-Gg: AYBFou1lQeAufFGVyzE7X/tNtm3SOtc3/R4RfZjZ+53H6Zl7GRKXHW4wsj+Gov8igMu
	ce/Smq5GlSViuE5pLQM5l/aO7CIKdJj4t/wk9JucD0Sj4nW8YzAno6qxn2er4Z6aH42cSP1dwuZ
	WGgzpxSmKLYzm/q3coNT9OLHmFZsKga2OGnTs2bKXlQP4J8Tn+CgD9tw2XMbjqwVpt9Mrvh5ORL
	de3Sty9kvxEODWQy6ZqoyqX+eID+YijBJCOMnA6f/qKhl/THKIKBEKX548tgLQ+jAm6ovfjnAPm
	p+j0ep/jEUwzH8zQCZrZZgISrRpFibvdBx0njCx8iGnNoHcSzBgqaEr1eAp1zQqYwNV7CRiyVvg
	IFoKH2gqjMtEnjBXXftKZeE+fI02+rF/02I6WxHXGceeVpPPbVPHJFTSy5+BWbFf4rhS8NIkjXP
	FNVWiYMi2LU6EkRSWIJQLHzk1elqpCjq59BV3nqUHfRSOztM3pVXP8gp7Bx4u+MRQN5jgTa9X1L
	DxTCzQSg+X6EsUX88BCSqB+XyB6bjAgifrhMCZLX7sy6jiRcBECRQ1kwLZZHZKgfn8mZDGE8HJh
	3a0A4KE/FKMVnFVpzAvio7MQBYpgqh8ZeXUPPeUdeEeMaNOeQaA2iM2GKhvGUNOOo9W6EugBaXH
	bZEOxYvrmPjzCvw0cmvZIjrqOgXdwCWvzm+y+ZYx8/JapC2C+2rBP7Oku
X-Received: by 2002:a05:7022:1182:b0:190:716:4822 with SMTP id a92af1059eb24-1b50308a4a0mr5060393c88.8.1794674273495;
        Sat, 14 Nov 2026 08:37:53 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm18093657c88.14.2026.11.14.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:37:53 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [GSoC Patch v9 1/5] repo: add path.workingtree with absolute and relative suffix formatting
Date: Sat, 14 Nov 2026 22:07:11 +0530
Message-ID: <20261114163715.257705-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
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

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other repository information.

Introduce `path.workingtree.absolute` and `path.workingtree.relative` keys
to `git repo info`. This allows scripts to retrieve the top-level
working tree path in a predictable, strictly formatted manner without
relying on `rev-parse`.

If requested in a bare repository where no working tree exists, the
command returns an empty string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..82bcd8ad2e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.workingtree.absolute`::
+	The canonical absolute path to the top-level directory of the
+	repository's working tree. Outputs an empty string if the repository
+	is bare.
+
+`path.workingtree.relative`::
+	The path to the top-level directory of the repository's working
+	tree relative to the current working directory. Outputs an empty
+	string if the repository is bare.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..9ec8623a8e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_workingtree_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_workingtree_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +159,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.workingtree.absolute", get_path_workingtree_absolute },
+	{ "path.workingtree.relative", get_path_workingtree_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..3225fc8583 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,39 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.workingtree absolute and relative' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.workingtree.absolute=$ROOT" >expect.abs &&
+		git repo info path.workingtree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.workingtree.relative=../" >expect.rel &&
+		git repo info path.workingtree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.workingtree absolute and relative in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+
+		echo "path.workingtree.absolute=" >expect.abs &&
+		git repo info path.workingtree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.workingtree.relative=" >expect.rel &&
+		git repo info path.workingtree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_done
-- 
2.56.0-rc2

