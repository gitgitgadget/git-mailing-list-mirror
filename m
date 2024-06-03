Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C383CA3
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407990; cv=none; b=KMFwwrezawXr+Hxvy5C7E/iEtIqInozJ23/mP38Qw9ZTBUbW31KfKd9Co8n4loo62AmVxsC7iKs8ZEODxKn0P6+ot4ERvPtlk22f58NznBVV1r3R+wc17j4kFiTRt8aZ8y1UwS9o0jXP7AvRYCWk40wwAo0su3PFF+4HZ93sv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407990; c=relaxed/simple;
	bh=q0ojwg9CatV63inep21xj8BJfFTcb43Nga6RM1ucF5s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p7n7nhZLlE5plzL6yE2U54j13JHb8n6DlzfFW1WnxhrOw3wIXodZJeIhkTD8dGEbn682JlkxutcM43mqiiSGcsWmE4M5LTm5ZhcpHGFqXjCD9aXMf4m44FqaCFtS4DCuPdRToVVyJ/8bq7OfqsKhAAqJxWV1/XFaJgOknG10Mks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pei2TuIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5qtf3wz; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pei2TuIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5qtf3wz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id E4971180009A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1717407987; x=1717494387; bh=BWvkeaA71dMacZvlqXpImmsqs8hZSDcP
	kf53iUio9NQ=; b=pei2TuIFD052v2d8ppWy3xF5T+DXsdeEwEHXN29hXnKjQVcE
	823QNlCzd/7jl3TP8qFyftBvWcpSFUGtY9sYLJiopIlmAnhuRMvr/yZ6gEzE6qL6
	P0cpgSQrBIbdTZOn7cfeMDllwfZHH08WPtdv9cqw1pprAWG3xaac9m/xv0BetIME
	/TqO1haGaKIjsGZuWGOyFTVjqj6yuVvLWBfSYyrLYFuntzg+Bv7yoa3dUbhRLIEd
	UhntNmDyely5tfBFEd8TsncNvw06H+UF5QP6fKfVN8ZMbvJ/y8yfgw5djmT5Mnhi
	rUdHFKtw/wSe9fuqVFZceXe34yAsCkz/7boVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1717407987; x=1717494387; bh=BWvkeaA71dMacZvlqXpImmsqs8hZSDcPkf5
	3iUio9NQ=; b=f5qtf3wzHPN6nQXJ8m1ITazCcqagvuYhP/x8dv/usgOdJrpd7qv
	y90QMmiQWr7CIttmRJ45cya44ZhrOFAwezkSkF6he1BOQaqJgfpcfUHIM5bp/pXf
	SSpUju51gyIVL7QPelZCI/UOl2QsCq5/gzHp2W+WGT8Gx4EeS36d6oX+OL5uXfgZ
	ArgrIquUSSHVTB7a6XFe5SB/cW9pb3Ca1IjxzVQuX5bpgtPuJdZw2finBess/FCC
	jHPIZtkfl5e4puOzUq2QSJwvZY/YfJSAN7giYACNcWbHWi7z9tcg3sNir9Ze/xIj
	jSLX0TO0YBLUHuVoCQs8VP39tP/+93u67DQ==
X-ME-Sender: <xms:85BdZvYLOR-xVRw294yv1ddHX_9O0f8MFClwLJBcHOwMF2QNoFqyIA>
    <xme:85BdZuY3xy7j2sdRA9xXgszlvOkuV4D8ZBYplgWjCz43oHFGu-k9ULK7gIDr2w099
    fCW0lIZPHd0ZwCbwQ>
