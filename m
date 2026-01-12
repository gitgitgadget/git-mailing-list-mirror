Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D73803F3
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244079; cv=pass; b=rRpjutwmO4cWxhx5nUAWQx8xDQ29p6cbRrBQ8dxbOCkgPSRWdyTo3hLbS+Qz9IU47ZOsC5coYxlmw7kv+GO/tJtds6GcBmYn+YevFfI+BSLBmHjMSv8aUTY4Y6ZHVORHp8aM0g9IYIcUkOigY8CXHB+lbyrJ5aunyLnnWsBQHWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244079; c=relaxed/simple;
	bh=8bsrlosi2EmXscBsblo9zIXvGA2YPwr1jbw8t2SujOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIzDa3jtJkMhDUJog38o9TpnHiIYNqc8K4Gr1aBsHqJPce1CklcWYPsx18t6SCj7QmMjKCQ3auQPgQK6lkOzMHwnVeoHm/44GioYBG/EZC7W0e+bFnneFCvzzsQYl2deRDWB3qM2z5ZrZchrDjlZRX28wJCPGL2zBu1JvXJuDz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WsnpJDZN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WsnpJDZN"
ARC-Seal: i=1; a=rsa-sha256; t=1768244050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QvBs5I4mbE3IQYvItLe9SsS05cZdDduACaOKA14a1QCTrzEtTZiw7uznk8s/mViO/cPVwBjFwaHZm6slFbaOaKXir191iY3mI6qG9PInPxClGz8kRBYR6FAq3x0F7Q4gpEdelSJIdResFx3azYeKzob5Md+Hu7QOVxzINXJyf3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244050; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FiBe+booWthG1bSjei1jizYf1V5sADzmnDOpYAnlc/A=; 
	b=MsqwHngoNi+l+g3z9zUpUBQjoHKK45fvH+2nMLD8+msn6fDIGB3lsasxu/v6b7LcLZHSOvuAlm6p3jXR1LQ/lXdVYYax8SszWlUMTjSKyCK1dNpjiBMEUuCq75Dsvsv2911fj9G/VHfloRY3PAjPmT4yc5q9SsOIZ+oH5/peOOY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244049;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FiBe+booWthG1bSjei1jizYf1V5sADzmnDOpYAnlc/A=;
	b=WsnpJDZNFzjvux/dZrXe9UZZEm+VemGcYCD+G5Lll8dW9VnL7DXwNnnWPbqp+cjz
	vd22dao51IucYu+Orv879X9ZVG5JICW4RR4E/rob4PQQYl9+ksjqACz9250ZyFi94rf
	1gcw5qIMiFXF0ZoYutP9A8zSZ2UySfq9tJKv084I=
Received: by mx.zohomail.com with SMTPS id 1768244047822816.3681986131014;
	Mon, 12 Jan 2026 10:54:07 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v9 00/11] Add submodulePathConfig extension and gitdir encoding
Date: Mon, 12 Jan 2026 20:46:21 +0200
Message-ID: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

For those new to the series, we're implementing a submodule gitdir
extension which allows us to have a unified way to determine gitdirs
and do things like encode submodule paths to avoid FS conflicts.

v9 addresses two more small feedback items from Patrick + some very
small whitespace problems I introduced in v8.

Patches 1-6 implement the basic mechanisms of the new extension.
Patches 7-11 improve filesystem conflict detection and resolution.

As always, this is based on the latest master branch, I've checkd
for conflicts with next/seen, pushed to Github [1] and succesfully
ran the CI [2].

1: https://github.com/10ne1/git/tree/dev/aratiu/encoding-v9
2: https://github.com/10ne1/git/actions/runs/20926359849

Changes in v9:
* Replaced git config --global with test_config_global (Patrick)
* Split die() messages to multiple lines (Patrick)
* Moved some of the whitespace fixes added in v8 to the commit
  which actually introduced the whitespace problem (Adrian)

