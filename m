Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574268;
	b=m1ht3Zw+/Vaofh6InRBcIrMIszG7yPJNJtER6g+uPrQMfvNNZ0RDh4vc9Vp9Fppug7MM
	 vV9re9xqTkSJSxMt4BjHAHQA5SC7a9JVprehy5qeev6E0/nBEFgfeYQm+A6t/d1kOwQzO
	 xenP2SCZFy5fDCL/U8KKy5oK2088dCFdpSBgWvfoCN8+fQR+4yNlLv6Kv4Tkw1uexUUb7
	 eKzJaEsL2jCXKwd/WN8WGdQqQ4Fzjc/wGVQhuu2DrFZYn1mJj8EV5eJKMZUzKc1oZ6abu
	 HJg6NKZyGvRZmx1snXAiV4UOwBRdG3X2Roj3tI8NlzmJlDwVBPGU9mUtDa94dTXXHFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=106whzjtiuCI/GqIGhFqQrvzBsRhb9rXaEw2GfuVY9c=;
	b=i/Bjwqeb54/p+AwC3f3/YpuYZlY4cBXGE7WVRQ3tlH2lcaYJC+bBEpGPK6z/s7Erx5cw
	 DEB9sSwrEKUgEpDwk235qZzhhkHO0r2tXTfXz+Xp3wJ/H8vsvsG87qHUyZ/gXvABFKXnM
	 EodAq5yujNKq5Nbd/XsZ+5UnpMhbk8JC4xKGOydJ3SzG9IGJ54AxPDvgHthQewf8UId6L
	 3bxX0BLYkInjRFZ0aOe9DPaxsoXHOFEMpyHASKp1I+FhRtZ5rTFM19LyYh5cIaNH2qE1L
	 00aybAD8yogeFirACyfMYfqAyVoREylI1eU9tm8zhPEzYH4tuBB1Jj/GB4dI1fisDrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bys1EkN7;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F111606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F111606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bys1EkN7
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so13646185e9.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574266; x=1794179066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=106whzjtiuCI/GqIGhFqQrvzBsRhb9rXaEw2GfuVY9c=;
        b=Bys1EkN7PTiuShsW2z0EzFQWwgzpbFo5/vMdTQ+Y9FAF46jsRF9YoHMe+jpDYI52vc
         dX8Mn/qeHCkqcbO15DNVbr42CDpxD0Vu4bR7qBFkJ6h8Ke5rTBcrMx4TR6NKW3qw7Mn6
         bP2vS9hJaIEn/WZMBir9e2v68/XPbJTqqPbxHaAE+LIpaPMORYpK6sVBE2vDWrlPRTZj
         67xz53rCgiOrgZAaAZ7vYQ04QH1L4868zL5tJ6u3HeNoo9ts3wuRl1vfIAoEB8+CqjNy
         16wxx4LzIh0+0guKbQTP0v8rGy17hfMn2hymGxq0WK4VPApGcRffOgm8Tfg5tBYXhgzN
         azbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574266; x=1794179066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=106whzjtiuCI/GqIGhFqQrvzBsRhb9rXaEw2GfuVY9c=;
        b=2rk6iAm7GUi8o+bZvx/0sW33AMkHYzJUMJlk+v9cdnHsBuaxL17MwhLsxcjlS0amyx
         gmfqo25TxBCYVLra8P7afJ50eHpAljzaTyuUs6sFB8wZE8a1IY9n/9k+NYTjB6SiK7HQ
         yahRYqJcFrIcgnCOrCMExmDp2jdWC9RCFUH2KQLqgwqKOAw55TPJfMqqSxdW3WIqVLNJ
         jst8DZKr4lzu+Mr3yVJSq+LEAsV/lkZZWpsJDdcWOwQQpv+AccEmvbD2pqvdYRqPwYNn
         Wbbhsl3MHepPNNZdE6yJwLGXD+u/mcxqg72pUePh5QWzdMZ4RyIvei+JoYULKmgV3ion
         EITA==