X-ME-Received: <xmr:85BdZh_Jc9qgAkulpebs9EQceo26dLaNIypbxyk1Gq1qtZaEealrfleR34Rxcrx43w7sXXTw7ZaYbZTdqa_S5C3mWFBoY4YHhSQFnIe4oeSrKsu1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:85BdZlrodZlJl5GyKgiDd6jH3cuvcR1l0UuAAive0xaqpGiNDficEg>
    <xmx:85BdZqqOMMHzT1b3ZtoVjxvYv8glEY6Yd5qdxozN1So04YGW5zUsyg>
    <xmx:85BdZrQWeFO9_kbXxVDqqV1XxEIsMkcS_OElRxRsojOzwpYCy5li9g>
    <xmx:85BdZir0FOcTv0FQbfgTC1aGVll6umXS_YS9O52HzQj_LHtRCNWcDg>
    <xmx:85BdZvDk25k5vXZBWnsxcojaVhzO9VH8h2O2UDxJ3NFjZxsZVKDrjajc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6a980184 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:01 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/29] Memory leak fixes (pt.2)
Message-ID: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZoGZ8d8GQ1kFbp9Z"
Content-Disposition: inline


--ZoGZ8d8GQ1kFbp9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is another random assortment of memory leak fixes for Git. With
these changes, another 77 test suites start to pass with the leak
sanitizer enabled. With that, we're down to ~270 test suites that do not
yet pass with the sanitizer enabled. My goal is that we can reduce this
number to 0 this year -- any help here would be appreciated.

While most of the commits are trivial, I realize that the overall series
is quite large. If you think that this is too big, please feel free to
speak up up and I'll split this and future series into batches of at
most 20 patches or less, if you think that's still too many.

The series is built on top of 9eaef5822c (Sync with 'maint', 2024-05-31)
with ps/leakfixes at 164937678c (Merge remote-tracking branch
'junio/ps/leakfixes' into HEAD, 2024-06-03) merged into it.

Thanks!

