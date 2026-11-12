Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521203;
	b=h7p19/Yb1muaUEesS1qRlmaysEJSmajj/wzo2WLeRWBDpm7RlD7z8dd6/ytBtNep2b3/
	 jcB+qBGSaPfYFHbmLDK3qdwrJtIhp8QYIj7azcKfbXTMKi4M7J7uWRrHLMuJ0MhVUZDzc
	 4eJ3dwFFtK1drOkcOtA6US5QnWWRk8pwmVlwXmyQCXaIQP/93KNg9g9+I5U3ylKF48Ehm
	 QcOA6r6rgs5dRMt1+0u0Qv810S0xtbZYLT9Xc6hb+Cu1+Nw3p5Eh6M/tAsIkFZX/AOJu6
	 V3jolAMDea4WLCrFxt7/rT+TfJeAzotI0cEedIDYD0oQKR460R4vDX/FcINRrgTEevw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RsoJClfNeqPRtejYMEDdSEPmrTJeUnfVigzL3WphGYQ=;
	b=ijfZo2ImRknYzvQNEY+cn9BeC+EUi/doIp6EHct134vI2TgnHampQICoEC4ZHe3TtYw0
	 2pXiboBgnLnJPGNqySnJMA2U51ohQ2Kr5h1QNLjddViZhZv8mvG77McqYGbqUurcSKALs
	 9hngk2bU/qKdZ1lXu+VKQ2butDu0oMSVFBuOgfkqdPwH82PPWBfqZduW2n0s0Cy0NplYu
	 HxK1D7iqA8geDiaFIisEw/sYpxbqAhnr7ucvhWKyQvUNrrYMlPipPtj8uN0kx5Dt97A62
	 WskirgqdOO3OmV1sfv+4HYxgoLc+9VeBJsclMuDFL2xlUL2p5XWEOAwL1mxf0is8xlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLo0AtqD;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8C606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLo0AtqD
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so2102625e9.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521201; x=1795126001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsoJClfNeqPRtejYMEDdSEPmrTJeUnfVigzL3WphGYQ=;
        b=JLo0AtqDGJItqrPwLeedzzdPVk5fQSKP8TUeaxhQsoM7m9/R2lF0eTIF8/MLLJrLXh
         Kr33vIs+q8EYzrLR4GDxUz89fx1K4dkycMjwMelie+MTrAYTPFL3FIhUd2zL/QTszJSR
         PWdbtOP6A6aO1flPC+Ruh/k6a7UCcoa6HXx8mA4L3WzLHCcKRy3lMVhUrrkTcti7hMfS
         zC/FZpWl+dszx8XcMJpOoATBM1fBB+P/JLmdqQnt6O9U8/GitL2Al3upZDt5KAGUREyj
         pNDEEcIs05TziFEC23/7VCZ2IlQ0JxVPs1v/jk3WVSmSOeIoPYxZnoUe+ZzwAooVWc2S
         LyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521201; x=1795126001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsoJClfNeqPRtejYMEDdSEPmrTJeUnfVigzL3WphGYQ=;
        b=plTWiFt62Hlcv+/vvCm6JGQ2l/F9WRSfZsAp+ONUeBlPOIwXdPA6mAgcwgKQ0Qz510
         lijGlHLuvzoSHX3r4aI2TYiDDKpB9b5IkISayP/DNkaZcPcyMbILKAze9HCdQMORQGh/
         OATnXNEdzKm/mNzFR5s9+9E0klmsv+hA/9/Me8bVOUlUS2qCb2jNa1MfhYc29AzfMNJQ
         oSCYNv5EZghrxWVcRqSwcBNERsM98+VJMktMBYYtW+v7eR6S/F8VUX7SFfa1sNz16WPy
         aFB4Dqa9tBnfmKptSbr+e+fNntRPOrk4jkCnmz9aHZ3bOujxMJovE7DmhDVUgGLJ5kYR
         K8tQ==
