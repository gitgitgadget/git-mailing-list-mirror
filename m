Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A834517BA7
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906501; cv=none; b=fhQo3FoYsWkkABDfMWzTCU8C/79l53mmV70W/iXJgGgaFpIbeso3ddYauYeahJJLHbjqr4pUZ3uBDLGYJd+6YKN10c0OmdCMJ+ERkE5bmtPKKPi7pQPFqHWo6Fx/IpWnliwATG6IWZeMBRh9Rr7edUy1X9dGn6kUnsNYZSJ5UUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906501; c=relaxed/simple;
	bh=ouw6xL6yotQRKIYs6fh01TpGJrXmEU4sP60OkQ+WZWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0jp2PnnQKXzlJqGpH8nXvF0fBdZPHiNj51krgCyGhEPYe+7nBr82W17fUxgSRlmy9EEZ7DsCzixGeqwLwzl5VUQcSEJmW4XN9WKDj3q+gtg8vO0Joa3T8clbkc/TcB4WHxZgwzGQ6STIwBdGb39MnoH5ip3scvl16j77ePms5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2I7dzmb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2I7dzmb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48af27fe287so2736735f8f.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791906497; x=1792511297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g0vE/00NApRwNOZq26JmbnSwevAz2yhfw4BnjsPNiiM=;
        b=R2I7dzmbnbYgyVi99hVcnxMkl4Tnc5TRvq8VlcPDQ0feh3EW9Q4vvyGudn2vwYBhZG
         alRJjT9mW4ItHHYS8tZCIIM8wzEnccM6/kJfB8J/MKxwzFz7luUKH72unxixEIWuq7Fw
         dqIeryk2zpZeRCRxX2MgRfHh2jYikIibY65ZjeBHxszTtNYtx/B90PzHgh38u93zd/dm
         F61GaDeQBU/c/8df0e1Moql1SczBxy3Jkne2+O7Q9Ms8e8xc7p4FBbFTxfpZWafxirK6
         3DCgA3aOfC/Ge59Vh9hGGlaCPJRAud6h44ESbwfh6K9C9g62h92SFZYZ+lDcj/TeIQs2
         G0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791906497; x=1792511297;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0vE/00NApRwNOZq26JmbnSwevAz2yhfw4BnjsPNiiM=;
        b=P/70CBG9jV+ApsU20dtLBdugM/T7/+6BuHKpFUZXHbJ8VeJqeArRUUoUXseo0XH6NT
         BDt+lp+CNOHvXy1wmK1S38DYPpK8b4bzzq892bTXOgzvv2qfT8bFRODeerGbnECUmHwm
         LXGdbNa20CXK0ZdXJvOIfvGGHMszSoLICFocuJgymiqAx4LlFE8SJ0yJSWQBCly0U7m5
         lonbtPdsC4BCPwYhy35bbXqRzz7wQLYrfgc86WHlV6OMLE29W/xoz+l9sPy4Xl+ibJG+
         vocgGanzRZ3AEOKM1XRxXKINAInkMCKijjcy/L3o7kneyArK+XXiUxakdOge9PKN5mT8
         5ViA==
X-Gm-Message-State: AFq9FYIfP2935p002Tzg50Q/hveYDS/ZKwJoiYnGSOW6W731K7N3SE4N
	Rss73xWDTznJyBkkNKpedxB4+jGye0m4Seps8cdZXtxJLPrLutapmey4dFhXBA==
X-Gm-Gg: AYBFou1rWLHOrOaHas9UibWt7Qj3ufPvNXcP+R6Zf9RfQFwWuZAQXSICZKiJBiEXixx
	k390RYJWJwmmZ4jMJFHD7AOxxTAGe//G5DbuFkWveMmcQJYfbOvl3C7fWhgCpasY3k/U/i1N6Zo
	p8G7jcPX36+0ojumAdtgrP2p2N4AR+AQWVgr3xQ8kwFVzHwWmv51OsEUG+56PLs+pY0PXCuFwN6
	4wLVDc8DblXCr0nLY1Sq4zBXQb7NDVf3m7Loa4V08k5d8dJ+DALUjMXDYWqrB6TuQkN21DR0P1F
	UgEn1XeFTG3YRruaOblMbfHw39THwtnFi2cqRpg/5s/C/uebFZlTq+LlfxLwOBs0lurQuiA5L5J
	qE+TK29vLi7lssMRMdvrmpml5M2R+7TbwcI2OyChjKMGf6RlUqVLsIID2F9uhIGN7d9dPDqT+y2
	ElnnyGOG2Z2VuZVEsm0k5Gs4HhoGkLrnE+lMSxabJ3hDtACt6Rr73bNFd/YkZBtDQfiSgJ4x3+P
	w==
X-Received: by 2002:a05:6000:160e:b0:487:27f9:842 with SMTP id ffacd0b85a97d-48dbace9d4fmr17037968f8f.55.1791906497204;
        Tue, 13 Oct 2026 08:48:17 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm5603561f8f.54.2026.10.13.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:48:16 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 0/3] checkout -m: recreate conflict labels
Date: Tue, 13 Oct 2026 16:47:52 +0100
Message-ID: <cover.1791906474.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git checkout -m <path>" recreates a merge conflict, it uses
the labels "base", "ours", "theirs", rather than the labels used by
the original merge. This short series teaches the ort machinery to
write the labels to ".git/MERGE_LABELS" when it switches to a merge
result containing conflicts, so that "git checkout -m" can then read
that file and use the same labels.

