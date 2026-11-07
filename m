Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067317;
	b=Fx3uKIwCyNbLmkPOXL9qqtwBL/cADW41m/7uGrKVBfMBwoX9yGIb711Ep0OlH+mRQDEB
	 N7zHokB+AHwaz130ZrP84C+UnFz1WKIoZDaosV0GG0aQpgbXpDBM9xgl4ZutNc3q0IcVF
	 3OGJ7kkq6XnhWPqvD2xdJ64D6w4LJbBOQhX1YWeJyuo9rSXxlMSwlD7nUfwWt6mzOLt28
	 jFVsvFmVR3QYi/ct0xEFVNQrN8PnB3UfCVW5BgU3vvCkzKTWEju8rVcveitwscn0PkPut
	 gRrZFOYLl7MgSvadD7Ijq3u/qJQTf+OLFNk1ad1E3zCJRzbDYWqtEr/suU2HxfXgqZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JwITyyaNl+/fWcDsfmzQJV/8ltUyKb3aXCQhR5R3LAQ=;
	b=KkKze2hCu31By0ifA+tDOMbfLqgmOAjFHnUxlKm640q/XHR0jxYnAWZA5qjgMSa0dAAN
	 gQxFgRWD4tCfE2VdjUO0EyF9NeEPARsV7U5FDZ9RoghWHnnYucHIadmpJTEudLoKWlfPg
	 sXuPUoz4vPKlOHKrl6lBTa1XuSDvtKmroek9yF15lU386ORj1w3FRxpG5um1qwqIBj650
	 jWDvW8Unw6nwxtIKQqZD09ylUScPuCfLCbg0ED3F//woiqmqBWnIUeIuHrWOBGQicSrso
	 xt5vHtkjJ6XG/lO2YRoz/i3o0R1LX+6UM+e1NHEkrFvru+8t9rwxcU7EL7VLOFw2D3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4TaQOo3;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39433606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39433606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4TaQOo3
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2761c69fbso424769c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067316; x=1794672116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwITyyaNl+/fWcDsfmzQJV/8ltUyKb3aXCQhR5R3LAQ=;
        b=J4TaQOo3Y8khkltJMpma6ly5f3JeDicAscwbwZ7XNFam4ZF9OLwRcC7sa0UGnjMN9a
         NPXC5AQVIjXdluKAMI40jTHu7xu8+Kakbyh9taItQkncTg/wTqzH30jB6TVRaLYeRg8z
         uKaSV1gA8QurbW4j3OWqkjtMBjYjGvTBoqix+d+yWRC/ByNeOuRPKYdOuXED+fE3a0lc
         aPNYMAQSyCgWKyGZadlZY9jc3VuvxQKFy4CymPIshfQkPQ4XZgNJoWreG3Xm4+vgj7Bx
         196X7ZpWipFYryeX80BZiQhC/2lcmRjmAY3ZIxn7gzgsTJI8Wab6w/ubdSnOsUJbyl3U
         wxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067316; x=1794672116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwITyyaNl+/fWcDsfmzQJV/8ltUyKb3aXCQhR5R3LAQ=;
        b=otxi9eFyOoIXa/4KbQhKk1JLgSPBXGe1h08SAYdz+ITi6EKPHcb4jkjay/q9i0b8pt
         DDma4mkDUfHlY5W6a/lkoZ+Hy4GXExKaw5iKjxQ0FDjJaMOyvrKvOUzeho9dwp1rlCCo
         MjMmW8x1IKsKysiOnc0rJ1GipNsnGtz+OiKIHW9TTbZu1LLTCy0wu8ku9OfZdQbpg9Tc
         ABvE5LaYkbWREAl73UQCs6o3cbhU5FCWrdxob+H5wlTFz2t3Xde4CXHLq+vF5M4xljUg
         KhhHeBEFvyiplH5LLsFObGNF7Ohw8IzmoRhc36vlKQMP3XBabcex3dx9GjTnIEpz0NOc
         hTCQ==
X-Gm-Message-State: APuU4Z9oILqiGoIiTx/4aN7G1UatwG4HY0Lhe3HDv0h7YBNjlr2JtGf2
	MgBBEHCjiiQqyG5BtZJh9IkCGAsNGDisjr81D1C+4OrJHWIMm7zT5HEs9Wef+g==
X-Gm-Gg: AYBFou2JN60bbCow55XvSHU8lpgpF8aHIvNoBenD6AYkIDO6X47hiC4b+Z0ko9CXMV4
	eUeo3LosMDwJGKNNmDoYR6e16hHj2mzgrx5M6tKnEouAfYjwf0XK4cOd2tm/PWBKqf+RPqfTcKE
	hN5Pmp+spAw67iwwb5f4x2uINSeWHK5rNTwsqfdGUJELXveInOPd+NoS04Wv+F20L1lHryTD4OP
	cnaPPM8OzmYr0z+UCfW0XDkyJkCNRegeGvqfBZNxDzexnVNZeCfQgGRnhurmKjq68HXDe0yKf+n
	fTPsPzyCv9t6EvqoY1kcmZzd2u6saYOCdZhnfDY4rZQ1EDu2Cz1twAidZH1V+kNdhTW9HAJ5WAy
	SypZ33/Z7lHiiguFcysj+FGy7kikbCRv8frUPAfcaCYhxQC+5nqaxjnsVehqcYkoZOsdPaQPFD9
	mtlwiXgXMUJDfgvkwBUAoo5DDltvLcK3K9RcUQamSm+apB3nRj3E3h7z14wK2MxREin9fGMa2ur
	bsJmf7K6K0DgUrbgW9AzWh0HKLciU55itobOd6OoQ6jmENVdPeJI1A/D+uEVLGaf2CzZMykl5zu
	6xAT14hMtkl99cMHCsLoY36ILfFDV1eq5miFXLSpiW6ih0i0wZAce3YppRm/ysHgYN9XNzO3a3C
	Xrt4gEwHn4DkRK/k1IGFTcKmDDOYufqKMkU1bbO5oMoUVOqa5n2iaRk2L
X-Received: by 2002:a05:701b:4553:20b0:151:2e62:fe5b with SMTP id a92af1059eb24-1b25d321238mr8082372c88.22.1794067315703;
        Sat, 07 Nov 2026 08:01:55 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:01:55 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 3/7] repo: add path.superproject-root with absolute and relative suffixes
Date: Sat,  7 Nov 2026 21:30:56 +0530
Message-ID: <20261107160100.122243-4-jayatheerthkulkarni2005@gmail.com>
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

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-root.absolute` and
`path.superproject-root.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 25 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..e524a07f53 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-root.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-root.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index c31e9cfa70..c17a8a3b35 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
@@ -121,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(repo, &superproject))
+		format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(repo, &superproject))
+		format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -159,6 +182,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
+	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 9417d1ab65..eec576a1d9 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,45 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-root absolute and relative' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		cd sub &&
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=../" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.superproject-root.absolute=" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.56.0-rc2

