Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A43EB105
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090296; cv=none; b=t1kBA+wcHSe2m0e+KwJ/eGlRyFQvFKVhSKtvFAKRGk8ycc7eknep0KFFrcVvI2wxNKMrebK1s0bnSo7MvlcdxA3lfIDZBMascdqcMWwIyfjzcVg07kLV0GJq6oMj97O6rdZZcgT5NNiZg6rNlsjpmhVw9Qw7rikML8+IFitKHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090296; c=relaxed/simple;
	bh=7NwaZfLZ3f635uDlA00MR1T7/35SFuK+wZ9k9Bx6Jxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b80IQ1sP+9RIPMIYH5clv6p/7LpRDPl2p0p2gi96u1gMvqa2/6JV9pZzxFPMTzgCsExCXFhupNRwfKPi+tug0455WywvR0DrdGqFOYYToUOAtVTLrPmLQliVNgnYJaN4R5DQKI9gU/fM5+d1c8WfWvxADf2n/g9eEQGUpVnEczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=P12Fwq3t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhehytxz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="P12Fwq3t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhehytxz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 05398EC00FD;
	Fri,  3 Jul 2026 10:51:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 10:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783090291; x=
	1783176691; bh=XA6HYGrFzbRLcwH8GTiotzjpEvo0laC2I5rum86AfY8=; b=P
	12Fwq3t93marcF7usg2T7o5UQTkzs5olJTHpmbD/m0Ac1gXP/hNwYu4Gry2HijhJ
	9Yd9uPpFVLHDoU5LJPDCudZs95x8RNUl5WzKEqSrCciqLRSEG5KFvLEbqtP+JssM
	JPlxxS3JilUoazOJ9TdXggVhvHjRStA6+SkwtSESmnxtPAuITCQXNLUvKOX+h3rJ
	a+92aW10biAb111+regYX4O05ouN8cFLmROmruviAdwPe7L7ltT/FZkfy4CE4mEF
	Dp6YZTn/Va+4/Zc0empeuXPDV7kEYn/AtdfAAVw2CyZgbHvTi3j2BO6L2cL5HM1e
	RTmkPTwCAdoA7PcNiHl1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783090291; x=1783176691; bh=X
	A6HYGrFzbRLcwH8GTiotzjpEvo0laC2I5rum86AfY8=; b=lhehytxzdc6wrj1bf
	QKaUlwMSnY+zSot8BpZUCyK7NgYQszvCFkhf48sRu9T51heXa8pISGJLK7Qitv2A
	lT4rpZqswALNJS0aC5IPJ1PrVvX81SH7naNqPfTxAtiFG1Av22OoBqblQv0i+GaT
	cY9TUVb2tQbsqNULp+np5KzlB3ZPaC/miX5xUzUUPIXKhkGoFQ5cqXoQxvMCSQZj
	fYZzbG3KesP0ONelSSjMrWEhd/7L+bK9lqm2uUgS3IYAanLvMtq6OuyA/nTOlMRB
	zQExvhoCLHzTiqd6EhqOIFtidRXVQi3lF2unqTcHJzjN2G1pKGjhmLxugO1Uze4f
	YbZJQ==
X-ME-Sender: <xms:csxHaoUUum85dopwbyhYdgpj90GQBvQsxquZqQwLcO5ly4C5dZT3hg>
    <xme:csxHajn7dGT2d9qP37FLbscgbnCO89VK8q99i74tX0idwZjcUsKb-_aVmWd6GlhvG
    0PhqEldYEwCSqLbCScnN91wOigWpgN0dKesaN4HOiArOo8-R3o80g>
X-ME-Received: <xmr:csxHahY7-lMWetFTC8hPFaiWIF8LtTh5OepVMoQakZztrDTHgGlZCK8HDZwXiIMgE0Med5Fc1JporOjULkWcKBnozBK_pKQsAArtwsxfXOUgEg>
X-ME-Proxy-Cause: dmFkZTE4Hl4khEIXP5PrbsNGrCwW6j5xvadoVIhxYzDMlE9gL3WsUXSe0RY5Fyq8WCYyi6
    YPXxVyJIqB7UJgXgvW2rqNq5X2H0tAqna/AI74HLBsWXYpEAOFxBTWcCGbb102NLJsoPKw
    XRQAh02kJyErwuiQ7vE5jCZLlBZ+LPRjGJh9LDkeYb9PeZVrfVyzjCyRDQEFbOUMIz64n4
    F2vGv9uD3KMgOy8PYQ33JaTlDjWKgsJwu1dN3pxWCAls4siLYKQZG2UgYfxV+v88WuaQDi
    ev7EAcs8kOdVEfJQzb7dVIHWBIeMGQEk8G/zdpkBCkzey0DByTv7CeFaHciMnX3x5wCdf5
    LCmkyAXLbSTumOeqCxbo1cRUh4gpqvoCVqQ90sBM+lwN1gb3wSQOGyVn2l42o4Y7Sp56X+
    mXHUbG6OsqQqpaoPZqfTAPMa0v6W56bJic6nw29CfKyzjo/Ckxl3rQCzDz8dpxfqagcpf2
    Ix2CILb5pgMI3fZ2SEG7c6wuL+gtSfPgPcns+Yo5SeNZLVMg8KC6gzjg7W1jumyqrbxOtL
    RmW0+An8bwtjjHudmrFqyvMdbTktrlJHkcfYiLHi5O8jlAjlVxhbTp19PDmlb4s4Z/Dq4L
    e0i1Da50AMZDaFr3AJOo6NZuVS3jeAttUGfgK+M6+7H9oP3sBgM4p2YWxLjw
X-ME-Proxy: <xmx:csxHamP6CPiVtSB9rjSQep9XU0NB9NGHQXS1atS_i5dltXBZujez-w>
    <xmx:csxHaubDTAeu0SH8gYFGskUrLnF7l76SrU1KRN0om5CDLGEEDjCToA>
    <xmx:csxHas1aTm5egKBR3uyanaYCr608j8hGa3mcDjIlolCXMxa95sd1qQ>
    <xmx:csxHasfq11-aIDE-3GOGtQTVIivVLEgPMF0tnQ1F6ZOpuhr7m-8sbA>
    <xmx:c8xHaoDy8IrlK-JgM7OgnIR6Zy2QG-9BAcTtXqh0dRbdju8llCsXCPw5>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 10:51:29 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH 2/3] doc: document history signing options
Date: Fri,  3 Jul 2026 23:50:36 +0900
Message-ID: <20260703145037.69832-3-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The history manual and usage text should describe the signing controls now
accepted by fixup, reword, and split.

Document -S/--gpg-sign and --no-gpg-sign with the same key-id spelling and
configuration override behavior used by commit-style signing options.

Signed-off-by: Souma <git@5ouma.me>
---
 Documentation/git-history.adoc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2ba8121795..a1dd5c8580 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,9 +8,9 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
-git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
-git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
+git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -109,6 +109,14 @@ OPTIONS
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
+`-S[<key-id>]`::
+`--gpg-sign[=<key-id>]`::
+`--no-gpg-sign`::
+	GPG-sign rewritten commits. The _<key-id>_ argument is optional and
+	defaults to the committer identity; if specified, it must be stuck to
+	the option without a space. `--no-gpg-sign` is useful to countermand
+	both `commit.gpgSign` configuration and earlier `--gpg-sign`.
+
 `--empty=(drop|keep|abort)`::
 	Control what happens when a commit becomes empty as a result of the
 	fixup. This can happen in two situations:
-- 
2.55.0

