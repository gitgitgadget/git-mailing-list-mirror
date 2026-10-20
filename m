Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538569;
	b=TZbQDyt10ZY/SPLHfvyGNjMQ1t09QVdYEQnHe/9LcimbI71ge1ygLoW0MeRxV/eUu8JD
	 7L3+PWEbNZWmg0JUgITQcyUeFakfms5fzooWBvmokKdgmHZX8Xg5kqxgWJhTc0jHhfDLq
	 c73nB4lv6sJwyONt8nvEiFxbUAhrHcK1VPJNVm52dQdX2/5jNMNXths9RdDO7NrSbAs4w
	 DtQ6WTKgQG59Ihu2RabgH4CUo3TAbznVz7URrr0Qte1SdjP1dVwgqepOSrh/18vq8d+wi
	 b30KhVvkPp8Px/rKcxZJAe67NGWcdME9y+GnjTacu6QzM7LCjwmyGkfo9595n9ayKhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538569;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Z+NHeaUXk5rEkatvzirEMkCS16l5jUCu0O7502KJgDo=;
	b=eqrN7TyH1kGDKr0Iiqg88twSecxUOia1aqnBWwn89V8yUmK+AdebiRTjRMoqafxR517s
	 r03VN3o250hhAAmo5f9n2GwzGwhmrnSXOeoEl/GTaSfYKp4oLv7R2cYnK4QI1NfbcPQP7
	 /taHFx3rc6KYvOfu/sQfsNh98LVt354MBKo/tstLkSoOSw/RYDwgT+NHHyQvC00NUw+Un
	 tQx+pCJFRvmRZtcy5NDlPph7sKNvGfhAtKplKRHsizo4YTdetSWg+8lXwHmE/N4FrR3vO
	 ikgxUVRnk6c4RxSYHbh3xOA5fz9QPk+DpdX7oadiVfNDl8wA0IcHdUO0KAlW5Uf2+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lcvqHwSc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qZYoXwzL;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D51606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lcvqHwSc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qZYoXwzL
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E2E0EC00AE
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:22:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 19:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792538568; x=
	1792624968; bh=Z+NHeaUXk5rEkatvzirEMkCS16l5jUCu0O7502KJgDo=; b=l
	cvqHwScQqxdfMi2wmfawRJ2rnbnMTlKjUcvxboVsuAUiUWXBMG7UuXQNRdG5lZx3
	8ZG3MDpqdo+jnepN1iGXCqFJp/1YiAVEzBHOcVP72/+N1oRaa9Scmdf/6XRVlEur
	jPFMfoE77LLqx/h6p3i4uydrrTZlFbSNmEY4KkY1w1Y407weA+gJN/pBMQwPforW
	qcptvHut9FnAZ8T0ji7cEp+e4+DXr9r1QK45DS2vleWl39aeUTU1UXqjdi6dG+SV
	mvHb/KrhWT157ZQTwrQ7WwK3arcRXNzP4+KnyUJyksOFsxCUgdidkKdRTz/4Nzst
	dgiZSxJQYofC0yAJIzY4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792538568; x=1792624968; bh=Z+NHeaUXk5rEkatvzirEMkCS16l5
	jUCu0O7502KJgDo=; b=qZYoXwzLRaKaDj0Khsq2DxH4AEdY/w1rhSDyg5oSNAnX
	0wmwU1Z/cv3GOgtwFeFJA2jxBYGKvpjnk/v2o5r34eH/85ErO3BoC11Vjj3+sUNt
	RtAI36JeKp7S/f+lakQo0KmSm3y388qwwMA8enW7cSKlHwqVn2UHiJKzHkHeFzPe
	MADmVo63VyI/5gw2qZWO8zov/tiGfTiwW2lGD6L1TtHn3LluOE1i3rSYbvkc2kIA
	vJVXYzWu14gbW3bBZQGWDe7EcFgDIRNyShPwADBhHIsbLyJw9xnspRfKqsDHELAY
	ktKG+H2FUKIRFjoWUffwa5Xhmyp1q3ebv4Uvx8yPCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792538568; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DQF7zvjFrD93ZnSmu32ZD9k7qeDRSIozr4eDlQwki77cVDE
	4TMZ9TiEOdnuM59reexLQtZxlHz5jdh81jL7LKjAkvrOtzqS2XD4N3ZIdxLdVhPD
	kd/UP/owJ3QwOEJfMNVU0I7Z4/WQ126C+2YMmFH174ux+URGvnqYOnh+Gz8kgN3g
	5Gy6znqj8qu026+8xdDhcbHQtQz/qrK1u1F9D7ZQYXrimL3DpYXAwtKGVHhdw7Pk
	ILeiXFbe8/6srRXB3JwLEtK9gMFrqI5yyXmLigP5RNxNWYUiwUo4pFPQBLz+Ux2B
	hoteiJvWEChxr+f6KbjTwDMv/8ZALQYhPM6oVFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+l6ieoEOMNDLK2Gf00kuV/1hoQAG9kZCwFV8D5ExWdY=:Q8RRI6rXdrHnyxOeNS6/l+NiaAA0BBsZSJYFN6KWW5A=;
