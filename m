Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377D388893
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081543; cv=none; b=mcSE+BjMYhrQcvY8hQl9mX96v6TxzuwqRdf6FuBdjGjEdWFAfHn5NCUMuY4qS53m7D3necja4H59keNDj8n5DfQYRRftxOmWqrahW1UWALJgufqLblTRG/NfHelupxZadvBwTwQ+H6kPnCxQ4iUt9OjYksn23kjlVvQCF67AMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081543; c=relaxed/simple;
	bh=vvP9V4Trg7iJL3Wejd1rGun4qGWmONAddNwVknV4JgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XED7Zlx/B+ZwJZwWfxk6uOV4BxgQ83tyFJD66FlYVv7MtlmdvyTGSIFqpP6b8m0B+nloAgRMDnt7YHwJicxuxK0T7n+WzCXltUnU5hKt7/g2UrmSTSt97N+TVtjZmoeyc4sovUdztqQd9MBOlJiaLdYVzouyjiWFNprs3Kxp4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=N20DZHZy; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="N20DZHZy"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f4e596e393so376250a34.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789081539; x=1789686339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfxWI831gVUK5SH/4EVYCQ9jarKR27pmQMvmqipoXxY=;
        b=N20DZHZy7AZQxUtLuy2HgiFs+zPyvuT6L7MMah7fBcy9Atekgo9Eq/8bJDPwIXjER+
         VAJdkPnIicSTOBp5jpSnizTuG8w9lbgwP72jpangvbWLPfMnf/QpYVxKstMEhprPcEUl
         YSw8R/b1s14cbVUGX84b2bMBw+vmo/aB2kPls35xIn5RFaj6GH2BwpQSzmSlfPEVCkp8
         ndyeZjdKAZ+NRHd0oDfgnqr/RDSE9vd2Nqrl/dXnyFyeA20cLqm9fqW1F+5hR8e+fpPw
         CFsGkH9XM71XYNTt8wnrhnGlgss2X9eeRul6LitINk1lJo2X3CZo0H30QoKEOmpKTVxT
         SN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789081539; x=1789686339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XfxWI831gVUK5SH/4EVYCQ9jarKR27pmQMvmqipoXxY=;
        b=WA/EgM5YoCu7qxso0a++ezabMH/Fh19kDjlAF8G7K3oBonAY2f4slcjlDop6vCEhZb
         vEsP3RQxvwinl1hbSL8k2AnS8YhG0qhdsMH7XFd6J79EEW21oBxthMPE4/ZYcFOzVdnD
         zsxtiUJY4Q2ZfXvz7cunj0fxflS+RN4j2SsgqgTqjq+Vv8V/MtQGsYlBQ0xvSbHjZsBV
         4Az487qkqNf1b3rCzYuPkOqxWbcSeMpmrXPWWwra4AO9odtT7uP7nvVo0aISh1/4+ABy
         lNViCaEE6RqGjQT+maomkYGk5Elwm7xoUFEl+P76EezYvqub2Cs8pedc1Sh1f/2kbOhj
         parw==
X-Gm-Message-State: AFuF++m771jYWSr0MG0ejbY+e+vVoGmIXUzHKcBLX9gHNrs6rzfHw6U3
	KV6a8dLZJQulV2hVjMKOaYziwvz8w7+34q2vvCIp9xN0rUUr3o1ORnqmd1OOgBdnih4RmqdxKgb
	2Z/K5N/I=
X-Gm-Gg: AYBFou3ttCIL93os72cARZlRxOXefJMLiWEefGKh8cgCoAf8XWyxYozZHIn3xUMnGMh
	bN0IBCiYsg8NnpGpoEGqSMVGCOtCpaZcC7qf8zHw7/kl78mVwud9hVU5DYq/vmAjHs+nDEBA/1T
	uphPweTtwbctTzc+obaBoYMWIMD/zmgDfaFjtrctSx1QpZ5BPz9zcqp0GIjYJFhNuPiFhgHSe1Q
	keP1gCeMbiRzAXHlyPdTCNCp+eNqpTTkYEQ4/0VskuNt4EiqJneD+APqGJa2hdRZoXeAi3kFfyl
	ZQgCF4mLhpGPV/sy0p0a2TFwyQGTuBnLCt2Ua39emRTGArgSLlvYd6lPcIXky46tzVAodUlyuFG
	/18pdUuBns/CrGt+17xIigN2/qQwTxPiAI/utxhlfz2sopMf7Io670IuPnXbKQkSG+NBNGAm6Cv
	19yZ3IFCGPQWsqi+20KoDPOjQH8hWP0fZvs4lkTyVONHBK+vgX6vJ3OpZHs0j3664hDiMlRd+b
X-Received: by 2002:a05:6830:6189:b0:7f8:4a36:5eb9 with SMTP id 46e09a7af769-803ff226bf1mr895072a34.12.1789081539533;
        Thu, 10 Sep 2026 16:05:39 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-803f59e04a0sm808215a34.8.2026.09.10.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:05:39 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v3 2/2] push: fix --force-if-includes detached HEAD advice
