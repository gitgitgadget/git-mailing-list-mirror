Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643620;
	b=4MK8Pi4qZ6ETrXc0glYbi56nCxT37auTg9hzvIncE1CZ2HMbQjxJKhxpeFnlNcqE+fzj
	 HZHfJ8l12C6S6DglCmIY9B/RBp/qN5JQrkXGaPzu6QYckX/33BH8pVpjIz7kzxTzzbIDR
	 zmgluE3fMuLgAYipysHvlMeKEsq1/amPsWPEQ43wVUlRQV3bI6ayx0hSbq4ywc3dHHIx0
	 vusWz45vnzP8makx4RqOoSjEzPAicP7KTOGkItb8DbPGDu7MIr0fM0IH41yQVMdm51UpN
	 R92V1eU9G1bAZIiutOFz/sjXfkFwWpkhAimQotsVeAr5/uaoK2UCoQxuuKV2a5ViEBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643620;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=R/Tz/7FBM+sdGiSqTHZcJpi+Zsu+Er+XCqw4SdDXdUY=;
	b=TLpzidkrdnv++NQm1upxjqr0ykPIXgbvLryDdH5csimpTPL/31rlBA/qGRUMwFeok2rd
	 /dp19S8sEAiQkhcwxpBEyqvRU8iaSR7IsN2/Gx4Lfq74h0k1Fult/RYrDZEPPystVL6he
	 G12oYBDiDM87Rh8V+r7GbiLSj9I1W0ftN2iqXK3x53o11uqvvgMQ5P9puX0SuJOzFwxRF
	 lwLWM2vzmcoknIamHZODc17XSEa3TEr52cPJyYoaT6tqo2ZT/XIvyZN1NHCNImDQhruEK
	 2ABy4x+6vdKINicEakN7oDGcQBIX1Ww2fJE9FpHQJJTyqvScYdyhrzToquL70CCK7NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=J7gnpt7l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UgGtP+vb;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA32606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA32606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=J7gnpt7l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UgGtP+vb
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2F927A00F1
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 13:20:18 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 02 Nov 2026 13:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793643618;
	 x=1793730018; bh=R/Tz/7FBM+sdGiSqTHZcJpi+Zsu+Er+XCqw4SdDXdUY=; b=
	J7gnpt7lLWRBU4Nn/JenaXrzaCKXgH4+ULpHrCSnZhsdrlakxRARKN3qYCcrQ0tm
	nacNqogR1Hhhpss/IeBwQn3GtKOK00wP8+QPcicTF9q2hQ9aoSjTrJLq0QW2BALw
	hCgWjMFp0cpZPmLGvDZ4Xb+kl9HbYMXZiiOQAAX8yE2Q+cMwkwHjNIcMePNREh0n
	E6PrWNlBBOkVT//7hRyj9Xlad89XBqfAumrnVU2mU9+pU0+F0J/f7H5rOEv2XK0x
	7qk0/S8x5qC8CcwUfPc5zLHrFNuSc+Cib6D27fo7cuafQHiK25ROGg59WITManB2
	ohNtae08dTU+zBNvTL67fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793643618; x=
	1793730018; bh=R/Tz/7FBM+sdGiSqTHZcJpi+Zsu+Er+XCqw4SdDXdUY=; b=U
	gGtP+vbi7u/zMLIUD9J7i3psqw5MpUgMWZ4zgINZOjf51oqX+XCeYGaw0mItO1cp
	w8O+NlfftzRWYL6+aGF88BUCKA+ncebECldUDwJxvNBIq6a46/9DpEBNZDrNRVQ+
	xMSOM7UED+aqSv4wMIdvb4HAixs1vaa0amCCGNAxbvO4PhuWVq1Xyl3pzxVsEgL6
	N2qJkTYG9K85qUve2NHTI1C2+P+44KcYnkMhsYJ8YQrfp3ar521gigVlHpOl+4ht
	XU7ajg+tVv9VvZ3OnofcvZQT076gA6ln6JHMDONjbFVjnK3sn13dqLIJbMsjT2eI
	3+85tpJSjkPCn1Pm6MCVA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793643618; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LIYmC7JFVUXbafC3nbm3GVlim2b0bqoRKP/VxKp12bOQjB0
	fKlVbu9y44TjiQdlPRqFhAjUMYyi3KbQ2NNh2Fq+y0TYbQEHGeq/H820stWs7WTE
	fpA0NVXI0iFEs3c56qqAdTPjUV9XK8AbKLNPy6sfS+aTyIhjzFfeTM+kFyjKuMMF
	WLJinu32aPsig11hnxWfN7tU98sWsOx8zrqxXg3Ntxb0aKj6Ssm3eu1KNFWF4+qc
	7/F94hQpzqYmqUtBAJnlnuD3Q1q+CmZGsnrDadFzPC4rCmaTlc55eEJJ0/gjEe4O
	hiTdETgDF7TNOpp//GXMb5k0/azSQGqC3sMsZ+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bzyot40sUsrAz7lCIrLiQG5xB9frG+mT2l8FEZQNmHw=:LlXBPVXVXgVDZfc4y+mFI6iLwlxZpFZZjBwXcBNOo6c=;
