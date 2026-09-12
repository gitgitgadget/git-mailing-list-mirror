Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492092E8B64
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228860; cv=none; b=hvSf3+MYn41k4LMXdIPlq4ywvvjWMV4gMmY2j0f758kFqr7A3ocjytzsdOhM4JlmMrpkUOBaX3u8Qbnzn4O3zcV1mWZgxXpjs3VBf5kru29E+VsCBAWG6rjDaXRwzghuo8cXxzPUDM2hdshUvuG7tQkeslWVAS4s0qRo6w66Mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228860; c=relaxed/simple;
	bh=NlEXYi9ImrsxwIg7Z9WfPlX1uX0ynr5XKSaAKDpQIJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA0oBh9EZObvbi5N/yrCkzCaPdeV7U4sFqgmkbmB2KBjNbd6oGVzCGwgRtz9oXWxk/sPuY+7Z+/mQSntnS+uP5HZY/f7wb1WypvihXt/HmvcBxwOHhBLVY7vFzk0N96vu3yxdAR0HJVJNhqvQRAUECYr7cA4qQEaJGijtax4tjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=bkUKH/pD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mauD+mpH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="bkUKH/pD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mauD+mpH"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CC0614000B8;
	Sat, 12 Sep 2026 12:00:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 12 Sep 2026 12:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789228857; x=
	1789315257; bh=ZCoS6x+dn5n6AFEqlNn87Ypv16iZfnIpKUy2JHCAOGk=; b=b
	kUKH/pD/kzJJRorXBztByz7l2046ECwM0scDG0hVSNlMbZErl9zGhaiOZqiCgRGn
	GHZ6mD9JNgM0KayTxZzsiAQLNIGHiRGPfFB5XAek4vczQbwx7eZZXXpVRxvSKPb3
	4Js8CTHJRyFZz+vPkf0zVfGO3kCdQlzbeiZw72cYtCviQxHq/0MyTPWkhjyeUZ92
	/3D6pXJTKg8l6xwjXxjMuCnYySCdnvJRsqlvRZB/xVUt/CwQgtUEuGfLNeu0JEYV
	067DcxS5PhcCWRTsAEOhOgge8TO9WXepgzKsZPrOi2pKVIAFpQ6fsY6ciN/xH0TP
	LDymidwUQTB2YHA+DYuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789228857; x=1789315257; bh=Z
	CoS6x+dn5n6AFEqlNn87Ypv16iZfnIpKUy2JHCAOGk=; b=mauD+mpHfvfIPx0xf
	njcfroCz1/4gMgES28ItO59SOgNnXRPviw+5u2I+NdU4iSxH5FITCRNSF7193aoF
	FmQRIZd5KAwwKhStJAWpooV6WVyer0RLGkv1K9QcdkMdp7aZl7MdbC0Naufg+U6R
	qZSKnzXkl4eAdYlJJ5DjCZtTZ0NasQLgGlqTzWVx/Hh90NfjRQGfA2KMYRY64oz+
	6aokdFv7g71oXK4J/fZv/hX5JUVNqNdv/W58ECppdfQSsm79AX2EkNSZkOFttGIB
	Lf/gavuGe6tf9ij2mFVHJyNsXFRrglewyNH5Li9TMdhbC9+Gn3coaVR0PU1eSafM
	2wFvA==
X-ME-Sender: <xms:OHelahobnqlhnlnXESzVdzypKbX_-eBad-8Yd7t83OCR9vmmaPyYJg>
    <xme:OHelaqqm0S8Ujxlkh8UzBss5bZeqhUmPTSHthzJKuYkwSwIwoPQAgtCCW8KJAfl1b
    Q0teeVb-aEr9mU3Sr3SEAdXTAjaaaBmXFcL5P-W6dDOgj18IvitFJfW>
