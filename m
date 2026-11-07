Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067341;
	b=hzWIe8vsFXkecXRuZuolLdzvamW4RkRLEgFgRvXuB3c/LF/mj4XyoVwP+ZecubQu5c7Y
	 1x383rVHdInb0L0y+qDJt98gcvIHvMkhhIYb33hSwn3HUUbT1WeRW4IvVBkHacKFpOu6d
	 siP3dbuCAFJKYYiJRMlz6y3aAuVIy8Acz8bg85E0Q14yCQgimbxQlHF6i/43qDf7K4k9y
	 y3RSXUhDU9cu8hk3qfnu2BThMABgrU6PWIE1oWli5QwaKpPaNdHMbhhPdIDOylodBQKZG
	 ZxlkrscRGS9GKsHDlLo1g1RwbMPT+3y3LDQeXislPMXaIvWfX6fYIz9DrRUn0hh+Nrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+oXGv7Y+ed6sD9/D0FZxv5dUlrVnoj18y5q+Lqb9ZQ=;
	b=J+eCdO9KPVCcwfnxvjD8ho2vv4siZM9rGbMnme1sKLTDwiPr663HAVz2iktoP+mDGd2+
	 H54Dhn6hu38rIvf9nkPt5moQSkh6cMseJhDp8PSSZ4rzRI06BLGmnzBteVNW+07DHN74D
	 CEg+y7SWs+ZHhU5P7j1jua+sLvm4Fo3N4g0W6NmQzpKXbO0hP4V7XG6YCC/GvpeFg/xAz
	 Yr3PWmwoM3Br2ZzP9sgkKKGbmlvNot6Um8EZT2gxdaDp1WNECz+tgORiZkITl06fCjLng
	 LWGx5Tqd5a4vbpYp53GozNfazLCF6zzu3iHp33g3dIKtux4J6xTZT7+UNWdfLNsUDyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLXWpvsA;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F15606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLXWpvsA
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so2042109c88.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067340; x=1794672140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+oXGv7Y+ed6sD9/D0FZxv5dUlrVnoj18y5q+Lqb9ZQ=;
        b=lLXWpvsAwBLq66jv6T2M3hj+rqZ8x1BfiXqVXoQjLIUPHh8q+iZpY9xvARgab6PVwU
         HUo+xheuIwFNnjm1mdLX+yx8VOYoFNOt61BjSvQl4ZbGZjW5RuacHZxJxpATPCr54S3V
         oebTieEKQpEvWbGD6lxHlTPw15/7rBLjtrmYhfl9EjiSnBqf2Pg6uQ2VH990YPzTygj6
         d3yxH1sYWiEkeL3v0vnyK6yym18D97bdn/YaEhz8bDz5Co2TM5KotptJdbX1ZXiUggmr
         efziCaitgbAxFN1czUoQFtRqHjM/9/MWtvCxwzAuH0pSB4wGQwGfvS/hKONkUgJRGqTF
         b+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067340; x=1794672140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+oXGv7Y+ed6sD9/D0FZxv5dUlrVnoj18y5q+Lqb9ZQ=;
        b=vV5jIW/ZjUnfXzWmZmUK28awv9gA8iy2Snh5u+uOCbq9vLFGl9jh6ILTkCWXTFjjro
         wDSTIAAabxn2IMNSrmW4W6/Iq17Erb6AnU73VliYxbrT1NgfUGcRQfYPEMCErLiDHWOR
         SEXF0F8DaULTFUdHwh4EcotWIJvm+6xIjpKXpPxQ2DGQk/hCZPGBPf5I0K7gNoko0vWH
         volB17cti0P/nZ1keruh/XLvgjem9R5v8Ord87SmQtT2l/MiEql5HP/1KBRYNPf7Upfw
         jVp0Oz02PTTGBN1x0X0yfaei3Zc7186TtDs9j2tzj2/EJoi/VU/b9m2dBwdE9asaxSzv
         D6AA==
X-Gm-Message-State: APuU4Z9NI70lhJXMaCQD2UimjHHufOK6XWsFW0EufuWxsTcSjzMx/bcr
	+EuH9vs/BAlWHE25UW2pR+kWkETRYUstBKX/hszkCdgHJECYmvninMc6
X-Gm-Gg: AYBFou3Q9QQi4K6rQZSTOV26IHe9oN2eL6SrwpHCsLgF1xGlvRsZmjjcXiu3UQ3DYNa
	BTFIWSnMUyZvnjCqim6OXZQjHnFxV01qg1TiWZPceMTmBTMwE3Hbtr9+B8h85XLSFVoscyDo5QZ
	ABsMb3Qoj1O9EuxPvBwUzYzoEaxs87kQHi6+GHIdfKo+Co66q1uis3BXncMzf+0xMwfEclLyNdW
	EX7FaEkFxCgfxbzO9xRdnYJUAHM7Mx37BHmll3zj59LTs7Oxo24Rep6keqqzT7l76UryLsQk+OJ
	yyCCdNawjrPkhnmL5HMStCJILEI8UxvB9RS8OA87Y/lhaQZxZGWh++oDV9BJVRWF1cUL+7BTPOo
	jCg5QiCCLSM7zpvgDtqrSrnV64V+Zn2kYKPfyEdQSOhvXvvfd8q1IOTIlLAWQ8JQ34WU/v/kAK9
	6weWSahQCWf0MdNY2+w/fNqfiAGm4RKNSjVGK99kIvNWolDiyrkRKEwOZ+UAaqDHED4X/OlC/H9
	XaXgeETVstzmSBQ/a3uzKmgrpiziWkbT6fqr9BlZD/qJDycxl1but28iQE67oTmTo/Eo3Pgvy/M
	TAhfaDPeLVbo1QQM7d4gq2PWl8pvl/SdJoe4X5frN9b5VYNEEsmEsRMtrJhmZ9j4n4nxX63DNtr
	21WWQEmZGN2UkWrBg21ulg2XkxK5clUnAdFgxRBlUfyzR6Gt7AdoIfRVI
X-Received: by 2002:a05:7023:a86:b0:1b2:557a:aa12 with SMTP id a92af1059eb24-1b25d315d44mr9390513c88.15.1794067339822;
        Sat, 07 Nov 2026 08:02:19 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:02:19 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 6/7] repo: add path.git-prefix
Date: Sat,  7 Nov 2026 21:30:59 +0530
Message-ID: <20261107160100.122243-7-jayatheerthkulkarni2005@gmail.com>
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

Scripts sometimes need the path from the repository's working tree root
to the current working directory. While this information can be derived
through existing Git commands, `git repo info` does not currently expose
it as a scriptable key.

Introduce the `path.git-prefix` key to `git repo info`. The key returns
the path from the working tree root to the current working directory,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 2240aae73e..c0d595cdc5 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The path from the root of the working tree to the current working
+	directory. Returns the empty string when the current working directory
+	is the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 859bd87617..0c63c0280f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo, struct strbuf *buf)
+{
+	/*
+	 * repo->prefix is NULL when the current working directory is
+	 * the worktree root.
+	 */
+	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -224,6 +234,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 140dfbe68a..b41fdeee77 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,6 +207,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.git-prefix=" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.git-prefix in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.git-prefix=sub/dir/" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.56.0-rc2

