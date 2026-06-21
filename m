Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4641C72
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029103; cv=none; b=bgqb+Rzf/5KGvOrITbGEU3aw60+7/cqYPA2oYfGj01JIJB66r6neNJ1ddr8nfNMP/A/9ResM8oyoibEChlFLCrAWsvDQAp8KThiBXTPdufOzMrzWyEEYs+gp1p9XN+NSii1p4lhoPYYHiF3Cs2lO1/Jhz7Vh2aYvicGxmEupPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029103; c=relaxed/simple;
	bh=XGw7ow3eCb0IcVq24egJLKI0BOU6eSoeYWYwYZt9poM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fkymsfggq2Mq7hq9jn+nI1Ilnl8GtN8QvfuWwEh1m/Y1kT/uThhN1hSHiwWmZ/RVNlAkF81SLH9UIDBdfskmW4pepOtenO+KNQAEnsGZq6V+GXkQpApyQodQ6lyqXLX6Y/aUA6Mdly0s27vklIpAyzn8J7kFShLSl6cbkIhDdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=cZuyI/KR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="cZuyI/KR"
Date: Sun, 21 Jun 2026 16:04:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1782029099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjESgfX67PzwWmw5GH+yY7pkpKduFHWhBhRcTLb1OXw=;
	b=cZuyI/KR0FfdddlsSLwUj1XjHORwVgivl6wd+LYos6VokDPh3aDpOrybg0G20XdL5Aq36C
	OGYg7GjJgB/Hf/kCLKlDS1iN+XunGGeHg4pIDuA3gOPbNm2Cr4JT3qMKKx27NQe49jGLiN
	zTf0t7lnIYZSaA6yFHg+Z4fd1Z7xuhfkqXEAA29sJgJ/3W+ozIzAGXIhwJHBPSLPrNP+OY
	CCNIAmWaerAuJ4ve+xWCp3Q1PhVjscm/T5RIsspOMr+ebD56chtAzNc+dxDwhPPk7X+U3X
	w9yPyMyfVTyV9SkfM59k/boMTcW4HU/oect6Cs44l2Rp0Csq+VDBX5GnwoFdTg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [PATCH v3 0/2] doc: clarify review replies and reroll timing
Message-ID: <cover.1782028813.git.wy@wyuan.org>
References: <cover.1781714757.git.wy@wyuan.org>
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
(Edit: the last point is discussed by Junio[3], which is improved in v3)

Since I am the newbie here, please tell me how to attribute the credit
to Patrick. Thank you Patrick!
(Edit: finished with the Helped-by trailer in v2)

[1]: <xmqq7bo5nf31.fsf@gitster.g>
[2]: <aietF4BX1Ewt3cpG@pks.im>
[3]: <xmqq4ij1vywy.fsf@gitster.g>

---
Changes in v3:

  - Reworked the substantial-rework case.  Instead of suggesting that
    authors send a new version sooner, the text now advises authors not
    to rush out an updated version before reviewing the larger changes
    carefully.  It recommends replying to the review that prompted the
    rewrite, saying that a substantial rework is planned, and pointing
    out which parts of the current series will become obsolete.

  - Dropped the advice that a topic close to being accepted may justify
    a quicker reroll.

  - Removed "how close the topic is to being accepted" from the short
    reroll-timing guidance in Documentation/SubmittingPatches.

  - Updated the commit message of patch 2 accordingly.


Changes in v2:

For [PATCH 1/2] doc: encourage review replies before rerolling:

  - Add "social interactions" in commit message.

  I didn't do any changes for Patrick's comments in [a]:

  > I feel like the new version doesn't really add anything significant
  > to this paragraph that it didn't already say before your patch, but
  > it does so with more words.
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

 Documentation/MyFirstContribution.adoc | 34 ++++++++++++++++++++++----
 Documentation/SubmittingPatches        | 23 ++++++++++++++---
 2 files changed, 48 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  4bb1efe71d = 1:  4bb1efe71d doc: encourage review replies before rerolling
2:  496a08c74d ! 2:  e1050a6ef5 doc: advise batching patch rerolls
    @@ Commit message
         time to comment regardless of their time zones.
     
         Mention factors that can affect the timing, such as series size, review
    -    depth, substantial rework, and how close the topic is to being accepted.
    -    Also point out that avoiding rapid rerolls encourages authors to polish
    -    each version before sending it, so reviewers can focus on substantial
    -    issues.
    +    depth, and substantial rework. Also point out that avoiding rapid
    +    rerolls encourages authors to polish each version before sending it, so
    +    reviewers can focus on substantial issues.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Weijie Yuan <wy@wyuan.org>
    @@ Documentation/MyFirstContribution.adoc: previous one" patches over 2 days), revi
     +The right timing depends on the topic and the feedback. Larger series usually
     +need more review time. If the only comments so far are minor, such as typo
     +fixes, it often makes sense to wait a little longer in case deeper reviews are
    -+still coming. If the comments require substantial rework, sending a new version
    -+sooner may save reviewers from spending time on a version you already know will
    -+change significantly. If the topic is close to being accepted and the remaining
    -+comments are small, a quicker new version may also be fine.
    ++still coming. If the comments call for substantial rework, do not rush out an
    ++updated version before you have reviewed the larger changes carefully. Instead,
    ++reply to the review that prompted the rewrite, say that you are preparing a
    ++substantial rework, and mention which parts of the current series will become
    ++obsolete so reviewers can avoid spending time on them until the updated series
    ++is ready.
     +
      
      [[reviewing]]
    @@ Documentation/SubmittingPatches: area.
     -input and avoids unnecessary churn from many rapid iterations.
     +input, gives reviewers in different time zones a fair chance to comment,
     +and avoids unnecessary churn from many rapid iterations.  Waiting also
    -+encourages you to polish each version before sending it, so reviewers can
    -+focus on substantial issues rather than typos or other small mistakes.
    ++encourages you to polish each version before sending it, so reviewers
    ++can focus on substantial issues rather than typos or other small
    ++mistakes. (only changes textwidth here)
     ++
     +As a rough default, avoid sending more than one new version of the same
    -+series per day, while considering the size of the series, the depth of
    -+review, and how close the topic is to being accepted.
    ++series per day, while considering the size of the series and the depth
    ++of review.
      
      . These early update iterations are expected to be full replacements,
        not incremental updates on top of what you posted already.  If you
-- 
2.54.0

