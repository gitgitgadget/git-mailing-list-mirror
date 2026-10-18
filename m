Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EC39733E
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355627; cv=none; b=NwN3LZkZqKXohg30SDdP2HvyVPlRzpFfS/3PrTE6WDQ6EScg0X4NR26859OJOeRUfXGG7b9f49uAGnjHTMj4hkwOmEbDhXpcMZq2Bims175gcdTf4gZaYyNUxa33bPi2sqlIh+vnAESK3SsThBps+83YNRo8RADA3fZhP4ZoSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355627; c=relaxed/simple;
	bh=lVBlliHcK1/X/SRcrDBwyQ1LpZLL/DHB/sqFhQPzGo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N16fnSnZbu/JwO02x7NNPV/EjiAGPvwr98ofnk86IbOfeR52eMzzeToqJVC/E7U80DyrUCqmfqZ7J1RjtZuE8bLp/x4xZSz2EbI7mla3q3nKFJ38/VokwxqUwsBhzg+M8fSP+Yxpg+GunALBx9iNPO/IP+4ikreanQZmVKGKOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=DMJUwZCd; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="DMJUwZCd"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8446af403b5so705050a34.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1792355625; x=1792960425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mmeGE9yvxLA31HdDlnOWH0KP3hdTYO8wYpcSVfPzrLk=;
        b=DMJUwZCdK47eMBhnLomZnnRdLGL00Q6It5IEfGR6MEPAOjRRYlD1q0UTqIc4/KT4zM
         zjZG38LeYGwqaimHunS3kMfAb57Ah+aQQL0oCut3coPCqKAyy0lSRH5Jr322sQuUPH6a
         mVT81g98O6uXQNaVjrT+WKKrXpaLEGgxwiCUKs7lSIXyXR2ZHFkMBFqRhLUEGRnqXtvN
         piHO9lEal+3IougIa32itRhdbf8AjQ6vhMQV8sLU4BMemKfjEuPE1wqLW1KzELKj6Bzs
         rOZLa4D7Vn1Tvf1PNG5Q7AITFci/hKCadn2+6KUrsy8b6LMvyAqdp8adKUdRItQ07yyT
         MX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355625; x=1792960425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mmeGE9yvxLA31HdDlnOWH0KP3hdTYO8wYpcSVfPzrLk=;
        b=MYl7cF/Knyhq+LfMW8S9h0nelEo7W4k3RlFQBZyGEJp+C9iB4fPXF44gnF4wKx/wvS
         l+/7oKn5opRiKD4R69qs9znRWkWr7LKe/4T8kY8K/f5FSS8+JcUgqZc+j1GojvwvfTwv
         R/wZtyEcYFhTGo6zyGozQeQtuJ9CuKQMKi3hRA76QSqHfVVPzVFud9p+s1yJYS7caH2P
         lGoJGMu58EpXz/b3AmkvJt77Gd67UUBADxHFfQ53s52BWcd8SXTJocYnJNF+ugVkWfKJ
         8HCN2Lsnz3Yjj9b+ljfSoUs4N+KEjDOLR2G7wRzfyhyiVGciHoPNl7QAHXi9KfP5udV1
         3OOA==
X-Gm-Message-State: AFq9FYI5eQF2QfKZdR99yj6+aPYcBQHel9Pk1aULFddqvCqzVgIHzQR6
	qumJ5OcOdP0lgvkXy/VbaEpxzw1lH3/RnesGRa2Z/w0ruuQu01Nt3JLZghluzD2xZcqsGYRb1pn
	wTm4w
X-Gm-Gg: AYBFou1s6Jzve1CVkTUNlF9EIfwtd99ji9/UVzdUzLMvcdDP9sAmLZb3IoDhRbLbvSU
	hsRiRG/pCeaXRZ9oE6AZyNYnYqi4g2tRoGhQYDRIIRQ/uge3kKi4OOKwF3hMtQuOSvZ7yGmZHRX
	Rhzub2I1DpYg5BYrsrdxFZeDjBYhaqFwOQLYkPfNUhy3sSTzlmjFIFmyUiUHtWSXxMnMPIInaBP
	t3l3epuDBOx6dNQPKCgnxmJjs1lTlmg2g9CppCIz178UuWlToxUlXX1b/uq02WJF3DgUKU1VEZo
	dahhM3vFhCzckBfyJxsAfPzLuuinWECEQWvAfSPmpxAFV28uK//oqGMYpNiCVVMk2nfP5qV2uN8
	0U40Ybis7D8m/FH5bI1jZkBs9NCaQ9rlTFPF12z4kV7C9gMkZJZLCqh2uQDwLNsD1fQhyWS/AGU
	JaRGyUwczMOkJSZonNacxQ0rv4KV4PVFoirbYoo2W8fBaqjKyWkum47lamdBnycT/OC0vdubSW
