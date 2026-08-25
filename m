Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827D40096D
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680725; cv=none; b=WDuEd/9shOlstQIpofeC4R9uuCuNHJaMOfzVKgDTyFxQd2s5vv5iUeD1zGn2pRgvkoJFQUJ46kBegRhTMm6Ez5gx1FICm400c77vMmjYuoRFVX/PRXDSwfNGLY0fp+OcuSKPLxfriNWAG7tYVP56iJA4aOEdLBImHyVxigZ3jHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680725; c=relaxed/simple;
	bh=wjeBB9xP3Br7rGi+Ns4Kr9wjKbI7q/BvttYczV5dn3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmJAfSTuTOlLmnSZWhufQEDcylp9mGFn+qeRXzVKCznxxt2RBkOAO+BdA3fCKDZnkEb9OH73Uak0dnxtHkznSXfOQ9uZ+rnqa8y3eYFF1dhMrkrNpX7Zn542t/dyfrO3n9FakMx5Iz38MZINWc6aMEKpR+JW10Uo0Qto0R40F+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxlWar5x; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxlWar5x"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so139982a91.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680723; x=1788285523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KH09sPDz6iSz1q1reqn14iRlqcXCrcfKXxzDVpgsaNI=;
        b=SxlWar5xbZ2xT2+tN8p/iGCOFUJeRx5QJzmCIik1iHTLcatykuvVECVcyIryORi3Ea
         h/4TlYZGPZelrveh80wDqHlevdWn7tlZDSC4rvdVobXEFdThS9nDnn6D3nVP3WOnLI8R
         Oqqz3D9NcuGwvjcnz62qpF2EF1JW+aeP3SAELSi2fIiraA/cv4+nYWR3EC5s9j4RrHQY
         JIDBP90qG/6YMBD0LsXqshd7jPWbtHCj+j2NOnLWXmKWy7nXEp2y71xNx+kXQbLwKAgJ
         Yofc4j1rKghUqU6dHNMtkScJzii58hQDfCn4+H3mGrlt00Sciv4qNRqqOo9p2B4vt5Zj
         yhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680723; x=1788285523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KH09sPDz6iSz1q1reqn14iRlqcXCrcfKXxzDVpgsaNI=;
        b=EaTksLT8t+ktoOm0F18O1OFKoIoFuG7UF9Hwi378incpZJARN1Ukcv5YxeMycfuiaj
         Q2gUXwcmFRnujH+oJIr2EPqYtoSFgzSfmHm+0HuVgux/DsMsvw5uIFZbWwZEQeb7rT7U
         D3p3vikER72a45S9nQHySGQGtB4/pYTNLPZOOPqFRdhtq/CIQBKz68kDa58SDHvXYQ3c
         CWbmcIAtIktezOiMCGUWzfoLF/9nG+y2w9YT0cJRxKljdvIvbPYtA0ciReATboxD2E/U
         dc7GXJQ7O6sq5oiCzp7/xRnXgvYfFGJ38XwWz3H2ahc/YQTBMAkHEjns9zmN4gaoRLiS
         FiCA==
X-Gm-Message-State: AFuF++mnExprB7xuL8JwwQTidYQ/p5BnrQBC6FkvyygO09L4G7+7GApT
	jewTRBr2H7Dh17n63UNUPcGnHCXRsklGVMuCsO4QiyGk2eiujgnbCAFE
X-Gm-Gg: AR+sD13e0J++9CYaOamsimlWIj/NRu1Kn6U9ftN9to7aXw0/hZcyLggV8bghZVcM3Lw
	yuk7sZSbXY3DFcIu8/l3mdh/K6eXZXMzKzvWrWBfKnTJB/gibQYI2qmbmz9aG4NaOBoLjRrGIil
	+XbbkgyfoXi7+97AdeXO7aJbfGZpxlJsXrbiN/gepEJV1l1OqzuB9onA5eY+NEJPCwE3YXTsNTM
	HTaLIJarU7U4JkXaYtX3viM6VSdM/wXWYjnelZFk4U5xQ3p7m/FB33LvcqzudoYDnBGL9wN7PTU
	GgwX2xyZ9vB/X0GHXrzj4lriATiX/Bjol2CnBggeN4Pdy4myCLdk74d/YqYholu2AleF309WekH
	gKTmiawB/geI0K2lMRMB8hVXvdUCNC8fYZ1+Zt8vXvXRWsdEfp7rlq19fsW8wOIjyVfh+UEL3ff
	dvvPnMXgpi3fiFYPTuMDWZooxJzoapM45M9LCIvUmJhSNSv/ZSstARjJ1I/mjPmjJMw54Z8iVqX
	XsHh2Emc5Y8BXo+8wShc0fp1a7vQuhKIKDJuNTtvxaDuyZqGdmNBX6IUF8GaXFP5Pq9Lg4=