X-Gm-Message-State: AFq9FYLt3B+DLlroM98vA767VAEt86ow2NICgvUJiwD8SwQLQ0fGaHVq
	f/7+wYkMXykKa4Zyex9Jm4UR5APiAi294dy688uKruEj0aYkYK5ev4PxNQM6nlS+
X-Gm-Gg: AYBFou0ff0ANSivpnUXI7+dA+sX/SU3ZVwyZLk419P0GxmGDCfS2gLLd0096H2yoguy
	cLw6+UN/z/OVguNC8xoiJSdEgDDWf7c/wh/KBxlRXuft48Nht0Dxt1xT3YACGyNM7Wvlqzn8GgL
	eSDrQnWR1DsyY2M78TE59ZB7ZMdAy9oKGC57oIdAzqjwdAdJYV5oShbk72j1gxrDkrjzCyY2xke
	se9ksmtiDczOxAfjQqmrL6PX2P3ncKLZDrGiTjYp3kH0ZIXcxLdj8neL48MKXkOmFUKLM7hR5V9
	i/XJibelphDN6fwo0z4tQlJKPt2yfK6r9t0UlxyWDydA3K9weZZdyQyOEk9GNZ/Tyx6HOEG4efq
	3NqXQZg3gAlOKF91VPCmEHmVqOjdPRLb/WcbsXX5A6QrDXd1EyyX7yMpCEjZGofwXHCutGTV8Xi
	Aa+GwKIcq9LOQ81zA5oM0mjvGa7tReDKIvr5D5F85ujSFVGetQroGpB8zIQ8xoYF8Lu+oi9ILdp
	MQEiBenPDZ6hXNUi+mTIELfkAtp3Oy7QvUEN9aiesIXpDTPsbkejCbE3XlqU5dXB2y/SocYayXb
	+HWpSSOnLAzh8VmgGkorpKm2uozLj7isjhQEbdyn0ETX391APt30dUfybDR7K9Z8fNSbplEgROb
	237ZzsAh6eMxFTwZb2OHd8QjVGaImSzV3H6gbL/r9GYg=
X-Received: by 2002:a05:600c:8b85:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4ac1932b550mr169810425e9.28.1793574265675;
        Sun, 01 Nov 2026 15:04:25 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm135151125e9.4.2026.11.01.15.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:04:25 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 0/5] root refs vs pseudorefs
Date: Sun,  1 Nov 2026 23:03:18 +0000
Message-ID: <20261101230326.3675597-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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

Changes in v2:
- Tweak pseudoref definition.
- Add prefix lists for per-worktree refs.
- Wrap lists in '--'.
- Add root refs and pseudorefs to ref types in gitdatamodel(7).
- Trim messages of commits 3 and 4.

Andy Koppe (5):
  doc: glossary: add root ref and clarify pseudorefs
  doc: glossary: update per-worktree refs
  doc: stop calling root refs pseudorefs
  refs: stop calling root refs pseudorefs
  t: stop calling root refs pseudorefs

 Documentation/config/core.adoc                |  2 +-
 Documentation/for-each-ref-options.adoc       |  2 +-
 Documentation/git-ls-remote.adoc              |  4 +-
 Documentation/git-update-ref.adoc             | 13 ++-
 Documentation/git-worktree.adoc               | 13 ++-
 Documentation/gitdatamodel.adoc               | 18 +++-
 Documentation/glossary-content.adoc           | 98 ++++++++++++-------
 Documentation/rev-list-options.adoc           |  4 +-
 builtin/for-each-ref.c                        |  2 +-
 contrib/completion/git-completion.bash        |  7 +-
 refs.h                                        | 13 ++-
 revision.c                                    |  2 +-
 t/show-ref-exists-tests.sh                    |  4 +-
 t/t0600-reffiles-backend.sh                   |  2 +-
 t/t0610-reftable-basics.sh                    |  2 +-
 t/t1400-update-ref.sh                         | 66 ++++++-------
 t/t1403-show-ref.sh                           |  2 +-
 t/t1460-refs-migrate.sh                       |  4 +-
 t/t4013-diff-various.sh                       |  6 +-
 ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |  2 +-
 t/t6302-for-each-ref-filter.sh                |  4 +-
 t/t9902-completion.sh                         |  4 +-
 22 files changed, 158 insertions(+), 116 deletions(-)
 rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE => diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)

