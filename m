Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD83074A1
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359741; cv=none; b=mqTRBpqUrEpQadiXBU74Y9jkc2CRZZqv5AMA6gJc6eKaZdja3NLBC47feHA4B3p0Leo7DBWK8/kkEdOOOX5n+M5aheQok5hYOqBjUC+2I+1OkbuY9HnwrBOXElDVi/9qChRe6WlbEubQ332Q8w+pjh315JbDPIOnGdLtlwpLumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359741; c=relaxed/simple;
	bh=p9iQ78q/t3UmlkxBLetfYXmgTG7TbPjLpk+4CxI5zaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXFazhfU9k6smHI9EIvOSmeMW5gKoSi0Oa7I/VE6I1QpQyUAMYZ4IUBH/u2eHp1bhRJLTX281qYAW9E5k+xxV4CyM2ycQqX1SNvxECp/N+tKUUY1CNBsLBnN0VcnDQYyrI7ufVSTdcjEFZxBGsFdsjJ828APvE1UAbj/tCKQkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=dr6HuREA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="dr6HuREA"
Date: Sat, 13 Jun 2026 22:08:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781359738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pREox+MUUByQJ8x5msabLeVm33xZL5dDUoWmR7bPwcA=;
	b=dr6HuREAm92cw3Ic4mhit0gTusjMX7eubiiATdt4g1YgByLzGUz2YRnFRklLxCMjN/0VDu
	MtIYTFiScW0jaKsY2td3ViBar4dMieDrvOE3y69+3/t6sPhm3DaeUjvkyojcmNZ3F7wJX5
	xFTzwgK6TXdfcx2sAJNyGlAjFXt8ZVxFurZwYRNtZ7jPXgGj2+uY2mch0CmhP5IlWM+bVV
	ESwsMqrkwUEhOtC3ddqe3hbNLC2LJZ13JecmpAxDiqq/UnJUnzMx0fx3oGQMYUfErtiR/C
	yglYndUCNnMFhOQgt+rdXsq4Wpx8DWygQc8UMPP2BJXKH0dFX47IFHuWipaXOQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [RFC PATCH 1/2] doc: encourage review replies before rerolling
Message-ID: <68a1969c35cbc2d24af7a0d09c376ecf403c3591.1781358364.git.wy@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781358364.git.wy@wyuan.org>
X-Migadu-Flow: FLOW_OUT

Review feedback should not be answered only by sending a new patch
version. Encourage contributors to discuss their planned response in the
mailing-list thread before rerolling.

This makes the author's reasoning explicit before the next version is
prepared, instead of forcing reviewers to infer it from the rerolled
patches.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 Documentation/MyFirstContribution.adoc | 12 +++++++-----
 Documentation/SubmittingPatches        | 12 +++++++++---
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 0e2a9313ce..59891e3c14 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1423,11 +1423,13 @@ fewer mistakes were the only one they would need to review.
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
index 6b83b6c89e..d8ad7fb73e 100644
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
@@ -639,7 +643,9 @@ grouped into their own e-mail thread to help readers find all parts of the
 series.  To that end, send them as replies to either an additional "cover
 letter" message (see below), the first patch, or the respective preceding patch.
 Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
-how to submit updated versions of a patch series.
+how to submit updated versions of a patch series.  Before sending another
+version, make sure you have answered meaningful review comments in the existing
+discussion.
 
 If your log message (including your name on the
 `Signed-off-by:` trailer) is not writable in ASCII, make sure that
-- 
2.54.0

