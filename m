Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A23E00BA
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096672; cv=none; b=N2mO+x3phObWEmXg/gNM/ku3xbXr6CGkzr27IUz8RSONc34kHXmqNecepKpzJBNHC8CLWnPTKBUy56z6x8/vdN7sXVcOkWML3tJKumt5iL01DZbl8q8zHuwrKE/SLKghSlyLckKqxTxaEr+cnA+K2qZcdktfJPWKULm9d+D2hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096672; c=relaxed/simple;
	bh=LchU0nGFWfbuRCNQN3Kph+ZB3TzAdKUE9lkyAdUF01g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fjxTuWD60afQK45GNk7mbSAw+lkvoIE+UxG0QIyhAW6pHQqhXcH0UCtG7LWD1BgDlNMVUC0Mp2Mx8+3epL10kgzK8aqXAx0K7DDI2aBh8U+ezpyK0Br49wugd8aZjQlpiTuB4LU7f7t9Ty7vbQl5L+L0zy8ZOBkKBj2nNJ6aZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cl504q+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lncePLCf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cl504q+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lncePLCf"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B7247A0140;
	Mon, 18 May 2026 05:31:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 18 May 2026 05:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096669;
	 x=1779183069; bh=WGNLYT8ivyD/VC1P4NbP0UsjZD2DdG64nwsM383JeqU=; b=
	cl504q+MMnfzpO+nfJ2XAyM89lJ2fCz09zSca3zQFN2ey7zqQLgaTLAsZHIK3Bfw
	dA9KW5brL0GffDxBXlkwEdapzfW8zOzQeBLIqFIh9WeGlZ2LohHfhGU9uOZCuAMG
	0BUfT0iI1h9rNqthr0KA7K9lguNni9JYa4r0eF5Zg/xGHS08ZHEKOcnuCxSQbcPr
	ZMYZpM67/jRkEAN9oI3RgLGuCLkSGkUthQBZFTCHIt636MRy7IAb7uoj2X9528V0
	YPr30f9RRNPuaQQVC8kXFc7AgxAR27R5FbTvnWVgbg9O0PdNdA4vV+yLe+QVGAU8
	UZbgnEGanTX0isXP/W+bQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096669; x=
	1779183069; bh=WGNLYT8ivyD/VC1P4NbP0UsjZD2DdG64nwsM383JeqU=; b=l
	ncePLCfdSvIlQU+/YqJcEuou5hpDpEjzyfDEQUlHYqtj4FBbg31KfxA7gy3ukWbb
	lHicgKZAPlFFD8fCS+mrBmFap/uuDpZGER9s9sAFEP89wnrsL28cyTpqaBtTvyfn
	/JMYHOr6QeJTUs0u94LT7MVVnKdlggtrNq8Usr3WIJBEM4NAmkdK8eSQTlwF5Ck5
	yYAHVOG5JvpLYvQW+SPy+WSST5Poe1SK0mC9QMwdgfxoLemT7dBZfYCjllsvineC
	HXrtqokXjIovYfKDPg3eQP6Q1Tf3JQRxblf2iGasnSYdGB1etNCox8HEWMx5HYSx
	dt/StrLxzkpXxQopzsEfw==
X-ME-Sender: <xms:XNwKam8WJ4ZqXL3a7VuBYyffWvb0RKWL_309Uej2RG8viFo7Zc4AoQ>
    <xme:XNwKatktTUhQCUlViJxEyd3xl31tlHFp2L4asdQU1_99uzmIUCh76rrBgFTMpIGnz
    XsAMT56IurcDwOVcvkVFD0fEOhnf9kZMtWXWZvfWKM3-k6QC2jxkRk>