X-Gm-Message-State: APuU4Z9v4dluKcWad37GbgGuTmSTBxPmmAXWGFysPiChxA1iM3b0quQl
	VStwxGRGcEiJ32DMcSs4+b+FV5zrfXIdmy48c72w+CvRc6b8IESdSmZNfLKXkOL0
X-Gm-Gg: AYBFou2rvq6CAs9dI4pK1CNqXXDIt2nTlFTWflOj8cUS9ns0W4O1M6G6NQMBm4d0mkn
	Hgn/2aYpxzYv/AGI9uo/oP63mxmfZO6tud6l4NwOAS28oLnmw4D4cdopZxJmDjLrNqstH5MrHlL
	Nwjz754V1ldDCy7xV0FzEsAuwL7qOL3ZShdB+RL2jXbwiii+lKVUlV8ED/AGFefPqR6dK6U4Pak
	NFvJG/9szw8HFW+oqX+v4wUwLGOXRb6HN9M5v0i/+s5LjFoZBmPeSZTasTesQ+U7tkfR4XxGE9L
	PspTLDdbR6zK+kdcYOZ1nenggopmiSuIVz8+Ap7Pap4ttiribidG3s9yizBVmVQcirbgYY9lEO1
	SWzLRXwhtmg7O4ck+EduXGbTE+EQBddPChuiMg9tj5hWELevwiuc+mMgtD+DGRfni51+3JoiGQH
	n2PwTJIR4TsMwA1G0e9iQcb+ueWI+pQ0NVsb11pOo66Nxbcmladz+gaOEZOWV7wlIkcRmTGKDAG
	0ze0INB9oxF/1M/t0bYwY1fKKydA2Q+T3dAKDJtcEQF4MDuPGaBFG02TS2UH/0Nvgeu7ohjcP+i
	n24iZPw3NLN3IpdM0R5NaUxcmKqUo17SbGqsTORVL259fPcphYpqBAfpLSqi74I/FyxmYGJXpk6
	kjnjJUIy8dkP/78EtoKo0fA==
X-Received: by 2002:a05:600c:628c:b0:4a5:26b8:4507 with SMTP id 5b1f17b1804b1-4bb55a7f827mr11906675e9.21.1794521200658;
        Thu, 12 Nov 2026 14:06:40 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29daa5sm106098995e9.12.2026.11.12.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:06:39 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v4 0/5] root refs vs pseudorefs
Date: Thu, 12 Nov 2026 22:05:36 +0000
Message-ID: <cover.1794520948.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794000450.git.andy.koppe@gmail.com>
References: <cover.1794000450.git.andy.koppe@gmail.com>
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

Changes in v4:
- Glossary: stop contrasting pseudorefs with root refs, mention
  remote-tracking branches in the "ref" entry, and state that the list
  of per-worktree ref prefixes will not be extended.
- git-ls-remote(1): describe what is shown by default, including
  peeling, and describe --refs and the example in those terms.
- gitdatamodel(7): mention the root ref naming rules, and drop
  "so-called".
- Reword the description and error message of rev-list --merge.

Andy Koppe (5):
  doc: glossary: add root ref and clarify pseudorefs
  doc: glossary: update per-worktree refs
  doc: stop calling root refs pseudorefs
  refs: stop calling root refs pseudorefs
  t: stop calling root refs pseudorefs

 Documentation/config/core.adoc                |   2 +-
 Documentation/for-each-ref-options.adoc       |   2 +-
 Documentation/git-ls-remote.adoc              |   9 +-
 Documentation/git-update-ref.adoc             |  13 +--
 Documentation/git-worktree.adoc               |  16 ++-
 Documentation/gitdatamodel.adoc               |  22 +++-
 Documentation/glossary-content.adoc           | 110 +++++++++++-------
 Documentation/rev-list-options.adoc           |   4 +-
 builtin/for-each-ref.c                        |   2 +-
 contrib/completion/git-completion.bash        |   7 +-
 refs.h                                        |  13 +--
 revision.c                                    |   2 +-
 t/show-ref-exists-tests.sh                    |   4 +-
 t/t0600-reffiles-backend.sh                   |   2 +-
 t/t0610-reftable-basics.sh                    |   2 +-
 t/t1400-update-ref.sh                         |  66 +++++------
 t/t1403-show-ref.sh                           |   2 +-
 t/t1460-refs-migrate.sh                       |   4 +-
 t/t4013-diff-various.sh                       |   6 +-
 ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |   2 +-
 t/t6302-for-each-ref-filter.sh                |   4 +-
 t/t9902-completion.sh                         |   4 +-
 22 files changed, 174 insertions(+), 124 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE => diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)