X-Received: by 2002:a17:90b:2c88:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3966d20e7aamr2102608a91.7.1787680723140;
        Tue, 25 Aug 2026 10:58:43 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:58:42 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 0/7] add more path keys to git repo info
Date: Tue, 25 Aug 2026 23:28:11 +0530
Message-ID: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.

Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-root: superproject tree from submodules.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.
* path.cdup: relative path to top level from subdirectory.

Keys support suffixes for format.
Commits contain documentation and tests.

changes since v4:
* Add path.cdup in git repo.

* Drop unused header cleanup patch as it will be sent in the next set of cleanup only
  patches.

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  repo: add path.superproject-root with absolute and relative suffixes
  repo: add path.hooks with absolute and relative suffixes
  repo: add path.index with absolute and relative suffixes
  repo: add path.grafts with absolute and relative suffixes
  repo: add path.git-prefix
  repo: add path.cdup

 Documentation/git-repo.adoc |  62 +++++++++++++
 builtin/repo.c              | 151 ++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 177 +++++++++++++++++++++++++++++++++++-
 3 files changed, 388 insertions(+), 2 deletions(-)

Range-diff against v4:
1:  db54cf2177 = 1:  3880485020 repo: add path.toplevel with absolute and relative suffix formatting
2:  5f5ab2b844 = 2:  1b7b0d286c repo: add path.superproject-root with absolute and relative suffixes
3:  a8c3526958 = 3:  517f621eb0 repo: add path.hooks with absolute and relative suffixes
4:  a419389911 = 4:  37d28712de repo: add path.index with absolute and relative suffixes
5:  a5a28f2e92 = 5:  d88340f5a6 repo: add path.grafts with absolute and relative suffixes
6:  39775f8d2f = 6:  38b19d8bfd repo: add path.git-prefix
7:  74dbca6f17 ! 7:  d6ce98e25e repo: remove unused setup.h include
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: remove unused setup.h include
    +    repo: add path.cdup
     
    -    The repository prefix is now stored in `struct repository`, so
    -    builtin/repo.c no longer uses any declarations from setup.h.
    +    Scripts sometimes need the relative path from the current working
    +    directory to the repository's working tree root (cdup). While this
    +    information can be retrieved through `git rev-parse --show-cdup`,
    +    `git repo info` does not currently expose it as a scriptable key.
     
    -    Remove the now-unused include.
    +    Introduce the `path.cdup` key to `git repo info`. The key returns the
    +    path from the current working directory to the root of the working tree,
    +    returning the empty string when invoked from the working tree root.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
         Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
    + ## Documentation/git-repo.adoc ##
    +@@ Documentation/git-repo.adoc: values that they return:
    + `object.format`::
    + 	The object format (hash algorithm) used in the repository.
    + 
    ++`path.cdup`::
    ++	The path to the root of the working tree relative to the current
    ++	working directory. Returns the empty string when the current
    ++	working directory is the root of the working tree.
    ++
    + `path.commondir.absolute`::
    + 	The canonical absolute path to the Git repository's common
    + 	directory (the shared `.git` directory containing objects,
    +
      ## builtin/repo.c ##
    -@@
    - #include "ref-filter.h"
    - #include "refs.h"
    - #include "revision.h"
    --#include "setup.h"
    - #include "strbuf.h"
    - #include "string-list.h"
    - #include "shallow.h"
    +@@ builtin/repo.c: static int get_object_format(struct repository *repo, struct strbuf *buf)
    + 	return 0;
    + }
    + 
    ++static int get_path_cdup(struct repository *repo, struct strbuf *buf)
    ++{
    ++	const char *pfx = repo->prefix;
    ++
    ++	while (pfx) {
    ++		pfx = strchr(pfx, '/');
    ++		if (pfx) {
    ++			pfx++;
    ++			strbuf_addstr(buf, "../");
    ++		}
    ++	}
    ++	return 0;
    ++}
    ++
    + static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
    + {
    + 	const char *common_dir = repo_get_common_dir(repo);
    +@@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    + 	{ "layout.bare", get_layout_bare },
    + 	{ "layout.shallow", get_layout_shallow },
    + 	{ "object.format", get_object_format },
    ++	{ "path.cdup", get_path_cdup },
    + 	{ "path.commondir.absolute", get_path_commondir_absolute },
    + 	{ "path.commondir.relative", get_path_commondir_relative },
    + 	{ "path.git-prefix", get_path_git_prefix },
    +
    + ## t/t1900-repo-info.sh ##
    +@@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
    + 	'.git' \
    + 	'GIT_DIR="../.git" && export GIT_DIR'
    + 
    ++test_expect_success 'path.cdup at repository root' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		echo "path.cdup=" >expect &&
    ++		git repo info path.cdup >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'path.cdup in subdirectory' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	mkdir -p repo/sub/dir &&
    ++	(
    ++		cd repo/sub/dir &&
    ++		echo "path.cdup=../../" >expect &&
    ++		git repo info path.cdup >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_expect_success 'path.git-prefix at repository root' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
-- 
2.55.GIT
