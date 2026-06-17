Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9383BB66B
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715058; cv=none; b=RyLJnoIOn7XGrrU9m7Zyu9tNq/80btzosqSDCOFaM8AXv4ZNrzsPcom8I4Ps+/WBTkMrj7dP3Te+/YTzceDl7+Hm0WSsLa7Am4tUFkfiBcAsKVH6nUSrn4zWo+FLnbXlgp3CdL8kQf7ZsJMhohRcj+TyZ3fVLaQS+akPPJ+p2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715058; c=relaxed/simple;
	bh=HKVQO6zBcnPOYCzKMhEkKYu++2QPayaKe1jSL6IfQzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqBPqwN6glmhqiGe3Ec9fx7LNFPQiBlTyIBGqG5qCJukEnh5TYvAB518lOWP80vd3kR46/MWxwiNDIjqyWiC+jigIUcLugNNudai9Y57Qu6WxGdGADVMv2rVFm3V9NTs+SqUFaCmls7sSOOtQZmCqfxjUKFOnY6/0VzE/5gg/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=FtWPHg2f; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="FtWPHg2f"
Date: Thu, 18 Jun 2026 00:50:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781715055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cpxwt+JmaqCCk5YLmdjeKOS2An2pJB74OGZFaMf1Plc=;
	b=FtWPHg2fuXem2sSy7aCB3QISJE1VaulrVJQJxR4xG0echQO8B4NAHmMUxOcp+suFuEtaC7
	WLvZ2eHIyvm4ArINS2cpB5E2Ca+qLfQDofpXCVSM1jbqkdUTgViZhpu7fHl/VfC7zFpV0n
	S0dxukqYKDTEbs1lXb06VfUCHLUBQCQwf6OwCIXUGEOjPL4/fIxIJYguXN/TKNHpCJgzAL
	8ywXVzkh9w2uAnOKrvmJHJorHyoZlJ9bNEg6HGN9EfOxdPL5K1R4VH5ERWQgGsuuteLseh
	0VpUXt7PhRxeQ8LogjcMtmMVo3GEaHq63eD0q6rHqioltItnsjDgolGXJsyYwQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [PATCH v2 1/2] doc: encourage review replies before rerolling
Message-ID: <4bb1efe71da5a9a16860a1fc4d22ef9ceab83ca2.1781714757.git.wy@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <cover.1781714757.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781714757.git.wy@wyuan.org>
X-Migadu-Flow: FLOW_OUT

Review feedback should not be answered only by sending a new patch
version. Encourage contributors to discuss their planned response in the
mailing-list thread before rerolling.

This makes the author's reasoning explicit before the next version is
prepared, instead of forcing reviewers to infer it from the rerolled
patches. It also encourages more direct social interaction between
contributors and helps foster a more collaborative review process.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 Documentation/MyFirstContribution.adoc | 12 +++++++-----
 Documentation/SubmittingPatches        | 12 +++++++++---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index b9fdefce02..00704ab91e 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1337,11 +1337,13 @@ fewer mistakes were the only one they would need to review.
 After a few days, you will hopefully receive a reply to your patchset with some
 comments. Woohoo! Now you can get back to work.
 
-It's good manners to reply to each comment, notifying the reviewer that you have
-made the change suggested, feel the original is better, or that the comment
-inspired you to do something a new way which is superior to both the original
-and the suggested change. This way reviewers don't need to inspect your v2 to
-figure out whether you implemented their comment or not.
+It's good manners to reply to each comment in the mailing list discussion
+instead of letting the next version of your patch be your only response. Tell
+the reviewer whether you plan to make the suggested change, keep the original,
+or pursue a different approach. This way reviewers can respond to your reasoning
+before you spend time preparing a version they may not agree with, and later do
+not need to inspect your v2 to figure out whether you implemented their comment
+or not.
 
 Reviewers may ask you about what you wrote in the patchset, either in
 the proposed commit log message or in the changes themselves.  You
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f042bb5aaf..6c1e1f6423 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -48,8 +48,12 @@ area.
 
 . You get comments and suggestions for improvements.  You may even get
   them in an "on top of your change" patch form.  You are expected to
-  respond to them with "Reply-All" on the mailing list, while taking
-  them into account while preparing an updated set of patches.
+  respond to them with "Reply-All" on the mailing list, instead of
+  letting an updated patch series be your only response.  Tell
+  reviewers which suggestions you plan to use, which ones you disagree
+  with, and when a comment leads you to consider a different approach.
+  Use these replies and any follow-up discussion as input when
+  preparing an updated set of patches.
 +
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
@@ -613,7 +617,9 @@ grouped into their own e-mail thread to help readers find all parts of the
 series.  To that end, send them as replies to either an additional "cover
 letter" message (see below), the first patch, or the respective preceding patch.
 Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
-how to submit updated versions of a patch series.
+how to submit updated versions of a patch series.  Before sending another
+version, make sure you have answered meaningful review comments in the existing
+discussion.
 
 If your log message (including your name on the
 `Signed-off-by` trailer) is not writable in ASCII, make sure that
-- 
2.54.0

