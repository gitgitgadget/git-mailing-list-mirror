Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE688372ECF
	for <git@vger.kernel.org>; Sun, 10 May 2026 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452910; cv=none; b=KmeUarI+4kTmvK9qU71/dyEINHZ9ZZtEEz5rh8y8uT3wrzB0lwzZ7m6MD9sh2eQGDhRhkdGPu/fJ1rcNLGaUjIRCwcqXw1RZnr8IIIS7CjlFQrUrDOvB+i6/S2SjDO9/VFsz6SISt1MK9/0oDe9BPSLoaYdumg/hHNg4qv9McJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452910; c=relaxed/simple;
	bh=5J75ltsNebruXavN5l+hBG/D81yeGxAxPlw7+cw9TcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyXv8oQW6PQU1zndLp4Sg2zgAsKCW0ye6wdHt2SF/x+X16wcmYszZLUgP3iwtyhfjGU1bsKpxaX0OT/vfSNWvsV4fFf57GVNQRIzey3EHOxh2hFW47xjkNUW9lLtkuyFn88GDV4PKA1B9niKcl63e7ztP+lp7rOjd+4U5JUCvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net; spf=pass smtp.mailfrom=abhinavg.net; dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b=sNlKYZFf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neRomsxM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b="sNlKYZFf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neRomsxM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C417140002B;
	Sun, 10 May 2026 18:41:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 10 May 2026 18:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhinavg.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1778452905; x=
	1778539305; bh=vrRcliELDi+2+xGFisphxCQZEKIxw2O8yHW/FzXum+E=; b=s
	NlKYZFfosy/CgvyoTwBz3Va4MPE6AS9WfkrciFqpnKt7vkY6mNVnpt1Posn4PFFR
	ztBr5dwL6wbyp6epWtAeilMmIpu0G4Grd/yZl8gliXm3BWraNjugTMrv/rzKfrsU
	z7XNJ/EGPZn7YVZH/NnQIlifYT88I6K+bnIiTLhcRTg8wvqmw+Sgfwazw03Kagyw
	bVcXP+VQ4Wq7gmJ1KNWuQs9bl8MGrtHSngzFq4Wogjo3EuyDdboXKZF9DpOyMowK
	I9KdVk/odarZkeeiTeIc6nb8U5EQ/DrPIjUB075KzsNEq2xv99NiB8FXhRaTdcH6
	Nn6kF3LYinNFdNBE3yg4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778452905; x=1778539305; bh=v
	rRcliELDi+2+xGFisphxCQZEKIxw2O8yHW/FzXum+E=; b=neRomsxMajJmYTE1I
	xLwuznwutq+pcXA0JwwR0SU1NIW9+DlZ3VAVqD2UxyzTn+Jc/4KTpVimROFS4XUU
	Ulc4gHfcQbYL3oaJcm34bihFDhsgf+/nd95IRCsdUwvtafrn04aWkKEpYw24sJ9d
	99m4Z4yC1ax+iinTZ9fyKlNnyDBkE4wBfbQLb6qlLg4rurUAtYlEekAXhWnBC0jf
	URi2gHWeixq9Dl9yIFNpU0Cfq5IsRMGJ91UQxTnpnT7fL8+IU9sW4QFn4JKsAc9P
	/8aIUDMgcSvIptkNIBxLrGQGext8SF8AMpJjr3r5HlKBltwc77XnCm+aB12BlD7k
	pbmdA==
X-ME-Sender: <xms:qQkBauF0Z3yNQLMvYQNDdbLDiL64iCxZ8iaejEMUNlOMCuDTrwetcg>
    <xme:qQkBatL3mqGlYUKv8AoLE7iI_II43q4V6czJuWXMvA0FKrnJo-_nhWOcw_uQYoBdX
    8h2PTGEJP4NTd9aT9RproXK4QIPrqzKwDhZrVufRKJzc7O0mTvBzh4>
X-ME-Received: <xmr:qQkBailme0iLKPszKmqqBUxJ2CNd9T-qYz0vRsJBtxXnnm9UjnzymwgbVmpIb3_f781UjMnstyTyDjJN6-nBV8RmmtZD8fVaOAj_RLFA507BWCOiHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmhgrihhlsegr
    sghhihhnrghvghdrnhgvthenucggtffrrghtthgvrhhnpeevgfdukeduhfeluefgvdegvd
    fgveevvdehfeeujeeutdevteeitdelueegffevieenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesrggshhhinhgrvhhgrdhnvghtpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehmrghilhesrggshhhinhgrvhhgrdhnvght
