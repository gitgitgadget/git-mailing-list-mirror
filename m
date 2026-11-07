Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067304;
	b=nJfPwQigVNLi7xfqt55dQ3YkrnqLMrFuZxEMSzMbZADh4fFS3wZ6p4WxRV18diVG8h5A
	 NA1+Df0y4E+l5JZhK9LDo8Q/B3WOEQLoxag3nX2gEeUn0a+ol+HUaQUR1t/buR3ISMmM2
	 f3ZxvuZM0E0TrbWOhOgnBiCHuWS3r8DwRJTUre2fIBsUtenbI/4FlmiP2o2dCHhruSR38
	 V96smibKSJOHfZramTkg1Lhv77Tx2cjQp6gxgjQZ1wg0qhtTE6+j2EhBXnx5MhTjGitYo
	 DiLO/aTEDW/VW5yILre3A3mi/83HoO1527lz1BCnbtesk/sYtCkbIu6A4GPG6spggXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4wgBgVj3MUo1VDPUzvH+Fz+Ph4snb/XERY/7VuHoEYk=;
	b=bFYHPqZ8AMrEGZDFoB/jbk6H1M/wF/Avl6N+Im/AIpPij76IMlbD8nGgiOxKEyhSLrxS
	 E+5GNje7vG8yM5PIBP5BQSzdv315Ndu2S+RncKL3tPlNsQw0wL5RMdNtrMBn9l99dsh7P
	 E4SWguwEr16WiXM4VGRvfsprrE0EINxRKLBLNgvdA69d/89zT6ma2YAyK2Fpx4SNQEW9x
	 SOc7blvQoiPnQH6/wNsGVvOsPfiy7HdaR38LzK8LeGojI9mLLpRygqTY7614unM5AtxCf
	 K0+YDRHRPqHcc3/JxWEFOtb8W7dkgnYzk7SRJr4pPnWy1m6bI9kBoqwI+6x5Hqv3qHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhQEvFBQ;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8E606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47E8E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhQEvFBQ
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so399898c88.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067303; x=1794672103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wgBgVj3MUo1VDPUzvH+Fz+Ph4snb/XERY/7VuHoEYk=;
        b=FhQEvFBQ11N61P4T4fSF6wgjBAnwBSFQsHYjuJTFnsiPK8J7kVXIaP3I9PachK5NtE
         hgFOvKATIyh5eE+wumxCyqQAhMh36WLqic9JH00cSMdgzlgNg+sqvx63bccgFuBomcco
         iQMmNLDJKOVSlb3nAvQriaUFRX6W/h/7x6UVyOSJtqov0OBZsws+bOWl3FwqMG7DteZA
         9EoER7O7NqZdQqiRz/+vhtdv+XkImytd1VQmN7ynwdfpgbIChHrL1yWVsArBR2GMBgzo
         HcuoTAMKhukwVFxIg5JF2WbhUKMhewVypZ9aQV47Os4zPwiv/zo7nuXOlyN1geBmkmFL
         Gs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067303; x=1794672103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wgBgVj3MUo1VDPUzvH+Fz+Ph4snb/XERY/7VuHoEYk=;
        b=1FbdtbXNevLeFf7dYBiv5YRXtTFy8S225Ung1l2iSw2nzomgYG3z7ANseCfvoiQega
         aduMcuW5zC8Ckfm1GUZbC1EjDcdWNGGcT5IOdaFsKeDWZvfUUPH60KHVQ65AlcCJUJuM
         U3ltBQ5/NALbfLUR8dE2brtOAPb+xhJw6mYpzLLXs+WGsJ2jnvfjcqqgM6fpxsNYClMg
         HItVgURqOipW4q0tm7q7YO0c2BbnVd03Q/BZPtQFWjDqj3iux7hgZEb6e7GzbSbYLh1l
         FKgj/IVzxJUgTKcyIU6PEQ6qH2VYb6x6kfFPjL5PF3J569LM1+lQ7HmanxSou8hoprOm
         ouDA==
X-Gm-Message-State: APuU4Z819qGmnDlpIA/acxPo5zyscOSx7J2bxWC1O1HDek7YsjhOUGOM
	Jl5DKYYkWbdGohnc5jpGo/6AKJuGUqJUZXVSACIdg3MD1bVRTFfYLXd2
X-Gm-Gg: AYBFou3mNpVBzBreXly5W4c3FGOe7z2ce0E4+69koUOVERfG1bo8/5a7bHcAcJ56ocF
	shtsmIwRgSH4z4gIs4RH+eYYh3rLq2hp5ThbmN1KWgtZOK7MrFPgd1VxcgPWy2ViWYjwHVGHgQg
	RhxT7X0QycD/8OMIYbuEXajFb9t5uMpsauaJ5AGWZbz+8tFBq6HAwyf7XjosFJ6TfcRZTwfewTS
	Kkbg0c85Rh3eddcTYcJkrWggsLDH9yriWSqAM4LbEuCU2oFZkseYdWuKbY2Wm6XnumjJ9sTxych
	V1Qqd5gnZkHOc6bLcaonAIPgZomnpLuS62k0I/Aqkkb0u/pk5PDxzlwafUDwosPHqbrJAOc7JgV
	/BKJhWhjSfsrVlAZKVq8+gTVK6kBbMRuFHT/S1RaNMag9eZGRYoJwoFrd22yJclt8NtGUFx99yZ
	DBSZm0Ws7qbslD46KXmoE5Y6eMgPEMtuf0mnOGAQPUmO8oRrIKpWXJ6GKG5wMiPQPMm4a+snsrs
	tBo3/VOb3aLx2YED5YXqtLeQXCY5xnD4+A5SD7yeys+WDCO6h6EDz9szbWyY/yIPOgiSYqSQ2iy
	xTd9iP8yECtOqCQp4FV59zdyiyCgDCs9n+rGzFbijlo+NLd06mH3eH0qXgOxozT0aj853BtQU72
	ucPYjpWAqHY8W9gVLNnTLbCxLiigXrvGqg9s=
X-Received: by 2002:a05:701b:4282:20b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b25d30af49mr7880372c88.15.1794067302935;
        Sat, 07 Nov 2026 08:01:42 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:01:42 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Sat,  7 Nov 2026 21:30:54 +0530
Message-ID: <20261107160100.122243-2-jayatheerthkulkarni2005@gmail.com>
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

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other repository information.

Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
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
index ed7d80c690..e34abe5fea 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.toplevel.absolute`::
+	The canonical absolute path to the top-level directory of the
+	repository's working tree. Outputs an empty string if the repository
+	is bare.
+
+`path.toplevel.relative`::
+	The path to the top-level directory of the repository's working
+	tree relative to the current working directory. Outputs an empty
+	string if the repository is bare.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..c31e9cfa70 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
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
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
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
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..9417d1ab65 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,39 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.toplevel absolute and relative' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=../" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.toplevel absolute and relative in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+
+		echo "path.toplevel.absolute=" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_done
-- 
2.56.0-rc2

