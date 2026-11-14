Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674290;
	b=o5ZRKCFHXsxoR0UAYZIOM8v+7ho9eB/TMQg68B8oBIh/w/iiHQjqKcfxyCYB6ubKyCUV
	 YsppV+IEaLfPCyD8AJgOQ8SzysjaGD5a7A8Uz6gKfqZOc8jXRq3bwB1BkrMntE4bszCtG
	 6C+2Z5OOdydYXiv/pbc8vYnzV2ZQZ2lzPQrD/PZkua5XEfkVACrcOR+HQ8jwSYvVVE7Ac
	 XAOD0jiPQn73I4mWW+fD2wqxu3eKKIT/NKpMfol+jii5WSxFGjHh9bIHeXRDK+AJo3seL
	 2+u8S0WWnnNXBTjZnOG5txfxUt081L7itVWgK4QsgaxvAXPY7IB3OIm8Se/Sgoz9MkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3LdsHOhRDj3HY0pXEMzTwywpq6luzrLMZ54uD34t7/0=;
	b=NwaJkVda2KaRdT8cQInG3kFQeqKBX82LaVeOKfkgYimQgm0ejdNFsRkhIxm0h0tt1aVQ
	 e5yJJFPmS8DBy/jCxY5Lb4xVmowjD7gGZr3jQ2SePSYrEMHeTqAbZkdeLsRhnqjd2CGKD
	 27AUdn7CdSBEvpKFGl6R1wpBOFqik5FIL4gfKMPF0VUEVTgjebSeToopQfafjW7j5ZsCH
	 TyfALkVzvkGRHVLpzBOIgQUgK/X52Q4YPt1UEKBHksLkrETDPtkrLxhy9vofwbdTMuAt9
	 CYIpE3awlAsdFXz9dxFqd8hrlxyz/Iq+Z6X9w4PxKW5cTQ4fFlFHYH+Bt4c0+ztLwuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OShQ+aHb;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852C606A327
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5852C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OShQ+aHb
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2498334c88.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674289; x=1795279089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LdsHOhRDj3HY0pXEMzTwywpq6luzrLMZ54uD34t7/0=;
        b=OShQ+aHbLWe/iqFeQs44BRtlX7rA9Gt8hWG8qgPpMLPsE2HgTfXweBk4bqnnY0+Q1/
         Y5zL/RjaVgiUwIuxz8DpfJYRz5f7RsYbJwaUBoRkfaPMSxXW/P0/hrRkdAe6jkLKRSCg
         DMmN/x8O8pfde7+3GppMkMTmeiykzXyJZyhB8UWsb7qsI5iCOlTzVkwBCVdWyWXHdIn2
         aZMWW/uraMuYBw0nPvZZBRLW1aEVUNCfOxA4to8YHLudIXblBU3k0+vomX5sxjk1/rLC
         ao+TtXqnnthZOoZ+hA0N3FIvQ1fWPAjtIcr15vupkoqSSjvnZDUn/TJQjQs3o9OvSTNI
         d1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674289; x=1795279089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LdsHOhRDj3HY0pXEMzTwywpq6luzrLMZ54uD34t7/0=;
        b=rvHbZJUSr5GfffrZT7xlK5RjvsPriWckPpkGPHRX/gA5gWXgTZa9h+6ZkfwkvClC7P
         sTGqzBNu830rml7TqHct8ZrpHtCx8zUepW6tiCvpjLRWf6xf48ZsqRz9OR+1HTb8QkIZ
         W/zADfJUbN/vkzM02uUVYdAOhcFE0F8RsjWRweKyLtNzn0G8PfoaGbVkE7OLk04D9cdr
         nvhhD9xOkzMCB/gbWZdI3s9zReq0BvpgtRO+T8td2f5n7fb06mq5WDqQOdJRB3yRxTnH
         CfDIyLMRIFEwDZIjJl/07tDCVUSNcsvR//KypM9fNKU+4Ut0zqzNJ8BSYYfWkZLPbrfo
         RMMg==
