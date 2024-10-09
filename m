Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD91D356C
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494914; cv=none; b=fwU2bSMwAx6i5ki9VNQjRIJTSXjwEI8YtJfN8hv8NzOcejr2Jb7mq/E9jdCzkdxxW8nrapgJEQBGxOJpQFDP1nQlbthVCa3nuG2EU1IGe7E//vRrg4EkvtPQOWbLlE0XKJAMdHgnu0+pTDl/sKMumqo2I8e5cajlEtXaI9/c854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494914; c=relaxed/simple;
	bh=YjG9nhHz2z5eIndOOSWRA3VWv2WjTNjVE4CplUlCmKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lFo0QbMPEaMPhTlQHdf0GOK0GtmDt6UNlwL2/gPRC2CHbkrRX1mlJTyXHXDBA/SOh1WqvmGG+hXV/r0DPpT+ol8Xx68Y2TkrFeQRIPZ9Ta8Vfymb/aUgXQjbxMlo8SF/FfbI8RGWOiu6x3wzx+sZ627QvTSrlN5aVuuhrJYAib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=HXrVGBfw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8hsEWfF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="HXrVGBfw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8hsEWfF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26E6011401E2;
	Wed,  9 Oct 2024 13:28:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 13:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1728494911; x=
	1728581311; bh=AS48G+XgHFpyXeLdOnnL/AcPn02N0jQyF40iSrYvb4U=; b=H
	XrVGBfw8GQwOZpNUAt4aK4iIL+BDwMdCU/tSExhf+bBU387NyO+jirW3WNoTd7mQ
	B+mzu++L5iaBVcRkQLEqkKkolp+G3sGH7PhsqHlJPZCxPSAW5eJA9ukBI7vsHuDa
	a6aHuI/gA4+JG9wz2T0h+TA1yBRyY5EqZ+RvyBqTT1Z8PeHu41DE0YOheA8rtO0n
	HEJV8lBxww03hefY4xuGqpqx6zdZvYh+8A38bMt+h+JbscIIfjV/iPswfjEvojIt
	QKhYy95YK3NXwLcA0elevEde1gfhXJjyyedHccazDKEp0xHhJkuHBsnafabPzduz
	XMGy1GELK384dAvl3NvFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728494911; x=1728581311; bh=AS48G+XgHFpyX
	eLdOnnL/AcPn02N0jQyF40iSrYvb4U=; b=U8hsEWfFe/UBrxb444TCjWNMtJeTd
	KJvY78+dL2wa7zuAVdTkXzUZkkxsAjKhFkZDQ76tj8IxOdqJxosV10sjpja2kfSu
	R2X3xdVjiBO0j/vVoeXmdH/Cqhlwf3//mraU/nj5YwWOBht7wnU/UFodU3RgMd4j
	2NaqVDQd0/0bQ74dQmMdI98jpniw1L77D/abMJJ3lCh0yZ19vSz+Iy8BUAPuOVh7
	PikR4yXoQDZaw/ZMeAhcQHqq4hATU9jQAm6ndmCm+THrIGCT2NOYhZoybIVvv0I6
	rBnE3u1XgXufgcoGIy6Mg8fVp/W32C7WvUW1+Rcnpm3uZr4TifsfxJAjw==
X-ME-Sender: <xms:Pr0GZ7RiHzT8aWnIPbKkZZftFabH6nX4ZSMCNHav1pDaeSkv_34cYUk>
    <xme:Pr0GZ8za8MGIzcSrwyi796vKa_XyBKg95A6JqGENfWMxaygIZV9uiP_K3ZfFJum16
    Y3GJFc48RRledXFzA>
X-ME-Received: <xmr:Pr0GZw3JkIsD3boj5eUe0Sfu0noDfqaU5jGpK-MsohANq0WUCsZasdb4_NhpLgCJ7OT-RwZbHwP8FM0YQ-3XI8txi8EMDX2icw3pcxQHJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepgfdvhefgffekgfeiheeivdetffelkefhheeitdejhfelhffhkeevudfh
    leekvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gv
X-ME-Proxy: <xmx:P70GZ7C0JmSBFruixWSck5MvHyFNkUXyS6fAf_UMPNo4_hRkJyhm0Q>
    <xmx:P70GZ0jTVNlNUtCkDkg84TrGukz-dH2ZW9wQNR7EgrTrrvqdfQnNrw>
    <xmx:P70GZ_pBN3Zk7Tdp_YW4uw4P2n0QFlUifNKMzDFaeJ8ucdGITvWjKQ>
    <xmx:P70GZ_hE4wtkRwxYVCJ4DbAPOZDin6ucc98tuCXlnTQzqcA3hn56tQ>
    <xmx:P70GZ9ss5EOpCaqpOgDM_fzLZh-akZwpfvKd3HDAFrTTIfbLwa0WaZ5A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:28:29 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] checkout: refer to other-worktree branch, not ref
Date: Wed,  9 Oct 2024 19:27:58 +0200
Message-ID: <259fcbb61f13873421d50df77f151130fdbf0166.1728494795.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 259fcbb61f13873421d50df77f151130fdbf0166
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We can only check out commits or branches, not refs in general.  And the
problem here is if another worktree is using the branch that we want to
check out.

Let’s be more direct and just talk about branches instead of refs.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I also change “is holding” to “is using”.  This has plenty of
    precedence:
    
    1. The code ultimately calls
      `builtin/checkout.c:die_if_switching_to_a_branch_in_use` which says
      that we die if the branch is “in use” by another worktree, just like
      we do here for the new description string on
      `--ignore-other-worktrees` (c.f. “holding the given ref”).
    2. `man git checkout` uses the phrase “in use by” when talking about the
       branch being checked out in another worktree.

 Documentation/git-checkout.txt | 6 +++---
 builtin/checkout.c             | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8bdfa54ab09..b00b375dd27 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -290,9 +290,9 @@ Note that this option uses the no overlay mode by default (see also
 `--overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
-	`git checkout` refuses when the wanted ref is already checked
-	out by another worktree. This option makes it check the ref
-	out anyway. In other words, the ref can be held by more than one
+	`git checkout` refuses when the wanted branch is already checked
+	out by another worktree. This option makes it check the branch
+	out anyway. In other words, the branch can be held by more than one
 	worktree.
 
 --overwrite-ignore::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9c30000d3af..c449558e663 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1716,7 +1716,7 @@ static struct option *add_common_switch_branch_options(
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
+			 N_("do not check if another worktree is using this branch")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
-- 
2.46.1.641.g54e7913fcb6