Patrick Steinhardt (29):
  revision: fix memory leak when reversing revisions
  parse-options: fix leaks for users of OPT_FILENAME
  notes-utils: free note trees when releasing copied notes
  bundle: plug leaks in `create_bundle()`
  biultin/rev-parse: fix memory leaks in `--parseopt` mode
  merge-recursive: fix leaging rename conflict info
  revision: fix leaking display notes
  notes: fix memory leak when pruning notes
  builtin/rev-list: fix leaking bitmap index when calculating disk usage
  object-name: free leaking object contexts
  builtin/difftool: plug memory leaks in `run_dir_diff()`
  builtin/merge-recursive: fix leaking object ID bases
  merge-recursive: fix memory leak when finalizing merge
  builtin/log: fix leaking commit list in git-cherry(1)
  revision: free diff options
  builtin/stash: fix leak in `show_stash()`
  rerere: fix various trivial leaks
  config: fix leaking "core.notesref" variable
  commit: fix leaking parents when calling `commit_tree_extended()`
  sequencer: fix leaking string buffer in `commit_staged_changes()`
  apply: fix leaking string in `match_fragment()`
  builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
  sequencer: fix memory leaks in `make_script_with_merges()`
  builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
  merge: fix leaking merge bases
  line-range: plug leaking find functions
  blame: fix leaking data for blame scoreboards
  builtin/blame: fix leaking prefixed paths
  builtin/blame: fix leaking ignore revs files

 apply.c                                   |  88 ++++++++++-------
 apply.h                                   |   2 +-
 blame.c                                   |   4 +
 builtin/am.c                              |   7 +-
 builtin/archive.c                         |   7 +-
 builtin/blame.c                           |   8 +-
 builtin/cat-file.c                        |  17 ++--
 builtin/clone.c                           |   3 +-
 builtin/commit-tree.c                     |  11 ++-
 builtin/commit.c                          |  10 +-
 builtin/difftool.c                        |   3 +
 builtin/fmt-merge-msg.c                   |   4 +-
 builtin/grep.c                            |   4 +-
 builtin/log.c                             |  16 ++--
 builtin/ls-tree.c                         |   3 +-
 builtin/merge-recursive.c                 |   6 +-
 builtin/merge-tree.c                      |   1 +
 builtin/merge.c                           |  18 +++-
 builtin/multi-pack-index.c                |  13 ++-
 builtin/replay.c                          |  14 ++-
 builtin/rev-list.c                        |   2 +
 builtin/rev-parse.c                       |  55 ++++++-----
 builtin/shortlog.c                        |   5 +-
 builtin/sparse-checkout.c                 |   1 +
 builtin/stash.c                           |  23 +++--
 bundle.c                                  |  29 ++++--
 commit.c                                  |  28 +++---
 commit.h                                  |  12 +--
 config.c                                  |   1 +
 diff-lib.c                                |   2 +
 diff.c                                    |   8 +-
 help.c                                    |  12 +--
 help.h                                    |   2 +
 line-range.c                              |   2 +
 list-objects-filter.c                     |   2 +
 log-tree.c                                |   1 +
 merge-ort-wrappers.c                      |   2 +-
 merge-ort-wrappers.h                      |   2 +-
 merge-ort.c                               |  12 ++-
 merge-ort.h                               |   2 +-
 merge-recursive.c                         |  68 ++++++++-----
 merge-recursive.h                         |   4 +-
 notes-merge.c                             |   1 +
 notes-utils.c                             |   9 +-
 notes-utils.h                             |   2 +-
 notes.c                                   |  21 +++--
 notes.h                                   |   5 +
 object-name.c                             |  40 +++++---
 object-name.h                             |   2 +
 rerere.c                                  |   3 +
 revision.c                                |  59 +++++++-----
 sequencer.c                               | 110 +++++++++++++++-------
 t/helper/test-parse-options.c             |   1 +
 t/t1004-read-tree-m-u-wf.sh               |   1 +
 t/t1015-read-index-unmerged.sh            |   2 +
 t/t1021-rerere-in-workdir.sh              |   1 +
 t/t1512-rev-parse-disambiguation.sh       |   1 +
 t/t2500-untracked-overwriting.sh          |   1 +
 t/t3301-notes.sh                          |   1 +
 t/t3306-notes-prune.sh                    |   1 +
 t/t3308-notes-merge.sh                    |   1 +
 t/t3309-notes-merge-auto-resolve.sh       |   1 +
 t/t3400-rebase.sh                         |   1 +
 t/t3401-rebase-and-am-rename.sh           |   1 +
 t/t3403-rebase-skip.sh                    |   1 +
 t/t3406-rebase-message.sh                 |   1 +
 t/t3407-rebase-abort.sh                   |   1 +
 t/t3417-rebase-whitespace-fix.sh          |   1 +
 t/t3418-rebase-continue.sh                |   1 +
 t/t3420-rebase-autostash.sh               |   1 +
 t/t3421-rebase-topology-linear.sh         |   2 +
 t/t3424-rebase-empty.sh                   |   1 +
 t/t3428-rebase-signoff.sh                 |   1 +
 t/t3430-rebase-merges.sh                  |   1 +
 t/t3434-rebase-i18n.sh                    |   1 +
 t/t3500-cherry.sh                         |   1 +
 t/t3504-cherry-pick-rerere.sh             |   1 +
 t/t3505-cherry-pick-empty.sh              |   1 +
 t/t3508-cherry-pick-many-commits.sh       |   1 +
 t/t3509-cherry-pick-merge-df.sh           |   1 +
 t/t3907-stash-show-config.sh              |   1 +
 t/t4061-diff-indent.sh                    |   1 +
 t/t4131-apply-fake-ancestor.sh            |   1 +
 t/t4151-am-abort.sh                       |   1 +
 t/t4153-am-resume-override-opts.sh        |   1 +
 t/t4208-log-magic-pathspec.sh             |   1 +
 t/t4253-am-keep-cr-dos.sh                 |   1 +
 t/t4255-am-submodule.sh                   |   1 +
 t/t5150-request-pull.sh                   |   1 +
 t/t5300-pack-object.sh                    |   4 +-
 t/t5305-include-tag.sh                    |   1 +
 t/t5407-post-rewrite-hook.sh              |   1 +
 t/t5605-clone-local.sh                    |   1 +
 t/t5607-clone-bundle.sh                   |   1 +
 t/t5612-clone-refspec.sh                  |   1 +
 t/t6000-rev-list-misc.sh                  |   1 +
 t/t6001-rev-list-graft.sh                 |   1 +
 t/t6013-rev-list-reverse-parents.sh       |   1 +
 t/t6017-rev-list-stdin.sh                 |   1 +
 t/t6020-bundle-misc.sh                    |   1 +
 t/t6115-rev-list-du.sh                    |   2 +
 t/t6130-pathspec-noglob.sh                |   2 +
 t/t6402-merge-rename.sh                   |   1 +
 t/t6427-diff3-conflict-markers.sh         |   1 +
 t/t6430-merge-recursive.sh                |   1 +
 t/t6432-merge-recursive-space-options.sh  |   1 +
 t/t6434-merge-recursive-rename-options.sh |   1 +
 t/t6436-merge-overwrite.sh                |   1 +
 t/t7006-pager.sh                          |   1 +
 t/t7010-setup.sh                          |   1 +
 t/t7012-skip-worktree-writing.sh          |   1 +
 t/t7201-co.sh                             |   1 +
 t/t7501-commit-basic-functionality.sh     |   1 +
 t/t7505-prepare-commit-msg-hook.sh        |   1 +
 t/t7512-status-help.sh                    |   1 +
 t/t7600-merge.sh                          |   1 +
 t/t7606-merge-custom.sh                   |   1 +
 t/t7611-merge-abort.sh                    |   1 +
 t/t8002-blame.sh                          |   1 +
 t/t8003-blame-corner-cases.sh             |   1 +
 t/t8004-blame-with-conflicts.sh           |   1 +
 t/t8006-blame-textconv.sh                 |   2 +
 t/t8008-blame-formats.sh                  |   2 +
 t/t8009-blame-vs-topicbranches.sh         |   2 +
 t/t8011-blame-split-file.sh               |   2 +
 t/t8012-blame-colors.sh                   |   1 +
 t/t8013-blame-ignore-revs.sh              |   2 +
 t/t8014-blame-ignore-fuzzy.sh             |   2 +
 t/t9500-gitweb-standalone-no-errors.sh    |   1 +
 t/t9502-gitweb-standalone-parse-output.sh |   1 +
 130 files changed, 588 insertions(+), 269 deletions(-)