Range-diff against v1:
1:  9979ad1589 ! 1:  4734fa2f2e doc: glossary: add root ref and clarify pseudorefs
    @@ Documentation/glossary-content.adoc: exclude;;
     -	A ref that has different semantics than normal refs. These refs can be
     -	read via normal Git commands, but cannot be written to by commands like
     -	linkgit:git-update-ref[1].
    -+	A name that can be used like a <<def_ref,ref>> to refer to
    -+	<<def_object,objects>>, but that is not stored in the same way as refs.
    -+	For example, pseudorefs cannot be written by linkgit:git-update-ref[1]
    -+	or listed by linkgit:git-for-each-ref[1].
    ++	A name that can be used like a <<def_ref,ref>> to refer to an
    ++	<<def_object,object>>, but that is not stored in the same way as refs.
    ++	For example, pseudorefs can be passed to linkgit:git-log[1] or
    ++	linkgit:git-diff[1], but they cannot be written by
    ++	linkgit:git-update-ref[1] or listed by linkgit:git-for-each-ref[1].
      +
      The following pseudorefs are known to Git:
    - 
    -@@ Documentation/glossary-content.adoc: The following pseudorefs are known to Git:
    +-
    +++
    ++--
    +  - `FETCH_HEAD` is written by linkgit:git-fetch[1] or linkgit:git-pull[1]. It
    +    may refer to multiple object IDs. Each object ID is annotated with metadata
    +    indicating where it was fetched from and its fetch status.
      
       - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
         conflicts. It contains all commit IDs which are being merged.
    ++--
     ++
     +When a pseudoref contains more than one object ID, using it to refer to an
     +object yields the first one.
2:  8932691331 ! 2:  62f4ae009c doc: glossary: update per-worktree refs
    @@ Documentation/glossary-content.adoc: exclude;;
     -	that start with `refs/bisect/`, but might later include other
     -	unusual refs.
     +	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
    -+	rather than shared between all worktrees. All
    -+	<<def_root_ref,root refs>>, such as <<def_HEAD,HEAD>>, are
    -+	per-worktree, as are refs that start with `refs/bisect/`,
    -+	`refs/worktree/` or `refs/rewritten/`.
    ++	rather than shared between all worktrees. All <<def_root_ref,root refs>>,
    ++	for example <<def_HEAD,HEAD>> and `ORIG_HEAD`, are per-worktree, as are
    ++	refs with the following prefixes:
    +++
    ++--
    ++ - `refs/bisect/`
    ++
    ++ - `refs/rewritten/`
    ++
    ++ - `refs/worktree/`
    ++--
     ++
     +<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
     ++
    @@ Documentation/glossary-content.adoc: exclude;;
     +per-worktree refs of other worktrees.
      
      [[def_pseudoref]]pseudoref::
    - 	A name that can be used like a <<def_ref,ref>> to refer to
    + 	A name that can be used like a <<def_ref,ref>> to refer to an
     @@ Documentation/glossary-content.adoc: and pseudorefs.
      	"working tree" and repository metadata, most of which are
      	shared among other worktrees of a single repository, and
      	some of which are maintained separately per worktree
     -	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
     -	per-worktree refs and per-worktree configuration file).
    -+	(e.g. the index, per-worktree refs such as HEAD, pseudorefs
    -+	such as MERGE_HEAD, and the per-worktree configuration file).
    ++	(e.g. the index, <<def_per_worktree_ref,per-worktree refs>>, and the
    ++	per-worktree configuration file).
