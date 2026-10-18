Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ECC35FF6E
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355617; cv=none; b=Wzj5Pt0IH1Z4MsMKU80VOZ0tqN3SSe6J2Bz4+8+aKZZlNA6WR10rFidkz59F8G7ALSJiSIH5E6nBT/DSiyPWzMbQREMHiLOm2mhbzHHdwj/Fp9ery+mWN68llgcDwqXUCFMspHIpnKli0wfjGfw0uqem6JRHobR/LYPAL/Rzg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355617; c=relaxed/simple;
	bh=wYA6adl/AMFHqy1JgLt5KYWZzU0fmf6td1JlRx4dsio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3DnXLKC2Rg/y2LwHXtY3CbkeO0/dqRyw9BIKPmr11p2arKjTlvuuggCSEIrdxRn6LmpKhvigLUmn+Zq+ClVjcreqKTz+zmZ7MeqQf3Zc8dnNMB53KHyVCWaYzkyLAfsHdpReMBWdvUT73KkUnpea0rYwpsyzTwdQYkkBBMjn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=Gbve+W0W; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="Gbve+W0W"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4f55a53898cso899237b6e.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792355615; x=1792960415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjbvWXGFPLdweX77JGXXCQEtJ5DM5MKkuo5iJqLFAM0=;
        b=Gbve+W0WjP1yxUtjrZ7aXGQ9kZFSCfztyw8awd16pR8khQS6LkYaK+vzWpifH+pmw8
         y6sJOQvqrsJ7Y1gcvuSP4147Md//KHou/Hxh4fdszA1gX+dX6jzrzIWCY4qzioVnvuRk
         GKpsnJjovb0Aio0pUZUXL7/p4Qle+WfAAC3j+U2X5zX984l2Q/o7V4REP5FQj+ozQw5z
         69yifqMj97JPiDybbXNZo1/wco2VmyhsMaXJ58BNEWJtNd2BarLeIF3CV1g8hgXuVb6s
         69RQ3SdDF+ZqdQ3I/FULd4ij+h9LlCH1oG+ex6TeKBC5KAe2k3mn/rnN1sNIwJ442efv
         CFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355615; x=1792960415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjbvWXGFPLdweX77JGXXCQEtJ5DM5MKkuo5iJqLFAM0=;
        b=tfSkOjDdKfFP35N2qHBSqwK1wX62NlXPbFTME7ajF9Aiw7rhnXX0pHXcmzs9AH2+pU
         la2/Xgng9QpsBEMy1ujpaclWnZ3NvM2PJVlhBi3GZ2sUK2uAlyM/tIxt5pw+Za/fHxsc
         XGheGxltOidj0dVGhq3G2xRI30ccxtWlBcy29Gh3soZSU5Zp54SuWvFUscT4cuv669+7
         QITWoZFk67zo5N78zsK/NBVedaR00rlqwBh2jredbWykOnmDHVIoaw3mDOIZcd+aVq3u
         pt+1rz3aYsCzOCW97ue0h9UpKDFJi1ocRw1qgY1GDf7t/LIsDKnyNvfX10q0DLicDzBO
         wz6A==
X-Gm-Message-State: AFq9FYJp8reMNENs/ZfeibTzKnmaNZJ/RbN/dU26vrTfOC4w6W5LQVDx
	4G2ubpy0YMXDGokrIetp7sXTkH0nQ+fGUixz4bJYIzZHAR54kmRmbSNf8Q5Yfpjv8bYohTFktJS
	+LDUe