--=20
2.45.1.410.g58bac47f8e.dirty


--ZoGZ8d8GQ1kFbp9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkO4ACgkQVbJhu7ck
PpQEeA//RJrTbrJikYiN9hc80PkbuvdJD5jRR7x/l+SSAEBxTXt17Tl4jLTDX9rH
jMsyeWyY9i6SvtCLbuKk+enqpJxN3SOpfmh+GHp1ofAzzezp2uR7y9CBnNdYG8h9
zrYFEzldFMXlUpSjSDSi8mVhP7QLRwNRKvBNQKkntX2QMF1rl3gPrqIhejslxGKy
uUV0XxdCcOtwUWUEGafGcOL7NUDivF4SWDaAT4W6ZBVGqDOaNogJEl+M6/8Crfqc
ZTGNz3tOfYSh1o03z1JOAFaFk194RMbmCnEjTeaPDDu2yGTphEeP0Qb/f8msqJyZ
HobndXsKtRxwuygmLSqaEh2qWK88OvAQOC9IwBkMKZi90d+NifM5lFb/d1Olb7vE
ueOaYgzyH4TvfTqUMLph8TE1RES9AUuPUuvdUMKf848KTZqnqe74xX97TtvKYlrf
N/5oPDZ7JBMluezQFW4lTyBQLqk7yVgPfpVBcNh9k8gAnOu+6eRdu20h/OgQ6YcP
+Y7GVQuv508pNqpJGeOY2vWWmSvPuCu2dUyBnmthrheLHV1jD3tyOJZKctbhUxeW
qus8u3/AsqWz6ILhgzV75Mb4/Uv8BFrR5rIjnt/Ri8yHRy2aAFCF059i2VWTSTK+
es7M7R1UQPioiQkTKGMUXdLLvgoY55tVDxU+kooiMBS0ZWQSYSk=
=u5n7
-----END PGP SIGNATURE-----

--ZoGZ8d8GQ1kFbp9Z--