X-ME-Proxy: <xmx:qQkBalSjtcRZUitjkJz03YEVL7INwz-pxkfmq0tFXAe9Y6sT2bcb4A>
    <xmx:qQkBakIWb-OFafvOrOMdFgUUL_KrsAIlbgnDS16n4BWzP39z74YiuQ>
    <xmx:qQkBarCsUICTNuK5CBtKPpyagbCIG6Av6PuCprzq5kVekJwOTBvRHQ>
    <xmx:qQkBatA50pK9E8c4lhxPGqi5gKV-t3YXCqg67ym39k0rP875kHms3Q>
    <xmx:qQkBapOnC4mXL3dBQiHS3uZ9pnSzabBk1duYx5hoLmvmW68gfMB8Jyes>
Feedback-ID: i43f949e9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 18:41:44 -0400 (EDT)
From: mail@abhinavg.net
To: git@vger.kernel.org,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	gitster@pobox.com
Cc: Abhinav Gupta <mail@abhinavg.net>
Subject: [PATCH v3 1/1] rebase: ignore non-branch update-refs
Date: Sun, 10 May 2026 15:41:11 -0700
Message-ID: <20260510224111.64467-2-mail@abhinavg.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510224111.64467-1-mail@abhinavg.net>
References: <20260508015817.86177-1-mail@abhinavg.net>
 <20260510224111.64467-1-mail@abhinavg.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhinav Gupta <mail@abhinavg.net>

The following Git configuration breaks git rebase --update-refs:

    [rebase]
        instructionFormat = %s%d

The '%d' format requests all available decorations for a commit,
filling the global decoration table with all of them,
which --update-refs then uses to populate 'update-ref' instructions
in the rebase todo list.

Specifically, this results in the following instruction:

    update-ref HEAD

The todo parser then rejects the instruction:

    error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
    error: invalid line 3: update-ref HEAD

To fix, ignore decorations that are not local branches
when scanning through the table.

This matches the documented contract:
it moves branch refs under refs/heads/
and leaves display-only decorations (HEAD, tags, etc.) alone.

Verification:
A regression test that fails without this fix is included.

Signed-off-by: Abhinav Gupta <mail@abhinavg.net>
---
Updates:
    v2: incorporate suggestions to simplify the test
    v3: merge two if statements into one

 sequencer.c                   |  8 +++++++-
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..ca3ea863d6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6431,8 +6431,14 @@ static int add_decorations_to_list(const struct commit *commit,
 		/*
 		 * If the branch is the current HEAD, then it will be
 		 * updated by the default rebase behavior.
+		 * Exclude it from the list of refs to update,
+		 * as well as any non-branch decorations.
+		 * Non-branch decorations may be present if the pretty format
+		 * includes "%d", which would have loaded all refs
+		 * into the global decoration table.
 		 */
-		if (head_ref && !strcmp(head_ref, decoration->name)) {
+		if ((head_ref && !strcmp(head_ref, decoration->name)) ||
+		    (decoration->type != DECORATION_REF_LOCAL)) {
 			decoration = decoration->next;
 			continue;
 		}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3e44562afa..58b3bb0c27 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1960,6 +1960,24 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 	)
 '
 
+test_expect_success '--update-refs ignores non-branch decorations' '
+	test_when_finished "git branch -D update-refs" &&
+	test_when_finished "git checkout primary" &&
+	git checkout -B update-refs no-conflict-branch &&
+	(
+		set_cat_todo_editor &&
+
+		# rebase.instructionFormat=%d loads normal log decorations before
+		# --update-refs adds its branch placeholders so we must ignore
+		# all non-local decorations.
+		test_must_fail git -c rebase.instructionFormat="%s%d" \
+			rebase -i --update-refs HEAD^ >todo
+	) &&
+	grep ^update-ref todo >actual &&
+	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success '--update-refs updates refs correctly' '
 	git checkout -B update-refs no-conflict-branch &&
 	git branch -f base HEAD~4 &&
-- 
2.54.0