X-Gm-Gg: AYBFou05TGpqHqXzoGBBsuclgn+yb9OOWDNWifqxWZss6SxwM0j3kScn3m7wO8noXTx
	0SnEwqnOeIJfqxVcBpCOHCVoZzPBsAYuQ4aQv4Us6adwJVWPuFc9WHwGBAR0+TsxNFO4gY3bjeF
	EbiBXVNZPQ8Xed61gzJzpTgohNua69gqFQc8lSwFFV0gJZGQWiqRwIYRhzKm0kBepWDPsEDuNff
	Vk/ADGjxTViDfLTHrqmDbbKHTxaLlBrrxSBcICdx0Lf4GDD5j80EBxQs84qMxf7G6cHqR5Q/ydT
	ZHi6o/upJMQzdrQaLbauluBFQzJi3mgxc/QNxfh/A6IamBBvrveW4vxL4lqO4hRcyWqJ9cgfNIn
	184jxzqg0qJ3nIZTTT47v0pzp3WVYZ6lLrP+g5QzV9ECwnW1+UhvdQJWw0oo/xeCoREvnsXCHCa
	GmitJ/wzAfYeeoL3CLJd1bZ6VgKsM81k+tkk0O5HLCKVqd8A/LMigfR5UUJc70oX00+mXOxnTr
X-Received: by 2002:a05:6808:1488:b0:4cb:f21b:6f8e with SMTP id 5614622812f47-53ccfcb392dmr4754584b6e.33.1792355614582;
        Sun, 18 Oct 2026 13:33:34 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-4a73b5bdeb9sm6952995fac.4.2026.10.18.13.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:33:33 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Tyler Cipriani <tyler@tylercipriani.com>,
	Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v7 0/3] push: check pushed ref for --force-if-includes
Date: Sun, 18 Oct 2026 14:32:51 -0600
Message-ID: <20261018203255.2343005-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

--force-if-includes is meant to refuse a forced push unless the tip of
the remote-tracking ref has been integrated into the ref you're pushing.
But it checks the reflog of the local branch named after the
destination, regardless of the ref being pushed.

For example, this command consults the reflog of main instead of src:

    git push --force-with-lease --force-if-includes origin src:main

Checking the wrong ref causes two problems:

- Data loss: if the local main has integrated origin/main, then the
  check passes even when src is an unrelated or outdated branch,
  allowing a push that clobbers the remote main.
- False rejections: if src has integrated origin/main but the local
  main is behind or missing, the push is rejected with "remote ref
  updated since checkout". Stefan Haller[0] and D. Ben Knoble[1] have
  both reported this.

1/3 checks the reflog of the branch that the pushed ref resolves to.
2/3 gives pushes that cannot be checked their own rejection status and
advice.
3/3 fixes an existing bug: --force-if-includes runs its reflog check
before the fast-forward rules, so it can reject a push that needs no
force at all, e.g., when the reflog has expired. 1/3 makes this worse,
since every push of a non-branch ref now fails the reflog check.

Behavior change
---------------

Only a branch's reflog records whether the remote tip was integrated
into it, so --force-if-includes can only verify a source that resolves
to a branch. HEAD's reflog spans all branches, and was rejected as too
broad in the original review[2]. A tag's reflog, when it exists, records
where the tag pointed. Mapping an oid to "the branch that points at it"
is ambiguous, since many branches can point at the same commit.

So a forced push whose source does not resolve to a branch (a detached
HEAD, a tag, an oid) is now rejected as unverifiable. The advice
suggests naming the expected value with
--force-with-lease=<ref>:<expect>, or skipping the check with
--no-force-if-includes.

This breaks workflows that only appear to work today. For example, this
passes today if a local "hotfix" branch has integrated origin/hotfix,
even though nothing about <tag> is checked:

    git push --force-with-lease --force-if-includes origin <tag>:hotfix

Fast-forward pushes of non-branch refs are still allowed (3/3), since a
fast-forward shows the remote tip has been integrated.

I'd welcome opinions on this trade-off.

Changes since v6:

- 1/3: fix a doubled "for" and the spelling of
  check_if_includes_upstream in the log message.
- 3/3: add missing "()" to function name in log message.
- Rebase on maint at v2.56.0, resolving conflicts with a85a43c480
  (push: suggest <remote> <branch> for a slash slip, 2026-06-27). The
  advice changes in the 2/3 range-diff are context from the
  pushRepoLooksLikeRef advice added there.
