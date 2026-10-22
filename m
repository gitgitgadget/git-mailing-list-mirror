Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703647;
	b=5Jx3JlO8/xI8sdWifB3azbBdASP6Twa9SwxOJTvZmb1Ay2Mjh7LlveCw/ZmSZT/H8Z1X
	 9tugW+M0+Hl5i3G5NYjraTdd5bxsOx4ZBnilgfis1sUNnNjNmqMk5oX7MoQA2IVkcydkV
	 qA/YXbLYJV0KFK7SY6hNlOxWoBAzXBJTbYx/X4Wgc6veQY6/zF+GhHbbDJTUxpxIpMfzK
	 eWcArlGhmNQXSYDyj3Dgli/mRvKGFd+oH4Ir6WYq92RXg8OGXjFEK5cEn3ahGx1JdROSW
	 vWAQf1Nw06/YvR02cTZeGSynwktn8yoIQta+5PyLNPzPgKOeyfOHZquB5jhqIwiOmnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703647;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=/XDyjioGrzVVaMvYl8qGlliYNVh4yfsrhyCWGYIlCK4=;
	b=EdtndlyI9htqGmZDOyI7OUYi/B4MQjCGsqG4WMlAd/r+ztTUzYZSfnKdOvkva+OH956C
	 iJCEH6+J5izW84e/zr9WbzOXkWb8CooieFCjEv7T2dJ1SAxqdClvuHhy41Sah86siTsdw
	 le126XTFaJ+NJw2QtCk13z+k1KBKAZ2skV4e2Nw+mLMldO+JgOeatmfnNUDV4Hp9jnLfT
	 7cmI7sSoi+89Bu1uUbxO7ZaRxVwIwYDXUeze3+CxK95Uvim9U/8s++34ZE5a5kxKqXTe3
	 jcUrmyOxQLoFWKMvRcsIcOypn6H6t0QP19cmoeovOzMkQRe16vB/U0ZC1ARhxmXqHtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=W73Ym8d5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Xs5i9+Ya;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8F606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC8F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=W73Ym8d5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Xs5i9+Ya
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 92E591D001E7
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:14:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 17:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792703646; x=
	1792790046; bh=/XDyjioGrzVVaMvYl8qGlliYNVh4yfsrhyCWGYIlCK4=; b=W
	73Ym8d5aQgtJmKCecPRIp7gPObljyErFeaafEoX1tp7qfYeIoVkb8kSEbeQiR5lV
	rY82PM6zhTLN55FJvzl8Quj2qw9oDhsVFNpETOnNd7736f9JXM1OaybJqb9hJ1Ct
	Y7KYNbkC7oz8e4G5wzBakPGjatQ1D6X/2gREDhLDuw+scL1chA/JP2PNSvYXBCmF
	wLDsgrFjx0YCtRqqX8dhP6L4A16Z3z3WqS0b48IxwjJXO41/Rm/yzV13I0VcwmuM
	2oWDG+whqc39RplewYqNosZdBtegIX968sSbY2R3DO86wHFI0MJfLPqNwoDTSqpt
	qoKUtHpehAmP0i1QVUcHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792703646; x=1792790046; bh=/XDyjioGrzVVaMvYl8qGlliYNVh4
	yfsrhyCWGYIlCK4=; b=Xs5i9+YaciyEAzjxRl0bvCmiI2DERACdPIaILHFiTI0O
	IT6nK+9uH0gC2/V0Fm81wc08SzMlZf7UZcbO9tWUnN4+LRjl5woUs2WKMwnVqvuo
	/W4OT4+7Bxbpu/1P5ymqksdtxDwAiXaDwQq1BUCzJd4LSdBBit+9bWgxY3eQbZKb
	zBouGSAmB+1MmjBfph+FHjgSHGcwhmG1eFDxjWJrmLV7D6/2as9TrgjENcUBv2Z4
	6dpXgY+Va2N2KUttInUUK/HzBwk7mz9Y1zWeVNtHfCHjcJMCvwOD/PQP4Z5SUoMu
	bIt/+3E1VVM6l9A2PA/0AuTYoxRxV4zgUjDryiT8Kg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792703646; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ntwNJlkFGkU4AQsN/VTkWvl+jFKGY43GTnVqIbKt4BGY+yn
	kuH90wmTjo4cHQN+cp2vc389U17soYAz50M934fRx571+MAp9Qgm2NuyIDTSnFGJ
	IEH8GC4u+PGUZi0e/jBqG6r5i8QDyeyspfYpv4eZYjn1Z4AclhTMljFjrzQZiCJv
	xk+VKSWiy5vuCRXSp2IWDITsXp8cFUe59e4j4+rxEONjoAvoa8nubQ/0lKemvUl3
	977PNieDDA+sbpTjxUvMrMBMSaqRIC4Q4phksNgAo1qvFopClnACTblL/ckQT4tF
	mJ9a8RpIW4bCpjtmOI1/4EQPA/ciPdv/Y5dvgMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1uKcqc9/TxmSitQ25LqDcgN4ig0HbhbScO5hXqFvCdQ=:ve/Bg/8ujLqqNDJrTq+wpwDcI0SOVJPpeCYhi0n2yrc=;
