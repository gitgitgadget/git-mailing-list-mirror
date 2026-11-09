Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202779;
	b=euRpoxWyDSv+FyyiviqGHdEuJQWKTekqSf6jq3Y1Sn+g6kAvR8x65/jhGKU4tK5if4vm
	 8Xwlk0rOsjMD4+qh9qR1gjgPRHPTZrIe+FBoergLOHtqpea8atS1GQ3JHctceT85elsw4
	 S2vfxS8pPnIik686E4HdN94nmrgTm6Vqwow0C/0gPhSoDYwXSLdL5Uon0mBXdhahfK1uy
	 Hd/2KCTkHwMcEIJz1HS0dmSso3kRHcRLIN9qXRmX2pnzHUZri62E2xIBrsx+ZhKKHTo88
	 6SRdGkQex8mqyANPQ/hDn6S7XJA7XioTxdOuaPItJxNA4ZLq1EV5OWBXZzXHMMPJtZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DDob+MccOZ03YDefw7lZn+vZx1gumvTB/l0q6fEF0ak=;
	b=HojNKkhn9CX12qZrdQkBsfTK4XV+5KjNJ0tAXphzM7u76aO0ezK7ZiQjdlLmtqyQDdBJ
	 0aqNOl3I2cQ0eDqF0Fjv0HlaUH4ld1LcZf0L/+apa2L75kNAwCRWRZil477ApQrV0SjiG
	 jeWWM8Co2thJ05dD4GS7lETOmPRYxKDgNy/Pcd99O4kItm7PrLhfK8jAN7Am13JxWlsae
	 vuaLYMMuYLIOx3m9WAAEYGz8QQfolVy4edVMoiKIXijiFvl6clUb1GjaPXUiDRWvSoeNN
	 nPkjk74y2M8ZYizSQroZZEbPIJG+h0nVxGemOiLJO9LEwca5Ct1w9xwgaKu1VUt891Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbY42X9j;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B6606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 05:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbY42X9j
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b70d5b07faso552729a12.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 21:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202776; x=1794807576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDob+MccOZ03YDefw7lZn+vZx1gumvTB/l0q6fEF0ak=;
        b=sbY42X9jTOaJbs8uP3lX1P4668XOVxush6mzSWfX7MpdLPwV9xEU6Ow72rTcAPyVQ3
         uXPy/9tuFU7if7+3OmNS7AHvoHSa7iO7gHw04OhYI650jATfRk90/bbSmSGm13y9SUj9
         +gTzU5SiUtSmeSx/x8DHY5o9tQvj+XT/j7en6Z9nq58MhEU7IIjQB97kwhEmOkBK4x0Q
         2QBiEpY4t8wrgrpouzZvbpw0ZJVl1vgjd/d41rPzbCFoicd077zj7iBw+sh0FZo3iUeb
         omQYrOrh3lYOKsO50F7FeS1cgeUu5yebVr2iORLLbPret34vc2GQqsLzm6ef4vX4btR5
         kDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202776; x=1794807576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDob+MccOZ03YDefw7lZn+vZx1gumvTB/l0q6fEF0ak=;
        b=Wqb1/nVTVO8LCJgkwc15esiUIPfpWqBAB45/rF4VF4Rg8BlQGGIHfwyOvzsER44AaA
         g+k1NoHECfCl4impcKPlx8v5BG9pSDMfqTFTynykCR9QQiQ2dR4WHPKWP3CAYS4m//6h
         2suBl9oaSmBePF+uPeRmdMlibZRfg6+q9I86P1CinF57HULOUXEV35s+DkA72zHykH4F
         hSBk5yBoqYv+H/E0yU9fnQ2UTVf23zwNODVS9ZaYsLz4JiUif31xt22ZZLnj+weSHrMQ
         lOMAGzqSHpdF+OesEWnUcjWH2h62AliLTgLOJlRtxh5RuzaFpGtkmfhc/IXEUrem8xLL
         esOA==
X-Gm-Message-State: APuU4Z+l6vOL9kYni6ZmEpRHUN+dtZi35vA/4rQBakgm2qLRkHN5H2FZ
	QsQg0a2ttCHxppxVTnld01sYXxrZZFzmcvOFbOYuiWEGLlzylCwlWDkw08u/1adFBc3/PQ==