X-ME-Received: <xmr:XNwKakUOLDXizubLT-8XhySxxXpKquqgGKcSrz_YkzFdbDet4etcvBjtefEyRTM-L8ZjGikI9zAtEsSYX3020dkonpHC28B8RDgQHQWtYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeltefggeehveevtefgledutdffleehjeeijeevvddugeethfeitedtheetgefgtden
    ucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrg
    htsehmrghlohhnrdguvghvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XNwKaqE70bvGkdY4eOClYzQoXGqudW1fj0KPm1QAAmxRVgwZ8vJG7A>
    <xmx:XNwKaofGKr8Cp39HKOvI4MPiAIKP99K6l4_WG0SSMkmoMGsGTZnCqA>
    <xmx:XNwKajIrBO4h-wkuYDTSEFSMVooMho8-r_Vanh4Nwqi312EjYK_HhQ>
    <xmx:XNwKalGY5po8u_IL0GI4Yx4nnSJjzbKmGvaoflJY-ikCwuu5KnfVjQ>
    <xmx:XdwKam2H2ImM0Hx19Wn-j2tZcLYxtjMjnSoIQhMmTR4C8VBFIL4Qht-d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e31c4b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/18] setup: drop uses of `the_repository`
Date: Mon, 18 May 2026 11:30:51 +0200
Message-Id: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzcCmoC/32NQQ6CMBBFr0K6dkxbwBRX3sOwgDrIaKRNp6CGc
 HcL7F2+5P33Z8EYCFmcs1kEnIjJDQn0IRO2b4Y7At0SCy31Sea5BP9kYIyjh7eD2CME9I4puvA
 Fo7BUrS3LtlIiFXzAjj5b/VrvzGP7QBvX5Gr0xOtyu5/U6u1Phf7/NCmQ0BWNUbaojEFzSfaRX
 qJeluUHfBIQ1dUAAAA=
X-Change-ID: 20260330-pks-setup-wo-the-repository-81e51bc55b91
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Hi,

I've had enough of "setup.c" and its complexities, so I finally decided
to take the bullet and start refactoring this subsystem. This here is
the first out of the following three steps:

  1. Drop all uses of `the_repository`. This doesn't yet allow us to get
     rid of `USE_THE_REPOSITORY_VARIABLE`.

  2. Convert a couple of global variables and drop
     `is_bare_repository_cfg`, which then allows us to drop
     `USE_THE_REPOSITORY_VARIABLE`.

  3. Refactor the subsystem a bit so that we stop intermixing repository
     discovery and repository initialization. This is my original
     motivation as I want to get rid of `odb_prepare_alternates()`, but
     due to the way we initialize the repository it has proven to be
     extremely tedious.

