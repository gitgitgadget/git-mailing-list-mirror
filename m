Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD832038DC
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905852; cv=none; b=lhikj/Q8JeUagcoXC51nNP/2HFqyyNy1GKsu23jqCSA9GYdnGZ2Yz0OM5d7k2jtexksG6FrJWXFIIiA3YeQKa2/W9mpFw71ixwWVGogKNyNvEikYjQADWoa6c3LJNX9Xio4wDheq0RXrFz70eApEgDmxTozH6vQO5LewN9FXnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905852; c=relaxed/simple;
	bh=1RR0gurO95KqF6S3k06FTg3REUjgOqwO8L2QxKDzWR8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdK9HGauTI+wk5zee0YjJazM+cD412hfMs8lL5mhODSWgJsMA69w767cstTGOB1ti3gQhOA4FhuwSe1SgRCWQzI6aheunp2kvIjHgWUsT59RW0zB4a9rb5ZhkMgzPVrEyIkTEOA8hQHagzj1aR21ud0uj1KBKRF0XZbK8XRZTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aP1E86zL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkU3d9DK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aP1E86zL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RkU3d9DK"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 27A53138062D
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 10:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905850; x=1730992250; bh=olmbXQN41A
	MfxveW4Do5+AekH6l2zLzl5DsvMIgQyMY=; b=aP1E86zLYbMOgYf9T9u1DnwX0Q
	tvbMNm6jmOtBuffsSGr5j0oOR+c8GN665t0CGc3FQXhSD0ewP5TZ1iyTQpJmInWH
	uIa2GM5K1TjiAipQ+oO4WaXXMpLUQDlmYYZcs6GXnmQxAlBuplS7UsBhVBBWQUGu
	cvFvFYy2uq7Y6vouFFIguqGAfItoOzNjZeDwn/avrBLjljXRtO5vgozxnF+LxB3W
	QmAbBlxB4MncSmqdI5cqEWDyxIAkofuHIamPafsVD7gx7/I7P4Teci8Wk5ZfnM2E
	056SrGr5Hv6T+aoWA1ofkjHF9raXFsy0vb91UTI4UFttTXyQ/d20A3LhWKyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905850; x=1730992250; bh=olmbXQN41AMfxveW4Do5+AekH6l2zLzl5Ds
	vMIgQyMY=; b=RkU3d9DKNDm3n4bcQc+6OicE0FJ1RnBv7XOLTd8ONbnjSOWFsbS
	kDKhRV9nQJ4qRFqV3wAlDyXsTfN6uSYP98mcvfvTww0VaLJSmzlEkPZLjjkYsSEd
	6bIAksYa4EPTYb5QUrWDkuq0LudL6q+cy9QEubuI/hX8PeF6TbeUy/dph2vVoJHs
	yittHpX3VwJX+Kn0IYlJtDKLft2y+vrkctt+L9W47eaEIvmpcS4Mx0PTRCT0GXYK
	xaECMTUgmwPtUJuvOF7+/RBz1JDhgHocIpDl6/U/NAnYbdx1qWDhJPOcgFPlF2u9
	ikXB/2+sPzfGhmpb2VrrIxMhfmdX4OY8kVw==
X-ME-Sender: <xms:-YYrZ4R_bYhUBe6dU9rcNqgZqBIOqNBkPjdVzCw6d5ayYtyoq57oBQ>
    <xme:-YYrZ1z_1cSwH2JZJqY4VMZ7Ap_BKAzAvXzeAu20BmSNTmmsKM1ZyoyotK2ItNlbQ
    18EgWyEpayMma8lag>
X-ME-Received: <xmr:-YYrZ126ujqwMXcLHCnCCFa9jj3CKQcszjhrK_ks20bB9XVJkr4aYrDlA86aK7xyZ9QbHkk-1726nqMX3IlfwPRVqp6GOb6CayD2-cmPYfyixQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-YYrZ8BTkH3eb7JY9k8yzeQ3c9lMa3zy1rcJUITDaa5mkHItIi8K2A>
    <xmx:-oYrZxjt9RKAV1j_--ejniXA4LS_x7EjRNS0h07MgVCimFrllZCVjQ>
    <xmx:-oYrZ4ofwOhim5uedIvaTqradkRqqr8kqY6Rxt2wwv6o1gsva8XIHA>
    <xmx:-oYrZ0j7-Ockzj-cPUpLphnunq9og8hAywFif33uI6dJYKKHG07RHQ>
    <xmx:-oYrZxYXtkmiAUSCHcg8VILLHXot6eDfrank-e1ax1XZewSEfHjDoCNP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 046f761f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:25 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/26] line-log: fix leak when rewriting commit parents
Message-ID: <c79be063a63e9f847fee5d5e58570df91157750f.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

In `process_ranges_merge_commit()` we try to figure out which of the
parents can be blamed for the given line changes. When we figure out
that none of the files in the line-log have changed we assign the
complete blame to that commit and rewrite the parents of the current
commit to only use that single parent.

This is done via `commit_list_append()`, which is misleadingly _not_
appending to the list of parents. Instead, we overwrite the parents with
the blamed parent. This makes us lose track of the old pointers,
creating a memory leak.

Fix this issue by freeing the parents before we overwrite them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c          | 1 +
 t/t4211-line-log.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/line-log.c b/line-log.c
index bca9bd80407..bc67b75d10d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1237,6 +1237,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 * don't follow any other path in history
 			 */
 			add_line_range(rev, parents[i], cand[i]);
+			free_commit_list(commit->parents);
 			commit_list_append(parents[i], &commit->parents);
 
 			ret = 0;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 950451cf6a6..1d6dd982a2a 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,6 +4,7 @@ test_description='test log -L'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '
-- 
2.47.0.229.g8f8d6eee53.dirty