X-Gm-Gg: AYBFou1zILAQ8kBbcn5qqTrgrgu5xD1igqU670u75YvkIu/ACWMFZtXXKfDTFh7qARw
	8r/iVQ57OB5LhDQSWYTnw8sgjkWfjWzqCIcRWR+WRPIq5eREFGdf4gHq+zXHTO1oyh89cGw+ssH
	KPyOaXseGlmFg0Cg7zAd3vkqTDNIr2KTL5zWN6W1/LWaeHNga1/p896IsndE+rsE7kB4SbEPHCS
	WwdrofyK6ftldaXrOCd7k+qN5/XJXNE19TZAkalZ5kDsaH1LIC0I9Ji375HM47I6ncfqKf5rNjy
	eSefCY/J1/rTciyWIZWRZGe9KT/GWu/fU5QT2kb5v2gV67cM8DhKxwpOXdXIcMTYxhHrQcK/sFk
	Csa3TVJsgj0PqV5NUqtmNQ/811INoZYgSZc+VS0qJihhWKzqKz4ee56cbjTX0R6zUfe7DtTzvv8
	jQLsU+jL+q+ya5ZkiXCl1SrnPGgXhw6crcLCtnSmBG/SSjyV1XWJAcLNS6IA3SFgOFdHQQ99dWb
	rdhaIxDa+OUodYvtUjEldAyGjqPt+DxMmod/t1NHBVdE+2ChZJ4Z/b/dBijnep1UMC70MGr3Ngg
	MvFeoNPcC9G7i01pIjaD/wVQiVaHtPOADrpRFKJntn93tPvDjKm25Buhf/pJTUur2e3NwA5zqPm
	XsvPcHChHw1QjZgN0422b3AHBmQYwGHPOKlJFs+JAKUnrkFMPyG6eIv78rYPCD199lz4t6CV0jK
	dIY6c89fxrMMsviNwgdRgvBm/+PH69
X-Received: by 2002:a05:6402:2747:b0:6b4:78c3:b8bf with SMTP id 4fb4d7f45d1cf-6b72242643bmr1755403a12.26.1794202776078;
        Sun, 08 Nov 2026 21:39:36 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ec2f7asm1151346a12.21.2026.11.08.21.39.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:39:34 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [Outreachy][Proposal v3]: Reduce Git's global state to enable Git's libification
Date: Mon,  9 Nov 2026 06:39:20 +0100
Message-ID: <20261109053920.92181-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104083322.80687-1-okhuomonajayi54@gmail.com>
References: <20261104083322.80687-1-okhuomonajayi54@gmail.com>
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

Hello,

This is the third and final version of my proposal for the project
"Reduce Git's global state to enable Git's libification" for the
December 2026 Outreachy internship. v1 is here [16], v2 here [21].

Changes since v2
----------------
- Contributions: updated statuses. diffcore-break and
  diffcore-rename are now in 'master', range-diff and bundle-uri
  are in 'next', and Junio marked merge and merge-blobs ready for
  'next' [23][24].
- Contributions: replaced the notes-utils entry with my 6-patch
  notes series, which fixes notes.c itself first, as Patrick
  suggested [22].
- Blog: added the link to my first post about this contribution
  period.

I'd appreciate any feedback.

Personal Information
====================

Full Name: Okhuomon Rosemary Ajayi
Email: okhuomonajayi54@gmail.com
GitHub: https://github.com/six-shot
Blog: https://okhuomonajayi.hashnode.dev/
Location: Lagos, Nigeria (WAT, UTC+1)

About Me
========

I am Okhuomon Rosemary Ajayi, often known as "sixshot", a
self-taught software developer from Lagos, Nigeria. I am obsessed
with robots and intelligent mechanical systems. C was the first
programming language I picked up, before I moved into frontend and
mobile development. Working on Git during this contribution period
has brought me back to C, and I have enjoyed working at that lower
level again.