X-Received: by 2002:a05:6830:d07:b0:806:d79a:c932 with SMTP id 46e09a7af769-84501cf7361mr5536290a34.20.1792355624826;
        Sun, 18 Oct 2026 13:33:44 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-849859184easm1049571a34.23.2026.10.18.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:33:44 -0700 (PDT)
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
Subject: [PATCH v7 2/3] push: fix --force-if-includes non-branch advice
Date: Sun, 18 Oct 2026 14:32:53 -0600
Message-ID: <20261018203255.2343005-3-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018203255.2343005-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20261018203255.2343005-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a --force-if-includes push is rejected due to lacking a reflog to
consult, the advice is misleading:

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

Add ref->unverifiable to differentiate pushing something without a
reflog to consult vs. a remote update rejection.

Ensure tests check the rejection message.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
 Documentation/config/advice.adoc |  4 ++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 17 +++++++++++++++++
 builtin/send-pack.c              |  5 +++++
 remote.c                         |  5 ++++-
 remote.h                         | 10 +++++++---
 send-pack.c                      |  1 +
 t/t5533-push-cas.sh              | 11 ++++++++---
 transport-helper.c               |  5 +++++
 transport.c                      |  8 ++++++++
 transport.h                      |  1 +
 12 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..26078bc300 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -94,6 +94,10 @@ all advice messages.
 		Shown when linkgit:git-push[1] rejects a forced update of
 		a branch when its remote-tracking ref has updates that we
 		do not have locally.