X-ME-Sender: <xms:nnzaat1ZnskpYUA_iCURpRPKDE7tioIdkFp8GQiH3cTAjgQa4Z5PWw>
    <xme:nnzaaqFweHN_eEPTkSZGggxqB2oK5Cxq7CBjITvHYHgCuQpNZjjt9GweNjN0fidYE
    Ju4uNWwMU3Bd7clsFwhSzmMjvjXri0yYLTDVjPRsQf3pdx4QwTym5E>
X-ME-Received: <xmr:nnzaariQLQaU48Zo5YcWxx91iLlSCcsChzDy4e0_cYLNQrIHnCnKuXGpa8lJgWSeRHQ5FOv4mCWlqbgHSMd5VXFKu9zh58lscjuW>
X-ME-Proxy-Cause: dmFkZTF/3Bs04/HANI0CNNG0VP2RXfSM0a6jTTXzysdFsv+jrOJgch+dlGrAahKkpu4aBo
    8VMh7sej5BfPgHu5WIRtTZnu9m7pUGApFF/ctO0aLcPqFhve+17dnqndW7RK3yYtDMhxCJ
    F4de3EV/IvfscYzbVIqyX2KyPivE1rurMmzPyCyC3fYhxleXc8ObltknQh6ch2f1l9tw/c
    5nwcIf/kFde2py7Le9Y43gljkcngUUDQJHHNPQsI4xSLj572o1uhwZ7u4LZP4BA9l1MO4N
    wl4pgJZUmRwsMBMnNTQJEw1CzNaiVYCrwDvI7q7yymoif+mYyZXCJtXGi7WHMq8e25oFLY
    PMfHCwfZbO9ikNKqXC0HuBThF85ix/PNgQtm2X2+9MX//87whAi8UuEIAGXosETJPMLOg1
    jlP/LKN2crQ2ipHUhoQ8ioLy4hDSnVYxv+Hw18Te0ecrfkIgle1Ij6/ijiHybx/AMHbwtG
    AAPvLHg3YUawPzHIqzgYQwGtVft6mFkTyrzKFoJmShkhisaZ0g6H76uy/pLroSg3aDjMJg
    Ou305S+VRVT3n2OuA4bZ6VvBusOaXxGz+l/AQYdpCCn+j2pItAlYFvYxHT2Ct6hDjmOKb6
    X1w9Etb0xO/7O3+RHr7VxgvqubA49iFehmI58Svy++y177g97XBKWAz34NBQ
X-ME-Proxy: <xmx:nnzaal835rKN6gdI0G2NzCiXYeycI_Hv6r_LHr0kd-CuJJe336WQ5A>
    <xmx:nnzaaiprH1kCbCEJI-FaAwA6rv9-xorYYi1F_J1Rz-aiaAfoghmX0w>
    <xmx:nnzaak9I-AD3C0nle621Kud2Bl4hvt6Dqfmx8_bjTmj-epfvZbUudw>
    <xmx:nnzaamV2FoGJCsNVs2FrOz7mboEQHR4M-HVMRUJ7gHvQvR5CRWfGBw>
    <xmx:nnzaapOavjHgR5ke_jW3_eB7EmSUOMeU_BBNDPKz1VId97_cYoIGyf6n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 17:14:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 0/2] MyFirstContribution: discuss then reroll
Date: Thu, 22 Oct 2026 14:14:02 -0700
Message-ID: <20261022211404.380904-1-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-336-g6ca398b529
In-Reply-To: <xmqqa4o94e0r.fsf@gitster.g>
References: <xmqqa4o94e0r.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MyFirstContribution document tells readers how to send v1, how
to send v2, and then how to respond to reviews, in that order.  It
uses a fairly weak language "it is a good manners to ..." to respond
to reviews before rerolling.

On the mailing list, we find ourselves more and more frequently
having to tell new contributors not to send updated iterations of
their patches before having any review discussion on the current
iteration.