Before Git, I contributed to other open source projects. In Servo
I fixed clippy warnings in the script crate and improved some
documentation [12]. In the OCaml ecosystem I added Deflate support
and horizontal differencing to ocaml-tiff, and worked on raven and
YOCaml [13]. In LibreOffice I worked in the C++ core, fixing a bug
where Infobar keys reached the document and cleaning up unit
conversion code [14]. In Mozilla Firefox I fixed layout bugs in
vertical tabs and split view [15].

As a woman in tech, I know how much it helps to see someone like
yourself doing the work. That is why I volunteered to train girls at
Edunity for Girls, helping them get started in tech.

Honestly, I would like to be part of the Git community and keep on
contributing to open source. This project lets me do that in C, the
language I started with, and my patches on the_repository so far
have shown me how much there is to learn here.

Past Experience with Git
========================

I have been using Git since I started coding, for my own projects
and when collaborating with other developers.

This is not my first time on the Git mailing list. I applied to
Outreachy in October 2025 and sent about ten patches in about a week
(patch-ids, commit.c comments, builtin/patch-id.c, gpg-interface)
[10]. None of them were merged. I was sending too fast, my subject
lines had doubled prefixes like "[PATCH] [PATCH v2]", and my commit
messages did not follow the project style, as Junio and Christian
pointed out [11].

This year I slowed down. I read SubmittingPatches properly, wrote
my commit messages in the present tense, and sent one change at a
time. The hardest part was still sending new versions: keeping each
version in sync with the review, the right thread and the notes on
what changed since the last version. This time my microproject and
two more patches (diffcore-break, diffcore-rename) are merged to
'master', range-diff and bundle-uri are in 'next' and marked "Will
merge to 'master'", and Junio marked merge and merge-blobs ready
for 'next'.

Contributions to the Git Community
==================================

Microproject
------------
+ delta-islands: use Q_() for island count
  Thread: https://lore.kernel.org/git/20261013203042.58610-1-okhuomonajayi54@gmail.com/
  Branch: oa/delta-islands-i18n-use-q
  Status: merged to 'master'
  Commit: 60e16b0387 (merge commit 7ac84b7267), listed in the
  Git 2.98.0 release notes
  Description: The island count in a progress message was built with
  a plain _() so translators could not handle plural forms. Use Q_()
  instead. v2 moved a reviewer note below the --- line after
  Junio's review.

Patches related to the project (the_repository)
------------------------------------------------
+ merge: stop using the_repository
  Thread: https://lore.kernel.org/git/20261015142532.48175-1-okhuomonajayi54@gmail.com/
  Branch: oa/merge-without-the-repository
  Status: in 'seen'; Junio: ready for 'next' [23]
  Description: Pass the repository already available at the entry
  points down to the helpers, removing the_repository and
  the_hash_algo from merge.c. Junio pointed out that merge.c still
  calls unpack_trees(), which uses the_repository underneath, and
  sent an RFC to drop USE_THE_REPOSITORY from unpack-trees.c [25].

+ merge-blobs: stop using the_repository
  Thread: https://lore.kernel.org/git/20261017105244.90295-1-okhuomonajayi54@gmail.com/
  Branch: oa/merge-blobs-stop-using-the-repository
  Status: in 'seen'; Junio: ready for 'next' [24]
  Description: Use the repository reachable from the index_state
  instead of the global.
  Usman suggested renaming "r" to "repo"; Junio preferred the short
  "r" used elsewhere for "struct repository *", so I kept it [9].

+ diffcore-break: remove USE_THE_REPOSITORY_VARIABLE
  Thread: https://lore.kernel.org/git/20261014114904.85300-1-okhuomonajayi54@gmail.com/
  Status: merged to 'master' (4e59483d59)
  Description: An earlier commit removed the last use of
  the_repository in diffcore-break.c, so the file no longer needs
  USE_THE_REPOSITORY_VARIABLE. Drop the define.

+ checkout: make unique_tracking_name() use the given repository
  (2 patches)
  Thread (v4): https://lore.kernel.org/git/20261104090534.21838-1-okhuomonajayi54@gmail.com/
  Status: v4 in 'seen' [26]; v4 unwraps the lines Christian pointed
  out now that they are shorter
  Description: Pass the repository to unique_tracking_name() and
  carry it in struct tracking_name_data, so checkout.c no longer
  needs USE_THE_REPOSITORY_VARIABLE. Usman asked for a clearer
  commit message in v1. In v2 Junio pointed out that the function
  still walked the remotes with for_each_remote(), which only works
  on the_repository, so v3 adds repo_for_each_remote() first.

