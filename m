Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899C3CBE71
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714927; cv=none; b=lEPlU5nqBglGhuXoNUJtaYtAYd7YCU8sRDcqzHOVnyZO5Vq3BiMa82RUrK+Z4FKlKBbeFL1NoGBniqs3CzhzemdL0SXM5dZfRz8FW6aNrLYEh3H1gnMcFVXclhyNeCF4Fmpe7231rNybqtZn97LT/IAR65Em+0MvBoI2oYE/cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714927; c=relaxed/simple;
	bh=+EsJKglrFmvQapYMCzqGGQ678rQFlXc2GyyVmxC/LeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhnqqb7S9VPt3i6uCHJ5HdKCO7bpOctsrVpL1SpMmLsAQZEXOgznGJ6JGACYPwab3O5ePw3I+i1aNDU9Wfe1b+c3lGhKyAZrm3lyrr83Wsh5Q85uoB304LFTd6MU2MLGu2NYoBSTwmVSfazq2HFzZEqpZX88YI0qKRi4etnwg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=twVr98vv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="twVr98vv"
Date: Thu, 18 Jun 2026 00:48:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781714920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3ucOuo8gYejPgGbK6JbuG9fS4OluhnoKqkjk59bc/k=;
	b=twVr98vvMhpvRMmp0Zze/pNwewmZdi3Agq81vEYK/TUkMkMPCmclNPnGuT1qtoCCRTnCx7
	T412HWpxYwslpmtHBghmWQhL86gA3ssf179rP0UmVpcGAitfYD6kvGeOH4LH8153YNIvUr
	2LdM5yxrIefVJyBEW7LWXW8lA2ysksNvT6w+0zdx89I+ND5+chWa8p1HcjR87NROuavJ/M
	hjmRoLzVDY7kbinRBxe02QD7fb51LMXffelgfq3OnK2bTHnB9KZFHk2gvGly9r5RcKCO9J
	rCOgckBBap5Vzp7DYZm3nH6F+TWy1J3LPLYT+9KFJO2fxcq3EtRkmXz5rQKBAw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [PATCH v2 0/2] doc: clarify review replies and reroll timing
Message-ID: <cover.1781714757.git.wy@wyuan.org>
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

Hi,

This small series updates the 2 documentations: MyFirstContribution and
SubmittingPatches.

The first patch clarifies that review feedback should not be answered
only by sending a new version of the patches, which is talked in [1].
Contributors are encouraged to and should discuss their planned response in
the existing review thread, so that the next version does not become the
only place where reviewers can infer the author's reasoning.

The second patch is originally from an email from Patrick [2], which
documents a rough expectation around reroll frequency.

Patrick suggests: There is no hard rule for when to send a new version,
but batching feedback and avoiding multiple rerolls of the same series
in a single day is a useful default. The text also mentions factors that
may affect this, such as the size of the series, the depth of review,
and whether the topic is close to being picked up.

Since I am the newbie here, please tell me how to attribute the credit
to Patrick. Thank you Patrick!

Please feel free to make comments. Thank you.

[1]: <xmqq7bo5nf31.fsf@gitster.g>
[2]: <aietF4BX1Ewt3cpG@pks.im>

---

Changes in v2:

For [PATCH 1/2] doc: encourage review replies before rerolling:

  - Add "social interactions" in commit message.

I didn't do any changes to this version for Patrick's comments in [a]:

> I feel like the new version doesn't really add anything significant to
> this paragraph that it didn't already say before your patch, but it does
> so with more words.
> I'm of course biased though, so maybe more words help newcomers?

Thinking about whether to delete/revert or not. Comments welcome.

For [PATCH 2/2] doc: advise batching patch rerolls:

  - Add a trailer to thank Patrick.

  Suggestions from Junio:

  - Mention that waiting between rerolls gives reviewers across time
    zones a fair chance to participate.
  - Mention that waiting also encourages authors to polish patches
    before sending them.

