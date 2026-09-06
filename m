Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5E2116F4
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679505; cv=none; b=gPzce/cKYUPB9+NpA86qbkZr14rd45v9M+jHNXk6a5cegf7eAlQ5BLGm+VkJcFUV/oPY5UiCK3jqOmeoFh5z1IucD+TOe8xftpiJf8ZMZT5Pmwfizjuswpk2HHgVBpeNkepzcOVQ60DCUSydv/FRWe84iLEkiALKXGWliODSv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679505; c=relaxed/simple;
	bh=JN8pxyDVZ1xJy6B29ltU/eiCRRjrNKs47epdHPrwkq4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B1+IwHlzvDqvgfA2MVXCqEAJDbeQQQoarxGX+uHL0umzZ1De+Nv+Kmx5X8B0f/Ea+dO2UABAKnDnzDRG6eQYtozOrGLR4fIyWbXkvyrogxKv8kiuGkoDFUKGpL6Ls1LgdgGuw76knv7BQ5Cys//1yXT9M93Jz+6IjXdnPuJDPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryswq0UF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryswq0UF"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1862706a91.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679502; x=1789284302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ePANBp8DUDrJEb0ur2/5BIHsAncqrifmC/PcsSDhjzY=;
        b=ryswq0UFPpljXawh5MqdNovF3m/QC7IjyVItSKlnQCQEOy5w4Dc5X5cLNYxEp9Foqx
         Jwd4pxYtdazL1bU0GlUyPmBhTt9Y/xs3EBCH/wlTEDRO8n2fIhtL5PVfplCXT2NLSAv/
         qHVWeUZUmxJZSJWJsX3KE7s+ze3vLhJusBPUPkOiACstLd8Ih4K2VH4UmRI1HJ1uAeUS
         mzmUMcAkOCgQ2NmOeUhM1LAj8Myttw3CUO5PDLnaviuWyQAXD+KNzSxRcIgvn7GszptH
         UvTBeyIXTnvVEmWGJac2Nqogaj98X1r6RifXYu7kCmoI+VC4w3rypsiouGXPcXf6eH8s
         xFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679502; x=1789284302;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ePANBp8DUDrJEb0ur2/5BIHsAncqrifmC/PcsSDhjzY=;
        b=samfzo2QKn/Udr46Y6HFfGLtkkD9/osRRF/zw5ZBG3ZJK/B7egDt551RUNlqsDF/f0
         Isq+Sw94Ec3/IdxvDWAJT9JB9ESNZXItioial5SV2TzVF+ETykiFCrh0Kw7K0MNZYtGB
         z6NzPTFrdnwOv04Z22byVKhqrznd7hpvJ9mgAcbkF29MMa0h1pze7HTFKtF69BjsNWUm
         WrfMLa5ySOs5nOPnibPathf40Jd2lV+JdhzVmbfGWS+t2+jppI4cC9qLAzZoTds2BUJX
         H7Bswxm4IA/+1GghRzMhU3OSYKg8l5nMJ1I2kQCeiIa+3RYS1FsJmUX7wUO9o0j4jO9S
         Xkdg==
X-Gm-Message-State: AFuF++l2aAvL9lDy5oc7I4tzhAzc/qudNVq4HXBXhgFuCZLhT7dP2Zdv
	IQaz3flUamhvcyKRBLGRnOpfU+7+xExvVPEcWN7f8heBNxPFezUXuP0yizSnCA==
X-Gm-Gg: AYBFou2Z42GAtOwZuLuX/CiztV0M8dYyVnFyW6Ijs0kcs3K7lGfAgCsIxEX8qpSWhDf
	5N8TTxzK+SFeICKRR5RcEFblkl7VxF/fNu9Bn8LlRLo1Vn4/1JEU/y4hBBxcnEnSda7zeCo3dqF
	LoSbHh3UKacCYOgTFIEUGhFbnr3oBT3aqnPhSO0ehopjASlmWgwKj7v1ksHo1b2EvdpBGrWihQu
	VjdxVt7Yrg3QBS1oDztXBJAzi6vyjV/69w6/Oz7nwXSLS8wYsIvsba9WlJwgEY4oy6I5uleCBgu
	ZpgOOkeTByub+uaMqnzmCbffH2SsuUDx42mQprIT2sgKN+bQ1HAxAdqbWiN/W0aXyt+shr8w/mc
	JG9o+rfmyoFQ5A74TDCIJCoXbUUml3SVb62RbRUt9bnkYUPcLZnG3kobxwUaTpPvaTWYe/UHAf+
	j7+BORlmbj3SacbG+Z5s4T0X0NqXv5l7+93pGicNiyIHQrAgJgr9ummIUlPyr0BVs=