X-Gm-Message-State: APuU4Z9Z5DgLwQ5T77+8tdXqAvGekTJQXOoKtotXoNDWRGlUROSsaRj0
	JM68NRBdizSXy52s+vm2/AAh3/EMCnUbSSpVLww7dEYJ90zJKAaF6O0v
X-Gm-Gg: AYBFou0YRl0sZsDgKiEeUDKa4osqSP0ogZGgvhPMw8x2/kZYk+ITzfHk27xXyzKG1MI
	BW87ncsTj3qYps99RJMF6+UhKLThOk6XFpP2nAranNIIV/mvMtqvp4aDSCeqpm6ZmQPDtU0ryqR
	ulY6+tqSLd0LR0KXgYnILh+Ti7rAyne6KzSoirJzKP6xojKB4uqMtZq58cheCVH2PWP4vcIUlfJ
	Qbhv7x5DNy7G0MX/T6mkeSZ3On1c11JxOjXKBmqTs6euFdytOw9Vf1QL9XGGGpXYH5eAYoy84Fp
	/UfZuRblPd+BrpOG1Lh6y1Y1+wauf8ob/ko4ZfWPj2A68rZYlk3Txr4C7Euv2F/2x+SleNAih+w
	Aw8pvoOks9S1s+tV4fj9jkMjcAXNqe3I5Kujuvtv6mJj02eSNhjYzqqfyJTcJLr3er2O7Bz7MdF
	iQVfyUtwvmZZf20F2R469pidY2PRTthUEgoRnXi5tPDPIY/WLrnwETXNA92xAx31DUuTTH8vDdB
	3kDcPwJ6abxYoCq+Zk6XJC7cM4eecJj4TSOYpSNknu1vx9CpJ2otxh49WfwXwDxDJynbMjV1w0e
	DaJCzCH87KPRcqtGlC9TswnIEYkcwAmh5IBlvLcMmDuZkNOQTEX1aIstbTK3AuZjh4oxeblDkmp
	LAeHQ6k7rc94PKDsfo+t9w6EPsOFQ+J4pWiY=
X-Received: by 2002:a05:7022:f211:b0:195:9228:50a0 with SMTP id a92af1059eb24-1b5030f2c79mr5942356c88.42.1794674289231;
        Sat, 14 Nov 2026 08:38:09 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm18093657c88.14.2026.11.14.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:38:08 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [GSoC Patch v9 4/5] repo: add path.index with absolute and relative suffixes
Date: Sat, 14 Nov 2026 22:07:14 +0530
Message-ID: <20261114163715.257705-5-jayatheerthkulkarni2005@gmail.com>
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

The repository index is a fundamental component used by Git and related
tooling to track the working tree state. Scripts that interact with the
index currently retrieve its location by invoking
`git rev-parse --git-path index`.

Introduce `path.index.absolute` and `path.index.relative` keys to
`git repo info`. This exposes the index file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 12 ++++++++++++
 builtin/repo.c              | 18 ++++++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 8cb154513a..c515e9372f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,18 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.index.absolute`::
+	The canonical absolute path to the repository's current index file.
+	Respects the `GIT_INDEX_FILE` environment override. Returns the
+	configured index path even if the repository is bare or the file does
+	not exist.
+
+`path.index.relative`::
+	The path to the repository's current index file relative to the current
+	working directory. Respects the `GIT_INDEX_FILE` environment override.
+	Returns the configured index path even if the repository is bare or the
+	file does not exist.
+
 `path.superprojectworkingtree.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 8b461ea226..eeaee98c75 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,22 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superprojectworkingtree_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -182,6 +198,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.index.absolute", get_path_index_absolute },
+	{ "path.index.relative", get_path_index_relative },
 	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
 	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 582f643dd1..46c92d4e43 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,29 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'index standard' 'index' '.git/index'
+
+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
+	'custom-index-file' \
+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
+
+test_expect_success 'path.index in a bare repository returns default index location' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		ROOT="$(test-tool path-utils real_path .)" &&
+
+		echo "path.index.absolute=$ROOT/index" >expect.abs &&
+		git repo info path.index.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.index.relative=index" >expect.rel &&
+		git repo info path.index.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.superprojectworkingtree absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.56.0-rc2

