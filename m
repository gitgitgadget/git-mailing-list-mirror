Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090332;
	b=fCKTVGQbFqDUmsmP747k0EZK3cl4w2ElWGWslJYa6Wp619DpM4YC4CbcXpDXUH3kFB6T
	 XHfq3oPp+IC6n4CpqTJE6XyRq/Wwrcx1zRcetl52jAHAcL3GrJrWhsm0hTG2/nU0rekPu
	 ft8mOdyiOrUlRS6RQ9uZSNbhz79tAIkEX69/OZFZlUHK09AwbtWb2nI0dzf5KZCX3b+MG
	 CCopICZ29DueJJgjmS1hCMm86PIKH6lpx1w0KYj5iHzkvSWa6k53q4GUtBGsICK5efY2Y
	 ILxZ+Oc5CfNktRnk5f/tqsDV0Cr6B+HfX+KhdaAE6wTUMNgDyZ4jBfpSplpWIBizJww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=dyCzdSZE9byzCLwEptS/6nKXLiDwQxdxKs++6j/xEjs=;
	b=nnbJSUIm8Ll6yrOQm7gRUQh94kf2WOEpFeWQAiHHqVKle5l6HzTiRNjHQDgb4CzlII44
	 vCa5ijHPTfdGWQQzDrPyLtasqtBwya1Vy9OvcEUMAN49TLoBj3IFRT0HZj1yC9Bk+TtWD
	 TpZy+qXOjK7XKBLp+HOkFzWvWPiPcX/eo+u/62rferoZ76bcjqN4iLap+CkK5hdSDSMtD
	 mJWhYxcsceJ569fxTjZQDrpA4FiWLiyAswfcKPkKOaAcM98lExQtgscr4j90Mvev4Xgnf
	 KOyZ/cK1WwvO1QOBrcMN596fsfygb8b4yYN4hbEwrq2rU0XfWeG18NCGbIjrV4IbApQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYmeozXH;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06C606A33F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC06C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYmeozXH
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6d7e06dbcccso2236332eaf.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793090331; x=1793695131; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dyCzdSZE9byzCLwEptS/6nKXLiDwQxdxKs++6j/xEjs=;
        b=FYmeozXHJIe8dUV1gMUHiz/SmKO5gZ0sJmJ41IQAbauJJ0PYswu0cejTZgluDvH+Lb
         58DVGEFqUGKIgwqSdCYX05Bxq/EAlgbkV2YAkXHEByzGgTqeoo99LFEoNX6+4O4xlRnR
         3TqLLlKDT6YLusCH3ByHvLk2rf6/+mkxKTSxbh7KpsWY1QLcllPkscWZF1aVLeN/7ue0
         gHBs788oK2ncphyNfF1HDl3/DxX9KfuXYVzpnb76bgWG2lRlDnAU5R/lGeTh8mavm6wU
         bfujVVbnfYDjR9W7DJlGeECrOR7txAj/R2midLEvaDeIeqYi2HMOPGdihgeG3aBKCGmO
         ykHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090331; x=1793695131;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyCzdSZE9byzCLwEptS/6nKXLiDwQxdxKs++6j/xEjs=;
        b=IIUUBrU8ChdBl4spLN+nAFa9hQzcFnboOEzw8tVOx93aFH4NMhj1qrYN8hIHVK0eUg
         1mbO9ktbg+pSui4Aa8G502I1epKVllPcuOIHp7Yh2rFl3bKs/4KBofYF2ITlzjEhZH93
         km/7iIyB8lTBh9frKd2egwOymyPfRtJAxizm/jE7o+U74DbDsoGVwc1JHXCoAT7xwC6Y
         SuV024MjGcgGdrXd1KrC7Lo4l2VsWzJakdSIlWDMLuEaUuuY6+UTakzidDQONMuDN+Dm
         bBSB4ped2QKYXh7jiIsyxuhsX7NeP9DqzQA/aCN6NyZVWgq7WLoRvpg5NxT61UqHsdiE
         D0zg==
X-Gm-Message-State: AFq9FYJxG8KWgLkIoQBlfNNczfVzRhsz7X1lYFghupUxJaQVmRezZTJx
	wfhJY7q7y1T3z7tJ1njBNLbZi2G4jAU1kcr5lqjyIr5UDvhY3HV6yCDTFQLmeybAzKE=
X-Gm-Gg: AYBFou1pkEMz5UCVEXEK2jxSe4PJ2IGMoEnFFde6z/KUPj3hdEcwnC2KBa9RB9fdvRt
	fGsLE+2p92ReU7xrVWdeZLTjBrsCDcUQ/WiQlbSgRyWrxhcKVUFpGwCRokBkjb8w05Z8gFJXGNF
	OLdsmagZfLHcfduq2+EkRLfjB9K/0VEhKxEfpicxyEwQKaU6Im4cFwYpVqBadFHJgZ1yTvAN5Gu
	P1t+kIws4fFOE2B1dTsCkRiPC11lcakF0jCM+8eNK12BI5kv4hUCRTHt/WS/L8VXYMl2Rt/GaYG
	0aspImsaZq7Bi7bsbSNZkRqAmUTQ/dJupo8ahSnkTK9lhDXc+emztK1nBFKSx8N34uvmbgt0XeH
	jANtAy4yWftq7ETTDFSvaI49r9fVKDS72mvE9D6TPttLBuzF+fcqNChKhihmTUIB1VUHJBJbELA
	/GMfTGHuTB/Ok/DFUfx2n5UspAnY3qL58MYVce4TNnfppdnHi3L5ItfXeF04jbRWKxjoCk02swb
	3fW/YAFT1Fp2CtxUh4BWR+ivCGJP1oYel5vYuwVcaPYQ/JvVfL1gx/j