X-ME-Sender: <xms:YtToav7ml5pTtqIi2OJc7yPx45gi72zxLfGYfj1nF4rpUDFF6EIf2A>
    <xme:YtToavth7F23o5ieZVOqloz9J31rxYpBN6yY8W2giv9uLs-QsTWFS-tjs7InpbZd0
    702hCyf_Hj4kv8G209U-f12FYv9umwGp2l5vgJmARouLT9EyitJcCyS>
X-ME-Proxy-Cause: dmFkZTFyFSminm2VShGJT2bH7kYnDR7MHcf96hW4Yrf51mEfV4vOHcUsqF5q8FSj0ZerdJ
    mCnn6eb1VB9EGCgrPHcP7NeHlhA6BWQQdAig1QMNrwKBQC4M0/v/T5jWYWAG4kF7wG5gO8
    6NuaV6nKJqRMeBBh6oh9yHm6q5W/5Ub7dCDTaJZ6WanQp6Xh8R/aJS1oq6S9Nx2F7jaLv3
    q8Y89kfscukN/X/+h9sJBtCsKojfFpw1gYwmjR4eDiI7AbkvbvxxVGq3Hv0/p3CsP8FiEG
    yGKu45+esWbqgfR8uRjome2UdcilzcXB08LcJ7L+c7Tn1rRymV8npcpkfGVpiS92JYygYr
    RwdboLzaT9iPs+bfQ8etQ+1jRxNTnc5dj4+rHkn5ogSoRzkiz8RAHzzb2UqZzd5NDT4cuV
    jNDmbKqR4838JPyJpt7NaRQZDyW4hBvygnVRb/3gEb1SRehwJ8z3zy1/QqGU/nfLkYffEJ
    BMS2zInzHY49X7iEpA1/09vdqp0a6hOvwAT/HOshIH1hTK+/nZzKmk+6wRyc3NYldnqRsH
    W5VRsdA2IXqGhFIlO9zOTF0iXi4s5aJqbmiGcr4Td7NNxy+VYSmzi2ZQ1e/tPteV/WZew3
    ZZGeXYFBDvIzDYcVb8Ou6T7HedlkysEK3i6CInFitB6/Mvikk8FJnoUXJWBA
X-ME-Proxy: <xmx:YtToashPgMYhrCxXXn9ZEuOjNr2mSq1DGIuPhLBUzyNSrc0tAYRe7g>
    <xmx:YtToai22z6FQjJSQtN0sS0ts8HkXiJE_YV9-779ZUysxzOefi-0boQ>
    <xmx:YtToaug02idOgcq9CNomOCMkExJ4y8acj4T6k0W3n95HFkRaIuCYXw>
    <xmx:YtToaqdE50eL_xO4DMyRGvt2_6Bo4WBzIeAz6mBj2U06jTgKmYeYCw>
    <xmx:YtToaplXhttdzLzjvhuV5efA0snLwVQpjBLXKe_ETqBbXH5n40ivf8zr>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 105F6782738; Mon,  2 Nov 2026 13:20:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AXlNo_7mn8GF
Date: Mon, 02 Nov 2026 13:19:57 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Andy Koppe" <andy.koppe@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com>
In-Reply-To: <20261101230326.3675597-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
 <20261101230326.3675597-1-andy.koppe@gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Nov 1, 2026, at 6:03 PM, Andy Koppe wrote:
> Changes in v2:
> - Tweak pseudoref definition.
> - Add prefix lists for per-worktree refs.
> - Wrap lists in '--'.
> - Add root refs and pseudorefs to ref types in gitdatamodel(7).
> - Trim messages of commits 3 and 4.
>
> Andy Koppe (5):
>   doc: glossary: add root ref and clarify pseudorefs
>   doc: glossary: update per-worktree refs
>   doc: stop calling root refs pseudorefs
>   refs: stop calling root refs pseudorefs
>   t: stop calling root refs pseudorefs
>
>  Documentation/config/core.adoc                |  2 +-
>  Documentation/for-each-ref-options.adoc       |  2 +-
>  Documentation/git-ls-remote.adoc              |  4 +-
>  Documentation/git-update-ref.adoc             | 13 ++-
>  Documentation/git-worktree.adoc               | 13 ++-
>  Documentation/gitdatamodel.adoc               | 18 +++-
>  Documentation/glossary-content.adoc           | 98 ++++++++++++-------
>  Documentation/rev-list-options.adoc           |  4 +-
>  builtin/for-each-ref.c                        |  2 +-
>  contrib/completion/git-completion.bash        |  7 +-
>  refs.h                                        | 13 ++-
>  revision.c                                    |  2 +-
>  t/show-ref-exists-tests.sh                    |  4 +-
>  t/t0600-reffiles-backend.sh                   |  2 +-
>  t/t0610-reftable-basics.sh                    |  2 +-
>  t/t1400-update-ref.sh                         | 66 ++++++-------
>  t/t1403-show-ref.sh                           |  2 +-
>  t/t1460-refs-migrate.sh                       |  4 +-
>  t/t4013-diff-various.sh                       |  6 +-
>  ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |  2 +-
>  t/t6302-for-each-ref-filter.sh                |  4 +-
>  t/t9902-completion.sh                         |  4 +-
>  22 files changed, 158 insertions(+), 116 deletions(-)
>  rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE => 
> diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)
>
> Range-diff against v1:
> 1:  9979ad1589 ! 1:  4734fa2f2e doc: glossary: add root ref and clarify 
> pseudorefs
>     @@ Documentation/glossary-content.adoc: exclude;;
>      -	A ref that has different semantics than normal refs. These refs 
> can be
>      -	read via normal Git commands, but cannot be written to by 
> commands like
>      -	linkgit:git-update-ref[1].
>     -+	A name that can be used like a <<def_ref,ref>> to refer to
>     -+	<<def_object,objects>>, but that is not stored in the same way 
> as refs.
>     -+	For example, pseudorefs cannot be written by 
> linkgit:git-update-ref[1]
>     -+	or listed by linkgit:git-for-each-ref[1].
>     ++	A name that can be used like a <<def_ref,ref>> to refer to an
>     ++	<<def_object,object>>, but that is not stored in the same way as 
> refs.
>     ++	For example, pseudorefs can be passed to linkgit:git-log[1] or
>     ++	linkgit:git-diff[1], but they cannot be written by
>     ++	linkgit:git-update-ref[1] or listed by 
> linkgit:git-for-each-ref[1].
>       +
>       The following pseudorefs are known to Git:
>     - 
>     -@@ Documentation/glossary-content.adoc: The following pseudorefs 
> are known to Git:
>     +-
>     +++
>     ++--
>     +  - `FETCH_HEAD` is written by linkgit:git-fetch[1] or 
> linkgit:git-pull[1]. It
>     +    may refer to multiple object IDs. Each object ID is annotated 
> with metadata
>     +    indicating where it was fetched from and its fetch status.
>      
>        - `MERGE_HEAD` is written by linkgit:git-merge[1] when resolving merge
>          conflicts. It contains all commit IDs which are being merged.
>     ++--
>      ++
>      +When a pseudoref contains more than one object ID, using it to refer to an
>      +object yields the first one.
> 2:  8932691331 ! 2:  62f4ae009c doc: glossary: update per-worktree refs
>     @@ Documentation/glossary-content.adoc: exclude;;
>      -	that start with `refs/bisect/`, but might later include other
>      -	unusual refs.
>      +	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
>     -+	rather than shared between all worktrees. All
>     -+	<<def_root_ref,root refs>>, such as <<def_HEAD,HEAD>>, are
>     -+	per-worktree, as are refs that start with `refs/bisect/`,
>     -+	`refs/worktree/` or `refs/rewritten/`.
>     ++	rather than shared between all worktrees. All <<def_root_ref,root refs>>,
>     ++	for example <<def_HEAD,HEAD>> and `ORIG_HEAD`, are per-worktree, as are
>     ++	refs with the following prefixes:
>     +++
>     ++--
>     ++ - `refs/bisect/`
>     ++
>     ++ - `refs/rewritten/`
>     ++
>     ++ - `refs/worktree/`
>     ++--
>      ++
>      +<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
>      ++
>     @@ Documentation/glossary-content.adoc: exclude;;
>      +per-worktree refs of other worktrees.
>      
>       [[def_pseudoref]]pseudoref::
>     - 	A name that can be used like a <<def_ref,ref>> to refer to
>     + 	A name that can be used like a <<def_ref,ref>> to refer to an
>      @@ Documentation/glossary-content.adoc: and pseudorefs.
>       	"working tree" and repository metadata, most of which are
>       	shared among other worktrees of a single repository, and
>       	some of which are maintained separately per worktree
>      -	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
>      -	per-worktree refs and per-worktree configuration file).
>     -+	(e.g. the index, per-worktree refs such as HEAD, pseudorefs
>     -+	such as MERGE_HEAD, and the per-worktree configuration file).
>     ++	(e.g. the index, <<def_per_worktree_ref,per-worktree refs>>, and the
>     ++	per-worktree configuration file).
> 3:  8cdd299c28 ! 3:  73dcb3d715 doc: stop calling root refs pseudorefs
>     @@ Commit message
>          there, correct "symbolics" to "symbolic refs".
>     
>          In git-update-ref(1), drop the incorrect mention of ORIG_HEAD. HEAD is
>     -    the only root ref that gets a reflog by default. Also restructure the
>     -    sentence to make it easier to parse.
>     +    the only root ref that gets a reflog by default. In the description of
>     +    core.logAllRefUpdates, correct the claim that "always" only applies to
>     +    refs under "refs/". It applies to root refs too.
>     
>     -    In the description of core.logAllRefUpdates, correct the claim that
>     -    "always" only applies to refs under "refs/". It applies to root refs
>     -    too.
>     +    Distinguish root refs and pseudorefs in gitdatamodel(7). Lowercase the
>     +    "other references" list entry there to match the others.
>     
>          Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
>     
>     @@ Documentation/git-worktree.adoc: but others are specific to an 
> individual worktr
>      -however: refs inside `refs/bisect`, `refs/worktree` and 
> `refs/rewritten` are
>      -not shared.
>      +In general, all root refs and pseudorefs are per-worktree and all 
> refs
>     -+starting with `refs/` are shared. There are exceptions, however: 
> refs
>     -+inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are not
>     -+shared.
>     ++starting with `refs/` are shared, except for refs with the 
> following prefixes:
>     ++
>     ++ - `refs/bisect/`
>     ++
>     ++ - `refs/rewritten/`
>     ++
>     ++ - `refs/worktree/`
>      
>       Refs that are per-worktree can still be accessed from another worktree via
>       two special paths, `main-worktree` and `worktrees`. The former gives
>     
>     + ## Documentation/gitdatamodel.adoc ##
>     +@@ Documentation/gitdatamodel.adoc: remote-tracking branches: 
> `refs/remotes/<remote>/<branch>`::
>     + default branch. This is the branch that `git clone` checks out by 
> default.
>     + 
>     + [[other-refs]]
>     +-Other references::
>     ++other references::
>     +     Git tools may create references anywhere under `refs/`.
>     +     For example, linkgit:git-stash[1], linkgit:git-bisect[1],
>     +     and linkgit:git-notes[1] all create their own references
>     +     in `refs/stash`, `refs/bisect`, etc.
>     +     Third-party Git tools may also create their own references.
>     +-+
>     +-Git may also create references other than `HEAD` at the base of 
> the
>     +-hierarchy, like `ORIG_HEAD`.
>     ++
>     ++[[root-refs]]
>     ++root refs::
>     ++    Git may also create references other than `HEAD` at the root 
> of the
>     ++    hierarchy, for example `ORIG_HEAD` or `REBASE_HEAD`.
>     ++
>     ++[[pseudorefs]]
>     ++pseudorefs::
>     ++    linkgit:git-fetch[1] and linkgit:git-merge[1] create the 
> so-called
>     ++    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not 
> references as
>     ++    such, as they are not stored in the same way, but they can 
> nevertheless

When I look at my .git directory during a merge conflict, I see these
files:

$ ls .git | grep HEAD
FETCH_HEAD
HEAD
MERGE_HEAD
ORIG_HEAD

From the above, it sounds like ORIG_HEAD is a "root ref" and
MERGE_HEAD is a "pseudoref", but naively it does look like
they're stored in the same way. What's the difference?