- The textual conflict in t5533 with as/push-force-if-includes-no-reflog
  remains: both topics add tests after the same existing test.

Earlier changes are listed in the v6 cover letter[3].

The new tests fail on maint and pass with this series applied.

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
[2]: <https://lore.kernel.org/git/xmqqsgbdk69b.fsf@gitster.c.googlers.com/>
[3]: <https://lore.kernel.org/git/20260917224351.57171-1-tyler@tylercipriani.com/>

Tyler Cipriani (3):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes non-branch advice
  push: --force-if-includes should allow fast-forward

 Documentation/config/advice.adoc |   4 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/push.c                   |  17 +++++
 builtin/send-pack.c              |   5 ++
 remote.c                         |  43 ++++++++++--
 remote.h                         |  10 ++-
 send-pack.c                      |   1 +
 t/t5533-push-cas.sh              | 115 ++++++++++++++++++++++++++++++-
 transport-helper.c               |   5 ++
 transport.c                      |   8 +++
 transport.h                      |   1 +
 12 files changed, 203 insertions(+), 8 deletions(-)

Range-diff against v6:
1:  e7912c3fd0 ! 1:  959490bb0a push: check pushed ref for --force-if-includes
    @@ Commit message
         The early return when peer_ref is missing in check_if_includes_upstream
         is necessary because apply_push_cas walks every advertised ref whenever
         use_tracking_for_rest is set (i.e., a bare --force-with-lease), so
    -    check_if_includes upstream is called for for refs that are not part of
    -    the push.
    +    check_if_includes upstream is called for refs that are not part of the
    +    push.
     
         Remove unnecessary check for empty return from get_local_ref, since it
         never returns NULL for a non-empty name.
2:  f85041efa8 ! 2:  92ef5412e1 push: fix --force-if-includes non-branch advice
    @@ Documentation/config/advice.adoc: all advice messages.
     +		Shown when linkgit:git-push[1] rejects a forced update of
     +		a branch when we are unable to verify the remote-tracking
     +		ref is integrated locally.
    - 	pushUnqualifiedRefname::
    - 		Shown when linkgit:git-push[1] gives up trying to
    - 		guess based on the source and destination refs what
    + 	pushRepoLooksLikeRef::
    + 		Shown when the repository given to linkgit:git-push[1] is not
    + 		a configured remote but looks like a `<remote>/<branch>` ref,
     
      ## advice.c ##
     @@ advice.c: static struct {
    @@ advice.c: static struct {
      	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching" },
      	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate" },
     +	[ADVICE_PUSH_REF_UNVERIFIABLE]			= { "pushRefUnverifiable" },
    + 	[ADVICE_PUSH_REPO_LOOKS_LIKE_REF]		= { "pushRepoLooksLikeRef" },
      	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
      	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
    - 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
     
      ## advice.h ##
     @@ advice.h: enum advice_type {
    @@ advice.h: enum advice_type {
      	ADVICE_PUSH_NON_FF_MATCHING,
      	ADVICE_PUSH_REF_NEEDS_UPDATE,
     +	ADVICE_PUSH_REF_UNVERIFIABLE,
    + 	ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
      	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
      	ADVICE_PUSH_UPDATE_REJECTED,
    - 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
     
      ## builtin/push.c ##
     @@ builtin/push.c: static const char message_advice_ref_needs_update[] =
3:  f9d97b0644 ! 3:  f97092092d push: --force-if-includes should allow fast-forward
    @@ Metadata
      ## Commit message ##
         push: --force-if-includes should allow fast-forward
     
    -    In set_ref_status_for_push, we apply --force-if-includes's reflog
    +    In set_ref_status_for_push(), we apply --force-if-includes's reflog
         reachability checks before fast-forward rules. As a result, valid
         fast-forward pushes may be rejected when a force push is unneeded; like
         when the reflog is expired:
-- 
2.47.3