Range-diff against v3:
1:  5630c671db ! 1:  e3f2ee816f doc: glossary: add root ref and clarify pseudorefs
    @@ Commit message
         them, as they are not stored or handled by the ref backend.
     
         Add a "root ref" entry, moving the naming rules and the list of
    -    irregular root refs there from the "ref" entry. State that pseudorefs
    -    are not root refs, and refer to gitrevisions(7) for descriptions of
    -    commonly used root refs and pseudorefs.
    +    irregular root refs there from the "ref" entry, and refer to
    +    gitrevisions(7) for descriptions of commonly used root refs. In the
    +    "ref" entry, mention remote-tracking branches alongside local branches
    +    and tags.
     
         Reword the "pseudoref" entry so that it no longer calls them refs, and
         explain how their additional semantics set them apart. Clarify what
    @@ Documentation/glossary-content.adoc: exclude;;
     -	linkgit:git-update-ref[1].
     +	A name that can be used like a <<def_ref,ref>> to refer to an
     +	<<def_object,object>>, but that has additional semantics: it can
    -+	record more than one object ID and may carry extra metadata. In
    -+	contrast to <<def_root_ref,root refs>>, pseudorefs are therefore
    -+	not stored or handled by the ref backend.
    ++	record more than one object ID and may carry extra metadata.
    ++	Therefore, pseudorefs are not stored or handled by the ref backend.
     ++
     +Pseudorefs can be passed to commands such as linkgit:git-log[1] or
     +linkgit:git-diff[1], but cannot be written by linkgit:git-update-ref[1]
    @@ Documentation/glossary-content.adoc: The following pseudorefs are known to Git:
     +<<def_root_ref,root refs>>.
      +
      Different subhierarchies are used for different purposes. For example,
    - the `refs/heads/` hierarchy is used to represent local branches whereas
    +-the `refs/heads/` hierarchy is used to represent local branches whereas
     -the `refs/tags/` hierarchy is used to represent local tags..
    -+the `refs/tags/` hierarchy is used to represent local tags.
    ++local branches are stored under `refs/heads/`, remote-tracking branches
    ++under `refs/remotes/`, and tags under `refs/tags/`.
      +
      See also "REFERENCES" in linkgit:gitdatamodel[7].
      
    @@ Documentation/glossary-content.adoc: format. See linkgit:git-reflog[1] for detai
     + - `MERGE_AUTOSTASH`
     +--
     ++
    -+<<def_pseudoref,Pseudorefs>> are not considered root refs, even though
    -+they follow the naming rules.
    -++
    -+See linkgit:gitrevisions[7] for descriptions of commonly used root refs
    -+and pseudorefs.
    ++See linkgit:gitrevisions[7] for descriptions of commonly used root refs.
     +
      [[def_SCM]]SCM::
      	Source code management (tool).