Here is an attempt to rectify the situation.

The first patch reorders the sections to explain how to send v1, how
to respond to reviews, before explaining how to send v2.

The second patch rewrites the "how to respond to reviews" section to
strengthen the "it is a good manners" by replacing it with "do not
send v2 before you have finished discussing v1".

Relative to v3, this rewrites the "responding to reviews" section
more tightly, shaving about 1/5 words, without losing substance.

Hopefully this will be the final iteration of this series.

 1/2: MyFirstContribution: move "how to send v2" after discussing reviews
 2/2: MyFirstContribution: clarify that "reviewing" is a discussion

 Documentation/MyFirstContribution.adoc | 273 +++++++++++--------------
 1 file changed, 125 insertions(+), 148 deletions(-)

Range-diff against v3:
1:  e6f4a2a7ca = 1:  9db8ec4b98 MyFirstContribution: move "how to send v2" after discussing reviews
2:  27f47d7d65 ! 2:  88abda272c MyFirstContribution: clarify that "reviewing" is a discussion
    @@ Commit message
         section largely duplicates the discussion on what to do after
         getting a review, which is covered in the subsequent section.  Also,
         the "Reviewing" section does not make it clear from the beginning
    -    that reviewing is a process of discussion with your reviewers to design
    -    what the next iteration should look like.
    +    that reviewing is a process of discussion with your reviewers.
     
         Rewrite the "Reviewing" section with stronger language to discourage
         sending a 'v2' iteration before working together with the reviewers
    @@ Documentation/MyFirstContribution.adoc: previous one" patches over 2 days), revi
     -reviewers' questions may be useful thing to use.  Your goal is to make
     -your v2 clear enough so that it becomes unnecessary for you to give the
     -same explanation to the next person who reads it.
    -+After a few days, you will hopefully receive a reply to your patch
    -+series with some comments.  Carefully read them to understand the
    -+reviewers' perspective.  Do not hesitate to ask for clarification if
    -+you do not understand their suggestions.
    ++After a few days, you may receive comments on your patch series.
    ++Carefully read them to understand the reviewers' perspective, and do
    ++not hesitate to ask for clarification.
     +
    -+Reviewers may also ask about what you wrote in the patch series,
    -+either in the proposed commit log message or in the changes
    -+themselves.  Answer these questions in your response.  Often,
    -+reviewers ask because your patch series needs clarification to be
    -+understood; use this as feedback to improve the clarity of your
    -+writing.  When answering, remember to update the patch itself so that
    -+the next reader will not need to ask the same question.
    ++Reviewers may also ask about your proposed commit log or the changes.
    ++Answer these in your response.  They often ask because the patch needs
    ++clarification; use this feedback to improve your writing, and update
    ++the patch so the next reader does not have to ask the same question.
     +
    -+Do not start coding, let alone send the next version of your patch,
    -+until you have finished discussing the current one so both sides know
    -+what to expect.  This saves time for everyone.  Reviewers can respond
    -+to your explanation before you spend time preparing a patch they might
    -+reject, and they will not have to inspect 'v2' only to find their
    ++Do not start coding, much less send the next version, until you finish
    ++discussing the current one and both sides know what to expect.  This
    ++saves time, lets reviewers respond before you write a patch they have
    ++to reject, and avoids forcing them to inspect 'v2' only to find their
     +concerns unaddressed.
     +
    -+Do not iterate too quickly.  Limiting yourself to at most one
    -+iteration of the same patch series per day is good practice; it takes
    -+time to fully discuss the current version before working on the next.
    -+This allows multiple reviewers to comment, gives participants in
    -+different time zones a fair chance to participate, lets you batch
    -+feedback, and gives you time to digest comments before coding again.
    ++Do not iterate too quickly; at most one iteration per day is good
    ++practice.  This allows multiple reviewers to comment, gives
    ++participants in different time zones a fair chance, lets you batch
    ++feedback, and gives you time to digest comments before coding.
     +
    -+Knowing that you cannot immediately send another version encourages
    -+you to review your patches more carefully before sending.  You can
    -+catch small mistakes like typos and off-by-one errors yourself,
    -+allowing reviewers to focus on design, algorithms, and other
    -+substantive issues.
    ++Knowing you cannot immediately send another version encourages careful
    ++self-review, letting you catch small mistakes yourself so reviewers
    ++can focus on design and other substantive issues.
      
      If you are going to push back on a comment, be polite and explain why you feel
      your original is better; be prepared that the reviewer may still disagree with
-- 
2.56.0-336-g6ca398b529