X-Received: by 2002:a17:90b:17cd:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-39b26272b4dmr24098063a91.13.1788679502071;
        Sun, 06 Sep 2026 00:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm2615153eec.20.2026.09.06.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:01 -0700 (PDT)
Message-Id: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:24:54 +0000
Subject: [PATCH v3 0/6] send-pack: avoid sending the whole tree when pushing from a shallow clone
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v2:

 * Rebased on master (ps/odb-pluggable-pack-generation has now been merged)
 * Completely rewrote the cover letter below
 * Fixed several suboptimal error messages related to Stolee's suggested
   testcase (Patches [1-3]/6)
 * Made push.shallowExcludeBoundary a tri-state setting, initially keeping
   the same default (Patch 4/6)
 * Argued for the change of default in a separate patch (Patch 5/6)
 * Added advice for retrying problematic multi-ref pushes separately. (Patch
   6/6)

Changes since v1:

 * Fixed two small code style issues
 * Updated the cover letter below to point out that push.negotiate=true
   doesn't work for everyone, and even when negotiation does work it doesn't
   solve all cases.
 * Updated to latest ps/odb-pluggable-pack-generation branch.

[Note: push.negotiate=true is NOT a general solution to this problem.
There's too many holes it leaves open.]

When pushing from a shallow clone, send-pack may know none of the commits
advertised by the receiver. Pack generation then walks back to the client's
shallow boundary and sends the boundary commit's entire tree. A tiny change
can consequently result in transferring gigabytes of objects that the
receiver almost certainly already has.

The behavior can be even worse with a partial, sparse clone. For example, a
repository created with:

git clone --depth=2 --filter=blob:none --sparse ...


may not have the blobs from its shallow boundary locally. Before sending the
unnecessarily large pack, Git first downloads those blobs from its promisor
remote, only to upload them back to what is often the same server.

A shallow client already omits the boundary commit's parents, which it does
not have, and relies on receive-pack's connectivity check to reject the push
if the receiver lacks them. This series allows the client to make the same
assumption about the boundary commit itself. Omitting that commit prevents
its tree from becoming part of the generated pack.

If the receiver has the shallow graft commit, the push avoids transferring
and recompressing its tree. If the receiver lacks both the shallow graft
commit and its history, the push was going to fail anyway, but now fails
without first sending the large pack.

The special case to consider is the rare use of push to seed a receiver that
accepts new shallow roots. Such a receiver already requires
receive.shallowUpdate=true; it must now be paired with
push.shallowExcludeBoundary=false on the client so that the boundary
snapshot is sent.

The series introduces push.shallowExcludeBoundary with three values:

 * true omits reachable shallow boundaries from the pack;
 * false retains the historical behavior; and
 * abort refuses to choose either behavior, telling the user to specify.

The series first introduces the option while not changing the default, and
then argues for the change of default in a separate patch.

As highlighted by Stolee's testcase, omitting a boundary can also cause a
shared pack for multiple refs to lack an object needed by one of those refs.
However, there is no corruption -- the receiver safely rejects the affected
updates, and the final patch advises retrying the refs separately, allowing
the user to easily recover.

Before changing send-pack, the first three patches improve how receive-pack
handles and reports incomplete pushes. Missing objects are distinguished
from type mismatches, repeated connectivity diagnostics are suppressed, and
a missing shallow boundary results in per-ref "missing necessary objects"
errors instead of receive-pack disconnecting.

Elijah Newren (6):
  unpack-objects: distinguish missing objects from type mismatches
  receive-pack: avoid repeating connectivity errors
  shallow: reject missing boundaries without disconnecting
  send-pack: optionally omit shallow boundaries
  send-pack: default to excluding shallow boundaries
  send-pack: advise splitting incomplete shallow pushes

 Documentation/config/advice.adoc |   5 +
 Documentation/config/push.adoc   |  23 ++++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/receive-pack.c           |   7 +
 builtin/unpack-objects.c         |   9 +-
 send-pack.c                      | 146 ++++++++++++++++++++-
 shallow.c                        |  16 ++-
 t/t5410-receive-pack.sh          |   6 +-
 t/t5504-fetch-receive-strict.sh  |   7 +-
 t/t5538-push-shallow.sh          | 216 ++++++++++++++++++++++++++++++-
 11 files changed, 422 insertions(+), 15 deletions(-)


base-commit: 1630431f326e15fcde608827b5ff38422528eb59
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2208%2Fnewren%2Favoid-expensive-shallow-pushes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2208/newren/avoid-expensive-shallow-pushes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2208

Range-diff vs v2:

 -:  ---------- > 1:  6056689be0 unpack-objects: distinguish missing objects from type mismatches
 -:  ---------- > 2:  74a52a632e receive-pack: avoid repeating connectivity errors
 -:  ---------- > 3:  fc21ecf832 shallow: reject missing boundaries without disconnecting
 1:  d4501a5c23 ! 4:  7a4fb38450 send-pack: avoid sending the whole tree when pushing from a shallow clone
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    send-pack: avoid sending the whole tree when pushing from a shallow clone
     +    send-pack: optionally omit shallow boundaries
      
     -    When pushing from a shallow clone, even if we only have made a small
     -    one-line change to a tiny file, we often push the entire toplevel tree
     -    of files.  For large repositories, this could be gigabytes instead of
     -    kilobytes.
     +    When the receiver advertises no commit the shallow client has, pack
     +    generation walks to a shallow boundary and sends its entire tree. A tiny
     +    push can consequently transfer gigabytes of objects the receiver likely
     +    already has.
      
     -    The reason for this is that the push likely lacks the commits the
     -    receiver has advertised, so it walks back to its shallow grafts.  Since
     -    it doesn't know that the server has anything, it sends the entire tree
     -    for the graft.  It would also send the parents of the shallow graft,
     -    except the shallow clone doesn't have those by construction.  We thus
     -    are forced to assume that the server has the parents of the shallow
     -    graft -- if it doesn't, the server's receive-pack will reject the push.
     +    The client already assumes the receiver has the boundary's parents,
     +    which are absent from the shallow clone. Extend that option to the
     +    boundary itself: push.shallowExcludeBoundary=true adds reachable shallow
     +    grafts as negative tips, letting receive-pack's connectivity check
     +    reject the push if the assumption is wrong.
      
     -    But that raises the obvious question: if we're going to assume the
     -    server has the parents of the shallow graft, why not just assume the
     -    server has the shallow graft itself -- which this clone almost certainly
     -    received from the server when the shallow clone was created?  As noted
     -    above, receive-pack already has a builtin connectivity check that
     -    predates pushing from a shallow clone by years[*], so even if a client
     -    is pushing to a different server than it cloned from, the worst that
     -    happens is a rejected push.  And by assuming the server has the shallow
     -    graft commits, then for large repositories (those most likely to use
     -    shallow clone) we can avoid transferring (and perhaps re-compressing)
     -    gigabytes of file contents that the server already has.
     +    Only use grafts reached from refs contributing to the pack. An unrelated
     +    graft could otherwise exclude an object another ref needs. Stop at
     +    commits known to both sides, since they already bound the pack.
      
     -    [*] Compare 5dbd76760181 (receive/send-pack: support pushing from a
     -        shallow clone, 2013-12-05) and 52fed6e1ce07 (receive-pack: check
     -        connectivity before concluding "git push", 2011-09-02)
     -
     -    Fix this by finding the shallow grafts behind the history we're pushing
     -    and adding them to the pack boundary as uninteresting (negative) tips,
     -    so the generated pack leaves out everything underneath them.  We only
     -    use grafts that the pushed commits can actually reach; excluding every
     -    graft in the repository would be simpler, but it could drop an object we
     -    really do need to send -- for example, a new blob we're pushing that
     -    also happens to sit under some unrelated shallow root pulled from a
     -    different remote.
     -
     -    We can also stop early at any commit we and the server both have --
     -    one the server advertised, or that push negotiation found in common.
     -    Such a commit already marks the edge of what we need to send, so
     -    there's no reason to keep walking down to a graft below it.  For
     -    deeper clones the server usually has a commit close by, which keeps
     -    this walk short; we only reach a graft when we and the server share no
     -    history that we know about.
     -
     -    One very rare (and non-default) workflow genuinely needs the larger
     -    push: seeding a receiver willing to adopt new shallow roots
     -    (receive.shallowUpdate; see 5dbd76760181 (receive/send-pack: support
     -    pushing from a shallow clone, 2013-12-05) and 0a1bc12b6e40
     -    (receive-pack: allow pushes that update .git/shallow, 2013-12-05)).
     -    When the server sets receive.shallowUpdate, it is willing to accept
     -    pushes despite lacking ancestors of the pushed commits.  But it expects
     -    us to send all tree objects so it can graft a new shallow root.  For
     -    that case, add a sender-side config, push.shallowExcludeBoundary,
     -    defaulting to true (the optimization), while allowing users to set it to
     -    false to restore the previous behavior needed for that rare case.
     -
     -    Update the existing shallow-seeding tests in t5538 to set
     -    push.shallowExcludeBoundary=false, since they exercise that
     -    receive.shallowUpdate path.  Add tests for the optimized default and the
     -    opt-out, that a rejected ref does not cause an accepted ref to be
     -    over-excluded, and that a shallowUpdate receiver still rejects a
     -    rootless snapshot by default.
     +    Also accept "abort" to make no assumption, and "false" to retain the
     +    historical behavior required when seeding a receive.shallowUpdate
     +    receiver.  Keep false as the default for now, so introducing the
     +    mechanism does not change existing pushes.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ Documentation/config/push.adoc: This will result in only b (a and c are cleared)
       	in common.
       
      +`push.shallowExcludeBoundary`::
     -+	When pushing from a shallow repository (see linkgit:git-clone[1]
     -+	`--depth`), Git normally assumes that the receiving end already
     -+	has the pushing repository's shallow grafts, and omits those
     -+	objects from the generated pack rather than resending the full
     -+	toplevel tree of those grafts. This is safe because the
     -+	receiving end rejects a push that references objects it does not
     -+	have. Set this to `false` to send those objects anyway; this is
     -+	only needed for the highly unusual case of using a push to seed
     -+	a receiver that adopts new shallow roots (i.e. a receiver that
     -+	has explicitly set `receive.shallowUpdate`). Default is `true`.
     ++	When pushing from a shallow repository, Git can omit the shallow
     ++	grafts' objects from the generated pack rather than resending the
     ++	full toplevel tree of those grafts.  This assumes the receiver
     ++	already has those objects.  If it does not, the receiver rejects
     ++	the push rather than accepting incomplete history. This setting
     ++	controls that behavior and accepts three values:
     +++
     ++--
     ++`abort`;;
     ++	If the push reaches such a boundary, refuse it rather than
     ++	choosing whether to send or omit it.
     ++`true`;;
     ++	Omit the boundary objects (fast). If the receiver does not have
     ++	them, the push is rejected.
     ++`false`;;
     ++	(the default) Send the boundary objects, retaining the historical
     ++	behavior.  This can send the boundary's entire tree, which may be
     ++	very large.  This is only needed when pushing to a receiver that
     ++	accepts new shallow roots (i.e. one with `receive.shallowUpdate`
     ++	enabled), which is very rare.
     ++--
      +
       `push.useBitmaps`::
       	If set to `false`, disable use of bitmaps for `git push` even if
     @@ send-pack.c: static void append_negative_object(struct repository *r,
       	oid_array_append(haves, oid);
       }
       
     -+static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args);
     ++static int check_to_send_update(const struct ref *ref,
     ++				const struct send_pack_args *args);
     ++
     ++enum exclude_boundary_mode {
     ++	EXCLUDE_BOUNDARY_NONE = 0,
     ++	EXCLUDE_BOUNDARY_YES,
     ++	EXCLUDE_BOUNDARY_ABORT
     ++};
     ++
     ++static enum exclude_boundary_mode get_exclude_boundary_mode(struct repository *r)
     ++{
     ++	const char *value;
     ++
     ++	if (repo_config_get_string_tmp(r, "push.shallowexcludeboundary", &value))
     ++		return EXCLUDE_BOUNDARY_NONE;
     ++
     ++	switch (git_parse_maybe_bool(value)) {
     ++	case 1:
     ++		return EXCLUDE_BOUNDARY_YES;
     ++	case 0:
     ++		return EXCLUDE_BOUNDARY_NONE;
     ++	default:
     ++		if (!strcasecmp(value, "abort"))
     ++			return EXCLUDE_BOUNDARY_ABORT;
     ++		die(_("bad push.shallowExcludeBoundary value: %s"), value);
     ++	}
     ++}
      +
      +/*
     -+ * Add the shallow grafts (nr_parent == -1), which are reachable from the
     -+ * refs being pushed, to the pack boundary ("haves") as uninteresting
     -+ * (negative) tips so the generated pack leaves out everything beneath them.
     -+ *
     -+ * Walk only from the pushed tips, and only until a graft: using a graft
     -+ * that does not bound the pushed history could exclude an object we are
     -+ * genuinely sending (if it is also reachable from that unrelated graft).
     -+ * Stop early at any commit the peer already has, since it is a negative
     -+ * the peer can use and the graft beneath it would be redundant.
     ++ * Append shallow grafts bounding contributing refs. Grafts from unrelated
     ++ * history could exclude objects this push needs, while commits both sides
     ++ * have make any graft below them irrelevant.
      + */
     -+static void append_reachable_shallow_grafts(struct repository *r,
     ++static int append_reachable_shallow_grafts(struct repository *r,
      +					    const struct ref *refs,
      +					    const struct oid_array *advertised,
      +					    const struct oid_array *negotiated,
     @@ send-pack.c: static void append_negative_object(struct repository *r,
      +	struct oidset seen = OIDSET_INIT;
      +	struct oidset known = OIDSET_INIT;
      +	const struct ref *ref;
     ++	int found = 0;
      +	size_t i;
      +
      +	for (i = 0; i < advertised->nr; i++)
     @@ send-pack.c: static void append_negative_object(struct repository *r,
      +	for (i = 0; i < negotiated->nr; i++)
      +		oidset_insert(&known, &negotiated->oid[i]);
      +
     -+	/*
     -+	 * Record every commit the peer is known to have as a boundary for
     -+	 * the walk, and seed the walk from the tips we are actually sending.
     -+	 * The walk below does not begin until "known" is fully populated.
     -+	 */
     ++	/* Populate "known" fully before starting the walk. */
      +	for (ref = refs; ref; ref = ref->next) {
      +		struct commit *commit;
      +
     @@ send-pack.c: static void append_negative_object(struct repository *r,
      +		if (oidset_insert(&seen, oid))
      +			continue;
      +
     -+		/*
     -+		 * A commit the peer already has bounds the pushed history
     -+		 * with a negative it can use, so stop here rather than
     -+		 * descend to a graft that would only be redundant.
     -+		 */
      +		if (oidset_contains(&known, oid) &&
      +		    odb_has_object(r->objects, oid, 0))
      +			continue;
     @@ send-pack.c: static void append_negative_object(struct repository *r,
      +		graft = lookup_commit_graft(r, oid);
      +		if (graft && graft->nr_parent == -1) {
      +			append_negative_object(r, haves, oid);
     ++			found++;
      +			continue;
      +		}
      +
     @@ send-pack.c: static void append_negative_object(struct repository *r,
      +
      +	oidset_clear(&seen);
      +	oidset_clear(&known);
     ++	return found;
      +}
      +
       /*
     @@ send-pack.c: static int pack_objects(struct repository *r,
       	for (size_t i = 0; i < negotiated->nr; i++)
       		append_negative_object(r, &opts.haves, &negotiated->oid[i]);
       
     -+	/*
     -+	 * When pushing from a shallow repository, avoid re-pushing the
     -+	 * entire toplevel tree.
     -+	 */
     -+	if (is_repository_shallow(r)) {
     -+		int exclude_boundary = 1;
     -+		repo_config_get_bool(r, "push.shallowexcludeboundary",
     -+				     &exclude_boundary);
     -+		if (exclude_boundary)
     -+			append_reachable_shallow_grafts(r, refs, advertised,
     -+							negotiated, args,
     -+							&opts.haves);
     -+	}
     ++	/* Exclude reachable shallow boundaries from the pack. */
     ++	if (is_repository_shallow(r) &&
     ++	    get_exclude_boundary_mode(r) == EXCLUDE_BOUNDARY_YES)
     ++		append_reachable_shallow_grafts(r, refs, advertised,
     ++						negotiated, args,
     ++						&opts.haves);
      +
       	while (refs) {
       		if (!is_null_oid(&refs->old_oid))
       			append_negative_object(r, &opts.haves, &refs->old_oid);
     +@@ send-pack.c: int send_pack(struct repository *r,
     + 			ref->status = REF_STATUS_EXPECTING_REPORT;
     + 	}
     + 
     ++	/* Honor ABORT before sending any ref-update commands. */
     ++	if (!args->dry_run && need_pack_data && is_repository_shallow(r) &&
     ++	    get_exclude_boundary_mode(r) == EXCLUDE_BOUNDARY_ABORT) {
     ++		struct oid_array probe = OID_ARRAY_INIT;
     ++		int reachable = append_reachable_shallow_grafts(r, remote_refs,
     ++								extra_have,
     ++								&commons, args,
     ++								&probe);
     ++		oid_array_clear(&probe);
     ++		if (reachable)
     ++			die(_("refusing to push a shallow boundary commit\n"
     ++			      "Set push.shallowExcludeBoundary to true to omit it (fast),\n"
     ++			      "or false to send it (needed for receive.shallowUpdate)."));
     ++	}
     ++
     + 	if (!args->dry_run)
     + 		advertise_shallow_grafts_buf(r, &req_buf);
     + 
      
       ## t/t5538-push-shallow.sh ##
     -@@ t/t5538-push-shallow.sh: EOF
     - test_expect_success 'push from shallow clone, with grafted roots' '
     - 	(
     - 	cd shallow2 &&
     --	test_must_fail git push ../.git +main:refs/remotes/shallow2/main 2>err &&
     -+	test_must_fail git -c push.shallowExcludeBoundary=false \
     -+		push ../.git +main:refs/remotes/shallow2/main 2>err &&
     - 	test_grep "shallow2/main.*shallow update not allowed" err
     - 	) &&
     - 	test_must_fail git rev-parse shallow2/main &&
     -@@ t/t5538-push-shallow.sh: test_expect_success 'add new shallow root with receive.updateshallow on' '
     - 	test_config receive.shallowupdate true &&
     - 	(
     - 	cd shallow2 &&
     --	git push ../.git +main:refs/remotes/shallow2/main
     -+	git -c push.shallowExcludeBoundary=false \
     -+		push ../.git +main:refs/remotes/shallow2/main
     - 	) &&
     - 	git log --format=%s shallow2/main >actual &&
     - 	git fsck &&
     -@@ t/t5538-push-shallow.sh: test_expect_success 'push from shallow to shallow' '
     - 	(
     - 	cd shallow &&
     - 	git --git-dir=../shallow2/.git config receive.shallowupdate true &&
     --	git push ../shallow2/.git +main:refs/remotes/shallow/main &&
     -+	git -c push.shallowExcludeBoundary=false \
     -+		push ../shallow2/.git +main:refs/remotes/shallow/main &&
     - 	git --git-dir=../shallow2/.git config receive.shallowupdate false
     - 	) &&
     - 	(
     -@@ t/t5538-push-shallow.sh: test_expect_success 'push new commit from shallow clone has good deltas' '
     - 	test_region pack-objects path-walk config-push.txt
     +@@ t/t5538-push-shallow.sh: test_expect_success 'incomplete shallow push rejects without disconnecting' '
     + 	test_grep ! "unable to parse commit" err
       '
       
     -+test_expect_success 'shallow push only pushes what is necessary' '
     ++test_expect_success 'shallow boundary exclusion avoids sending the full tree' '
      +	git init adv-origin &&
      +	# The shallow grafts are intentionally untagged so that no
      +	# advertised ref points at them.
     @@ t/t5538-push-shallow.sh: test_expect_success 'push new commit from shallow clone
      +
      +	git -C adv-client checkout -b topic &&
      +	test_commit --no-tag -C adv-client new &&
     -+	GIT_PROGRESS_DELAY=0 git -C adv-client push --progress origin topic 2>err &&
     ++	GIT_PROGRESS_DELAY=0 git -C adv-client \
     ++		-c push.shallowExcludeBoundary=true \
     ++		push --progress origin topic 2>err &&
      +
      +	# Only the new commit, its tree, and the new blob are sent; sending
      +	# the full tree is avoided by excluding the shallow graft.
     @@ t/t5538-push-shallow.sh: test_expect_success 'push new commit from shallow clone
      +	test_grep "Enumerating objects: 7, done." err
      +'
      +
     -+# A rejected ref must not over-exclude objects that another, accepted ref
     -+# legitimately needs in the pack.  Set up a testcase using two independent
     -+# shallow roots.
     -+#
     -+#   origin: two unrelated histories; only branch A carries blob O (sh=shared)
     -+#       A:  A0---A1     (A0, A1 trees contain sh=O)
     -+#       B:  B0---B1     (no "shared" blob)
     -+#
     -+#   receiver: seeded from branch B only, under both ref names; lacks blob O
     -+#       refs/heads/B -> B1
     -+#       refs/heads/A -> B1     (makes our A push a non-fast-forward)
     -+#
     -+#   client: "clone --depth=1 --no-single-branch" gives a graft at each tip
     -+#           and a copy of blob O under A1   (x = cut parents = shallow graft)
     -+#           x        x
     -+#           |        |
     -+#          A1       B1
     -+#           |        |
     -+#          cX     topic=cY     (cY re-adds sh=O, which the receiver lacks)
     -+#
     -+#   push "A topic" (non-atomic):
     -+#     A     -> a non-fast-forward vs receiver A=B1, so its ref update is
     -+#              rejected locally and never applied.  It still takes part in
     -+#              the shared pack computation, and the buggy code also walked
     -+#              back from it to graft A1 (which owns O).
     -+#     topic -> accepted; cY grafts onto B1 and needs blob O.
     -+#
     -+#   Using the shallow graft A1 (an ancestor of A) to trim the pack, even
     -+#   though our push of A is rejected locally, would omit blob O from topic's
     -+#   pack -- yet topic needs O.  We want to ensure that when topic is pushed,
     -+#   O is sent along with it despite A being rejected.
     ++test_expect_success 'push.shallowExcludeBoundary=abort refuses when a graft is reached' '
     ++	git init adv-origin3 &&
     ++	test_commit --no-tag -C adv-origin3 a &&
     ++	test_commit --no-tag -C adv-origin3 b &&
     ++
     ++	git clone --depth=1 "file://$(pwd)/adv-origin3" adv-client3 &&
     ++
     ++	# The remote branch advances past the history we have, so its
     ++	# advertised tip cannot bound the walk; only the shallow graft could,
     ++	# which is exactly what "abort" refuses to rely on.
     ++	test_commit --no-tag -C adv-origin3 c &&
     ++
     ++	git -C adv-client3 checkout -b topic &&
     ++	test_commit --no-tag -C adv-client3 new &&
     ++
     ++	test_must_fail git -C adv-client3 \
     ++		-c push.shallowExcludeBoundary=abort push origin topic 2>err &&
     ++	test_grep "push.shallowExcludeBoundary" err &&
     ++
     ++	# The receiver must be left untouched: no ref was created.
     ++	test_must_fail git -C adv-origin3 rev-parse --verify refs/heads/topic
     ++'
     ++
     ++# A and B are unrelated shallow histories. The receiver has B1 under both
     ++# names, but lacks the "shared" blob from A1. The client adds cX atop A1 and
     ++# reintroduces "shared" on a topic atop B1. Pushing A and topic together
     ++# rejects A as a non-fast-forward, but A still participates in pack selection.
     ++# Its A1 boundary must not exclude the blob needed by topic.
      +test_expect_success 'shallow push does not over-exclude for an accepted ref via a rejected one' '
     -+	# origin
      +	git init tworoot-origin &&
      +	git -C tworoot-origin checkout -b A &&
      +	test_commit -C tworoot-origin --no-tag has-shared sh shared &&
     @@ t/t5538-push-shallow.sh: test_expect_success 'push new commit from shallow clone
      +	test_commit -C tworoot-origin --no-tag B0 &&
      +	test_commit -C tworoot-origin --no-tag B1 &&
      +
     -+	# receiver: branch B only, exposed as both B and A
      +	git init --bare tworoot-receiver.git &&
      +	git -C tworoot-origin push "file://$(pwd)/tworoot-receiver.git" \
      +		B:refs/heads/B B:refs/heads/A &&
      +
     -+	# client: a shallow graft at each branch tip
      +	git clone --depth=1 --no-single-branch \
      +		"file://$(pwd)/tworoot-origin" tworoot-client &&
      +
     -+	# branch A gets commit cX; including A in the push gives us a
     -+	# locally-rejected ref whose graft A1 the buggy code walked to.  The A
     -+	# ref update is a non-fast-forward, so it is rejected and never applied.
      +	git -C tworoot-client checkout A &&
      +	test_commit -C tworoot-client --no-tag cX &&
      +
     -+	# branch topic is what we actually send, reintroducing blob O on B1
      +	git -C tworoot-client checkout -b topic B &&
      +	test_commit -C tworoot-client --no-tag reintroduce sh shared &&
      +
     -+	# push both in one command: they share a single pack computation, so a
     -+	# graft reached from the rejected A can strip objects that topic needs.
     -+	# The A ref update is rejected locally (non-fast-forward); the shared
     -+	# pack must still contain blob O for topic to land on the receiver.
     -+	test_must_fail git -C tworoot-client push \
     ++	test_must_fail git -C tworoot-client \
     ++		-c push.shallowExcludeBoundary=true push \
      +		"file://$(pwd)/tworoot-receiver.git" A topic &&
      +	git --git-dir=tworoot-receiver.git rev-parse --verify topic
      +'
      +
     -+# push.shallowExcludeBoundary (default true) omits the shallow boundary
     -+# snapshot from the pack, since an ordinary receiver already has it.  The
     -+# exception is a receiver willing to adopt a *new* shallow root
     -+# (receive.shallowUpdate): it genuinely needs that snapshot, so the default
     -+# optimization leaves it unable to graft the new root.  Verify the receiver
     -+# rejects such a push (rather than corrupting itself), and that setting the
     -+# config to false restores the full snapshot and lets the push succeed.  This
     -+# is the tradeoff that motivates the config knob.
     -+test_expect_success 'default push to a shallowUpdate receiver rejects a rootless snapshot' '
     ++# A receive.shallowUpdate receiver needs the boundary snapshot to adopt a new
     ++# shallow root, so omission must reject rather than create a broken ref.
     ++test_expect_success 'push to a shallowUpdate receiver rejects a rootless snapshot' '
      +	git init seed-origin &&
      +	test_commit -C seed-origin s1 &&
      +	test_commit -C seed-origin s2 &&
     @@ t/t5538-push-shallow.sh: test_expect_success 'push new commit from shallow clone
      +	git init --bare seed-receiver.git &&
      +	git --git-dir=seed-receiver.git config receive.shallowUpdate true &&
      +
     -+	# Default (optimization on): the s2 boundary snapshot is withheld, so
     -+	# the receiver cannot graft the new root and rejects the push, leaving
     -+	# the ref uncreated.
     -+	test_must_fail git -C seed-client push \
     ++	# Optimization on: the s2 boundary snapshot is withheld, so the
     ++	# receiver cannot graft the new root and rejects the push, leaving the
     ++	# ref uncreated.
     ++	test_must_fail git -C seed-client \
     ++		-c push.shallowExcludeBoundary=true push \
      +		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded 2>err &&
      +	test_grep "remote rejected" err &&
      +	test_must_fail git --git-dir=seed-receiver.git rev-parse --verify seeded &&
 -:  ---------- > 5:  afa44c6d22 send-pack: default to excluding shallow boundaries
 -:  ---------- > 6:  ae821ce078 send-pack: advise splitting incomplete shallow pushes

-- 
gitgitgadget