[a] <ai_7Wh7hrD8PZozg@pks.im>

---
base commit: 700432b2ba (topic flush before -rc1 (batch 1), 2026-06-15)


Weijie Yuan (2):
  doc: encourage review replies before rerolling
  doc: advise batching patch rerolls

 Documentation/MyFirstContribution.adoc | 32 ++++++++++++++++++++++----
 Documentation/SubmittingPatches        | 22 ++++++++++++++----
 2 files changed, 45 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  b9fa5fe471 ! 1:  4bb1efe71d doc: encourage review replies before rerolling
    @@ Commit message
     
         This makes the author's reasoning explicit before the next version is
         prepared, instead of forcing reviewers to infer it from the rerolled
    -    patches.
    +    patches. It also encourages more direct social interaction between
    +    contributors and helps foster a more collaborative review process.
     
         Signed-off-by: Weijie Yuan <wy@wyuan.org>
     
2:  fafec6b31d ! 2:  496a08c74d doc: advise batching patch rerolls
    @@ Commit message
         Contributors often need guidance on how quickly to send later iterations
         of a patch series. Add a rough default of no more than one new version
         of the same series per day so feedback can be batched and reviewers have
    -    time to comment.
    +    time to comment regardless of their time zones.
     
         Mention factors that can affect the timing, such as series size, review
         depth, substantial rework, and how close the topic is to being accepted.
    +    Also point out that avoiding rapid rerolls encourages authors to polish
    +    each version before sending it, so reviewers can focus on substantial
    +    issues.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Weijie Yuan <wy@wyuan.org>
     
      ## Documentation/MyFirstContribution.adoc ##
    @@ Documentation/MyFirstContribution.adoc: previous one" patches over 2 days), revi
      single polished version came 2 days later instead, and that version with
      fewer mistakes were the only one they would need to review.
      
    -+This consideration applies not only when going from the initial patch to v2, but
    -+also to later iterations of the same series. There is no fixed rule for how long
    -+to wait before sending a new version. A useful default is to send at most one
    -+new version of the same patch series per day. This gives multiple reviewers time
    -+to comment, lets you batch feedback together, and gives you time to think
    -+through the comments you received.
    ++This consideration applies not only when going from the initial patch to v2,
    ++but also to later iterations of the same series. There is no fixed rule for how
    ++long to wait before sending a new version. A useful default is to send at most
    ++one new version of the same patch series per day. This gives multiple reviewers
    ++time to comment, gives reviewers across time zones a fair chance to
    ++participate, lets you batch feedback together, and gives you time to think
    ++through the comments you received. Knowing that you should not immediately send
    ++another version also encourages you to review the patches more carefully before
    ++sending them, catch small mistakes such as typos and off-by-one errors
    ++yourself, and let reviewers spend more of their attention on design,
    ++algorithms, and other substantial issues.
     +
     +The right timing depends on the topic and the feedback. Larger series usually
     +need more review time. If the only comments so far are minor, such as typo
    @@ Documentation/MyFirstContribution.adoc: previous one" patches over 2 days), revi
      === Responding to Reviews
     
      ## Documentation/SubmittingPatches ##
    -@@ Documentation/SubmittingPatches: It is often beneficial to allow some time for reviewers to provide
    +@@ Documentation/SubmittingPatches: area.
    + It is often beneficial to allow some time for reviewers to provide
      feedback before sending a new version, rather than sending an updated
      series immediately after receiving a review. This helps collect broader
    - input and avoids unnecessary churn from many rapid iterations.
    +-input and avoids unnecessary churn from many rapid iterations.
    ++input, gives reviewers in different time zones a fair chance to comment,
    ++and avoids unnecessary churn from many rapid iterations.  Waiting also
    ++encourages you to polish each version before sending it, so reviewers can
    ++focus on substantial issues rather than typos or other small mistakes.
     ++
     +As a rough default, avoid sending more than one new version of the same
     +series per day, while considering the size of the series, the depth of
-- 
2.54.0

