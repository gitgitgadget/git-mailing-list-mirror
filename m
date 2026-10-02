Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9C44C66C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947653; cv=none; b=FvEXThkWCzw8wArvdiQDrj2MTIrd3V3gqXkf6EFmEdOPUs1BtSFVKai3Pbkf7jjlvCxrMZTUfqZRWJQqACWa4XlGV5VXdhNXmC2IZoPmO2/Kex0QVcqg2xeKXNgvzKmFmq6SVWLYDAEELlh3W71zkbUiEy6VXsjcrkkeXDBYEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947653; c=relaxed/simple;
	bh=o+KPM3xq1HmQF6+JqWERIb1wakKPLslB+FDxKe4XEx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSvXOqhh4tRpOiXnhpLpG6e0TegnIQe1pZvwQNoCjvTPgDyVbNg4GeRdcpNN5wbyTzzWhtFBfnSRvhbEQhggci2qQDJ8Q6eNQRELpy4kGEU9Jx9IQWqWKeVdsF6UM/lMUbR/sLyLbsZvhjODJQcWoOcJAot8DVu6+96bUNyOvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=JrZ24Gej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JareX0zV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="JrZ24Gej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JareX0zV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DB3BEC0102
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:27:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 09:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790947651; x=
	1791034051; bh=FRwOlxPn0E63vRp0ha3OAG/BBnPl1ALg+O9tjcNwUPU=; b=J
	rZ24GejCMZJAJ5sAhqJPP/sExDRIJuvplbZRGBpxUIXNxpXC80C54QhhKtQ587Pr
	4hLvcg6pWAkOc8Cr5XZw2FuJP71sc2lcKbfmlB+xwo5PITmOkrLK8TwGHCzB6T5I
	vJOuCS1msTxLNc+rJVxJytVb2KYlMThJ6C0QM1M0twalbnBMti2qwQZHIoKuNxjw
	bJdRc8j2zTpyZTzmy7p5RMXTClU+fR7m3brjlRQ71xO4Hg6EeJZ+rNGLQXGEagFp
	ypHrFtAiWAxhvErj3hjJfZHPjhRxVUKZM3VzEAeuun1/WSF6/TjnQQDKO8llORXj
	Tx5+MVve98Fl18tBYye9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790947651; x=1791034051; bh=F
	RwOlxPn0E63vRp0ha3OAG/BBnPl1ALg+O9tjcNwUPU=; b=JareX0zV+osfnguAy
	0GFE2bSAhdF4xY4GU67xFs1BLfVeJHKA9vJsmweoYNrkdDb6qFthUksZLM8LF6bO
	hP6lTFlRFm8NdrFNMB8+BQ7WEUiiYs+BlGSNAPSCCU2F8Oyi4yBNnjk8+cC4SN0o
	DbTmhJAjIi9nVdcqNCoz0eYIgdHYYRHZJNvfXmWB8+bNmCL93n8Z013bG1JURs5E
	NpxatEXp61EbJj8/bpBYUwdOfBRIO3W8fiXRe2kX87IWr5VCBbB9An6rkHELWXFS
	F2zWbF/CCBDPRIQTNjfrjZSVca80D7tuoPNpqn64NX0E+6Zz89uz8ljUvBhg7Ng4
	uOTHA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790947651; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KYtZ76j47NNDG1NwTue7iXGiE8kCiLdnGTgasutEF9RM/rP
	ouEoCUSz8rsvNUg43qm8fZJydlTTAZa5pktxRsJSM2Vl+7oDNTNa/S1FRwGUzV8j
	jLBnmugGXbf9NwIe29CX8FsJpP61mvosJucxMv6o/Mt3p0tRejnDs7ycQraCTED/
	uuKWLO0ynxS7paOZ3sVMlgm1pkpAs1tU+8Wz5cqAGvRMqecxjnNJNPoQlxT/oHcA
	wudHckGGf3PyD2+1lOO5x3VXRvGUDOLPiKoxY9koFEPk+WotPyFzMzJbOyUU+XPj
	m47DupcSdvNjzj4Vke3AR/urFWSfGlpbaz7IRbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rNfrI0qEswC9cvJSiclGLNba5CC/bd7OKvm/MQkacPU=:o+KPM3xq1HmQF6+JqWERIb1wakKPLslB+FDxKe4XEx0=;
X-ME-Sender: <xms:Q7G_ajb-BuSM4W0SZFwOt8ouanIWwMy5RT5B_89jeNb9NyqmHvSuXQ>
    <xme:Q7G_apaBVfDAPwxA3YHP0AG88Wjs3rpVxWOrkNl_098DJW8Pk3Gnl01X_LN4DIOlR
    vSyG_xHiy1w-y_ARzwKXWL26kErZibwkbdWjE78YLSYUg1Ov_l3HFx8>