X-Received: by 2002:a05:6820:1503:b0:6dd:9701:6305 with SMTP id 006d021491bc7-70ba0ec52b6mr5096034eaf.65.1793090330487;
        Tue, 27 Oct 2026 01:38:50 -0700 (PDT)
Received: from [127.0.0.1] ([4.150.62.85])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70e1dd8712bsm5236635eaf.1.2026.10.27.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:38:49 -0700 (PDT)
Message-Id: <pull.2448.v3.git.git.1793090327.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:38:45 +0000
Subject: [PATCH v3 0/2] reflog: add --operations and --historical-branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Create a better reflog. Follows the discussion in
https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.

The reflog of HEAD records the work done on every branch, so "git reflog"
mixes them and does not say which entry was made on which branch. This adds
a "%gb" placeholder that names the branch HEAD was on when each entry was
recorded:

$ git log -g --format='%h %gd: (%gb) %gs'
9c8d7e6 HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
1a2b3c4 HEAD@{2}: (topic) rebase (start): checkout main
1a2b3c4 HEAD@{3}: (main) commit: fix typo


It follows branch switches, branch renames and rebases, including "git
rebase ", rebases of a detached HEAD and rebases of a branch that was
already up to date. When HEAD was detached, the entry shows "detached at ".

Changes in v3:

 * Dropped --operations.
 * Replaced --historical-branch with a %gb placeholder for --format, e.g.
   git log -g --format='%h %gd: (%gb) %gs'.
 * %gb names the right branch after git rebase <upstream> <branch>, a rebase
   of a detached HEAD and an up-to-date rebase.
 * Named the returning to and checkout reflog strings in reflog.h too.

Changes in v2:

 * Move the "historical branch" rightward in the display for cleaner
   alignment.
 * Improve commit messages.

Harald Nordgren (2):
  reflog: name the strings that mark switches, renames and rebase steps
  pretty: add %gb to name the branch of each reflog entry

 Documentation/pretty-formats.adoc |   3 +
 builtin/branch.c                  |   3 +-
 builtin/checkout.c                |   3 +-
 builtin/rebase.c                  |  19 ++--
 object-name.c                     |   3 +-
 pretty.c                          |   4 +
 reflog-walk.c                     | 156 ++++++++++++++++++++++++++++--
 reflog-walk.h                     |   2 +
 reflog.h                          |   8 ++
 sequencer.c                       |  13 +--
 t/t1414-reflog-walk.sh            | 122 +++++++++++++++++++++++
 wt-status.c                       |   3 +-
 12 files changed, 314 insertions(+), 25 deletions(-)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v3
Pull-Request: https://github.com/git/git/pull/2448