Date: Thu, 10 Sep 2026 17:05:06 -0600
Message-ID: <20260910230506.1631656-3-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910230506.1631656-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260910230506.1631656-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a --force-if-includes push is rejected due to a detached HEAD
state where there is no per-branch reflog to consult, the advice is
misleading:

     ! [rejected] HEAD -> main (remote ref updated since checkout)
    error: failed to push some refs to '<remote>'
    hint: Updates were rejected because the tip of the remote-tracking
    hint: branch has been updated since the last checkout. If you want
    hint: to integrate the remote changes, use 'git pull' before
    hint: pushing again. See the 'Note about fast-forwards' in 'git
    hint: push --help' for details.

But a `git pull` will not fix this rejection. What is required is either

- Specify the expected remote tip with --force-with-lease=<ref>:<expect>
- Ignore the error with --no-force-if-includes

Add ref->unverifiable to differentiate between a detached HEAD rejection
vs. a remote update rejection.

Ensure tests check the rejection message.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 Documentation/config/advice.adoc |  4 ++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 15 +++++++++++++++
 builtin/send-pack.c              |  5 +++++
 remote.c                         |  5 ++++-
 remote.h                         | 10 +++++++---
 send-pack.c                      |  1 +
 t/t5533-push-cas.sh              |  7 +++++--
 transport-helper.c               |  5 +++++
 transport.c                      |  8 ++++++++
 transport.h                      |  1 +
 12 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..a0eff8bbd6 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -90,6 +90,10 @@ all advice messages.
 		Shown when linkgit:git-push[1] rejects a forced update of
 		a branch when its remote-tracking ref has updates that we
 		do not have locally.
+	pushRefUnverifiable::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when we are unable to verify the remote-tracking
+		ref is available locally.
 	pushUnqualifiedRefname::
 		Shown when linkgit:git-push[1] gives up trying to
 		guess based on the source and destination refs what
diff --git a/advice.c b/advice.c
index 0018501b7b..08842deb66 100644
--- a/advice.c
+++ b/advice.c
@@ -69,6 +69,7 @@ static struct {
 	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent" },
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching" },
 	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate" },
+	[ADVICE_PUSH_REF_UNVERIFIABLE]			= { "pushRefUnverifiable" },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
diff --git a/advice.h b/advice.h
index 8def280688..189eadc089 100644
--- a/advice.h
+++ b/advice.h
@@ -36,6 +36,7 @@ enum advice_type {
 	ADVICE_PUSH_NON_FF_CURRENT,
 	ADVICE_PUSH_NON_FF_MATCHING,
 	ADVICE_PUSH_REF_NEEDS_UPDATE,
+	ADVICE_PUSH_REF_UNVERIFIABLE,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
diff --git a/builtin/push.c b/builtin/push.c
index 6021b71d66..9676c6241f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -319,6 +319,12 @@ static const char message_advice_ref_needs_update[] =
 	   "remote changes, use 'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_unverifiable[] =
+	N_("Updates were rejected because the tip of the remote-tracking branch\n"
+	   "cannot be checked against a detached HEAD. If you want to push anyway,\n"
+	   "specify the expected value with '--force-with-lease=<ref>:<expect>'\n"
+	   "or use '--no-force-if-includes' to skip this check.");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_enabled(ADVICE_PUSH_NON_FF_CURRENT) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
@@ -361,6 +367,13 @@ static void advise_ref_needs_update(void)
 	advise(_(message_advice_ref_needs_update));
 }
 
+static void advise_ref_unverifiable(void)
+{
+	if (!advice_enabled(ADVICE_PUSH_REF_UNVERIFIABLE) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
+		return;
+	advise(_(message_advice_ref_unverifiable));
+}
+
 static int push_with_options(struct transport *transport, struct refspec *rs,
 			     int flags)
 {
@@ -412,6 +425,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		advise_ref_needs_force();
 	} else if (reject_reasons & REJECT_REF_NEEDS_UPDATE) {
 		advise_ref_needs_update();
+	} else if (reject_reasons & REJECT_REF_UNVERIFIABLE) {
+		advise_ref_unverifiable();
 	}
 
 	return 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 1412b49bc8..07accb6e6b 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -76,6 +76,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "remote ref updated since checkout";
 			break;
 
+		case REF_STATUS_REJECT_UNVERIFIABLE:
+			res = "error";
+			msg = "remote ref unverifiable";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
diff --git a/remote.c b/remote.c
index 326af76eeb..72bfc4dbc4 100644
--- a/remote.c
+++ b/remote.c
@@ -1701,6 +1701,9 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			else if (ref->check_reachable && ref->unreachable)
 				reject_reason =
 					REF_STATUS_REJECT_REMOTE_UPDATED;
+			else if (ref->check_reachable && ref->unverifiable)
+				reject_reason =
+					REF_STATUS_REJECT_UNVERIFIABLE;
 			else
 				/*
 				 * If the ref isn't stale, and is reachable
@@ -2823,7 +2826,7 @@ static void check_if_includes_upstream(struct ref *remote)
 					       "HEAD", 0, NULL, &flag);
 		if (!name || !(flag & REF_ISSYMREF)) {
 			/* detached HEAD: no per-branch reflog to consult */
-			remote->unreachable = 1;
+			remote->unverifiable = 1;
 			return;
 		}
 	}