2:  0bc902f13d ! 2:  ccc3554410 doc: glossary: update per-worktree refs
    @@ Commit message
         under "refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to
         each worktree too.
     
    -    Bring the list up to date, and refer to git-worktree(1) for how to
    -    access per-worktree refs of other worktrees. In the "worktree" entry,
    -    link to "per-worktree ref" instead of listing HEAD and MERGE_HEAD.
    +    Bring the list up to date, and state that it will not be extended, as
    +    new per-worktree refs are meant to go under "refs/worktree/" since
    +    8aff1a9ca5 (Add a place for (not) sharing stuff between worktrees,
    +    2018-09-29).
     
         Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
     
    @@ Documentation/glossary-content.adoc: exclude;;
     + - `refs/worktree/`
     +--
     ++
    -+<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
    ++This list will not be extended in future. Any new per-worktree refs shall be
    ++created under `refs/worktree/`.
    +++
    ++Even though they are not refs, <<def_pseudoref,pseudorefs>> are also
    ++specific to each worktree.
     ++
     +See "REFS" in linkgit:git-worktree[1] for how to access the
     +per-worktree refs of other worktrees.
      
      [[def_pseudoref]]pseudoref::
      	A name that can be used like a <<def_ref,ref>> to refer to an
    -@@ Documentation/glossary-content.adoc: and pseudorefs.
    +@@ Documentation/glossary-content.adoc: See linkgit:gitrevisions[7] for descriptions of commonly used root refs.
      	"working tree" and repository metadata, most of which are
      	shared among other worktrees of a single repository, and
      	some of which are maintained separately per worktree
