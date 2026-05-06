Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175423183C
	for <git@vger.kernel.org>; Wed,  6 May 2026 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035315; cv=none; b=octtwLJA8idvp6I4fGR7SGYsFR0cfSksnsQPnSkp4sHzM/zJri/yPmoFgkloJb0TAlM2dCWJvEqZYmfyzgb1Wx9CG9gUSZHi9WBub/y8rvlKsYjWGah3UK7cxziXog5SQiTuxHmKhc2ViQd2ZmH2UQSfNet6Ey7EdSlRlYqTxlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035315; c=relaxed/simple;
	bh=W8HlMVBKizMXsDlgITWS7Ct/WHZ8p2dSAVJM5JLfDo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbAQPFpXnS5yTu7iwjUUdnqS6oCdi1b1rx9gFRGumq/6Cw7jyU0gf4c8ngytOhPTSmazpBqResKwpJWHVrA7M/KWewQmnIY31yG901/nHH1dF6RaWhgPsP9TabmRdx8zdxQCfZZMBAXFx9R+m+y7+lJT1lRlVJox0gavCmRADkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net; spf=pass smtp.mailfrom=abhinavg.net; dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b=iAQthXox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2/lSm52; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abhinavg.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abhinavg.net header.i=@abhinavg.net header.b="iAQthXox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2/lSm52"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E4587A0122;
	Tue,  5 May 2026 22:41:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 05 May 2026 22:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abhinavg.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1778035312; x=1778121712; bh=ykl+yiU7L8ieFvFzHlXyF
	MbgpMxAVueOa4JAr8xdkvY=; b=iAQthXoxbLmV0M+QCePS9p2XmMudx4+s2NbcW
	Mdh84v62Fdy59kP0foQ4Wgo74EtuYeRvs5u6uPevAjuXes2hBW208pK3RtdM8aJq
	rxiVXOXlz1QDZB94Nb+YyTf3/FuxcVRGUUgLuMt/lJuY/Q2ABr94lN61Cu3g52hF
	GiDu0hwHP12/odo6WipLSIuNukdSe9UJNCBCTZQYNUDECAYOKM06q6RaNMmynsow
	gMuaMwYiHsgg26/a0FOwxtlcB2WnAJxjWztuk05EqSzbdI101rxPAmy/cOxZHRev
	wTCz+sBcZjRc4szX1uBV0EAgAXvZeeeoZPJrgLRIP56rtEKrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778035312; x=1778121712; bh=ykl+yiU7L8ieFvFzHlXyFMbgpMxAVueOa4J
	Ar8xdkvY=; b=f2/lSm52LlOoLHzClcAxQzutXoPW9y2vtbgUmEkWqL0OjhZ5aVe
	27yzXfWNH2gVjd9P2/VTnypbbduRWBnV1jfjI6E2HDFWJ4nL+9Lrh7ipCWxTgY7M
	CnaLWqXzKlbD2UutFS0Q1qMK849QJtqFgZVvTWxYmL5VS5TrHBZuzQ/ESzdczdNH
	SHzn8DNCVZCm5JLnLcWfMlEmbiajI9urSNlITSHBi04uitaoS5Q7JnolZlhxuF7t
	6f2N9ILQ/v5hRvTg90orqAxO+GgvBwroC+c/YDSTMYdwyfrNyAh1P3LjwZOKnabn
	e/Qjgny8przVuImFguN2Uef/w6gW8TdyYlQ==
X-ME-Sender: <xms:cKr6aW-CrHFd4VNgYWIA3eDY8V9m0p3gUVgvTor1CxwO6xhYdmHjnA>
    <xme:cKr6adsDJkee1juM7dSZmvKj8CWeeEszxZH9KIPtZgMphNGNEMbHSK9SGBYq34tlJ
    d8K7dZzcBVd3FE5Lf4gvMW-InsN4LwR55mGzSG_0vWibA-Vn_gMVn4>