+	pushRefUnverifiable::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when we are unable to verify the remote-tracking
+		ref is integrated locally.
 	pushRepoLooksLikeRef::
 		Shown when the repository given to linkgit:git-push[1] is not
 		a configured remote but looks like a `<remote>/<branch>` ref,
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..bcabc76a4f 100644
--- a/advice.c
+++ b/advice.c
@@ -69,6 +69,7 @@ static struct {
 	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent" },
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching" },
 	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate" },
+	[ADVICE_PUSH_REF_UNVERIFIABLE]			= { "pushRefUnverifiable" },
 	[ADVICE_PUSH_REPO_LOOKS_LIKE_REF]		= { "pushRepoLooksLikeRef" },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..933b297d6b 100644
--- a/advice.h
+++ b/advice.h
@@ -36,6 +36,7 @@ enum advice_type {
 	ADVICE_PUSH_NON_FF_CURRENT,
 	ADVICE_PUSH_NON_FF_MATCHING,
 	ADVICE_PUSH_REF_NEEDS_UPDATE,
+	ADVICE_PUSH_REF_UNVERIFIABLE,
 	ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..2ea73489d1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -322,6 +322,13 @@ static const char message_advice_ref_needs_update[] =
 	   "remote changes, use 'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
+static const char message_advice_ref_unverifiable[] =
+	N_("Updates were rejected because what you are pushing is not a branch,\n"
+	   "so there is no reflog to check against the tip of the remote-tracking\n"
+	   "branch. If you want to push anyway, specify the expected value with\n"
+	   "'--force-with-lease=<ref>:<expect>' or use '--no-force-if-includes'\n"
+	   "to skip this check.");
+
 static void advise_pull_before_push(void)
 {
 	if (!advice_enabled(ADVICE_PUSH_NON_FF_CURRENT) || !advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
@@ -364,6 +371,14 @@ static void advise_ref_needs_update(void)
 	advise(_(message_advice_ref_needs_update));
 }
 
+static void advise_ref_unverifiable(void)
+{
+	if (!advice_enabled(ADVICE_PUSH_REF_UNVERIFIABLE) ||
+			!advice_enabled(ADVICE_PUSH_UPDATE_REJECTED))
+		return;
+	advise(_(message_advice_ref_unverifiable));
+}
+
 static int push_with_options(struct transport *transport, struct refspec *rs,
 			     int flags)
 {
@@ -415,6 +430,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 		advise_ref_needs_force();
 	} else if (reject_reasons & REJECT_REF_NEEDS_UPDATE) {
 		advise_ref_needs_update();
+	} else if (reject_reasons & REJECT_REF_UNVERIFIABLE) {
+		advise_ref_unverifiable();
 	}
 
 	return 1;
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d6cdbae472..efedd7dba7 100644
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
index 7cd7b0d6d4..4258d8dabd 100644
--- a/remote.c
+++ b/remote.c
@@ -1719,6 +1719,9 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			else if (ref->check_reachable && ref->unreachable)
 				reject_reason =
 					REF_STATUS_REJECT_REMOTE_UPDATED;
+			else if (ref->check_reachable && ref->unverifiable)
+				reject_reason =
+					REF_STATUS_REJECT_UNVERIFIABLE;
 			else
 				/*
 				 * If the ref isn't stale, and is reachable
@@ -2919,7 +2922,7 @@ static void check_if_includes_upstream(struct ref *remote)
 	 * then there is no reliable reflog to check
 	 */
 	if (!name || !starts_with(name, "refs/heads/")) {
-		remote->unreachable = 1;
+		remote->unverifiable = 1;
 		return;
 	}
 
diff --git a/remote.h b/remote.h
index cca02033b9..a453c5c2d2 100644
--- a/remote.h
+++ b/remote.h
@@ -171,10 +171,13 @@ struct ref {
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
@@ -205,6 +208,7 @@ struct ref {
 		REF_STATUS_REJECT_STALE,
 		REF_STATUS_REJECT_SHALLOW,
 		REF_STATUS_REJECT_REMOTE_UPDATED,
+		REF_STATUS_REJECT_UNVERIFIABLE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
diff --git a/send-pack.c b/send-pack.c
index f20460fbf4..69921f6b65 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -289,6 +289,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_REJECT_REMOTE_UPDATED:
+	case REF_STATUS_REJECT_UNVERIFIABLE:
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index febf16fa7c..957b19f826 100755
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
@@ -458,7 +459,9 @@ test_expect_success '"--force-if-includes" should reject forced update from deta
 		git reset --hard origin/main &&
 		git switch -c newbranch origin/main &&
 		git checkout HEAD^ &&
-		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main
+		test_must_fail git push --force-if-includes --force-with-lease origin HEAD:main 2>err &&
+		test_grep "remote ref unverifiable" err &&
+		test_grep "no-force-if-includes" err
 	)
 '
 
@@ -473,7 +476,9 @@ test_expect_success '"--force-if-includes" should reject forced update from tag'
 		git switch -c newbranch origin/main &&
 		git checkout HEAD^ &&
 		git tag stable &&
-		test_must_fail git push --force-if-includes --force-with-lease origin stable:main
+		test_must_fail git push --force-if-includes --force-with-lease origin stable:main 2>err &&
+		test_grep "remote ref unverifiable" err &&
+		test_grep "no-force-if-includes" err
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index d5a064d386..06765febd6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -907,6 +907,10 @@ static int push_update_ref_status(struct strbuf *buf,
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
@@ -1060,6 +1064,7 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_REJECT_REMOTE_UPDATED:
+		case REF_STATUS_REJECT_UNVERIFIABLE:
 			if (atomic) {
 				reject_atomic_push(remote_refs, mirror);
 				string_list_clear(&cas_options, 0);
diff --git a/transport.c b/transport.c
index 25e2c14a7b..cc882ed15f 100644
--- a/transport.c
+++ b/transport.c
@@ -823,6 +823,11 @@ static int print_one_push_report(struct ref *ref, const char *dest, int count,
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
@@ -937,6 +942,8 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 			*reject_reasons |= REJECT_NEEDS_FORCE;
 		} else if (ref->status == REF_STATUS_REJECT_REMOTE_UPDATED) {
 			*reject_reasons |= REJECT_REF_NEEDS_UPDATE;
+		} else if (ref->status == REF_STATUS_REJECT_UNVERIFIABLE) {
+			*reject_reasons |= REJECT_REF_UNVERIFIABLE;
 		}
 	}
 	free(head);
@@ -1394,6 +1401,7 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 	switch (r->status) {
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 	case REF_STATUS_REJECT_REMOTE_UPDATED:
+	case REF_STATUS_REJECT_UNVERIFIABLE:
 	case REF_STATUS_REJECT_STALE:
 	case REF_STATUS_UPTODATE:
 		return 0; /* skip refs which won't be pushed */
diff --git a/transport.h b/transport.h
index 39193d0077..ba51b65d93 100644
--- a/transport.h
+++ b/transport.h
@@ -258,6 +258,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 #define REJECT_FETCH_FIRST      0x08
 #define REJECT_NEEDS_FORCE      0x10
 #define REJECT_REF_NEEDS_UPDATE 0x20
+#define REJECT_REF_UNVERIFIABLE 0x40
 
 int transport_push(struct repository *repo,
 		   struct transport *connection,
-- 
2.47.3