+ diffcore-rename: stop using the_repository
  Thread: https://lore.kernel.org/git/20261024221341.92086-1-okhuomonajayi54@gmail.com/
  Status: merged to 'master' (5eaaabe82a)
  Description: diffcore_rename_extended() already has the
  repository through its options. Use its hash algorithm when
  checking for empty blobs, pass it to start_delayed_progress(),
  and drop USE_THE_REPOSITORY_VARIABLE. Patrick reviewed it and
  said it looks correct.

+ notes-cache: read the cache ref from the given repository
  Thread: https://lore.kernel.org/git/20261026102603.32377-1-okhuomonajayi54@gmail.com/
  Status: reviewed by Junio, waiting to be queued
  Description: notes_cache_match_validity() already receives the
  repository but read the ref from the_repository. Pass it to
  get_main_ref_store() so the check reads the same repository.

+ combine-diff: use the repository from diff options
  Thread: https://lore.kernel.org/git/20261026111303.92117-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: show_combined_header() and show_patch_diff()
  already have opt->repo; use it for the hash algorithm,
  abbreviation and gitlinks. The file still needs the macro for
  DEFAULT_ABBREV, which depends on the default_abbrev global.

+ negotiator/default: stop using the_repository
  Thread (v2): https://lore.kernel.org/git/20261103155038.87456-1-okhuomonajayi54@gmail.com/
  Status: v2 in 'seen', after Christian's review (use the local
  variable I had introduced, and take the repository as the first
  argument, like most functions)
  Description: Give default_negotiator_init() a repository,
  store it on the negotiation state and use it to parse commits,
  clear marks and walk refs. Drop USE_THE_REPOSITORY_VARIABLE.

+ bundle-uri: stop using the_repository
  Thread (v2): https://lore.kernel.org/git/20261029131325.79176-1-okhuomonajayi54@gmail.com/
  Status: v2 in 'next', marked "Will merge to 'master'"
  Description: unbundle_from_file() unbundles objects into the
  given repository but read and wrote refs in the_repository, and
  fetch_bundle_uri() used the_repository for tracing. v1 used the
  given repository for both and was reviewed by Karthik. Patrick
  then pointed out that only two more uses were left in the file,
  in find_temp_filename() and copy_uri_to_file(), so v2 passes the
  repository to them too and drops USE_THE_REPOSITORY_VARIABLE
  from bundle-uri.c.

+ range-diff: use diffopt->repo instead of the_repository
  Thread (v2): https://lore.kernel.org/git/20261029084720.93221-1-okhuomonajayi54@gmail.com/
  Status: in 'next', marked "Will merge to 'master'"
  Description: output_pair_header() and patch_diff() receive a
  diffopt that names the repository, but still used the_repository
  and the_hash_algo. Use diffopt->repo, and give get_filespec() a
  hash algorithm parameter. v2 rewords the commit message after
  Pablo's review.

+ pseudo-merge: use writer->repo instead of the_repository
  Thread: https://lore.kernel.org/git/20261029194116.63464-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: The functions in pseudo-merge.c receive a
  bitmap_writer that names the repository, but used the_repository.
  Use writer->repo, give push_pseudo_merge() a repository
  parameter, and drop USE_THE_REPOSITORY_VARIABLE.

+ name-hash: use istate->repo instead of the_repository
  Thread: https://lore.kernel.org/git/20261030183218.32630-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: Three functions receive the index but read
  core.ignoreCase through the_repository. Read it from istate->repo
  and drop USE_THE_REPOSITORY_VARIABLE.

+ fsmonitor: stop using the_repository
  Thread: https://lore.kernel.org/git/20261031111450.66192-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: refresh_fsmonitor() gets its repository from the
  index, but the helpers it calls used the_repository. Pass the
  repository to fsmonitor_hook_version(), use the one the other
  helpers already have, and drop USE_THE_REPOSITORY_VARIABLE.