X-ME-Received: <xmr:OHelajPAojb4BdMoOVbFDaClZj0hl9JmUL5YGtqHn2z9QBEyecdiXq38Swdpp0uVlut7obeJn2brFteVNZByDuDnecqiXeH705GDuedYnxxVEQ>
X-ME-Proxy-Cause: dmFkZTEJzP3TrDj/EJZpEAQrG75aOaV9GM771ArQfABipHARsdFm0SHFh4/m+QKViygr2S
    2TjZ+j5UrVPSzOUMlDBf/nTGDzW6hkJ7V0NG9N5F1zk0/ktg+PZ61GmwJEyiUyrRcg0sr9
    fnxvk8Wu27LW35DrCgblsNn23raH4HZeP34IVmCoi2356wpSg0wYNq8tJoKbClnQeHq6Wu
    8TsU2OM0eNQLEYAa3cri9W8/RGzIS8RAhXrD51i7z97WE1Vv+RjFcUG2GUwGCu2ZYN3Tbj
    J5+pBAiRO8JX3pi7aHyHlbVy8zaNrdmBA2ezMGKVuxKf1mZIpXfKstvXYNtCSd5vVG2nE+
    YXDoSjXAW2LHy0IXHpo9JsKgYfWM8GMN6C6pc52EHZ8cHCyHDZZDH+MFisnQq7oNkrKWyO
    FeB+ZDKdexNRcc2a0Zts4Pf5ofGmO6FAmFlAdcRd5HsVeKQ9lYQI9m5Q0ro6237U2KmMWR
    VN6+Yiab57hq4hn0ChStW0fOCqdP6DsNV/ZPCkJU8J/SuwYstUYPCUTnN/88FN4G2+RxBd
    Ii4LRUTCQY1reNc7rVSxx5cf1zbu87yH6vDs/4KR7Ogl31Ju0AVBWMb1e4Vp2kkHN+D6XY
    C1lgRVV8sjp7U5YDriDPVmExFYx86yijj2qBIQTFa4K+NVKaVXqQ3VcfKJwQ
X-ME-Proxy: <xmx:OHelary1Hb6vk264IrXMoqMKf6huOtJgD6fXvLDViQKUF-8ThUSPKQ>
    <xmx:OXelast-fuKp0DNA7wkEvZKTRKcIH6w-CCyKt2T5d1CQKsMsapZ_Tw>
    <xmx:OXelak6sgFFQS2ujymsZPrT254M5P21UeCada5IwEK8WxRPnYYKREg>
    <xmx:OXelarSEalKCfHTKbboef0vDADR8Z3kaSdpoS3Pz1ZcI5mOxXZ6H0A>
    <xmx:OXelah1KGwqojjQZUhYSVjZyLjPHa0pCiEORjqnep-irdHc2EY-gND-H>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 12:00:55 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v3 0/2] history: support signing rewritten commits
Date: Sun, 13 Sep 2026 01:00:43 +0900
Message-ID: <20260912160045.36064-1-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The history commands create commits directly and via the replay
machinery, but currently have no way to honor `commit.gpgSign` or an
explicit signing request. This means users who require signed commits
lose that property when rewriting history.

Teach the replay API to accept a signing key, then expose the standard
`-S`/`--gpg-sign[=<key-id>]` and `--no-gpg-sign` interface across the
`git history drop`, `git history fixup`, `git history reword`, and `git
history split` subcommands. The selected policy applies to every new
commit, including both halves of a split and replayed descendants.

The implementation follows the precedence used by rebase, cherry-pick,
and revert: `commit.gpgSign` supplies the default, command-line options
override it, and the last command-line option wins.

The signature records the attestation of the current committer to the
rewritten commit while retaining the original author identity; it does
not claim authorship of commits written by somebody else.

Changes since v2:

 - Shorten the commit messages based on review feedback
 - Rename the history implementation commit from `builtin/history` to
   `history`
 - Fix the continuation-backslash formatting in `OPT_HISTORY_GPG_SIGN`

Souma (2):
  replay: allow callers to sign commits
  history: sign rewritten commits

 Documentation/git-history.adoc | 16 +++++--
 builtin/history.c              | 84 ++++++++++++++++++++++++++--------
 replay.c                       | 13 ++++--
 replay.h                       |  6 +++
 t/t3451-history-reword.sh      | 63 +++++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++++
 8 files changed, 286 insertions(+), 29 deletions(-)

