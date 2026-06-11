Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CA408638
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187310; cv=none; b=UcN4iqDckBEEZocf1WHOAjlXSOL1MmSMiOLgz2wlWucky5yVUT2xnmLkKeW20uNpwodxp7MJ1Z0Y50Jlbounkq49CPiAx4NpI6vyvCUr76IwTCQ0co5JIsySIIdJW5E9vgg7FB1OlXELcTaq8wEhsSJJJTNzk4zBci61Ot1LsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187310; c=relaxed/simple;
	bh=rg1fshBOxu5d1orNDU9UaHcqEVwjs4HF5jLsYkJN8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RAxXkEst554gKPCnqHm0W6zU1Hd8hFT+QIA6uMu63IEjYEtE26gsCa+xuzNcgTCJKJu6jNnltkJ0Yk69sxqGvEVR6Le7oekAPGJF0Nm6ChfatmhAqAGVIO1A04tFr/wQdfOOdFImH6HpX9Y5KzyQfn0XbUJ9p8LIWbnNgJp8Fz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=VD0Mrryp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="VD0Mrryp"
Date: Thu, 11 Jun 2026 22:14:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781187306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=diheQsddEhvR/7+2JqsJS+5STdN58aQI3kMatZLXS7U=;
	b=VD0Mrryp6NOrPy7ZTdWdfXS0+1d4zw+XY7+tJnRMFVqgflhlLQWpgAdAEsddWRzVFA3jfq
	/SZNlz1EHkWq3qxYIkfEU+SKekC6pFDp3CV72FeG/YvImYzr5cvxhrRzQpzBCdL1mD1v6b
	CRJEw5x1gq21mv2P68TwodQX75gv+Ef8QxoK1QVW/Ad5kxZqcjc3ceGf8qPIxvbFIcvjdD
	MNVdE/wqRREmCbDKDcQwbKukqZX3D6hKooSmWogER95//emkUeGixGTnBlK/nekhsmK0At
	bHK4FSyPzoo8c8Mwe3cDEiWReEB3BLuea40o5UkUTngCJMHFzqYzY3JLOeiobA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [RFC PATCH] MyFirstContribution: mention trimming quoted text in
 replies
Message-ID: <080402ff0ac8127b654dccea59a1bf643df62a5c.1781186476.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

Junio has pointed out a few times that over-quoting can make review
discussions harder to follow [1], so I thought it would be helpful to
add a reminder about it in MyFirstContribution. Please feel free to
comment on the patch, as my English is not good.

For your reference:

Git's ReviewingGuidelines [2]:

If a patch is long, you are encouraged to delete parts of it that are
unrelated to your review from the email reply. Make sure to leave enough
context for readers to understand your comments!

The Linux Kernel documentation [3]:

Similarly, please trim all unneeded quotations that aren´t relevant to
your reply. This makes responses easier to find, and saves time and
space.

[1] <xmqqik7tz092.fsf@gitster.g>
[2] https://git-scm.com/docs/ReviewingGuidelines/2.38.0#_performing_your_review
[3] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

--- >8 ---

ReviewingGuidelines already advises reviewers to trim irrelevant quoted
context when replying. Give the same advice to new contributors in
MyFirstContribution, so our documentation is consistent about mailing
list reply etiquette.

Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 Documentation/MyFirstContribution.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 607876f3d8..0e2a9313ce 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1453,6 +1453,11 @@ effect which had not occurred to you. It is always okay to ask for clarification
 if you aren't sure why a change was suggested, or what the reviewer is asking
 you to do.
 
+When replying to review comments, quote only the parts of the message that are
+relevant to your response. It is usually helpful to trim away unrelated context,
+such as large portions of the patch that are not being discussed, while keeping
+enough quoted text for readers to understand what you are responding to.
+
 Make sure your email client has a plaintext email mode and it is turned on; the
 Git list rejects HTML email. Please also follow the mailing list etiquette
 outlined in the
-- 
2.54.0

