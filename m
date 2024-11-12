Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9261F7558
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406852; cv=none; b=jnFzPEui6Lfq9mnbIifApUfIXz8nKaW4WVFBnd0D6a1E4/INxC2KdRNLHWht23cUGMN0DehoH7CYGtU0my84dSPAlzA+R8ud9ZcZEzbePX4qdR9O5Z8jqwVvj2xZ4erYo+4wdOqtdxGYxqjeldoLHNej/hn5cWTkgfWlh8/Glg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406852; c=relaxed/simple;
	bh=sSxb4bLn3uh4Cdr5+XDHYCChni0RNpXeeS2dSlZOZ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwxIEFdFjTuxOeQ0alLv0f9BGTSFk1ncYT1CJ0ppBQqLeQXXoKLUf3Zb5c2hLHN7By8Sqpbno047ud50WHuED6vAVRTM72w1XiOOdRPHG9wdtmsGZ76LDIBUZ2RCD/vPwG387qQE2tKZ59eMbdtbEyZ6tfoSLb2tUWezjt7i1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eyag8QdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jk8y0Vs6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eyag8QdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jk8y0Vs6"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A3A911401D2;
	Tue, 12 Nov 2024 05:20:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 12 Nov 2024 05:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731406849;
	 x=1731493249; bh=B0Yk7vtPfnROu6oEekg40wiAT5/BiD9PGk1lp27YqQc=; b=
	eyag8QdQCdmXFhJhu+Vxm9pLKPOJTq6XvPd+nM/4wExEQsatKoLvIvJHZJiQ7ipf
	P3p1XarBHWRLJjiqu1SaCQ6TYI+1qwAZxKe18lUMVe7Y6sccjfIpCQ8SIfxPwXtt
	6uS+SFDX1YXR2NMa02QjpCZ4h7R5Dun3lJJdqi0V1E5zr3jZL7fkBWL2Y1JDir5B
	XCaIxnF5WDycfVOuTp0agT08erEPzRfGhxxL8CnSMLnDmU3TEH4Ks57//UXFw2fT
	9b29RtT9WeetUjtcBn7QibvuGImhSoNyFQO8z7DRVBmsWgX6nFgkZJjOmVRR/s0E
	v8DkSPo0nYgDPONVfPwIYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731406849; x=
	1731493249; bh=B0Yk7vtPfnROu6oEekg40wiAT5/BiD9PGk1lp27YqQc=; b=j
	k8y0Vs6ZWaT0c+2K7zkLE6ExAZvCu7Sm51ko0DOmmFpxZ/00mEKD9OB3gy2WVJON
	MbOJNu2rS+P/FJX4w9A6q93vonzaK422uYFlXeSIY3/vQxu30Gu9wzqABg4IapNa
	WcMB1Pip0Y58aCmBn50NTRflEIziy9Fs97ARLeMrmclqlRBQU88xZRC3L9UcymhT
	0o4P2aYipdaUV77DK5YVo1y+xPr9cljefEh6D3OVT7hgfFmXEkx2riV9OBaUBfxB
	DIBdqcyLbT2olz77+imfPu93b1M/yvOQwx3xYxAeUnffeESnkiP4nBDAzYzfBd8W
	lHpfSS897DKsNpspBGbpg==
X-ME-Sender: <xms:ACwzZ1l937y8XAWJznJOKzokU2Ak1ryJvcokhql5k8kYtbCmY9hbnOE>
    <xme:ACwzZw1xyDkEyDa2aq-KuO8rWNWU-haQPfvmmoChZArc73Hf7h8uwoZqBXIIa_6U_
    -Hwzfra7qtV-s6Ktw>
X-ME-Received: <xmr:ACwzZ7ooRiVin8LiPdY3ycK20pTrUV_RkgotdcB3hZKazKQGOsONefshhBv2rUZyAmGlO0LSO79y1JswxEjiFXARM13iajsyeAHQPclBww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfegle
    fhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomh
X-ME-Proxy: <xmx:ACwzZ1nf0QMN5IbY9VsPlOcf2FdH8jYr60jcmu77H9dsDArxcmhAng>
    <xmx:ACwzZz3TVX_L3fQs5P5K0ngXhqvirBg-Zqfo9Xx9jZtZx8PZU-gh_A>
    <xmx:ACwzZ0tbdnaNgFW8wTlAa33QZI9JX0YIq4TQBE_sXv-ZvHpa-4ue7w>
    <xmx:ACwzZ3XSK2xyNOwCNVtDB8VTPYgozJYT8lfmbQjRO5DTaPVus_BxaQ>
    <xmx:ASwzZz-Bs41Vzc13-ZmrZmmXpH6pEZJ1hBh8G_YRjjRvo3FXtvL6fOn6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:20:47 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com,
	phillip.wood123@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 2/3] sequencer: comment `--reference` subject line properly
Date: Tue, 12 Nov 2024 11:20:12 +0100
Message-ID: <710c5b1a3f6bf8dc112ff13f27a8b2165274488d.1731406513.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.47.0.317.g7d2562b9734
In-Reply-To: <cover.1731406513.git.code@khaugsbakk.name>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name> <cover.1731406513.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Comment the subject line used in `git cherry-pick --reference`
properly.

Follow the existing pattern and use the case described in the original
commit message[1] as the `core.commentChar` test case:

    If the user exits the editor without touching this line by mistake,
    what we prepare to become the first line of the body, i.e. "This
    reverts commit 8fa7f667 (do this and that, 2022-04-25)", ends up to
    be the title of the resulting commit.

† 1: 43966ab3156 (revert: optionally refer to commit in the "reference"
    format, 2022-05-26)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • `strbuf_commented_addf` adds a newline, unlike the previous function.
       We need to remove a newline from the final `strbuf_addstr` with `This
       reverts commits` and add a newline to each of the other
       branches (`else if` and `else`).

 sequencer.c                   |  9 +++++----
 t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1b6fd86f70b..d26299cdea2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2341,8 +2341,8 @@ static int do_pick_commit(struct repository *r,
 		next = parent;
 		next_label = msg.parent_label;
 		if (opts->commit_use_reference) {
-			strbuf_addstr(&ctx->message,
-				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
+			strbuf_commented_addf(&ctx->message, comment_line_str,
+				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
 		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
 			   /*
 			    * We don't touch pre-existing repeated reverts, because
@@ -2352,12 +2352,13 @@ static int do_pick_commit(struct repository *r,
 			   !starts_with(orig_subject, "Revert \"")) {
 			strbuf_addstr(&ctx->message, "Reapply \"");
 			strbuf_addstr(&ctx->message, orig_subject);
+			strbuf_addstr(&ctx->message, "\n");
 		} else {
 			strbuf_addstr(&ctx->message, "Revert \"");
 			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"");
+			strbuf_addstr(&ctx->message, "\"\n");
 		}
-		strbuf_addstr(&ctx->message, "\n\nThis reverts commit ");
+		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		refer_to_commit(opts, &ctx->message, commit);
 
 		if (commit->parents && commit->parents->next) {
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 411027fb58c..26d3cabb608 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -228,6 +228,18 @@ test_expect_success 'identification of reverted commit (--reference)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git revert --reference with core.commentChar' '
+	test_when_finished "git reset --hard to-ident" &&
+	git checkout --detach to-ident &&
+	git -c core.commentChar=% revert \
+		--edit --reference HEAD &&
+	git log -1 --format=%B HEAD >actual &&
+	printf "This reverts commit $(git show -s \
+ 		--pretty=reference HEAD^).\n\n" \
+		>expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'identification of reverted commit (revert.reference)' '
 	git checkout --detach to-ident &&
 	git -c revert.reference=true revert --no-edit HEAD &&
-- 
2.47.0