Range-diff against v2:
1:  3f4dc0b982 ! 1:  ca35b0acaa replay: allow callers to sign commits
    @@ Metadata
      ## Commit message ##
         replay: allow callers to sign commits

    -    The replay machinery creates commits directly through
    -    `commit_tree_extended()`, but callers cannot currently request
    -    signatures. Commands that replay rewritten history consequently cannot
    -    carry their signing policy through to descendant commits.
    -
    -    Add `sign_commit` to `replay_revisions_options` and thread it through
    -    commit creation. `NULL` preserves the existing unsigned behavior, an
    -    empty string selects the default signing key, and a non-empty string
    -    selects an explicit key. Existing callers zero-initialize the options
    -    structure, so their behavior is unchanged.
    +    Add a signing-key option to replay_revisions_options and pass it to
    +    commit_tree_extended() when creating replayed commits.

         Signed-off-by: Souma <git@5ouma.me>

    @@ replay.c: static struct commit *pick_regular_commit(struct repository *repo,
     +					  enum replay_empty_commit_action empty,
     +					  const char *sign_commit)
      {
    - 	struct commit *base, *replayed_base;
      	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
    +
     @@ replay.c: static struct commit *pick_regular_commit(struct repository *repo,
      		}
      	}

     -	return create_commit(repo, result->tree, pickme, replayed_base, mode);
     +	return create_commit(repo, result->tree, pickme, replayed_base, mode,
    -+			     sign_commit);
    ++					    sign_commit);
      }

      void replay_result_release(struct replay_result *result)
     @@ replay.c: int replay_revisions(struct rev_info *revs,

    - 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
    - 						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
    --						  &merge_opt, &result, mode, opts->empty);
    -+						  &merge_opt, &result, mode, opts->empty,
    -+						  opts->sign_commit);
    - 		if (!last_commit)
    - 			break;
    + 			last_commit = pick_regular_commit(revs->repo, commit, base,
    + 							  &merge_opt, &result,
    +-							  mode, opts->empty);
    ++							  mode, opts->empty,
    ++							  opts->sign_commit);
    + 		}

    + 		if (!last_commit)

      ## replay.h ##
     @@ replay.h: struct replay_revisions_options {
2:  0e63c0b66a ! 2:  f0a1a88411 builtin/history: sign rewritten commits
    @@ Metadata
     Author: Souma <git@5ouma.me>

      ## Commit message ##
    -    builtin/history: sign rewritten commits
    +    history: sign rewritten commits

    -    The history commands create replacement commits directly instead of
    -    using the sequencer or the commit porcelain. As a result, rewritten
    -    commits ignore `commit.gpgSign` and cannot be signed on demand.
    +    Add --gpg-sign/--no-gpg-sign support to git history and honor
    +    commit.gpgSign when creating replacement commits. Thread the selected
    +    signing key through direct rewrites and replayed descendants while
    +    preserving the original author identity.

    -    Read the signing configuration before parsing options so that it
    -    establishes the default and later `-S`/`--gpg-sign` or `--no-gpg-sign`
    -    options override it. Pass the selected key through direct rewrites and
    -    the replay machinery.
    -
    -    Sign every newly created commit, including both halves of a split and
    -    replayed descendants. Dropping the tip creates no replacement commit,
    -    so there is nothing to sign. As with `rebase --gpg-sign`, the signature
    -    records the attestation of the current committer to the rewritten
    -    commit while retaining the original author identity; it does not claim
    -    authorship of commits written by somebody else.
    -
    -    Document the behavior and add GPG-gated coverage for configuration,
    -    command-line overrides, last-option-wins precedence, replayed
    -    descendants, split commits, an explicit signing key, and the
    -    no-new-commit drop case.
    +    Cover configuration, command-line precedence, explicit keys, split commits,
    +    and replayed descendants with GPG-gated tests.

         Signed-off-by: Souma <git@5ouma.me>

    @@ builtin/history.c: enum commit_tree_flags {
     +	return git_default_config(var, value, ctx, NULL);
     +}
     +
    -+#define OPT_HISTORY_GPG_SIGN(v) {                 \
    -+	.type = OPTION_STRING,                    \
    -+	.short_name = 'S',                        \
    -+	.long_name = "gpg-sign",                  \
    -+	.value = (v),                             \
    -+	.argh = N_("key-id"),                     \
    ++#define OPT_HISTORY_GPG_SIGN(v) { \
    ++	.type = OPTION_STRING, \
    ++	.short_name = 'S', \
    ++	.long_name = "gpg-sign", \
    ++	.value = (v), \
    ++	.argh = N_("key-id"), \
     +	.help = N_("GPG-sign rewritten commits"), \
    -+	.flags = PARSE_OPT_OPTARG,                \
    -+	.defval = (intptr_t)"",                   \
    ++	.flags = PARSE_OPT_OPTARG, \
    ++	.defval = (intptr_t)"", \
     +}
     +
      static int commit_tree_ext(struct repository *repo,
--
2.55.0

