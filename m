Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067322;
	b=dg0elHPhhlychW1SWs3BjuAvfCWu3YxgXvt9t/ysH+RYgwwpguqpFUVBe29O4F81j7bB
	 PetZX5Df6IDw2cixAGtiqeyT2s0avaWmIeiXvF+rvm37sQ2BdHmxEJLxa4hfJ8Of2/vwv
	 hpiuZAljaVwJiA7yq6MA09dK0kcOL8yqEMSFgWr9IafBTx8eIXEwUA+cTF7F7a5sykl/T
	 YeadU3BJUlY6ayFPaEuUCKoFf4ZGRQ7tMrjFm2chfazuJd0C4IDhcYES7tvpwsoNnViWZ
	 tOr90Cf4gHi5vptRTUT0+iPpb2AEw5Ds4ihus6vvaCPibHDLAUx/0i5NV8QKB1rNeCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ggCxabWpclLTSO2drgP3ee6SyMTF7Q52CvqifG614d4=;
	b=j5uvxihPoWlj1Xbq65xhvYq+9DZYph1ka7cHWqSmgWiqYkIHWOY6sjAyOY7Ct57aoPa+
	 PJ874BMew5GZAl42qh9PlSDTjV33JTj3F1pAZMM3n7j5YcopJUj3WcQ8lJ+ulIDcZOO3V
	 YJFlGXQuwFcQ1t5+4b0whZ2d72vDhW1+ffP6uqoc3jKocCy53IcNIyHV+pt4Cq0UZB8Ac
	 puqMrg4eV3HUY53tAlqIVffrnjgCe3iSKBmI3wbAojhh8wkYK9HxLLZqocyuviI78xf/4
	 sw8xs80MjWIZGh7+SxPGEsAjZE0BbM/r7Ca4+t1VVK264Kn0SlTEeeFynHVnHZoRADg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2secASQ;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CC606A32D
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 138CC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2secASQ
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3246994c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067321; x=1794672121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggCxabWpclLTSO2drgP3ee6SyMTF7Q52CvqifG614d4=;
        b=Q2secASQpK73JHbqECNaQdwYCgVhaILpAMH8/yOREVSEyoQnLfgZm2942dnhZ2/cLE
         IwYdxtZ98/UyVyVu3cTqrK5F1sAdkO0PL/DBSlVU3ClTTt2c76V8zK+eF6FJIX7I3y6g
         HmXKFVRw7xIJy/WA8FsFG14MgJckEgPcZrEfPgxZVbFH8lYVzaubAVYW59IChlReSn4d
         n40u4jua+P8ltRKVVekxPpgTeTR8FMhMdFeSSakobV1Xqctg/7izjKaYlOft2skZKiFd
         ho41aQ+Xjp635gUHt8A9coeqtxBmp4AoBSVmaQL2AhEdqIAo4dJCDeDHSK0xndaPg6Ny
         Vcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067321; x=1794672121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggCxabWpclLTSO2drgP3ee6SyMTF7Q52CvqifG614d4=;
        b=wY1wiTLNvE0aATAiKUBYdZ4pOhDn2OrsKLLAQ/EPZc/YDaHEOnqUQ2RWNgI1wDUTTO
         ykS1ibV1Ut0zp/+GHl2TpkgDoB1W70iv4GWrgZp8fhgRILG3s5/ymqWOR7FuRejnfxjw
         11IZ1bFQlX14BvMYpIJ+2hN07dwbY6DDfBI+C3pGX4OSVv0b4qCd2B8W81dln+ds5iyq
         nHo/7mkDdyw2Te6THicxlXQTRrkfgmBSlF+BS1ZZPozDF2+uB+zJbaFNzG+Q3DNykqPy
         VEr/dIqQFfrogohyOCR1FaYy7tjSZqIXAKSjQVNY0xm/iM/CZirbgdypKFEydddWZJbv
         sZFg==
X-Gm-Message-State: APuU4Z9UHTiX8u72Qj1+vSP/gpp7YLu9G7NoTMx9q4oiMOwToOYc8Ln1
	3to/ZVJoHpJuoPY/1Myg2si903wPIryQs0+j/ZZsGasR943uLQInc51B