Most of the patches in this series here are rather mechanical. There's
only a handful of patches that warrant more attention:

  -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
  -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
  -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
  - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`

Those patches don't only mechanical move stuff around, but also change
some logic to make it work.

Changes in v2:
  - Drop some static variables.
  - Rebase on top of origin/master at 59ff4886a5 (Merge branch
    'ps/clang-w-glibc-2.43-and-_Generic', 2026-05-13). This resolves a
    single conflict, but more importantly the rebase fixes CI.
  - Link to v1: https://patch.msgid.link/20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im

Changes in v1 (relative to the botched-up [1]):
  - Remove static `initialized` variable in `setup_work_tree()`.
  - Use enum values to initialize fields.
  - Fix up a comment.
  - Link to v1: https://lore.kernel.org/all/20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im/

Thanks!

Patrick

[1]: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>

---
Patrick Steinhardt (18):
      setup: replace use of `the_repository` in static functions
      setup: stop using `the_repository` in `is_inside_worktree()`
      setup: stop using `the_repository` in `is_inside_git_dir()`
      setup: stop using `the_repository` in `prefix_path()`
      setup: stop using `the_repository` in `path_inside_repo()`
      setup: stop using `the_repository` in `verify_filename()`
      setup: stop using `the_repository` in `verify_non_filename()`
      setup: stop using `the_repository` in `enter_repo()`
      setup: stop using `the_repository` in `setup_work_tree()`
      setup: stop using `the_repository` in `set_git_work_tree()`
      setup: stop using `the_repository` in `setup_git_env()`
      setup: stop using `the_repository` in `setup_git_directory_gently()`
      setup: stop using `the_repository` in `setup_git_directory()`
      setup: stop using `the_repository` in `upgrade_repository_format()`
      setup: stop using `the_repository` in `check_repository_format()`
      setup: stop using `the_repository` in `initialize_repository_version()`
      setup: stop using `the_repository` in `create_reference_database()`
      setup: stop using `the_repository` in `init_db()`

 archive.c                                    |   2 +-
 blame.c                                      |   2 +-
 builtin/blame.c                              |   2 +-
 builtin/check-attr.c                         |   4 +-
 builtin/check-ref-format.c                   |   5 +-
 builtin/checkout-index.c                     |   4 +-
 builtin/checkout.c                           |   2 +-
 builtin/clone.c                              |  12 +-
 builtin/describe.c                           |   2 +-
 builtin/diff-index.c                         |   2 +-
 builtin/diff.c                               |  10 +-
 builtin/difftool.c                           |   2 +-
 builtin/grep.c                               |   8 +-
 builtin/hash-object.c                        |   4 +-
 builtin/help.c                               |   2 +-
 builtin/init-db.c                            |   8 +-
 builtin/ls-files.c                           |   4 +-
 builtin/merge-file.c                         |   2 +-
 builtin/mv.c                                 |   5 +-
 builtin/read-tree.c                          |   2 +-
 builtin/receive-pack.c                       |   2 +-
 builtin/reset.c                              |   6 +-
 builtin/rev-parse.c                          |  14 +-
 builtin/rm.c                                 |   2 +-
 builtin/sparse-checkout.c                    |  19 +-
 builtin/stripspace.c                         |   2 +-
 builtin/submodule--helper.c                  |   2 +-
 builtin/update-index.c                       |  16 +-
 builtin/upload-archive.c                     |   2 +-
 builtin/upload-pack.c                        |   2 +-
 daemon.c                                     |   4 +-
 environment.h                                |   2 -
 git.c                                        |  10 +-
 http-backend.c                               |   2 +-
 http-fetch.c                                 |   2 +-
 http-push.c                                  |   2 +-
 imap-send.c                                  |   2 +-
 line-log.c                                   |   2 +-
 list-objects-filter-options.c                |   2 +-
 object-name.c                                |   4 +-
 pathspec.c                                   |   2 +-
 refs.c                                       |   2 +-
 remote-curl.c                                |   4 +-
 repository.h                                 |   4 +-
 revision.c                                   |   6 +-
 scalar.c                                     |   4 +-
 setup.c                                      | 451 ++++++++++++++-------------
 setup.h                                      |  43 ++-
 submodule.c                                  |   2 +-
 t/helper/test-advise.c                       |   2 +-
 t/helper/test-bitmap.c                       |   2 +-
 t/helper/test-bloom.c                        |   2 +-
 t/helper/test-cache-tree.c                   |   2 +-
 t/helper/test-config.c                       |   2 +-
 t/helper/test-dump-cache-tree.c              |   2 +-
 t/helper/test-dump-fsmonitor.c               |   2 +-
 t/helper/test-dump-split-index.c             |   2 +-
 t/helper/test-dump-untracked-cache.c         |   2 +-
 t/helper/test-find-pack.c                    |   2 +-
 t/helper/test-fsmonitor-client.c             |   2 +-
 t/helper/test-lazy-init-name-hash.c          |   2 +-
 t/helper/test-match-trees.c                  |   2 +-
 t/helper/test-pack-deltas.c                  |   2 +-
 t/helper/test-pack-mtimes.c                  |   2 +-
 t/helper/test-partial-clone.c                |   4 +-
 t/helper/test-path-utils.c                   |   4 +-
 t/helper/test-path-walk.c                    |   2 +-
 t/helper/test-reach.c                        |   2 +-
 t/helper/test-read-cache.c                   |   2 +-
 t/helper/test-read-graph.c                   |   2 +-
 t/helper/test-read-midx.c                    |   2 +-
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-revision-walking.c             |   2 +-
 t/helper/test-scrap-cache-tree.c             |   2 +-
 t/helper/test-serve-v2.c                     |   2 +-
 t/helper/test-submodule-config.c             |   2 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/helper/test-submodule.c                    |  10 +-
 t/helper/test-subprocess.c                   |   6 +-
 t/helper/test-userdiff.c                     |   2 +-
 t/helper/test-write-cache.c                  |   2 +-
 worktree.c                                   |   2 +-
 wt-status.c                                  |   2 +-
 83 files changed, 402 insertions(+), 383 deletions(-)

Range-diff versus v1:

 1:  2bdd6dfead =  1:  275a0e45a3 setup: replace use of `the_repository` in static functions
 2:  e38c29bd25 !  2:  d748d28abe setup: stop using `the_repository` in `is_inside_worktree()`
    @@ setup.c: int is_inside_git_dir(void)
     -	if (inside_work_tree < 0)
     -		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
     -	return inside_work_tree;
    -+	static struct strbuf buf = STRBUF_INIT;
    -+	const char *worktree = repo_get_work_tree(repo);
    ++	struct strbuf buf = STRBUF_INIT;
    ++	const char *worktree;
    ++	int ret;
    ++
    ++	worktree = repo_get_work_tree(repo);
     +	if (!worktree)
     +		return 0;
    -+	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
    ++
    ++	ret = is_inside_dir(strbuf_realpath(&buf, worktree, 1));
    ++
    ++	strbuf_release(&buf);
    ++	return ret;
      }
      
      void setup_work_tree(void)
 3:  184b1f2331 !  3:  3f1da8a163 setup: stop using `the_repository` in `is_inside_git_dir()`
    @@ setup.c: int is_nonbare_repository_dir(struct strbuf *path)
     -	if (inside_git_dir < 0)
     -		inside_git_dir = is_inside_dir(repo_get_git_dir(the_repository));
     -	return inside_git_dir;
    -+	static struct strbuf buf = STRBUF_INIT;
    -+	return is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
    ++	struct strbuf buf = STRBUF_INIT;
    ++	int ret = is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
    ++	strbuf_release(&buf);
    ++	return ret;
      }
      
      int is_inside_work_tree(struct repository *repo)
 4:  c178fb7f3d =  4:  59426f6dbc setup: stop using `the_repository` in `prefix_path()`
 5:  e408ba2332 =  5:  aae9034d31 setup: stop using `the_repository` in `path_inside_repo()`
 6:  b43251adcb =  6:  b8d6abd41f setup: stop using `the_repository` in `verify_filename()`
 7:  e489b6f84e !  7:  e6ecd9ea0d setup: stop using `the_repository` in `verify_non_filename()`
    @@ builtin/reset.c: static void parse_args(struct pathspec *pathspec,
      			/* Otherwise we treat this as a filename */
     
      ## revision.c ##
    -@@ revision.c: static int handle_dotdot_1(const char *arg, char *dotdot,
    +@@ revision.c: static int handle_dotdot_1(const char *a_name, const char *b_name,
    + 		return -1;
      
      	if (!cant_be_filename) {
    - 		*dotdot = '.';
    --		verify_non_filename(revs->prefix, arg);
    -+		verify_non_filename(the_repository, revs->prefix, arg);
    - 		*dotdot = '\0';
    +-		verify_non_filename(revs->prefix, full_name);
    ++		verify_non_filename(the_repository, revs->prefix, full_name);
      	}
      
    + 	a_obj = parse_object(revs->repo, &a_oid);
     @@ revision.c: static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
      		goto out;
      	}
 8:  54192c579e =  8:  87fe43bf7c setup: stop using `the_repository` in `enter_repo()`
 9:  78ae1d0845 !  9:  897a0ac4a6 setup: stop using `the_repository` in `setup_work_tree()`
    @@ Commit message
         the repository as a parameter. The injection of `the_repository` is thus
         bumped one level higher, where callers now pass it in explicitly.
     
    -    Note that the function tracks bogus worktree configuration via a global
    -    variable. If we have bogus configuration, and if later on some caller
    -    tries to setup a worktree, then we'll die instead.
    +    Note that the function tracks two bits of information via global
    +    variables. This of course doesn't make much sense anymore now that we
    +    can set up worktrees for arbitrary repositories:
     
    -    Of course, tracking this as a global variable doesn't make sense anymore
    -    now that we can set up worktrees for arbitrary repositories. Move the
    -    variable into `struct repository` instead.
    +      - We track whether the worktree has already been initialized and, if
    +        so, we skip the call to `chdir_notify()` and setenv(3p). It does not
    +        make much sense to store this info in the repository, as we _would_
    +        want to update the environment when switching between worktrees back
    +        and forth.
    +
    +        So instead of storing this info in the repository, we drop this
    +        state entirely and live with the fact that we may execute the logic
    +        twice. It should ultimately be idempotent though and thus not be
    +        much of a problem.
    +
    +      - We track whether the worktree configuration is bogus. If so, and if
    +        later on some caller tries to setup the worktree, then we'll die
    +        instead. This is indeed information that we can move into the
    +        repository itself.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ setup.c
      	ALLOWED_BARE_REPO_EXPLICIT = 0,
      	ALLOWED_BARE_REPO_ALL,
     @@ setup.c: int is_inside_work_tree(struct repository *repo)
    - 	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
    + 	return ret;
      }
      
     -void setup_work_tree(void)
     +void setup_work_tree(struct repository *repo)
      {
      	const char *work_tree;
    - 	static int initialized = 0;
    -@@ setup.c: void setup_work_tree(void)
    - 	if (initialized)
    - 		return;
    +-	static int initialized = 0;
      
    +-	if (initialized)
    +-		return;
    +-
     -	if (work_tree_config_is_bogus)
     +	if (repo->worktree_config_is_bogus)
      		die(_("unable to set up work tree using invalid config"));
    @@ setup.c: void setup_work_tree(void)
      	if (!work_tree || chdir_notify(work_tree))
      		die(_("this operation must be run in a work tree"));
      
    +@@ setup.c: void setup_work_tree(void)
    + 	 */
    + 	if (getenv(GIT_WORK_TREE_ENVIRONMENT))
    + 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
    +-
    +-	initialized = 1;
    + }
    + 
    + static void setup_original_cwd(struct repository *repo)
     @@ setup.c: static const char *setup_explicit_git_dir(struct repository *repo,
      		if (git_work_tree_cfg) {
      			/* #22.2, #30 */
10:  f2f0c80991 ! 10:  f1ceac2491 setup: stop using `the_repository` in `set_git_work_tree()`
    @@ setup.c: const char *enter_repo(struct repository *repo, const char *path, unsig
      	}
     -	git_work_tree_initialized = 1;
     -	repo_set_worktree(the_repository, new_work_tree);
    -+	repo->worktree_initialized = 1;
    ++	repo->worktree_initialized = true;
     +	repo_set_worktree(repo, new_work_tree);
      }
      
11:  0c72972ba4 = 11:  f7de435b86 setup: stop using `the_repository` in `setup_git_env()`
12:  7a758cf4de = 12:  aea92d5f0a setup: stop using `the_repository` in `setup_git_directory_gently()`
13:  7485a9e031 = 13:  4981d7d67d setup: stop using `the_repository` in `setup_git_directory()`
14:  5397aac8e7 = 14:  046de3ad97 setup: stop using `the_repository` in `upgrade_repository_format()`
15:  f713bdb472 ! 15:  905b7dbb89 setup: stop using `the_repository` in `check_repository_format()`
    @@ setup.c: enum discovery_result discover_git_directory_reason(struct strbuf *comm
      }
      
     +/*
    -+ * Check the repository format version in the path found in repo_get_git_dir(the_repository),
    ++ * Check the repository format version in the path found in repo_get_git_dir(repo),
     + * and die if it is a version we don't understand. Generally one would
     + * set_git_dir() before calling this, and use it only for "are we in a valid
     + * repo?".
16:  0e1931e40f = 16:  bdf0a02c59 setup: stop using `the_repository` in `initialize_repository_version()`
17:  9cddc161a6 = 17:  74bd848268 setup: stop using `the_repository` in `create_reference_database()`
18:  996771094d = 18:  6fa2476a01 setup: stop using `the_repository` in `init_db()`

---
base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
change-id: 20260330-pks-setup-wo-the-repository-81e51bc55b91