X-ME-Received: <xmr:Q7G_aq_-Bh9IX37pBo7Qy5494XB7Jyxt58DgttqgGSpZfh5BInaar3uZaRaocQ5hEWMsuug5aKJGY_ub7wpKOb2L8MWxmIZ_-ggmmRjrDhc>
X-ME-Proxy-Cause: dmFkZTES2ku0SqNb2DiDQqCKzJ1AhFM3ETkz+plOTKaUsCTU5JJBtioiH5rjMiRv5MB5cN
    6PcKOzzuLmD+RTUxITX+OCgg6daTq10FYd6xI2/Z3ClOrDJrnlRruXq4bg/TXcRF1aR/DF
    V2u6ujFRWukqFwwrvQ9y/KFKfemxtEvlVH4m1YuQgYDLMGSAZ0GchrMxUxC/CFs8X6epYm
    aYTQwlTbw3fC41S+K/kkF3S3wlr0PhdltW7YJrHQg8s6MIAmOCMUAnGIjSpBYZ+o806A3P
    UfUODwHscW3EQOv4z14Wj+7MW0rzpYCGey91tDk5q+gkXMZqhWTz61jtuk8Gpo1SOLU3tj
    kpVm0ialPBMiIFzxfaxBu1WHMZtMu2F+hloCXz/QAe2JuSs5hq5G0ysXsHtnWXHj89PYlc
    TWoZwUroS6LY9aMAPQPSRdQ5RsCLvvUm5hGI0IzCDFFnL85ShzO2UU5qk8c7MM1X1eP1kg
    YfCgnlANI4F4EQaEjVyT4wsPgRvGbmr5MccjT98qAW/L9y1Z7mf36Q7W5BMcr/iV3n0Qh1
    ZOsk44Xy9OPNgTKYC92R5ceyOj5xe1Phwemf/t/+L8tEneiak8brT/ZhxfLtDURhEqD5qo
    9fn2f2Y60w76lAw+Le3XOMWCHlqPtG5RgrLknR3VOgGqZeEf9DWBw+uBRAfQ
X-ME-Proxy: <xmx:Q7G_aoi4P-PkQd_Y9TRIrOOIddfdbJeV7ezST2F0P6dw61fc9WMLoQ>
    <xmx:Q7G_aqf3jLxfBPdGMpwf34LPYWtov7AHQtHquTeQV2MXaA1rZ8RmdQ>
    <xmx:Q7G_avrJD117qDWj344aUZzz5ZOaalmFJhDw8i3BYB7Ny1tYo4D4fA>
    <xmx:Q7G_avCuklUw7X__JYf5KhayOk3BnSsTTcd-B16kGx3igs6zO622Yw>
    <xmx:Q7G_apl2TKof5eajHyNmvbA4Ei4nXCPzKDVwiVNxS78KCa1ZXujXFuyQ>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 09:27:29 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v4 1/2] replay: allow callers to sign commits
Date: Fri,  2 Oct 2026 22:27:17 +0900
Message-ID: <20261002132718.3830-2-git@5ouma.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a signing-key option to replay_revisions_options and pass it to
commit_tree_extended() when creating replayed commits.

This provides the replay infrastructure for history commands to sign
replayed descendants.

Signed-off-by: Souma <git@5ouma.me>
---
 replay.c | 13 ++++++++-----
 replay.h |  6 ++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/replay.c b/replay.c
index f415103023..3e8a70bce1 100644
--- a/replay.c
+++ b/replay.c
@@ -85,13 +85,13 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    enum replay_mode mode,
+				    const char *sign_commit)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
 	char *author = NULL;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
@@ -288,7 +288,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
-					  enum replay_empty_commit_action empty)
+					  enum replay_empty_commit_action empty,
+					  const char *sign_commit)
 {
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
 
@@ -361,7 +362,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	return create_commit(repo, result->tree, pickme, replayed_base, mode,
+					    sign_commit);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -481,7 +483,8 @@ int replay_revisions(struct rev_info *revs,
 
 			last_commit = pick_regular_commit(revs->repo, commit, base,
 							  &merge_opt, &result,
-							  mode, opts->empty);
+							  mode, opts->empty,
+							  opts->sign_commit);
 		}
 
 		if (!last_commit)
diff --git a/replay.h b/replay.h
index 2c71afbfde..2eb7704b74 100644
--- a/replay.h
+++ b/replay.h
@@ -57,6 +57,12 @@ struct replay_revisions_options {
 	 */
 	int contained;
 
+	/*
+	 * Key used to sign newly-created commits. An empty string requests the
+	 * default configured signing key, and NULL disables signing.
+	 */
+	const char *sign_commit;
+
 	/*
 	 * Controls what to do when a replayed commit becomes empty.
 	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
-- 
2.56.0

