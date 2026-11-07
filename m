Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067348;
	b=ojBG/FMmetxSF4jjCdDYZO+pk8Mq1hvi1lWrNwi5lqdqNueBTC+tNLBcdJhsmP2M7aYI
	 xDjEA+mLLeAXKPLcHW2I616dcz/iDqB26msRe+OVHAZO4yc1rAmgBzsqdVsEOvNyHCjs/
	 7vmLw+yz2sjt7qK0p6I/UbwgDNLC9vGZJbCiy4Eoxb/brLfbUbYnZw9TyeQE+rxcdrD/+
	 GlbkD6yq72ym2bng3mK+shJp378Z6fqKl4E8i+d8biLJzOEWg2rZTRqfdEKsEhMl1+54c
	 cwkg3JU+OY8f/h4lIsUpCBB8SLjGq4PaR/v4yvHMKpfPvqVXyXRDSFmmX6Wz/LYa2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4i1u94vMWVPdihw4FIpmW4qWKG2UHf0vHwqHXy27Eq8=;
	b=YYvws6YRxMcA/B/7lp5P5by5yB3Ffbj+jyoIZny7axYdXm4DZ9N974OCmv0YF4ZF/m8c
	 T3/+EHbGr4/oK5WFAQeVTb/kqH1KTQMllbyW6CGIxDBUfBL2Ig1WiarnuIT4yt8g3jVBE
	 pHsRdONttYtEMcQhB/nlfYsCtAS6gCDdJ0FVbrVOAMHE0BStaLFp0C6gtD99K1bkOr+42
	 WNx+jH9LpvUTFJCBXf1BxGMug2YPm4+eshjT3D4p38lYsP1MscuZqCZzwZim9gB0SCjuc
	 zVl63EcAlP2imztP0MgK3AqVFvd6tGrlmjercfsBcfTxIRRlbS5fMCnT82rT5suQomA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpEcZ+yT;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6E606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB6E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bpEcZ+yT
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so2846141c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067347; x=1794672147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4i1u94vMWVPdihw4FIpmW4qWKG2UHf0vHwqHXy27Eq8=;
        b=bpEcZ+yTFQMJOg9n5kWXJrxo6R8lUfdSlTf1WV9tTPqAaxOqZbeoED2Gakq+h0l+sp
         gvfDGkzM6bFtE3RDenCqeXimD3YyP5NiOyUd3pZeTUiHl3APh5tspOtOmQqPEMRLLieN
         sTBxdFk7ZcNg+7pUbnEMjTpW1bk2z7SCmvz0hf2KP1GQa0X64Cijp5PlXbnpb1Sc3CW7
         ohOCq3gutKBzP8fjjwhP1Pwjr6PIIXi8ChTAXoWYtC8YRSM3yGZNMxY+OHzMQD1XG31j
         u4UEu78wOgqcd7jyai4DnId5PiSCoPSiWaL/M1FWudSWWq+nNCTJhyaAuw/GQcJzFnSR
         2zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067347; x=1794672147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4i1u94vMWVPdihw4FIpmW4qWKG2UHf0vHwqHXy27Eq8=;
        b=mJXRkzVByOhJhdlXGggEKVw59D2k4hDUrnV2Co9wg7crAm3wT/H2yLcmMCrRjKkfbg
         H+s9wlwUazm++HykryPbdF0pxioyEsXp4cJxIQSYGn72wyX/dRT5U4YLYHsbBWo++7iu
         pRZu/ctCL0QaAiReON+vMt43uyTBbq6Li7nhu6BkdkDVlPz2Z92kMS3IfW2BVJ1Kc10t
         ltrG1AFQNQOundZBn/qdq1N194tqaB7U2uYfTv5WQdnRzUUjnKa6aITFjyF3mI1Ua1oB
         QB2tigAnLDkztMscAIVDwIhomTVibQ561j2TJwQoQn0aq+Eckxe6t7kp5TI26yZxYg52
         noVA==
X-Gm-Message-State: APuU4Z9grngJmZRNjqEzEzsA9w9H+57fmicajYo5uyPuIdSxqQGy94cc
	R6XTnMN4+CYyvzN1yJw3L34f0vwHu6QvH4sB1KODoIS2fcQ5HduYXRru