diff --git a/remote.h b/remote.h
index 54b17e4b02..8e2d56c2c2 100644
--- a/remote.h
+++ b/remote.h
@@ -169,10 +169,13 @@ struct ref {
 		/* Need to check if local reflog reaches the remote tip. */
 		check_reachable:1,
 		/*
-		 * Store the result of the check enabled by "check_reachable";
-		 * implies the local reflog does not reach the remote tip.
+		 * Store the result of the check enabled by "check_reachable".
+		 * "unreachable" implies the local reflog does not reach the remote
+		 * tip. "unverifiable" implies no local branch reflog to check; i.e.,
+		 * detached HEAD.
 		 */
-		unreachable:1;
+		unreachable:1,
+		unverifiable:1;
 
 	enum {
 		REF_NOT_MATCHED = 0, /* initial value */
@@ -203,6 +206,7 @@ struct ref {
 		REF_STATUS_REJECT_STALE,
 		REF_STATUS_REJECT_SHALLOW,
 		REF_STATUS_REJECT_REMOTE_UPDATED,
+		REF_STATUS_REJECT_UNVERIFIABLE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
diff --git a/send-pack.c b/send-pack.c
index 3bb5afc687..6b78470f37 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -322,6 +322,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_REJECT_REMOTE_UPDATED:
+	case REF_STATUS_REJECT_UNVERIFIABLE:
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 0c02151747..fe6af3f41c 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -311,7 +311,8 @@ test_expect_success 'background updates to remote can be mitigated with "--force
 		git switch main &&
 		test_commit J &&
 		git fetch --all &&
-		test_must_fail git push --force-with-lease --force-if-includes --all
+		test_must_fail git push --force-with-lease --force-if-includes --all 2>err &&
+		test_grep "remote ref updated since checkout" err
 	) &&
 	git ls-remote dst refs/heads/main >actual.main &&
 	git ls-remote dst refs/heads/branch >actual.branch &&
@@ -457,7 +458,9 @@ test_expect_success '"--force-if-includes" should reject forced update from deta
 		git reset --hard origin/main &&
 		git switch -c newbranch origin/main &&
 		git checkout HEAD^ &&
-		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
+		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main 2>err &&
+		test_grep "remote ref unverifiable" err &&
+		test_grep "no-force-if-includes" err
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..1763570352 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -893,6 +893,10 @@ static int push_update_ref_status(struct strbuf *buf,
 			status = REF_STATUS_REJECT_REMOTE_UPDATED;
 			FREE_AND_NULL(msg);
 		}
+		else if (!strcmp(msg, "remote ref unverifiable")) {
+			status = REF_STATUS_REJECT_UNVERIFIABLE;
+			FREE_AND_NULL(msg);
+		}
 		else if (!strcmp(msg, "forced update")) {
 			forced = 1;
 			FREE_AND_NULL(msg);
@@ -1046,6 +1050,7 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_REJECT_REMOTE_UPDATED:
+		case REF_STATUS_REJECT_UNVERIFIABLE:
 			if (atomic) {
 				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
diff --git a/transport.c b/transport.c
index 0f5ec30247..3d60d6de54 100644
--- a/transport.c
+++ b/transport.c
@@ -779,6 +779,11 @@ static int print_one_push_report(struct ref *ref, const char *dest, int count,
 				 "remote ref updated since checkout",
 				 report, porcelain, summary_width);
 		break;
+	case REF_STATUS_REJECT_UNVERIFIABLE:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				 "remote ref unverifiable",
+				 report, porcelain, summary_width);
+		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
@@ -893,6 +898,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			*reject_reasons |= REJECT_NEEDS_FORCE;
 		} else if (ref->status == REF_STATUS_REJECT_REMOTE_UPDATED) {
 			*reject_reasons |= REJECT_REF_NEEDS_UPDATE;
+		} else if (ref->status == REF_STATUS_REJECT_UNVERIFIABLE) {
+			*reject_reasons |= REJECT_REF_UNVERIFIABLE;
 		}
 	}
 	free(head);
@@ -1348,6 +1355,7 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 	switch (r->status) {
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 	case REF_STATUS_REJECT_REMOTE_UPDATED:
+	case REF_STATUS_REJECT_UNVERIFIABLE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_UPTODATE:
 		return 0; /* skip refs which won't be pushed */
diff --git a/transport.h b/transport.h
index 7e5867cffa..eaa3b616ee 100644
--- a/transport.h
+++ b/transport.h
@@ -256,6 +256,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 #define REJECT_FETCH_FIRST      0x08
 #define REJECT_NEEDS_FORCE      0x10
 #define REJECT_REF_NEEDS_UPDATE 0x20
+#define REJECT_REF_UNVERIFIABLE 0x40
 
 int transport_push(struct repository *repo,
 		   struct transport *connection,
-- 
2.47.3