Range-diff vs v2:

 1:  745929bd80 ! 1:  4d779e8da3 reflog: name the strings that mark switches, renames and rebase steps
     @@ Metadata
       ## Commit message ##
          reflog: name the strings that mark switches, renames and rebase steps
      
     -    The next commit adds "git reflog --operations", which finds branch
     -    switches, branch renames and the start and end of a rebase by the
     -    messages they leave in the reflog. The commands that write these
     -    messages spell out the strings by hand, and "@{-<n>}" and "git status"
     -    each keep their own copy of the switch prefix to read it back. Reading
     -    them in one more place would add yet another copy that has to stay in
     -    sync.
     +    The next commit adds a "%gb" placeholder that shows which branch HEAD
     +    was on for each reflog entry. It finds the branch from the messages
     +    that branch switches, branch renames and rebases leave in the reflog.
     +    The commands that write these messages spell out the strings by hand,
     +    and "@{-<n>}" and "git status" each keep their own copy of the switch
     +    prefix to read it back. Reading them in one more place would add yet
     +    another copy that has to stay in sync.
      
          Name the strings once in reflog.h and use the names wherever the
          messages are written or read: the "checkout: moving from " prefix
          written by "git checkout", the "Branch: renamed " prefix written by
     -    "git branch -m", and the "start", "finish" and "abort" steps written
     -    by "git rebase".
     +    "git branch -m", and the "start", "finish" and "abort" steps, the
     +    "returning to " before the branch a rebase goes back to and the
     +    "checkout " before what it checks out, all written by "git rebase".
      
          No change in behavior.
      
     @@ builtin/rebase.c: static int move_to_original_branch(struct rebase_options *opts
       		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
      -	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
      -		    opts->reflog_action, opts->head_name);
     -+	strbuf_addf(&head_reflog, "%s (%s): returning to %s",
     ++	strbuf_addf(&head_reflog, "%s (%s): " REFLOG_RETURNING_TO "%s",
      +		    opts->reflog_action, REFLOG_STEP_FINISH, opts->head_name);
       	ropts.branch = opts->head_name;
       	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
       		      RESET_WORKING_TREE_UPDATE_HEAD;
     +@@ builtin/rebase.c: static int checkout_up_to_date(struct rebase_options *options)
     + 	struct reset_working_tree_options ropts = { 0 };
     + 	int ret = 0;
     + 
     +-	strbuf_addf(&buf, "%s: checkout %s",
     ++	strbuf_addf(&buf, "%s: " REFLOG_CHECKOUT "%s",
     + 		    options->reflog_action, options->switch_to);
     + 	ropts.oid = &options->orig_head->object.oid;
     + 	ropts.branch = options->head_name;
      @@ builtin/rebase.c: int cmd_rebase(int argc,
       		if (read_basic_state(&options))
       			exit(1);
       
      -		strbuf_addf(&head_msg, "%s (abort): returning to %s",
      -			    options.reflog_action,
     -+		strbuf_addf(&head_msg, "%s (%s): returning to %s",
     ++		strbuf_addf(&head_msg, "%s (%s): " REFLOG_RETURNING_TO "%s",
      +			    options.reflog_action, REFLOG_STEP_ABORT,
       			    options.head_name ? options.head_name
       					      : oid_to_hex(&options.orig_head->object.oid));
     @@ builtin/rebase.c: int cmd_rebase(int argc,
       
      -	strbuf_addf(&msg, "%s (start): checkout %s",
      -		    options.reflog_action, options.onto_name);
     -+	strbuf_addf(&msg, "%s (%s): checkout %s", options.reflog_action,
     -+		    REFLOG_STEP_START, options.onto_name);
     ++	strbuf_addf(&msg, "%s (%s): " REFLOG_CHECKOUT "%s",
     ++		    options.reflog_action, REFLOG_STEP_START, options.onto_name);
       	ropts.oid = &options.onto->object.oid;
       	ropts.orig_head = &options.orig_head->object.oid;
       	ropts.flags = RESET_WORKING_TREE_DETACH |
     @@ reflog.h
      +#define REFLOG_STEP_START "start"
      +#define REFLOG_STEP_FINISH "finish"
      +#define REFLOG_STEP_ABORT "abort"
     ++#define REFLOG_RETURNING_TO "returning to "
     ++#define REFLOG_CHECKOUT "checkout "
      +
       #define REFLOG_EXPIRE_TOTAL   (1 << 0)
       #define REFLOG_EXPIRE_UNREACH (1 << 1)
     @@ sequencer.c: static int checkout_onto(struct repository *r, struct replay_opts *
      -		.head_msg = reflog_message(opts, "start", "checkout %s",
      -					   onto_name),
      +		.head_msg = reflog_message(opts, REFLOG_STEP_START,
     -+					   "checkout %s", onto_name),
     ++					   REFLOG_CHECKOUT "%s", onto_name),
       		.default_reflog_action = sequencer_reflog_action(opts)
       	};
       	if (reset_working_tree(r, &ropts)) {
     @@ sequencer.c: cleanup_head_ref:
      -			msg = reflog_message(opts, "finish", "returning to %s",
      -				head_ref.buf);
      +			msg = reflog_message(opts, REFLOG_STEP_FINISH,
     -+				"returning to %s", head_ref.buf);
     ++				REFLOG_RETURNING_TO "%s", head_ref.buf);
       			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg)) {
       				res = error(_("could not update HEAD to %s"),
       					head_ref.buf);
 2:  1c47ba225e < -:  ---------- reflog: add --operations to show one entry per command
 3:  aa5a98b80d ! 2:  dee548f9b1 reflog: add --historical-branch to name the branch of each entry
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    reflog: add --historical-branch to name the branch of each entry
     +    pretty: add %gb to name the branch of each reflog entry
      
     -    "git reflog" does not say which branch HEAD was on when an entry was
     -    recorded. After switching between a few branches, telling which
     -    commits and rebases belong to which branch means reading back to the
     -    last "checkout: moving from" entry for each of them. Commit
     -    decorations do not help either, since they only name branches that
     -    still point at that commit, and a rebased or amended commit has none.
     +    The reflog of HEAD records the work done on every branch, so the
     +    output of "git reflog" mixes them and does not say which entry was
     +    made on which branch. Working that out by hand means looking back for
     +    the branch switch before each entry, and a rebase can move HEAD to
     +    another branch without writing one, as "git rebase <upstream>
     +    <branch>" does.
      
     -    Teach "git reflog" and "git log -g" a "--historical-branch" option
     -    that shows the branch each entry was made on before its message, in
     -    place of the refs that point at the commit now. The hashes and
     -    selectors stay lined up in their columns, and the name is colored like
     -    a branch decoration:
     +    Add a "%gb" placeholder that names the branch HEAD was on when each
     +    entry was recorded:
      
     -      $ git reflog --historical-branch
     -      4e5f6a7 HEAD@{0}: (topic) commit: add tests
     -      1a2b3c4 HEAD@{1}: (topic) checkout: moving from main to topic
     -      8c9d0e1 HEAD@{2}: (main) commit: fix typo
     +        $ git log -g --format='%h %gd: (%gb) %gs'
     +        9c8d7e6 HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
     +        9c8d7e6 HEAD@{1}: (topic) rebase (pick): add tests
     +        1a2b3c4 HEAD@{2}: (topic) rebase (start): checkout main
     +        1a2b3c4 HEAD@{3}: (main) commit: fix typo
     +        5d6e7f8 HEAD@{4}: (main) checkout: moving from topic to main
      
     -    Every entry gets a name, including ones whose commits are no longer on
     -    any branch. Entries from before a branch was renamed show its old name,
     -    and entries made on a detached HEAD show "detached at <commit>".
     -    Combined with "--operations", which leaves out the branch switches
     -    themselves, it lists what was done to each branch.
     +    The branch is read from the entries that branch switches, branch
     +    renames and rebases leave behind. The entries of a rebase are named
     +    after the branch being rebased. When HEAD was detached, the entry
     +    shows "detached at <commit>" with the commit HEAD was at when it
     +    moved on. When nothing older in the reflog says which branch a rebase
     +    started on, the rebase is taken to have started on the branch it
     +    rebased. For the reflog of any other ref, "%gb" is the name of that
     +    ref.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/git-reflog.adoc ##
     -@@ Documentation/git-reflog.adoc: actions, and in addition the `HEAD` reflog records branch switching.
     - --pretty=oneline`; see linkgit:git-log[1] for more information.
     - With `--operations`, branch switches and other entries that change no
     - branch are left out, and a rebase is shown as a single entry instead
     --of one entry for each commit it replayed.
     -+of one entry for each commit it replayed. With `--historical-branch`,
     -+each entry shows the branch it was made on before its message.
     - 
     - The "list" subcommand lists all refs which have a corresponding reflog.
     - 
     + ## Documentation/pretty-formats.adoc ##
     +@@ Documentation/pretty-formats.adoc: endif::git-rev-list[]
     + +%gE+:: reflog identity email (respecting .mailmap, see
     + 	linkgit:git-shortlog[1] or linkgit:git-blame[1])
     + +%gs+:: reflog subject
     +++%gb+:: reflog branch, the branch `HEAD` was on when the entry was
     ++	recorded, e.g., `topic` or `detached at 1a2b3c4`. For the reflog
     ++	of any other ref, this is the shortened refname.
     + ++%(trailers++`[:<option>,...]`++)++::
     + display the trailers of the body as interpreted by
     + linkgit:git-interpret-trailers[1]. The `trailers` string may be followed by
      
     - ## Documentation/rev-list-options.adoc ##
     -@@ Documentation/rev-list-options.adoc: Under `--pretty=reference`, this information will not be shown at all.
     - 	rebase started. It is an error to use this option unless
     - 	`--walk-reflogs` is in use.
     - 
     -+ifndef::git-rev-list[]
     -+`--historical-branch`::
     -+	Show the branch `HEAD` was on when each reflog entry was
     -+	recorded, such as `(topic)`, before the reflog message, in
     -+	place of the refs that point at the commit now. When `HEAD` was
     -+	detached, the entry shows `(detached at <commit>)`. For the
     -+	reflog of any other ref, the name of that ref is shown. It is
     -+	an error to use this option unless `--walk-reflogs` is in use.
     -+endif::git-rev-list[]
     -+
     - `--merge`::
     - 	Show commits touching conflicted paths in the range `HEAD...<other>`,
     - 	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
     -
     - ## log-tree.c ##
     -@@ log-tree.c: void format_decorations(struct strbuf *sb,
     - 	}
     - }
     - 
     -+static void format_historical_branch(struct strbuf *sb,
     -+				     struct rev_info *opt)
     -+{
     -+	const char *branch = get_reflog_branch(opt->reflog_info);
     -+	enum git_colorbool use_color = opt->diffopt.use_color;
     -+	const char *color_commit, *color_reset;
     -+
     -+	if (!branch)
     -+		return;
     -+
     -+	color_commit = diff_get_color(use_color, DIFF_COMMIT);
     -+	color_reset = decorate_get_color(use_color, DECORATION_NONE);
     -+	strbuf_addf(sb, "%s(%s%s%s%s%s)%s ",
     -+		    color_commit, color_reset,
     -+		    decorate_get_color(use_color, DECORATION_REF_LOCAL),
     -+		    branch, color_reset, color_commit, color_reset);
     -+}
     -+
     - void show_decorations(struct rev_info *opt, struct commit *commit)
     - {
     - 	struct strbuf sb = STRBUF_INIT;
     -@@ log-tree.c: void show_decorations(struct rev_info *opt, struct commit *commit)
     - 		if (slot && *slot)
     - 			fprintf(opt->diffopt.file, "\t%s", *slot);
     - 	}
     --	if (!opt->show_decorations)
     -+	if (!opt->show_decorations || opt->historical_branch)
     - 		return;
     - 	format_decorations(&sb, commit, opt->diffopt.use_color, NULL);
     - 	fputs(sb.buf, opt->diffopt.file);
     -@@ log-tree.c: void show_log(struct rev_info *opt)
     - 			graph_show_oneline(opt->graph);
     - 		}
     - 		if (opt->reflog_info) {
     -+			struct strbuf branch = STRBUF_INIT;
     -+
     - 			/*
     - 			 * setup_revisions() ensures that opt->reflog_info
     - 			 * and opt->graph cannot both be set,
     - 			 * so we don't need to worry about printing the
     - 			 * graph info here.
     - 			 */
     -+			if (opt->historical_branch)
     -+				format_historical_branch(&branch, opt);
     - 			show_reflog_message(opt->reflog_info,
     - 					    opt->commit_format == CMIT_FMT_ONELINE,
     - 					    opt->date_mode,
     --					    opt->date_mode_explicit);
     -+					    opt->date_mode_explicit,
     -+					    branch.buf);
     -+			strbuf_release(&branch);
     - 			if (opt->commit_format == CMIT_FMT_ONELINE)
     - 				return;
     - 		}
     + ## pretty.c ##
     +@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     + 			if (c->pretty_ctx->reflog_info)
     + 				get_reflog_message(sb, c->pretty_ctx->reflog_info);
     + 			return 2;
     ++		case 'b':	/* reflog branch */
     ++			if (c->pretty_ctx->reflog_info)
     ++				get_reflog_branch(sb, c->pretty_ctx->reflog_info);
     ++			return 2;
     + 		case 'n':
     + 		case 'N':
     + 		case 'e':
      
       ## reflog-walk.c ##
      @@
     + #include "git-compat-util.h"
     + #include "commit.h"
       #include "refs.h"
     - #include "reflog.h"
     ++#include "reflog.h"
       #include "diff.h"
      +#include "hex.h"
      +#include "object-name.h"
     @@ reflog-walk.c: struct complete_reflogs {
       		int tz;
       		char *message;
      +		char *branch;
     - 		bool user_operation;
       	} *items;
       	int nr, alloc;
     ++	bool branches_marked;
     + };
     + 
     + static int read_one_reflog(const char *refname UNUSED,
      @@ reflog-walk.c: static int read_one_reflog(const char *refname UNUSED,
       	item->timestamp = timestamp;
       	item->tz = tz;
       	item->message = xstrdup(message);
      +	item->branch = NULL;
     - 	item->user_operation = true;
       	array->nr++;
       	return 0;
     + }
      @@ reflog-walk.c: static void free_complete_reflog(struct complete_reflogs *array)
       	for (i = 0; i < array->nr; i++) {
       		free(array->items[i].email);
     @@ reflog-walk.c: static void free_complete_reflog(struct complete_reflogs *array)
       	}
       	free(array->items);
       	free(array->ref);
     -@@ reflog-walk.c: static void mark_operations(struct complete_reflogs *array)
     - 	}
     +@@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UNUSED)
     + 	free_complete_reflog(array);
       }
       
     -+static char *branch_label(const char *name, size_t len)
     ++static char *branch_label(const char *name, size_t len,
     ++			  const struct object_id *oid)
      +{
     -+	struct object_id oid;
     -+	const char *short_name;
     ++	if (name) {
     ++		struct object_id hex_oid;
     ++		char *branch;
      +
     -+	if (len == the_hash_algo->hexsz && !get_oid_hex(name, &oid))
     -+		return xstrfmt("detached at %s",
     -+			       repo_find_unique_abbrev(the_repository, &oid,
     -+						       DEFAULT_ABBREV));
     -+	if (skip_prefix(name, "refs/heads/", &short_name))
     -+		len -= short_name - name;
     -+	else
     -+		short_name = name;
     -+	return xmemdupz(short_name, len);
     ++		if (skip_prefix(name, "refs/heads/", &name))
     ++			len -= strlen("refs/heads/");
     ++		branch = xmemdupz(name, len);
     ++		if (strcmp(branch, "HEAD") && get_oid_hex(branch, &hex_oid) &&
     ++		    !check_refname_format(branch, REFNAME_ALLOW_ONELEVEL))
     ++			return branch;
     ++		free(branch);
     ++	}
     ++	return xstrfmt("detached at %s",
     ++		       repo_find_unique_abbrev(the_repository, oid,
     ++					       DEFAULT_ABBREV));
     ++}
     ++
     ++static const char *skip_rebase_step(const char *message, const char *step)
     ++{
     ++	const char *p = strstr(message, " (");
     ++	const char *colon = strstr(message, ": ");
     ++
     ++	if (!p || (colon && colon < p) ||
     ++	    !skip_prefix(p + 2, step, &p) || !skip_prefix(p, "): ", &p))
     ++		return NULL;
     ++	return p;
      +}
      +
      +struct branch_move {
     @@ reflog-walk.c: static void mark_operations(struct complete_reflogs *array)
      +{
      +	const char *to;
      +
     -+	if (!skip_prefix(message, REFLOG_SWITCH_PREFIX, &move->from) &&
     -+	    !skip_prefix(message, REFLOG_RENAME_PREFIX, &move->from))
     ++	move->from = move->to = NULL;
     ++	move->from_len = move->to_len = 0;
     ++	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &move->from) ||
     ++	    skip_prefix(message, REFLOG_RENAME_PREFIX, &move->from)) {
     ++		to = strstr(move->from, " to ");
     ++		if (!to)
     ++			return false;
     ++		move->from_len = to - move->from;
     ++		move->to = to + strlen(" to ");
     ++	} else if (((to = skip_rebase_step(message, REFLOG_STEP_FINISH)) ||
     ++		    (to = skip_rebase_step(message, REFLOG_STEP_ABORT))) &&
     ++		   skip_prefix(to, REFLOG_RETURNING_TO, &to)) {
     ++		move->from = move->to = to;
     ++		move->from_len = strcspn(to, "\n");
     ++	} else if (skip_prefix(message, "rebase: " REFLOG_CHECKOUT, &to)) {
     ++		move->to = to;
     ++	} else if (!skip_rebase_step(message, REFLOG_STEP_START)) {
      +		return false;
     -+	to = strstr(move->from, " to ");
     -+	if (!to)
     -+		return false;
     -+	move->from_len = to - move->from;
     -+	move->to = to + strlen(" to ");
     -+	move->to_len = strcspn(move->to, "\n");
     ++	}
     ++	if (move->to)
     ++		move->to_len = strcspn(move->to, "\n");
      +	return true;
      +}
      +
      +static void mark_branches(struct complete_reflogs *array)
      +{
     ++	struct ref_store *refs = get_main_ref_store(the_repository);
     ++	struct object_id oid;
     ++	const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0, &oid, NULL);
      +	char *branch = NULL;
     ++	int unknown = array->nr;
      +
     -+	if (strcmp(array->ref, "HEAD"))
     -+		return;
     ++	if (head)
     ++		branch = branch_label(head, strlen(head), &oid);
      +
      +	for (int i = array->nr - 1; i >= 0; i--) {
      +		struct reflog_info *item = &array->items[i];
     @@ reflog-walk.c: static void mark_operations(struct complete_reflogs *array)
      +			continue;
      +		}
      +
     -+		if (!branch)
     -+			for (int j = i + 1; j < array->nr; j++)
     -+				array->items[j].branch =
     -+					branch_label(move.to, move.to_len);
     -+		item->branch = branch_label(move.to, move.to_len);
     -+		free(branch);
     -+		branch = branch_label(move.from, move.from_len);
     ++		if (!branch) {
     ++			branch = branch_label(move.to, move.to_len,
     ++					      &array->items[unknown - 1].noid);
     ++			for (int j = i + 1; j < unknown; j++)
     ++				array->items[j].branch = xstrdup(branch);
     ++		}
     ++		item->branch = branch;
     ++		if (move.from) {
     ++			branch = branch_label(move.from, move.from_len,
     ++					      &item->ooid);
     ++		} else {
     ++			branch = NULL;
     ++			unknown = i;
     ++		}
      +	}
      +
     -+	if (!branch) {
     -+		struct ref_store *refs = get_main_ref_store(the_repository);
     -+		const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0,
     -+							   NULL, NULL);
     -+
     -+		if (head && skip_prefix(head, "refs/heads/", &head))
     -+			for (int i = 0; i < array->nr; i++)
     -+				array->items[i].branch = xstrdup(head);
     -+	}
     ++	if (!branch && unknown < array->nr)
     ++		for (int i = 0; i < unknown; i++)
     ++			array->items[i].branch =
     ++				xstrdup(array->items[unknown].branch);
      +	free(branch);
      +}
      +
       static struct complete_reflogs *read_complete_reflog(const char *ref)
       {
       	struct complete_reflogs *reflogs =
     -@@ reflog-walk.c: void init_reflog_walk(struct reflog_walk_info **info)
     - 	(*info)->complete_reflogs.strdup_strings = 1;
     - }
     - 
     --void reflog_walk_mark(struct reflog_walk_info *info, bool operations)
     -+void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
     -+		      bool historical_branch)
     - {
     - 	struct string_list_item *item;
     - 
     - 	for_each_string_list_item(item, &info->complete_reflogs) {
     - 		if (operations)
     - 			mark_operations(item->util);
     -+		if (historical_branch)
     -+			mark_branches(item->util);
     - 	}
     - }
     - 
      @@ reflog-walk.c: int add_reflog_for_walk(struct reflog_walk_info *info,
       	return 0;
       }
     @@ reflog-walk.c: void get_reflog_message(struct strbuf *sb,
       	strbuf_add(sb, info->message, len);
       }
       
     -+const char *get_reflog_branch(struct reflog_walk_info *reflog_info)
     ++void get_reflog_branch(struct strbuf *sb,
     ++		       struct reflog_walk_info *reflog_info)
      +{
      +	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
     ++	struct complete_reflogs *reflogs;
     ++	const char *branch;
      +
      +	if (!commit_reflog)
     -+		return NULL;
     ++		return;
      +
     -+	if (strcmp(commit_reflog->reflogs->ref, "HEAD"))
     -+		return short_ref(commit_reflog->reflogs);
     -+	return commit_reflog->reflogs->items[commit_reflog->recno+1].branch;
     ++	reflogs = commit_reflog->reflogs;
     ++	if (strcmp(reflogs->ref, "HEAD")) {
     ++		strbuf_addstr(sb, short_ref(reflogs));
     ++		return;
     ++	}
     ++
     ++	if (!reflogs->branches_marked) {
     ++		mark_branches(reflogs);
     ++		reflogs->branches_marked = true;
     ++	}
     ++	branch = reflogs->items[commit_reflog->recno+1].branch;
     ++	if (branch)
     ++		strbuf_addstr(sb, branch);
      +}
      +
       const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
       {
       	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
     -@@ reflog-walk.c: timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info)
     - }
     - 
     - void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
     --			 struct date_mode dmode, int force_date)
     -+			 struct date_mode dmode, int force_date,
     -+			 const char *branch)
     - {
     - 	if (reflog_info && reflog_info->last_commit_reflog) {
     - 		struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
     -@@ reflog-walk.c: void show_reflog_message(struct reflog_walk_info *reflog_info, int oneline,
     - 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
     - 		get_reflog_selector(&selector, reflog_info, dmode, force_date, 0);
     - 		if (oneline) {
     --			printf("%s: %s", selector.buf, info->message);
     -+			printf("%s: %s%s", selector.buf, branch,
     -+			       info->message);
     - 		}
     - 		else {
     --			printf("Reflog: %s (%s)\nReflog message: %s",
     --			       selector.buf, info->email, info->message);
     -+			printf("Reflog: %s (%s)\nReflog message: %s%s",
     -+			       selector.buf, info->email, branch,
     -+			       info->message);
     - 		}
     - 
     - 		strbuf_release(&selector);
      
       ## reflog-walk.h ##
     -@@ reflog-walk.h: struct date_mode;
     - 
     - void init_reflog_walk(struct reflog_walk_info **info);
     - void reflog_walk_info_release(struct reflog_walk_info *info);
     --void reflog_walk_mark(struct reflog_walk_info *info, bool operations);
     -+void reflog_walk_mark(struct reflog_walk_info *info, bool operations,
     -+		      bool historical_branch);
     - int add_reflog_for_walk(struct reflog_walk_info *info,
     - 			struct commit *commit, const char *name);
     - void show_reflog_message(struct reflog_walk_info *info, int,
     --			 struct date_mode, int force_date);
     -+			 struct date_mode, int force_date,
     -+			 const char *branch);
     +@@ reflog-walk.h: void show_reflog_message(struct reflog_walk_info *info, int,
     + 			 struct date_mode, int force_date);
       void get_reflog_message(struct strbuf *sb,
       			struct reflog_walk_info *reflog_info);
     -+const char *get_reflog_branch(struct reflog_walk_info *reflog_info);
     ++void get_reflog_branch(struct strbuf *sb,
     ++		       struct reflog_walk_info *reflog_info);
       const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
       timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
       void get_reflog_selector(struct strbuf *sb,
      
     - ## revision.c ##
     -@@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
     - 		revs->show_signature = 1;
     - 	} else if (!strcmp(arg, "--no-show-signature")) {
     - 		revs->show_signature = 0;
     -+	} else if (!strcmp(arg, "--historical-branch")) {
     -+		revs->historical_branch = 1;
     - 	} else if (!strcmp(arg, "--show-linear-break")) {
     - 		revs->break_bar = "                    ..........";
     - 		revs->track_linear = 1;
     -@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
     - 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
     - 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
     - 
     -+	if (!revs->reflog_info && revs->historical_branch)
     -+		die(_("the option '%s' requires '%s'"), "--historical-branch", "--walk-reflogs");
     -+
     - 	if (!revs->reflog_info && revs->reflog_operations)
     - 		die(_("the option '%s' requires '%s'"), "--operations", "--walk-reflogs");
     - 
     - 	if (revs->reflog_info)
     --		reflog_walk_mark(revs->reflog_info, revs->reflog_operations);
     -+		reflog_walk_mark(revs->reflog_info, revs->reflog_operations,
     -+				 revs->historical_branch);
     - 
     - 	if (revs->line_level_traverse &&
     - 	    (revs->full_diff ||
     -
     - ## revision.h ##
     -@@ revision.h: struct rev_info {
     - 			show_notes_given:1,
     - 			show_notes_by_default:1,
     - 			show_signature:1,
     -+			historical_branch:1,
     - 			pretty_given:1,
     - 			abbrev_commit:1,
     - 			abbrev_commit_given:1,
     -
       ## t/t1414-reflog-walk.sh ##
     -@@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a rebase as one entry' '
     - 	)
     +@@ t/t1414-reflog-walk.sh: test_expect_success 'walk prefers reflog to ref tip' '
     + 	test_cmp expect actual
       '
       
     -+test_expect_success '--historical-branch names the branch of each entry' '
     ++test_expect_success '%gb names the branch HEAD was on' '
     ++	git init branches &&
      +	(
     -+		cd operations &&
     ++		cd branches &&
     ++		test_commit base &&
     ++		git switch -c topic &&
     ++		test_commit A &&
     ++		test_commit B &&
     ++		git switch main &&
     ++		test_commit upstream &&
     ++		git switch topic &&
     ++		git rebase main &&
      +
      +		cat >expect <<-\EOF &&
     -+		HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
     -+		HEAD@{1}: (topic) rebase (pick): C
     -+		HEAD@{2}: (topic) rebase (pick): B
     -+		HEAD@{3}: (topic) rebase (pick): A
     -+		HEAD@{4}: (topic) rebase (start): checkout main
     -+		HEAD@{5}: (topic) checkout: moving from main to topic
     -+		HEAD@{6}: (main) commit: upstream
     -+		HEAD@{7}: (main) checkout: moving from topic to main
     -+		HEAD@{8}: (topic) commit: C
     -+		HEAD@{9}: (topic) commit: B
     -+		HEAD@{10}: (topic) commit: A
     -+		HEAD@{11}: (topic) checkout: moving from main to topic
     -+		HEAD@{12}: (main) commit (initial): base
     ++		(topic) rebase (finish): returning to refs/heads/topic
     ++		(topic) rebase (pick): B
     ++		(topic) rebase (pick): A
     ++		(topic) rebase (start): checkout main
     ++		(topic) checkout: moving from main to topic
     ++		(main) commit: upstream
     ++		(main) checkout: moving from topic to main
     ++		(topic) commit: B
     ++		(topic) commit: A
     ++		(topic) checkout: moving from main to topic
     ++		(main) commit (initial): base
      +		EOF
     -+		git reflog --historical-branch >out &&
     -+		cut -d " " -f 2- out >actual &&
     ++		git log -g --format="(%gb) %gs" >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success '--historical-branch takes the place of decorations' '
     ++test_expect_success '%gb names the ref of other reflogs' '
      +	(
     -+		cd operations &&
     -+		hash=$(git rev-parse --short HEAD) &&
     -+		echo "<YELLOW>$hash<RESET> HEAD@{0}: <YELLOW>(<RESET><BOLD;GREEN>topic<RESET><YELLOW>)<RESET> rebase (finish): returning to refs/heads/topic" >expect &&
     -+		git reflog --historical-branch --decorate --color -1 >out &&
     -+		test_decode_color <out >actual &&
     ++		cd branches &&
     ++		echo main >expect &&
     ++		git log -g -1 --format=%gb main >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success '--historical-branch names the ref of other reflogs' '
     ++test_expect_success '%gb follows "git rebase <upstream> <branch>"' '
      +	(
     -+		cd operations &&
     -+		echo "main@{0}: (main) commit: upstream" >expect &&
     -+		git reflog -1 main --historical-branch >out &&
     -+		cut -d " " -f 2- out >actual &&
     ++		cd branches &&
     ++		git switch main &&
     ++		test_commit main-change &&
     ++		git rebase main topic &&
     ++		git switch main &&
     ++		git rebase main topic &&
     ++
     ++		cat >expect <<-\EOF &&
     ++		(topic) rebase: checkout topic
     ++		(main) checkout: moving from topic to main
     ++		(topic) rebase (finish): returning to refs/heads/topic
     ++		(topic) rebase (pick): B
     ++		(topic) rebase (pick): A
     ++		(topic) rebase (start): checkout main
     ++		(main) commit: main-change
     ++		(main) checkout: moving from topic to main
     ++		EOF
     ++		git log -g -8 --format="(%gb) %gs" >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     - test_expect_success '--operations shows a stopped rebase as one entry once it finishes' '
     - 	set_fake_editor &&
     - 	(
     -@@ t/t1414-reflog-walk.sh: test_expect_success '--operations shows a pull --rebase as one entry' '
     - 	)
     - '
     - 
     --test_expect_success '--operations requires --walk-reflogs' '
     -+test_expect_success '--historical-branch names the current branch when HEAD never switched' '
     ++test_expect_success '%gb names a detached HEAD by the commit it was left at' '
      +	(
     -+		cd downstream &&
     -+		echo "(topic)" >expect &&
     -+		git reflog --historical-branch >out &&
     -+		cut -d " " -f 3 out | sort -u >actual &&
     ++		cd branches &&
     ++		git switch --detach topic~1 &&
     ++		test_commit detached &&
     ++		git rebase topic &&
     ++		rebased=$(git rev-parse HEAD) &&
     ++		git switch topic &&
     ++
     ++		left_before=$(git rev-parse --short detached) &&
     ++		left_after=$(git rev-parse --short $rebased) &&
     ++		cat >expect <<-EOF &&
     ++		(topic) checkout: moving from $rebased to topic
     ++		(detached at $left_after) rebase (pick): detached
     ++		(detached at $left_after) rebase (start): checkout topic
     ++		(detached at $left_before) commit: detached
     ++		(detached at $left_before) checkout: moving from topic to topic~1
     ++		EOF
     ++		git log -g -5 --format="(%gb) %gs" >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success '--historical-branch follows a renamed branch' '
     ++test_expect_success '%gb names the branch of a "git pull --rebase" in a fresh clone' '
     ++	git clone branches downstream &&
      +	(
     -+		cd operations &&
     -+		test_commit D &&
     -+		git branch -m topic renamed &&
     -+		test_commit E &&
     ++		cd branches &&
     ++		test_commit upstream-change
     ++	) &&
     ++	(
     ++		cd downstream &&
     ++		test_commit local-change &&
     ++		git pull --rebase &&
      +
     -+		cat >expect <<-\EOF &&
     -+		HEAD@{0}: (renamed) commit: E
     -+		HEAD@{1}: (renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
     -+		HEAD@{3}: (topic) commit: D
     -+		EOF
     -+		git reflog --historical-branch -3 >out &&
     -+		cut -d " " -f 2- out >actual &&
     ++		echo "(topic)" >expect &&
     ++		git log -g --format="(%gb)" >out &&
     ++		sort -u out >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success '--historical-branch shows where HEAD was detached' '
     ++test_expect_success '%gb follows a renamed branch' '
      +	(
     -+		cd operations &&
     -+		git checkout --detach &&
     -+		test_commit F &&
     -+		git checkout renamed &&
     ++		cd branches &&
     ++		test_commit before-rename &&
     ++		git branch -m topic renamed &&
     ++		test_commit after-rename &&
      +
     -+		cat >expect <<-EOF &&
     -+		HEAD@{0}: (renamed) checkout: moving from $(git rev-parse F) to renamed
     -+		HEAD@{1}: (detached at $(git rev-parse --short F)) commit: F
     ++		cat >expect <<-\EOF &&
     ++		(renamed) commit: after-rename
     ++		(renamed) Branch: renamed refs/heads/topic to refs/heads/renamed
     ++		(topic) commit: before-rename
      +		EOF
     -+		git reflog --historical-branch -2 >out &&
     -+		cut -d " " -f 2- out >actual &&
     ++		git log -g -3 --format="(%gb) %gs" >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success '--operations and --historical-branch require --walk-reflogs' '
     - 	test_must_fail git log --operations 2>err &&
     -+	test_grep "requires .--walk-reflogs." err &&
     -+	test_must_fail git log --historical-branch 2>err &&
     - 	test_grep "requires .--walk-reflogs." err
     + test_expect_success 'rev-list -g complains when there are no reflogs' '
     + 	test_must_fail git rev-list -g
       '
     - 

-- 
gitgitgadget