X-Gm-Gg: AYBFou0rUgo+CytROsVNtN7gDVyBuSGMj/9MqAzgAo2mBtXxaDCn2b1sdFvJri/AnUg
	LipYKwPlF0PUJ2TDlLCMWoVmmYWETXE75HfJseEhsz4tsRhWH8MSZYDSecadqWU6ZPwg0uTHoO+
	lQuufoV/QfMCmATntrWJZbcoNaEMuQug2Vy44egpi3Ghqa+13TkznwDvSqr10jev6XTRSgvh4s2
	Q50Fw8rFa78PchjGlV8TNN8vmGQNhtUU9IJktUtUTsSF+3fX4ZVy2qkXzlL0LzDF1n2n/LXIiC3
	Gf/2Z1qmpkDBoNww86YMaLgMFUjDVbNTZBXmWnIhLiVlcrKdhwWDxaumjn5owSI3OwILjtBPUsb
	pSp/yEGoyouc57eoeaK3l0oRpfgN2MAogulXDbIHW5K9WXQ/PNJGOl5GN+ub8GMJ/+az/PpzIb+
	yU3B8bFpXsFz1xu3O3tVr6zxB3fLVrz49SVieOrjjncuhZ9/oqEvfwSk7bV8IRTVUlsRATULcz1
	A6aN8rO3JtH853U9S+mgnkkXNAuAIbBUHlT1yRWlrWWub+C6ZUuRukN0KtJ7QMJZgUf7arKLkMY
	xKAYbDYuF3n2ePEuEaNPjU958KpDy4B4fUGRMgRoraM0pJ1NmE4naI1p5fpVzHEacBcqcCnzQW+
	P6RHJNeRDZAiBYtm54/vmq8kxdfuzGshvsprd
X-Received: by 2002:a05:7022:b043:20b0:168:3243:c911 with SMTP id a92af1059eb24-1b25d35d272mr8440713c88.37.1794067321120;
        Sat, 07 Nov 2026 08:02:01 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:02:00 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 4/7] repo: add path.hooks with absolute and relative suffixes
Date: Sat,  7 Nov 2026 21:30:57 +0530
Message-ID: <20261107160100.122243-5-jayatheerthkulkarni2005@gmail.com>
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

Hooks are an integral part of a repository's configuration and are
commonly used by tooling to automate repository-specific workflows.
Currently, scripts typically retrieve the hooks directory by invoking
`git rev-parse --git-path hooks`.

Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
`git repo info`. This exposes the hooks directory as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 30 ++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 25 +++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e524a07f53..526a4ccfbd 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.hooks.absolute`::
+	The canonical absolute path to the repository's hooks directory.
+	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
+	set to `/dev/null`, that value is returned unchanged.
+
+`path.hooks.relative`::
+	The path to the repository's hooks directory relative to the current
+	working directory. Respects the `core.hooksPath` configuration. If
+	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
+
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index c17a8a3b35..739ac2974c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,34 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	if (!strcmp(hooks_path.buf, "/dev/null"))
+		strbuf_addstr(buf, "/dev/null");
+	else
+		format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
+
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
+static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	if (!strcmp(hooks_path.buf, "/dev/null"))
+		strbuf_addstr(buf, "/dev/null");
+	else
+		format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -182,6 +210,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.hooks.absolute", get_path_hooks_absolute },
+	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index eec576a1d9..5fefb0ca79 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,31 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
+
+test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
+	'custom-hooks' \
+	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
+
+test_expect_success 'hooks with core.hooksPath=/dev/null' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+		cat >>../.git/config <<-\EOF &&
+		[core]
+			hooksPath = /dev/null
+		EOF
+		echo "path.hooks.absolute=/dev/null" >expect.abs &&
+		echo "path.hooks.relative=/dev/null" >expect.rel &&
+		git repo info path.hooks.absolute >actual.abs &&
+		git repo info path.hooks.relative >actual.rel &&
+		test_cmp expect.abs actual.abs &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.56.0-rc2