+ wt-status: use the repository the status already has
  Thread: https://lore.kernel.org/git/20261101063951.85427-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: Use s->repo and r where the functions already have
  a repository. The define stays because DEFAULT_ABBREV expands to
  the global default_abbrev.

+ notes: use the repository stored in the notes tree (6 patches)
  Thread: https://lore.kernel.org/git/20261105203344.48513-1-okhuomonajayi54@gmail.com/
  Status: sent, waiting for review
  Description: This replaces my earlier notes-utils series. Its v1
  made create_notes_commit() and commit_notes() use the repository
  they are given, and v2 also dropped USE_THE_REPOSITORY_VARIABLE
  after Patrick asked why I stopped short. Junio then pointed out
  that this is misleading: the notes.c functions that notes-utils.c
  calls still only work with the_repository [20]. I first sent a
  patch hiding those functions, but Patrick suggested fixing
  notes.c instead [22]. This series stores the repository in
  struct notes_tree, uses it in notes.c for reading, writing and
  pruning notes and in the combine_notes callbacks, and passes it
  to the ref glob helpers. After that, notes-utils.c really no
  longer needs USE_THE_REPOSITORY_VARIABLE. This taught me to
  follow the calls down before claiming a file no longer depends
  on the_repository.

+ environment: move commit_encoding into repo_config_values
  Thread: https://lore.kernel.org/git/20261021155608.58509-1-okhuomonajayi54@gmail.com/
  Status: v1 reviewed by Junio; v2 in progress
  Description: v1 moved the global into struct repo_config_values.
  Junio pointed out that only commit.c uses it and suggested passing
  a "const char *" encoding down to the functions instead of the
  whole repository. v2 will do that.