3:  ac3ed53867 ! 3:  bc29d66748 doc: stop calling root refs pseudorefs
    @@ Commit message
         ORIG_HEAD as examples. In git-worktree(1), say that both root refs and
         pseudorefs are per-worktree, and drop the description of them as being
         directly under $GIT_DIR, because that does not apply to the reftable
    -    backend.
    +    backend. As in the glossary, state that the list of per-worktree
    +    prefixes will not be extended.
     
    -    In git-ls-remote(1), describe --refs as omitting refs outside "refs/",
    -    since that is what it actually checks. In the example, refer to HEAD,
    -    which is the only root ref that git-upload-pack(1) advertises. While
    -    there, correct "symbolics" to "symbolic refs".
    +    In git-ls-remote(1), state that HEAD and refs under "refs/" are shown
    +    by default, and describe --refs and the example in those terms rather
    +    than in terms of pseudorefs. Say "object IDs" instead of "commit IDs",
    +    as tag objects are shown too.
     
         In git-update-ref(1), drop the incorrect mention of ORIG_HEAD. HEAD is
         the only root ref that gets a reflog by default. In the description of
    @@ Documentation/for-each-ref-options.adoc: TAB %(refname)`.
          Allows paginating the output by skipping references up to and including the
     
      ## Documentation/git-ls-remote.adoc ##
    +@@ Documentation/git-ls-remote.adoc: SYNOPSIS
    + DESCRIPTION
    + -----------
    + Displays references available in a remote repository along with the associated
    +-commit IDs.
    ++object IDs. By default, `HEAD` and all refs under `refs/` are shown.
    ++Annotated tags are also shown peeled, i.e. recursively resolved to the objects
    ++they point at.
    + 
    + 
    + OPTIONS
     @@ Documentation/git-ls-remote.adoc: OPTIONS
      	with other git subcommands.
      
      --refs::
     -	Do not show peeled tags or pseudorefs like `HEAD` in the output.
    -+	Do not show peeled tags or refs outside `refs/`.
    ++	Do not show `HEAD` or peeled tags in the output.
      
      -q::
      --quiet::
    @@ Documentation/git-ls-remote.adoc: line shows the name of the object the tag poin
      --------
      
     -* List all references (including symbolics and pseudorefs), peeling
    -+* List all references (including `HEAD` and symbolic refs), peeling
    -   tags:
    +-  tags:
    ++* List `HEAD` and all refs under `refs/`, peeling tags:
      +
      ----
    + $ git ls-remote
     
      ## Documentation/git-update-ref.adoc ##
     @@ Documentation/git-update-ref.adoc: still see a subset of the modifications.
    @@ Documentation/git-worktree.adoc: but others are specific to an individual worktr
     + - `refs/rewritten/`
     +
     + - `refs/worktree/`
    ++
    ++This list will not be extended in future. Any new per-worktree refs shall be
    ++created under `refs/worktree/`.
      
      Refs that are per-worktree can still be accessed from another worktree via
      two special paths, `main-worktree` and `worktrees`. The former gives
    @@ Documentation/gitdatamodel.adoc: remote-tracking branches: `refs/remotes/<remote
     +[[root-refs]]
     +root refs::
     +    Git may create references other than `HEAD` at the root of the hierarchy,
    -+    for example `ORIG_HEAD` or `REBASE_HEAD`.
    ++    for example `ORIG_HEAD` or `REBASE_HEAD`. Their names must follow
    ++    special rules.
     +
     +[[pseudorefs]]
     +pseudorefs::
     +    linkgit:git-fetch[1], linkgit:git-merge[1] and linkgit:git-pull[1]
    -+    create the so-called pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
    ++    create the pseudorefs `FETCH_HEAD` and `MERGE_HEAD`.
     +    They are not references as such, because they are not stored by the
     +    ref backend, but they can nevertheless be used to refer to objects in
     +    commands such as linkgit:git-log[1] and linkgit:git-diff[1].
     +
    -+See linkgit:gitglossary[7] for further details on root refs and
    -+pseudorefs.
    ++See linkgit:gitglossary[7] for the root ref naming rules and further details
    ++on pseudorefs.
      
      NOTE: Git may delete objects that aren't "reachable" from any reference
      or <<reflogs,reflog>>.
    @@ Documentation/rev-list-options.adoc: Under `--pretty=reference`, this informatio
      	Show commits touching conflicted paths in the range `HEAD...<other>`,
     -	where `<other>` is the first existing pseudoref in `MERGE_HEAD`,
     -	`CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
    -+	where `<other>` is the first of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
    ++	where `<other>` is the first one of `MERGE_HEAD`, `CHERRY_PICK_HEAD`,
     +	`REVERT_HEAD` or `REBASE_HEAD` that exists. Only works
      	when the index has unmerged entries. This option can be used to show
      	relevant commits when resolving conflicts from a 3-way merge.
4:  2c3f3ab195 ! 4:  610138169d refs: stop calling root refs pseudorefs
    @@ Commit message
         those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD,
         so update them.
     
    +    The "--merge" error message called MERGE_HEAD, CHERRY_PICK_HEAD,
    +    REVERT_HEAD and REBASE_HEAD pseudorefs, but MERGE_HEAD is the only
    +    actual pseudoref among them, and merely listing their names suggests
    +    that one of them should be given as an argument. Instead, say that an
    +    ongoing merge, cherry-pick, revert or rebase is required.
    +
         Bash completion function __git_pseudoref_exists() is not renamed, as
         there is no obvious term covering both root refs and pseudorefs, and
         third-party completion scripts might depend on the name.
    @@ contrib/completion/git-completion.bash: __git_eread ()
     -# 1: The pseudo-ref to search
     +# Runs git in $__git_repo_path to determine whether a root ref or
     +# pseudoref exists.
    -+# 1: The ref to check
    ++# 1: The name to check
      __git_pseudoref_exists ()
      {
      	local ref=$1
    @@ refs.h: void update_ref_namespace(enum ref_namespace namespace, char *ref);
     - * "normal" refs. These refs can thus not be stored in the ref backend,
     - * but must always be accessed via the filesystem. The following refs
     - * are pseudorefs:
    -+ * Pseudorefs are names that can be used like refs, but have different
    ++ * Pseudorefs are names that can be used like refs, but have additional
     + * semantics. They cannot be stored in the ref backend, but must always
     + * be accessed via the filesystem. The following are pseudorefs:
       *
    @@ revision.c: static const char *lookup_other_head(struct object_id *oid)
      		}
      
     -	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
    -+	die(_("--merge requires one of MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
    ++	die(_("--merge requires an ongoing merge, cherry-pick, revert or rebase"));
      }
      
      static void prepare_show_merge(struct rev_info *revs)
5:  d8a825d8cc = 5:  368ea8b6bc t: stop calling root refs pseudorefs
-- 
2.56.0