X-ME-Received: <xmr:cKr6aRB0dFjESfo1uMDt-02OyWtUMWGVbu4nJQT7HcYcKIZj13UwlsR9s5-EiblLxZ-BVREPOzn-BkTF4JTXtUSPzspWk9J4j2kMiNKmbospZYbaKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmhgrihhlsegrsghh
    ihhnrghvghdrnhgvthenucggtffrrghtthgvrhhnpeekgeeludfffeeugeejhfelheevhf
    dvudffudffveevvdffleelgedttdeuvdfftdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesrggshhhinhgrvhhgrdhnvghtpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlsegrsghhihhnrghvgh
    drnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cKr6adXYuwHdKGK17XoCPnPnQstc_fy0ilGVuMFlHB7DezQnWmpaCg>
    <xmx:cKr6aXDmZ8nYocN8JBpXFAZ2myMo3Y5K7StQ9NJgjHhrt2vIu5qy_g>
    <xmx:cKr6aY8LHPjLL1hrL1yBc8mWTqG-2qMuAGDNDnmLU_dtb09Z32sBGQ>
    <xmx:cKr6aWF5EggZkS6AYh1w-xEhTfiXjME5juJpIxZWkw-jOjwTAYEzng>
    <xmx:cKr6aUhOmwfDBCDoP4SXWIjDFP-dMvc8HudN6aQ9pl8-f_a5UO5LWy3_>
Feedback-ID: i43f949e9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 22:41:51 -0400 (EDT)
From: mail@abhinavg.net
To: git@vger.kernel.org
Cc: Abhinav Gupta <mail@abhinavg.net>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rebase: ignore non-branch update-refs
Date: Tue,  5 May 2026 19:39:43 -0700
Message-ID: <20260506023944.90691-1-mail@abhinavg.net>
X-Mailer: git-send-email 2.54.0
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

This filtering matches the documented contract:

    Automatically force-update any branches that point to commits [..]

Signed-off-by: Abhinav Gupta <mail@abhinavg.net>
---
 sequencer.c                   | 10 ++++++++++
 t/t3404-rebase-interactive.sh | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..25bcfc5da0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6428,6 +6428,16 @@ static int add_decorations_to_list(const struct commit *commit,
 		const char *path;
 		size_t base_offset = ctx->buf->len;
 
+		/*
+		 * The global decoration table may contain names loaded by
+		 * a previous pretty format such as "%d".
+		 * This will result in refs such as "HEAD" being present.
+		 */
+		if (decoration->type != DECORATION_REF_LOCAL) {
+			decoration = decoration->next;
+			continue;
+		}
+
 		/*
 		 * If the branch is the current HEAD, then it will be
 		 * updated by the default rebase behavior.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3e44562afa..d58236f0eb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1960,6 +1960,28 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 	)
 '
 
+test_expect_success '--update-refs ignores non-branch decorations' '
+	test_when_finished "git branch -D update-refs" &&
+	test_when_finished "git branch -D third" &&
+	test_when_finished "git checkout primary" &&
+	git checkout -B update-refs no-conflict-branch &&
+	git branch -f third HEAD~1 &&
+	(
+		set_cat_todo_editor &&
+
+		# rebase.instructionFormat=%d loads normal log decorations before
+		# --update-refs adds its branch placeholders.
+		# The placeholder scan must still ignore symbolic decorations,
+		# because "update-ref HEAD" is not a valid branch update.
+		test_must_fail git -c rebase.instructionFormat="%s%d" \
+			rebase -i --update-refs primary >todo &&
+
+		test_grep "^update-ref refs/heads/third$" todo &&
+		test_grep ! "^update-ref refs/heads/update-refs$" todo &&
+		test_grep ! "^update-ref HEAD$" todo
+	)
+'
+
 test_expect_success '--update-refs updates refs correctly' '
 	git checkout -B update-refs no-conflict-branch &&
 	git branch -f base HEAD~4 &&

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.54.0