Other patches
-------------
+ credential-store: add lockTimeout config option (#leftoverbits)
  Thread (v2): https://lore.kernel.org/git/20261016212216.58000-1-okhuomonajayi54@gmail.com/
  Status: v2 sent after Junio's review, waiting
  Description: Junio noted in the rerere thread that
  credentialStore.lockTimeoutMS is the only timeout setting with
  the unit in its name, and suggested a synonym without "MS". Add
  credentialStore.lockTimeout; the old name keeps working.

Reviews and help to other applicants
------------------------------------
+ list-objects-filter-options: pass repository to partial clone
  helpers (Dorine Tipo)
  My reply: https://lore.kernel.org/git/CAFpMFfCu6JrUC8i453qBP=AktqcG_9sGX=1-1ekEDCYm_+pkUw@mail.gmail.com/
  Description: Dorine asked whether USE_THE_REPOSITORY_VARIABLE
  could be dropped. I applied the patch, removed the define and
  checked that the file still builds, so it can go in the same
  patch. Dorine added it to v2 with a Helped-by trailer.

+ submodule: use the submodule repository to abbreviate commits
  (Srujith Poojary)
  My review: https://lore.kernel.org/git/CAFpMFfALb1KbEw-dc4wYCxS4PXfDBwzQOD6YPRe52_bpRnGt9w@mail.gmail.com/
  Description: Confirmed that the new test fails without the fix,
  and suggested describing the problem first, naming the code area
  in the title, choosing the repository once, and falling back to
  o->repo instead of the_repository. Srujith applied all of them
  in v2. On v2 I pointed out that "git log" on submodule.c always
  writes the area in lowercase, which he fixed in v3, and Junio
  queued the patch.

+ Microproject idea: modernize a file-existence check in
  t/t0081-find-pack.sh (Immaculate Mecha)
  My reply: https://lore.kernel.org/git/CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com/
  Description: Pointed out that Shashank S had already changed that
  exact line, and suggested searching lore and "What's cooking"
  before choosing a microproject.

Git Rev News
------------
+ Proofread edition 140 and fixed typos in the Developer Spotlight
  interview (https://github.com/git/git.github.io/pull/878). It was
  merged, and I am credited in the published edition.

Learning resource
-----------------
+ "Learn C by reading Git" -- a zero-to-hero guide
  Link: https://six-shot.github.io/six-shot-git-c-zero-to-hero/
  Description: C was the first language I learned, but I had not
  used it in a while. I built this guide during this Outreachy
  contribution period so I could understand C well by learning it
  with Git itself. It teaches C from zero using real code from
  git.git (repository.h, merge-blobs.c, git.c, ...), with
  exercises. It covers the patterns this project depends on:
  structs and pointers, passing "struct repository *" down a call
  chain, and why global variables like the_repository are a
  problem. I hope it also helps other people who want to start
  contributing to Git.

Project Overview
================

Git keeps the state of the repository it is working on in a single
global object, the_repository, which is a "struct repository". A
lot of internal code uses this global directly instead of taking a
repository as a parameter. On top of that, many configuration and
environment values are stored as global variables in environment.c
rather than in the repository they belong to.

This design assumes that a process only ever works with one
repository. That is not true for things like submodules, and it is
one of the main things blocking the long-term goal of libifying Git,
where a program could open several repositories at the same time.
With shared globals, two repositories in one process would read and
overwrite the same values, which can lead to wrong behaviour that is
hard to debug. It also makes the code harder to read and test,
because a function's dependencies are hidden instead of being
visible in its parameters.

This project reduces that global state step by step:
- removing the_repository from library code by passing the
  repository explicitly through the call chain, so files no longer
  need USE_THE_REPOSITORY_VARIABLE;
- moving repository-specific settings from environment.c into the
  repository, mostly struct repo_config_values and struct
  repo_settings;
- and, where a value is only used in one place, passing just that
  value down instead of the whole repository.

A lot of progress has already been made: many settings that used
to be globals now live in struct repo_config_values, and many files
no longer need the_repository. But there is still plenty left.
Over a hundred library files outside builtin/ still define
USE_THE_REPOSITORY_VARIABLE, and environment.h still has globals
such as git_commit_encoding, git_log_output_encoding and
comment_line_str. That remaining library code is where I want to
focus.

Review of Previous Work and Strategies
======================================

From reading past series on the list and from my own patches, I see
three strategies, and the right one depends on the variable:

1. Thread the repository through the call chain, bottom-up.
   Patrick Steinhardt introduced USE_THE_REPOSITORY_VARIABLE so files
   that still depend on the global are marked [1]. Work then goes from
   the lowest layers up, removing the macro file by file (objects [2],
   path [3], packfile by Karthik [4]). My patches to merge.c,
   merge-blobs.c, diffcore-break.c, diffcore-rename.c, checkout.c,
   notes-cache.c, combine-diff.c, negotiator/default.c,
   bundle-uri.c, range-diff.c and notes.c follow this pattern.

2. Move repository-scoped config into the repository.
   core.hooksPath and core.sharedRepository moved into repo-settings
   with accessors [3]. Later, Olamide Caleb Bello's Outreachy series
   added struct repo_config_values, with repo_config_values(repo) as
   the accessor, and moved core.attributesFile, core.sparseCheckout
   and branch.autoSetupMerge into it [5]. Others, such as Tian Yuchen,
   have moved more values there since.

3. Pass only the value the function needs.
   the_hash_algo was replaced by an explicit
   "const struct git_hash_algo *" in csum-file.c [2]. Junio asked for
   the same thing on my commit_encoding patch: since only commit.c
   uses the variable, pass the encoding string instead of adding it
   to repository config [6].

Roadblocks seen in earlier work
-------------------------------
- Not every global belongs in struct repository. When Ayush
  Chandekar tried to move core.attributesfile into repo_settings,
  Junio questioned whether attribute data belongs to a repository at
  all, since attributes come from the index and the working tree,
  and compared it to how index_state is passed around instead of the
  repository [7]. The config value was later stored in struct
  repo_config_values instead [5].
- State used during early startup cannot simply be moved; the setup
  code has to change first. Patrick did this for
  is_bare_repository_cfg and git_work_tree_cfg in his "setup: drop
  global state" series [8]. have_git_dir() is still left, and
  environment.h says it "should not have to exist at all".
- builtin/ commands: the "repo" argument of cmd_foo() can be NULL
  (e.g. "git foo -h" outside a repository), so blindly replacing
  the_repository there causes crashes. Library code is the safer
  target.
- Naming: Junio prefers a short "r" for "struct repository *"
  parameters [9], and most functions take it as their first
  argument.
- Hidden dependencies: a file can pass a repository everywhere and
  still depend on the_repository through the functions it calls.
  For notes-utils.c, the notes.h functions underneath still only
  work with the_repository, so dropping the define there would
  have been misleading [20]. My notes series now fixes notes.c
  first, and Junio made the same point about merge.c and
  unpack_trees() [23]. Before dropping a define I now follow the
  calls down into the other files.

Can there be clear criteria? Only partly. My working checklist:
  a. Who reads and writes it? (git grep every use)
  b. Is it per-repository, per-index, per-subsystem or process-wide?
  c. Is it needed before a repository is set up?
  d. Does only one file use it? Then pass the value (strategy 3).
  e. Search the list for earlier attempts and objections first.
Anything still unclear goes to the list as a question before code.

Example: git_log_output_encoding
--------------------------------
This is the encoding Git uses when it shows commit messages. It is
the twin of git_commit_encoding, which my commit_encoding patch
works on, but it is harder:

- It is set in two places: from i18n.logOutputEncoding in
  environment.c, and from "git log --encoding=..." in revision.c.
  Other revision options like --reverse are stored in struct
  rev_info, but --encoding writes the global. The parsing was moved
  into revision.c in 2006 (7cbcf4d557) so that rev-list and
  diff-tree could use it too, and at that time the rest of the
  code read the encoding from a global anyway.

- It is read through get_log_output_encoding() 15 times in 12
  files. Many of these callers (log-tree.c, bundle.c, submodule.c,
  sequencer.c) copy it into
  "struct pretty_print_context.output_encoding", so that struct
  already carries the value. That points to strategy 3: fill the
  context once from the caller and let the pretty-printing code use
  ctx->output_encoding instead of calling the global getter.

- Some callers do not print a log: remote-curl.c uses it to
  re-encode an error message from the server, and sequencer.c uses
  it when building the todo list. So the value is really "the
  user's display encoding", not something that belongs to one
  repository. That is a reason NOT to put it in
  repo_config_values, which is also what Junio said about
  commit_encoding [6].

My plan for it: first do commit_encoding (single caller), then
propose on the list storing the --encoding value in struct rev_info
and passing it through pretty_print_context, and ask whether that
design is acceptable before writing the series.

Internship Plan and Timeline
============================

The internship runs from 7 December 2026 to 8 March 2027.

Before the internship (now -- 6 Dec 2026)
- Finish open patches: commit_encoding v2, the notes series and
  the others waiting for review. No new topics until those are
  reviewed.
- Keep reviewing other applicants' patches in the global-state area.
- Build a list of remaining globals and USE_THE_REPOSITORY_VARIABLE
  files outside builtin/, ordered by how low in the call graph they
  sit.

Weeks 1-2 (7 Dec -- 20 Dec)
- Agree the list and order with mentors.
- First series: a group of related library files off
  USE_THE_REPOSITORY_VARIABLE, sent together instead of one topic
  per file [19].
- First blog post.

Weeks 3-6 (21 Dec -- 17 Jan)
- environment.c globals that only one subsystem uses: pass the value
  down, as Junio suggested for commit_encoding.
- git_log_output_encoding next: it is read in 12 files and also set
  by "--encoding", so agree the design on the list before coding.
- Ask on the list before touching the comment_line_str group and the
  abbrev globals, since they are read in many places.

Weeks 7-10 (18 Jan -- 14 Feb)
- Continue bottom-up removal of the_repository in library code,
  one subsystem per series.
- Move reusable code out of builtin/ into library helpers, which
  Junio describes as useful work because builtin/ code cannot be
  reused [18]. Agree candidates with mentors first.
- Look at a harder item if mentors agree, such as have_git_dir(),
  which still depends on the_repository.

Weeks 11-13 (15 Feb -- 8 Mar 2027)
- Land rerolls, no new big series.
- Final report on the blog and the list.
- Update the "Learn C by reading Git" guide with what I learned.

Throughout: related changes batched into one series, reply to
reviews within a day or two,
weekly blog post, weekly sync with mentors.

Availability
============

I can give 40 hours a week to the project during the internship.
I am based in Lagos (WAT, UTC+1) and can adjust my hours for calls
and reviews when needed.

Blogging
========

I will blog on Hashnode (https://okhuomonajayi.hashnode.dev/),
which anyone can read without an account, and post weekly updates
on my progress, what I learned and the challenges I faced. I will
share each post on the mailing list, like previous interns did.

My first post is about this contribution period:
https://okhuomonajayi.hashnode.dev/my-outreachy-contribution-period-with-git-removing-global-state-one-patch-at-a-time

After the Internship
====================

After the internship I want to continue as an open source
contributor to Git: sending patches, reviewing others' work and
helping new contributors get started, the way Usman and Junio
helped me. I also want to keep the "Learn C by reading Git" guide
up to date so it stays useful for future applicants.

Appreciation
============

I want to thank Usman and Junio for always helping out during this
contribution period. I also want to thank Patrick, Karthik, Pablo,
Christian, Siddharth and Kaartic, who reviewed my work and gave me
feedback, and everyone in the Git community for being so welcoming.

References
==========
[1] https://lore.kernel.org/git/cover.1718347699.git.ps@pks.im/
[2] https://lore.kernel.org/git/20250306-b4-pks-objects-without-the-repository-v2-1-f3465327be69@pks.im/
[3] https://lore.kernel.org/git/20250207-b4-pks-path-drop-the-repository-v2-14-13cad3c11b8a@pks.im/
[4] https://lore.kernel.org/git/cover.1733236936.git.karthik.188@gmail.com/
[5] https://lore.kernel.org/git/cover.1771258573.git.belkid98@gmail.com/
[6] https://lore.kernel.org/git/xmqq33tyn5qi.fsf@gitster.g/
[7] https://lore.kernel.org/git/xmqqwmcw97z2.fsf@gitster.g/
[8] https://lore.kernel.org/git/20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im/
[9] https://lore.kernel.org/git/xmqqwlrcrqaz.fsf@gitster.g/
[10] https://lore.kernel.org/git/20251009214445.1190274-1-okhuomonajayi54@gmail.com/
[11] https://lore.kernel.org/git/CAP8UFD2sdvkv_ZqiLZU9k5zF+tM3UTQ8+mJjziRZGzOra6dMFA@mail.gmail.com/
     https://lore.kernel.org/git/xmqqo6q5z6iu.fsf@gitster.g/
[12] https://github.com/servo/servo/pulls?q=is%3Apr+author%3Asix-shot+is%3Amerged
[13] https://github.com/geocaml/ocaml-tiff/pull/80
     https://github.com/raven-ml/raven/pulls?q=is%3Apr+author%3Asix-shot
     https://github.com/xhtmlboi/yocaml/pulls?q=is%3Apr+author%3Asix-shot
[14] https://gerrit.libreoffice.org/q/owner:okhuomonajayi54@gmail.com+status:merged
     https://whatsnew.libreoffice.org/25.8.4/
[15] https://github.com/mozilla-firefox/firefox/commits?author=okhuomonajayi54@gmail.com
[16] https://lore.kernel.org/git/20261029141818.40193-1-okhuomonajayi54@gmail.com/
[17] https://lore.kernel.org/git/CAP8UFD1VUCTeXNbb4YKGkZRWY8i56Zms_=qkR2oqF7e1Aagy1Q@mail.gmail.com/
[18] https://lore.kernel.org/git/xmqqmru76ybk.fsf_-_@gitster.g/
[19] https://lore.kernel.org/git/auhtiZ86trLamccS@pks.im/
[20] https://lore.kernel.org/git/xmqqjymt94l3.fsf@gitster.g/
[21] https://lore.kernel.org/git/20261104083322.80687-1-okhuomonajayi54@gmail.com/
[22] https://lore.kernel.org/git/auyRGpaHb5rdVP0d@pks.im/
[23] https://lore.kernel.org/git/xmqq33tdcuub.fsf@gitster.g/
[24] https://lore.kernel.org/git/xmqqy0b59xvs.fsf@gitster.g/
[25] https://lore.kernel.org/git/xmqqtsltbfdv.fsf@gitster.g/
[26] https://lore.kernel.org/git/20261104090534.21838-1-okhuomonajayi54@gmail.com/

Thanks for reading.

Okhuomon Ajayi
