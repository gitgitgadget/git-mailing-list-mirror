Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067329;
	b=b+Kk46ycuvReBfUNFaYgvAvnm/HV14h2iVkER6SZhcbyawAmbRsf/eU9i1/M3u0To0eu
	 OcmYN/odsyiPkNfOlt82Q8nqo+GgsFgBznh2q7knT84rbWtSwWTFD5R/3fCl8dCvceode
	 LyxFAi7zID88J6AcUpyy6A5ID+OL/pThRWkGTamhX8ulJkFJUpKBDGPEMAbs6+mrhgI10
	 tAV+1IXyIXMQfk5hKkpLcuiHUv36xDsx+e4RcZDofP/CgvXhR7At8M/zY/s3+APoYRx+g
	 HbDjQkl1ZlT50rdK5pIwKwvz63Fbk+6dZcpMv2CF1pSLpaz1UwT0M8pTXs7FeH/Npaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TEtETgOlRO+bzDmDV0VxxSFcEVJ+TAjCqE9ODF5hI2Q=;
	b=0CMJNOQbBnZIneVfrWYwa6HjfUY0W7f+s+MOWG22AluExCYbLlk1ymt3zun5MmfRTOPU
	 hVlxPDoaGbkPYq4OabAG1enq/DzXJFETLMMWMqnHipmvhetgH/pVE8Zu5kOKsCrs7AEbf
	 x0jetSvLmED31WxvvM8dJBtOqBV0XzGlOaWRBfpIAexNeirUQaT6zEbuv6J0C1Au+KbU6
	 JsR703WBW5K2qH0z15X7Crf/gLkXUT8opUHlD4slwmAoQj07kJMNFye2AqlUkNrf491oy
	 eB0yxD+7pDXwhQ1e8r201g3fCv3GI/ojxql+ew4aRmTQLtUstcTmAplcgugM4g1o/uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ogh7i2uG;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754F606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D754F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ogh7i2uG
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1556567c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067328; x=1794672128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEtETgOlRO+bzDmDV0VxxSFcEVJ+TAjCqE9ODF5hI2Q=;
        b=Ogh7i2uGgf4S/VGzrJjx1ZNaJO45q0iU9kfqXorSLwzfYlDqQP6i0HLbIjjRKtLROR
         24ycHMq6i9Q/PDS8la0pC+Et0EbbCV0bxl4Gw97viayULtvz9LCXTs/aLD4xdK/RWfwE
         RM9q0hF2F00MC31RPUkuzFf3jGjbXRxF5k8MA8XeYx6rbcq4ZzH4xwUTrylYcdBAkND9
         H0dio0Jr+cUXzYACKLBVq2Orz8oT5bTGOJ592VgIQGkolCaiqTmenk3yJbsGQ7vOTAXY
         0QUwiuOvVtIdHGE+EPbz52nf6Tzj+u6XBwXUR4DboNm364KzDxHWGpbGt1tIf076iUPr
         As5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067328; x=1794672128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TEtETgOlRO+bzDmDV0VxxSFcEVJ+TAjCqE9ODF5hI2Q=;
        b=vJiuL6+NE/kZ7gNvoz5MwyCDHLcHfsyv+Vqo27LGIW+cpWdoCvRE+BnSHcT26QvAkN
         Qyt2jItMXIgvxJjLtXb0Xkl73YkswIDj68CU6YIwApgVzD52Hc2dbyJWsyMYEh5pXKr7
         pSm6jwadBoAPdy2avPAAOAezB09tOVYtVTtQytM2DbrVLcOQovqRyoLLBLoHLXG5TZxg
         FioMjb0tVj7poclhXJURpSuPy/IbXk6w5U3AhEe/Y7nJCMSd4HVnZ4Z4oMyfvxrxkiAr
         5pYqH+0qV73xBh6ncyXrTLlkYm9ptjI32PDcimgkWEN/qc4ALqWKz0sEM4d59G0sqK+k
         jOaw==
X-Gm-Message-State: APuU4Z/4oay8dEtYCpy75PXbaJf7i7kJpPzoHh2SUJqIhggVcFTMukoX
	S/pUGog6hB8Fq84w6u0GlF4b00XxncGbalnc5NxaY1vfkQmvSJbBYOX8
X-Gm-Gg: AYBFou1QDsA0z1Y6Apd9q0XtNPA7DZpBB9cj0rhyTkutmI7cgNkQfp1TofXNc7SHWGy
	REjinMYSv+ctdIq/Rs8VkO4kMLozcjmHWhcC7wqQH1SPeSE/gi34ADgrq1r8E5LsIIvk5k4OMXn
	6WP18cBEYXBMchiHmaCAeuCEXaPtlh3H9/PObYFffg4CfwNLmKhv2Dda5aJZ4vefaE0/72CrAHB
	xny3PBjmEtURQ63ehrVwiaTUn+ui3BWjb9HEEqxwbsWrGW61GV4AHXMcbjrhB9BZVVIBrdC+MQZ
	D2IAHuaTg17OBuucLrbI4tH8f3U2JwhpjGvsJ69L+DpgSLNDc7+E9q2jxNSpL6OVEDIMqDx0XQl
	PBzNosyxqdaRG0xBmUEOlKDoZmQYsosOhbBw17xFjn+Evb0tv8zjL/9ZGyS+RkSfwWN4eWDeN8j
	bAK0iXM6IptihC/je5UCETaL8OFSXqHvEDpeLxUlu+K+nPyi4HpA2UEVEz0CXCvfbC8yDITk1Iv
	LJa/S7m1jf8rmKv3xYuc7hzxfbse44mSO7moyaKwDTi6KNJ5rgyu6qzv2SRyvD8cg0R41YCsCwD
	VJtKhIoW2NFWXBsPEwZp313XDxtGsqYk0djukT1hjl2tKqBVTEQJv3AyEhVIVwpWkT3+429Rjqd
	j32Puqy0nJNGzWSeY0wr0JP1oLKXNJfn8Ncs=
X-Received: by 2002:a05:7022:4588:b0:1b2:42eb:7e11 with SMTP id a92af1059eb24-1b25d33008emr10465387c88.26.1794067327761;
        Sat, 07 Nov 2026 08:02:07 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:02:07 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 5/7] repo: add path.index with absolute and relative suffixes
Date: Sat,  7 Nov 2026 21:30:58 +0530
Message-ID: <20261107160100.122243-6-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
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
index 526a4ccfbd..2240aae73e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -129,6 +129,18 @@ values that they return:
 	working directory. Respects the `core.hooksPath` configuration. If
 	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
 
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
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 739ac2974c..859bd87617 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -150,6 +150,22 @@ static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
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
 static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -212,6 +228,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
+	{ "path.index.absolute", get_path_index_absolute },
+	{ "path.index.relative", get_path_index_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 5fefb0ca79..140dfbe68a 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -238,6 +238,29 @@ test_expect_success 'hooks with core.hooksPath=/dev/null' '
 	)
 '
 
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
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.56.0-rc2