Changes since V3:

 - added patch 2 to cache merge config settings and conflict labels

Changes since V2:

 - only write ".git/MERGE_LABELS" when there are conflicts and added
   a check to an existing "checkout -m <branch>" test
 - change write_merge_labels() to take an array of labels
 - use a local variable to store the internal merge state when writing
   labels
 - use strbuf_detach() rather than xmemdupz() when reading labels
 - add a comment to say we ignore trailing cruft when reading the
   labels file

Changes since V1:

 - use strbuf_getline() rather than strbuf_read_file() to read labels
   so that the newline handling of the reading and writing sides match.

NB ".git/MERGE_LABELS" is still undocumented - I'm hoping to find time
to add some documentation for all the MERGE_* files in a future series.
Johannes suggested using an index extension to store the labels,
but as we already have MERGE_MODE, MERGE_RR and MERGE_MSG I think it
is easier just to add another file.

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fconflict-labels%2Fv4
View-Changes-At: https://github.com/phillipwood/git/compare/3bc034112...eda10c234
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/conflict-labels/v4


Junio C Hamano (1):
  checkout -m <path>: cache merge settings

Phillip Wood (2):
  remove_branch_state: convert boolean argument to flags
  merge: remember conflict labels

 branch.c           | 17 ++++++++----
 branch.h           |  4 ++-
 builtin/checkout.c | 66 ++++++++++++++++++++++++++++++++++++++--------
 builtin/commit.c   |  1 +
 merge-ort.c        | 20 ++++++++++++++
 merge.c            | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 merge.h            |  3 +++
 path.c             |  1 +
 path.h             |  1 +
 repository.c       |  1 +
 repository.h       |  1 +
 sequencer.c        |  1 +
 t/t7201-co.sh      | 22 ++++++++++++++++
 13 files changed, 187 insertions(+), 17 deletions(-)

Range-diff against v3:
1:  86ef0f848a = 1:  86ef0f848a remove_branch_state: convert boolean argument to flags
-:  ---------- > 2:  36f3808d2f checkout -m <path>: cache merge settings
2:  182edb2e88 ! 3:  eda10c2340 merge: remember conflict labels
    @@ builtin/checkout.c
      #include "lockfile.h"
      #include "mem-pool.h"
      #include "object-file.h"
    -@@ builtin/checkout.c: static int checkout_merged(int pos, const struct checkout *state,
    - 	struct cache_entry *ce = the_repository->index->cache[pos];
    - 	const char *path = ce->name;
    - 	mmfile_t ancestor, ours, theirs;
    +@@ builtin/checkout.c: static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
    + struct checkout_merged_data {
    + 	int conflict_style;
    + 	int renormalize;
     +	char *base_label, *ours_label, *theirs_label;
    - 	enum ll_merge_result merge_status;
    - 	int status;
    - 	struct object_id oid;
    -@@ builtin/checkout.c: static int checkout_merged(int pos, const struct checkout *state,
    + };
    + 
    ++static void checkout_merged_release(struct checkout_merged_data *data)
    ++{
    ++	free(data->base_label);
    ++	free(data->ours_label);
    ++	free(data->theirs_label);
    ++}
    ++
    + static void checkout_merged_prepare(struct checkout_merged_data *data)
    + {
    + 	int renormalize = 0;
      
      	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
    - 	ll_opts.renormalize = renormalize;
    -+	if (read_merge_labels(the_repository, &base_label, &ours_label,
    -+			      &theirs_label)) {
    -+		base_label = xstrdup("base");
    -+		ours_label = xstrdup("ours");
    -+		theirs_label = xstrdup("theirs");
    + 	data->renormalize = renormalize;
    ++	if (read_merge_labels(the_repository, &data->base_label, &data->ours_label,
    ++			      &data->theirs_label)) {
    ++		data->base_label = xstrdup("base");
    ++		data->ours_label = xstrdup("ours");
    ++		data->theirs_label = xstrdup("theirs");
     +	}
    - 	ll_opts.conflict_style = conflict_style;
    + }
    + 
    + static int checkout_merged(int pos, const struct checkout *state,
    +@@ builtin/checkout.c: static int checkout_merged(int pos, const struct checkout *state,
    + 
    + 	ll_opts.renormalize = data->renormalize;
    + 	ll_opts.conflict_style = data->conflict_style;
     -	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
     -				&ours, "ours", &theirs, "theirs",
    -+	merge_status = ll_merge(&result_buf, path, &ancestor, base_label,
    -+				&ours, ours_label, &theirs, theirs_label,
    ++	merge_status = ll_merge(&result_buf, path, &ancestor, data->base_label,
    ++				&ours, data->ours_label, &theirs, data->theirs_label,
      				state->istate, &ll_opts);
    -+	free(base_label);
    -+	free(ours_label);
    -+	free(theirs_label);
      	free(ancestor.ptr);
      	free(ours.ptr);
    - 	free(theirs.ptr);
    +@@ builtin/checkout.c: static int checkout_worktree(const struct checkout_opts *opts,
    + 			pos = skip_same_name(ce, pos) - 1;
    + 		}
    + 	}
    ++
    ++	if (opts->merge)
    ++		checkout_merged_release(&checkout_merged_data);
    ++
    + 	if (pc_workers > 1)
    + 		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
    + 					      NULL, NULL);
     @@ builtin/checkout.c: static void report_tracking(struct branch_info *new_branch_info)
      
      static void update_refs_for_switch(const struct checkout_opts *opts,
-- 
2.56.0.134.g299a3c16181