X-ME-Sender: <xms:yPfXajHSRxDyuD3MfAZlZx4h9oq_Drju5iKSIbbOAI7_7BytN3n9rg>
    <xme:yPfXamUkLJGGGBXv4YvF8cnOwGgZXdAfGFDu-NtmsU_lwAOMUA6zfCtZLt1fZY48p
    6JZnrxHbdD5YsYAaX7PH2oHuodsH07cxXt3f_92zyLWesfUP6LD5ik>
X-ME-Received: <xmr:yPfXaiwz48-1x1RmsjPs7hn5urxI-PluyW6SQNI5jD_8OEjUqsbqaEMpI3Nnf7S2Gd8OZspykwp9MDNcaL1I2qFElPzb9Ot1p6QI>
X-ME-Proxy-Cause: dmFkZTGS9G+VbDQyqWJeggG+U0P5jfalRw0s4wlbKvT3RtC3E/6ZBwWEl0kpGEoRHF9Nrc
    Rq/XjmVdqnvl41AuRFF/6aABozBQNR8s3c/acq06upR9GIi+O1wOadSXeyTMCxhafeKN5x
    ZKFZ+xXQwHTYOxKiMwf9Kn+ryaHcq4cPATLWYfYwaClhS/vjPI9CcJ6BPFv1SYhdljGfoB
    8ZxWBx7zuXwvUvkygCCiFLJ0KKVaP41FAX8DJjcSgtRMiKFF418S81O8suFQM8uGN9eWFC
    Z+4fZyFJ54SeOT6mRlfhhoFKingjsc/L6LNTyY5bSmgDINDsYSk4qQHnhP7WZehH26xQhH
    zCckcDvxet6WhuyPT0i7wUHiPbMIU4PjF96zYci97Zotzk/PS1CLhiNrU2lkSSbrLoiXhr
    a3YWhFUjbbkqWVbnq1JMGHQPASpD57hND+bbodnfpzDDwblMQ/H0vGp4gqFWBIttWCvqjz
    31gYTMGRLzAQE1AjM9+U0vB3PZumY5RCRhSyuV3Qd0KQ8ZLorASzgtZoNh6WkVBBD2In2z
    M9D3yZ2dRCEOZpN002C3oZ0FYT+4rLpz+XmQbo/dZoe2CbF4rpZga7TMgdIuHmsgk/KJha
    kzJjXE6VRRP7Zt66In6h0QOG9RSUNiJDwRuEHSO/eY747693m4NLPgGk7SZA
X-ME-Proxy: <xmx:yPfXasOaICB7EpXAemSJ08x667HrYvv5FRs5Xa3S3S1bwDi4PfJ5Nw>
    <xmx:yPfXar6Ud6h2dhYQ39HxjCqH_1-M3g0QQs-KwF9lh9k8-zrC0Cjf5A>
    <xmx:yPfXalP0TKsxQvKbm3MVymwzqxvll9mSWQ7NlCjSTSe5spzA_vpbYw>
    <xmx:yPfXahlMXyULfW-3NZvLHMAoL-YXl0co4w9Tl5dFivztUFm3dcAMwg>
    <xmx:yPfXaufMTrgwmAgl6zVtisKkmgxqvNC9KFwikfPcJ5mQLGZLZxjE5ico>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 19:22:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/2] MyFirstContribution: clarify that "reviewing" is a discussion
Date: Tue, 20 Oct 2026 16:22:42 -0700
Message-ID: <20261020232242.2217109-3-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-321-g29a826976d
In-Reply-To: <20261020232242.2217109-1-gitster@pobox.com>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261020232242.2217109-1-gitster@pobox.com>
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

The latter half of the "We sent our initial patch.  Now what?"
section largely duplicates the discussion on what to do after
getting a review, which is covered in the subsequent section.  Also,
the "Reviewing" section does not make it clear from the beginning
that reviewing is a process of discussion with your reviewers.