X-Gm-Gg: AYBFou3vO0D8YIszGtyP2l/TJfvgs+7s4KgNoiaezeEsDjVYTrcLlniUohxvUmcQ6zl
	/vNkgsZkPL0TdloPCT6VZZSTgPdcJXLEeUXbTNlFG1kfc2TQNZ8zHa4nZ9tSlKF/GF0phPBWkyu
	DVtYEGHNyZXCZvp28HtwJQnlNMlPzltUPfGGVzluTps3DQKztxfXtUDiN+fxE89fbE/kNyIc88G
	yLKKnuxmLGTJLL9xRYb3rBO9gAJdm22sgRgJaDpGncPBf4hLIAWimFicMa1jWYC9ZpuAdMxn4Of
	EYj9JJ5BEOBkUedYlIl5CS7llFLiA7ECJUmFBjD8O4xIc7TULR6fZu2GP3lvT07akzD7CZnVMXs
	RLPnBHXk+1XmuN4vQsalQnu/1aJDB2y34tLCdW/ckcbVdZntO7oEptZVpNAXQL0K3iRxHxK7N1T
	qP8k0RCV0O83lC67epdePpdyRynmx5sY8cgUyyMFddAA6iMudUbw/hrnIGyhac/f5vvF0/Tn9YU
	OcQGBmlwptb+bRKa/JJhnfT9uLJ/F0zKNBWmt2MJyNwuk7+g7F+d2CC+D5XqNLjV5HGTty8Lpi4
	Lb4O/N5THKvTSQ2k7fhIVTKCblTaV3HZLScUS4uyaVkWKSlRggSPWUuEKSjXOdku80YeUC8riRW
	kriu/VfWODiYG2db/04QlB942+I8bfuDiv7k=
X-Received: by 2002:a05:7022:f8c:b0:1a4:fac9:aeee with SMTP id a92af1059eb24-1b25d28c3f8mr9861050c88.4.1794067347048;
        Sat, 07 Nov 2026 08:02:27 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:02:26 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 7/7] repo: add path.cdup
Date: Sat,  7 Nov 2026 21:31:00 +0530
Message-ID: <20261107160100.122243-8-jayatheerthkulkarni2005@gmail.com>
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

Scripts sometimes need the relative path from the current working
directory to the repository's working tree root (cdup). While this
information can be retrieved through `git rev-parse --show-cdup`,
`git repo info` does not currently expose it as a scriptable key.

Introduce the `path.cdup` key to `git repo info`. The key returns the
path from the current working directory to the root of the working tree,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 23 +++++++++++++++++++++
 t/t1900-repo-info.sh        | 40 +++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index c0d595cdc5..281c600175 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,11 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.cdup`::
+	When the command is invoked from a subdirectory, show the
+	path of the top-level directory relative to the current
+	directory (typically a sequence of "../", or an empty string).
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/builtin/repo.c b/builtin/repo.c
index 0c63c0280f..3e5572f6cf 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -78,6 +78,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_cdup(struct repository *repo, struct strbuf *buf)
+{
+	const char *pfx = repo->prefix;
+
+	if (!is_inside_work_tree(repo)) {
+		const char *worktree = repo_get_work_tree(repo);
+
+		if (worktree)
+			strbuf_addstr(buf, worktree);
+		return 0;
+	}
+
+	while (pfx) {
+		pfx = strchr(pfx, '/');
+		if (pfx) {
+			pfx++;
+			strbuf_addstr(buf, "../");
+		}
+	}
+	return 0;
+}
+
 static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *common_dir = repo_get_common_dir(repo);
@@ -232,6 +254,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.cdup", get_path_cdup },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.git-prefix", get_path_git_prefix },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index b41fdeee77..a3c1be97c3 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,6 +207,46 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.cdup at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.cdup=" >expect &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.cdup in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.cdup=../../" >expect &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.cdup cwd outside the working tree' '
+	test_when_finished "rm -rf repo" &&
+	mkdir -p repo/tmp/x &&
+	(
+		cd repo &&
+		git init test &&
+		echo "path.cdup=$(pwd)/tmp/x" >test/expect &&
+		cd test &&
+		GIT_WORK_TREE=../tmp/x &&
+		export GIT_WORK_TREE &&
+		GIT_DIR=$(pwd)/.git &&
+		export GIT_DIR &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'path.git-prefix at repository root' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.56.0-rc2