Range-diff between v8 -> v9:
 1:  5aae0df74b =  1:  cda5f3688b submodule--helper: use submodule_name_to_gitdir in add_submodule
 2:  041d921487 =  2:  f57fcc359a submodule: always validate gitdirs inside submodule_name_to_gitdir
 3:  12ff77be2d =  3:  63e2bcd7bf builtin/submodule--helper: add gitdir command
 4:  faaea085d2 =  4:  26d0bbff85 submodule: introduce extensions.submodulePathConfig
 5:  3a65c86a38 !  5:  3f268165b9 submodule: allow runtime enabling extensions.submodulePathConfig
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
      '
      
     +test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
    -+	git config --global init.defaultSubmodulePathConfig true &&
    ++	test_config_global init.defaultSubmodulePathConfig true &&
     +	git init repo-init &&
    -+	git -C repo-init config extensions.submodulePathConfig > actual &&
    -+	echo true > expect &&
    ++	git -C repo-init config extensions.submodulePathConfig >actual &&
    ++	echo true >expect &&
     +	test_cmp expect actual &&
     +	# create a submodule and check gitdir
     +	(
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +		git init -b main sub &&
     +		test_commit -C sub sub-initial &&
     +		git submodule add ./sub sub &&
    -+		git config submodule.sub.gitdir > actual &&
    -+		echo ".git/modules/sub" > expect &&
    ++		git config submodule.sub.gitdir >actual &&
    ++		echo ".git/modules/sub" >expect &&
     +		test_cmp expect actual
    -+	) &&
    -+	git config --global --unset init.defaultSubmodulePathConfig
    ++	)
     +'
     +
     +test_expect_success '`git init` does not set extension by default' '
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +
     +test_expect_success '`git clone` respects init.defaultSubmodulePathConfig' '
     +	test_when_finished "rm -rf repo-clone" &&
    -+	git config --global init.defaultSubmodulePathConfig true &&
    ++	test_config_global init.defaultSubmodulePathConfig true &&
     +	git clone upstream repo-clone &&
     +	(
     +		cd repo-clone &&
     +
     +		# verify new repo extension is inherited from global config
    -+		git config extensions.submodulePathConfig > actual &&
    -+		echo true > expect &&
    ++		git config extensions.submodulePathConfig >actual &&
    ++		echo true >expect &&
     +		test_cmp expect actual &&
     +
     +		# new submodule has a gitdir config
     +		git submodule add ../sub sub &&
     +		test_path_is_dir .git/modules/sub &&
    -+		git config submodule.sub.gitdir > actual &&
    -+		echo ".git/modules/sub" > expect &&
    ++		git config submodule.sub.gitdir >actual &&
    ++		echo ".git/modules/sub" >expect &&
     +		test_cmp expect actual
    -+	) &&
    -+	git config --global --unset init.defaultSubmodulePathConfig
    ++	)
     +'
     +
     +test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmodulePathConfig' '
     +	test_when_finished "rm -rf repo-clone-recursive" &&
    -+	git config --global init.defaultSubmodulePathConfig true &&
    ++	test_config_global init.defaultSubmodulePathConfig true &&
     +	git clone  --recurse-submodules upstream repo-clone-recursive &&
     +	(
     +		cd repo-clone-recursive &&
     +
     +		# verify new repo extension is inherited from global config
    -+		git config extensions.submodulePathConfig > actual &&
    -+		echo true > expect &&
    ++		git config extensions.submodulePathConfig >actual &&
    ++		echo true >expect &&
     +		test_cmp expect actual &&
     +
     +		# previous submodules should exist
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +		# create another submodule and check that gitdir is created
     +		git submodule add ../sub new-sub &&
     +		test_path_is_dir .git/modules/new-sub &&
    -+		git config submodule.new-sub.gitdir > actual &&
    -+		echo ".git/modules/new-sub" > expect &&
    ++		git config submodule.new-sub.gitdir >actual &&
    ++		echo ".git/modules/new-sub" >expect &&
     +		test_cmp expect actual
    -+	) &&
    -+	git config --global --unset init.defaultSubmodulePathConfig
    ++	)
     +'
     +
      test_done
 6:  c62db6b32f !  6:  0bbe9769d1 submodule--helper: add gitdir migration command
    @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **arg
     +	repo_config_get_int(the_repository, "core.repositoryformatversion", &repo_version);
     +	if (repo_version == 0 &&
     +	    repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
    -+		die(_("could not set core.repositoryformatversion to 1. "
    -+		      "Please set it for migration to work, for example: "
    ++		die(_("could not set core.repositoryformatversion to 1.\n"
    ++		      "Please set it for migration to work, for example:\n"
     +		      "git config core.repositoryformatversion 1"));
     +
     +	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
    -+		die(_("could not enable submodulePathConfig extension. It is required "
    -+		      "for migration to work. Please enable it in the root repo: "
    ++		die(_("could not enable submodulePathConfig extension. It is required\n"
    ++		      "for migration to work. Please enable it in the root repo:\n"
     +		      "git config extensions.submodulePathConfig true"));
     +
     +	repo->repository_format_submodule_path_cfg = 1;
    @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc,
      		OPT_SUBCOMMAND("add", &fn, module_add),
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed submodule changes and verify updates' '
    - test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
    - 	git config --global init.defaultSubmodulePathConfig true &&
    - 	git init repo-init &&
    --	git -C repo-init config extensions.submodulePathConfig > actual &&
    --	echo true > expect &&
    -+	git -C repo-init config extensions.submodulePathConfig >actual &&
    -+	echo true >expect &&
    - 	test_cmp expect actual &&
    - 	# create a submodule and check gitdir
    - 	(
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
    - 		git init -b main sub &&
    - 		test_commit -C sub sub-initial &&
    - 		git submodule add ./sub sub &&
    --		git config submodule.sub.gitdir > actual &&
    --		echo ".git/modules/sub" > expect &&
    -+		git config submodule.sub.gitdir >actual &&
    -+		echo ".git/modules/sub" >expect &&
    - 		test_cmp expect actual
    - 	) &&
    - 	git config --global --unset init.defaultSubmodulePathConfig
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone` respects init.defaultSubmodulePathConfig' '
    - 		cd repo-clone &&
    - 
    - 		# verify new repo extension is inherited from global config
    --		git config extensions.submodulePathConfig > actual &&
    --		echo true > expect &&
    -+		git config extensions.submodulePathConfig >actual &&
    -+		echo true >expect &&
    - 		test_cmp expect actual &&
    - 
    - 		# new submodule has a gitdir config
    - 		git submodule add ../sub sub &&
    - 		test_path_is_dir .git/modules/sub &&
    --		git config submodule.sub.gitdir > actual &&
    --		echo ".git/modules/sub" > expect &&
    -+		git config submodule.sub.gitdir >actual &&
    -+		echo ".git/modules/sub" >expect &&
    - 		test_cmp expect actual
    - 	) &&
    - 	git config --global --unset init.defaultSubmodulePathConfig
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
    - 		cd repo-clone-recursive &&
    - 
    - 		# verify new repo extension is inherited from global config
    --		git config extensions.submodulePathConfig > actual &&
    --		echo true > expect &&
    -+		git config extensions.submodulePathConfig >actual &&
    -+		echo true >expect &&
    - 		test_cmp expect actual &&
    - 
    - 		# previous submodules should exist
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
    - 		# create another submodule and check that gitdir is created
    - 		git submodule add ../sub new-sub &&
    - 		test_path_is_dir .git/modules/new-sub &&
    --		git config submodule.new-sub.gitdir > actual &&
    --		echo ".git/modules/new-sub" > expect &&
    -+		git config submodule.new-sub.gitdir >actual &&
    -+		echo ".git/modules/new-sub" >expect &&
    - 		test_cmp expect actual
    - 	) &&
    - 	git config --global --unset init.defaultSubmodulePathConfig
    + 	)
      '
      
     +test_expect_success 'submodule--helper migrates legacy modules' '
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +	rm -rf repo-clone-recursive &&
     +
     +	# enable the extension, then retry the clone
    -+	git config --global init.defaultSubmodulePathConfig true &&
    ++	test_config_global init.defaultSubmodulePathConfig true &&
     +	git clone --recurse-submodules upstream repo-clone-recursive &&
     +	(
     +		cd repo-clone-recursive &&
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +		git config submodule.sub2.gitdir &&
     +		test_path_is_dir .git/modules/sub1 &&
     +		test_path_is_dir .git/modules/sub2
    -+	) &&
    -+	git config --global --unset init.defaultSubmodulePathConfig
    ++	)
     +'
     +
      test_done
 7:  c554017f83 =  7:  25e491de11 builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
 8:  7a794b9b61 !  8:  4fc31f2476 submodule--helper: fix filesystem collisions by encoding gitdir paths
    @@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` works after migration' '
    - 	git config --global --unset init.defaultSubmodulePathConfig
    + 	)
      '
      
     +test_expect_success 'setup submodules with nested git dirs' '
 9:  142a85a1af =  9:  45a3ad12bb submodule: fix case-folding gitdir filesystem collisions
10:  bafde20354 = 10:  bb03d7be7a submodule: hash the submodule name for the gitdir path
11:  e3fe1f7529 = 11:  6bde65c6d1 submodule: detect conflicts with existing gitdir configs

Adrian Ratiu (11):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  submodule: always validate gitdirs inside submodule_name_to_gitdir
  builtin/submodule--helper: add gitdir command
  submodule: introduce extensions.submodulePathConfig
  submodule: allow runtime enabling extensions.submodulePathConfig
  submodule--helper: add gitdir migration command
  builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
  submodule--helper: fix filesystem collisions by encoding gitdir paths
  submodule: fix case-folding gitdir filesystem collisions
  submodule: hash the submodule name for the gitdir path
  submodule: detect conflicts with existing gitdir configs

 Documentation/config/extensions.adoc       |  29 ++
 Documentation/config/init.adoc             |   6 +
 Documentation/config/submodule.adoc        |   7 +
 builtin/credential-store.c                 |   7 +-
 builtin/submodule--helper.c                | 204 +++++++-
 repository.c                               |   1 +
 repository.h                               |   1 +
 setup.c                                    |  17 +
 setup.h                                    |   1 +
 submodule.c                                | 223 +++++++--
 t/lib-verify-submodule-gitdir-path.sh      |  24 +
 t/meson.build                              |   1 +
 t/t7425-submodule-gitdir-path-extension.sh | 528 +++++++++++++++++++++
 t/t9902-completion.sh                      |   1 +
 url.c                                      |  13 +
 url.h                                      |  14 +
 16 files changed, 1026 insertions(+), 51 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-gitdir-path-extension.sh

-- 
2.52.0