3:  8cdd299c28 ! 3:  73dcb3d715 doc: stop calling root refs pseudorefs
    @@ Commit message
         there, correct "symbolics" to "symbolic refs".
     
         In git-update-ref(1), drop the incorrect mention of ORIG_HEAD. HEAD is
    -    the only root ref that gets a reflog by default. Also restructure the
    -    sentence to make it easier to parse.
    +    the only root ref that gets a reflog by default. In the description of
    +    core.logAllRefUpdates, correct the claim that "always" only applies to
    +    refs under "refs/". It applies to root refs too.
     
    -    In the description of core.logAllRefUpdates, correct the claim that
    -    "always" only applies to refs under "refs/". It applies to root refs
    -    too.
    +    Distinguish root refs and pseudorefs in gitdatamodel(7). Lowercase the
    +    "other references" list entry there to match the others.
     
         Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
     
    @@ Documentation/git-worktree.adoc: but others are specific to an individual worktr
     -however: refs inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are
     -not shared.
     +In general, all root refs and pseudorefs are per-worktree and all refs
    -+starting with `refs/` are shared. There are exceptions, however: refs
    -+inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are not
    -+shared.
    ++starting with `refs/` are shared, except for refs with the following prefixes:
    ++
    ++ - `refs/bisect/`
    ++
    ++ - `refs/rewritten/`
    ++
    ++ - `refs/worktree/`
      
      Refs that are per-worktree can still be accessed from another worktree via
      two special paths, `main-worktree` and `worktrees`. The former gives
     
    + ## Documentation/gitdatamodel.adoc ##
    +@@ Documentation/gitdatamodel.adoc: remote-tracking branches: `refs/remotes/<remote>/<branch>`::
    + default branch. This is the branch that `git clone` checks out by default.
    + 
    + [[other-refs]]
    +-Other references::
    ++other references::
    +     Git tools may create references anywhere under `refs/`.
    +     For example, linkgit:git-stash[1], linkgit:git-bisect[1],
    +     and linkgit:git-notes[1] all create their own references
    +     in `refs/stash`, `refs/bisect`, etc.
    +     Third-party Git tools may also create their own references.
    +-+
    +-Git may also create references other than `HEAD` at the base of the
    +-hierarchy, like `ORIG_HEAD`.
    ++
    ++[[root-refs]]
    ++root refs::
    ++    Git may also create references other than `HEAD` at the root of the
    ++    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
    ++
    ++[[pseudorefs]]
    ++pseudorefs::
    ++    linkgit:git-fetch[1] and linkgit:git-merge[1] create the so-called
    ++    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not references as
    ++    such, as they are not stored in the same way, but they can nevertheless
    ++    be used to refer to objects in commands such as linkgit:git-log[1] and
    ++    linkgit:git-diff[1].
    + 
    + NOTE: Git may delete objects that aren't "reachable" from any reference
    + or <<reflogs,reflog>>.
    +
      ## Documentation/rev-list-options.adoc ##
     @@ Documentation/rev-list-options.adoc: Under `--pretty=reference`, this information will not be shown at all.
      
4:  8bb6d5435c ! 4:  eb3d64fa96 refs: stop calling root refs pseudorefs
    @@ Commit message
     
         Some messages and comments in the code still use "pseudoref" in its old
         sense of any ref outside of "refs/", whereas the glossary now calls
    -    those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD.
    +    those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD,
    +    so update them.
     
    -    Replace "pseudoref" with "root ref" in the help text for
    -    "git for-each-ref --include-root-refs", in comments in refs.h, and in
    -    comments in the bash completion script, including the one for
    -    __git_pseudoref_exists(), which is also used for root refs. The function
    -    itself is not renamed. There is no obvious term covering both root refs
    -    and pseudorefs, and the old name might need to be kept for third-party
    -    completion scripts.
    -
    -    Update the description of pseudorefs in refs.h to match the glossary.
    +    Bash completion function __git_pseudoref_exists() is not renamed, as
    +    there is no obvious term covering both root refs and pseudorefs, and
    +    third-party completion scripts might depend on the name.
     
         Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
     
5:  c681a032ba = 5:  31022553a6 t: stop calling root refs pseudorefs
-- 
2.56.0