Rewrite the "Reviewing" section with stronger language to discourage
sending a 'v2' iteration before working together with the reviewers
to prepare for it.  In particular, replace the weak "it is a good
manners to do so" with a firmer "do not send v2 before you are
done."

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 78 +++++++++++---------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 682c797e3c..3fd6587e5a 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1314,56 +1314,42 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
 single polished version came 2 days later instead, and that version with
 fewer mistakes were the only one they would need to review.
 
-This consideration applies not only when going from the initial patch to v2,
-but also to later iterations of the same series. There is no fixed rule for how
-long to wait before sending a new version. A useful default is to send at most
-one new version of the same patch series per day. This gives multiple reviewers
-time to comment, gives reviewers across time zones a fair chance to
-participate, lets you batch feedback together, and gives you time to think
-through the comments you received. Knowing that you should not immediately send
-another version also encourages you to review the patches more carefully before
-sending them, catch small mistakes such as typos and off-by-one errors
-yourself, and let reviewers spend more of their attention on design,
-algorithms, and other substantial issues.
-
-The right timing depends on the topic and the feedback. Larger series usually
-need more review time. If the only comments so far are minor, such as typo
-fixes, it often makes sense to wait a little longer in case deeper reviews are
-still coming. If the comments call for substantial rework, do not rush out an
-updated version before you have reviewed the larger changes carefully. Instead,
-reply to the review that prompted the rewrite, say that you are preparing a
-substantial rework, and mention which parts of the current series will become
-obsolete so reviewers can avoid spending time on them until the updated series
-is ready.
-
 
 [[reviewing]]
 === Responding to Reviews
 
-After a few days, you will hopefully receive a reply to your patchset with some
-comments. Woohoo! Now you can get back to work.
-
-It's good manners to reply to each comment in the mailing list discussion
-instead of letting the next version of your patch be your only response. Tell
-the reviewer whether you plan to make the suggested change, keep the original,
-or pursue a different approach. This way reviewers can respond to your reasoning
-before you spend time preparing a version they may not agree with, and later do
-not need to inspect your v2 to figure out whether you implemented their comment
-or not.
-
-Reviewers may ask you about what you wrote in the patchset, either in
-the proposed commit log message or in the changes themselves.  You
-should answer these questions in your response messages, but often the
-reason why reviewers asked these questions to understand what you meant
-to write is because your patchset needed clarification to be understood.
-
-Do not be satisfied by just answering their questions in your response
-and hear them say that they now understand what you wanted to say.
-Update your patches to clarify the points reviewers had trouble with,
-and prepare your v2; the words you used to explain your v1 to answer
-reviewers' questions may be useful thing to use.  Your goal is to make
-your v2 clear enough so that it becomes unnecessary for you to give the
-same explanation to the next person who reads it.
+After a few days, you will hopefully receive a reply to your patch
+series with some comments.  Carefully read them to understand the
+reviewers' perspective.  Do not hesitate to ask for clarification if
+you do not understand their suggestions.
+
+Reviewers may also ask about what you wrote in the patch series,
+either in the proposed commit log message or in the changes
+themselves.  Answer these questions in your response.  Often,
+reviewers ask because your patch series needs clarification to be
+understood; use this as feedback to improve the clarity of your
+writing.  When answering, remember to update the patch itself so that
+the next reader will not need to ask the same question.
+
+Do not start coding, much less send the next version of your patch,
+until you have finished discussing the current round of reviews with
+your reviewers.  This saves time for both you and your reviewers.
+They can respond to your reasoning before you spend time preparing a
+version they might reject, and they will not have to inspect your 'v2'
+to check if you addressed their concerns.
+
+Do not iterate too quickly.  Limiting yourself to at most one
+iteration of the same patch series per day is good practice; it takes
+time to fully discuss the current version before working on the next.
+This allows multiple reviewers to comment, gives participants in
+different time zones a fair chance to participate, lets you batch
+feedback, and gives you time to digest comments before coding again.
+
+Knowing that you cannot immediately send another version encourages
+you to review your patches more carefully before sending.  You can
+catch small mistakes like typos and off-by-one errors yourself,
+allowing reviewers to focus on design, algorithms, and other
+substantive issues.
 
 If you are going to push back on a comment, be polite and explain why you feel
 your original is better; be prepared that the reviewer may still disagree with
-- 
2.56.0-321-g29a826976d

