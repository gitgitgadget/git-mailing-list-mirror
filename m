Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703651;
	b=0pZ3xBg1/PlKlnyOo2yep9fWVczBe3Qp/VY7WoHS7IbWm2BisOeGfktpawitXsNJxyB0
	 2bIGjilTD3XgTZ2uOH3Eze0Hz2WvDKItfnKTBqjMQSgrVdhMkcbF75zni+A2pMYa+vDsR
	 AnJgNpSe+uH5/EOgMsuWp+oD40CPYLfiS/p+z3ovi8WpJl+hP+ROq6cVOnGrdCcaISib0
	 opIAO4DJgpYY2weaGDJfxkqnL/VI8pP/O7ujs2YbmlrO2vr67cQbSvEmfHhrCGyEf2G9z
	 VwVpndUZzZlb1t3RinqpoD9xMt/Gz6V8rf/v1f4+9AnXPS2wJjrmlyKEBbYpSr1d9cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703651;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=br6JAQzNoWvl56LWMtlWtVAqhLHHaVGcVUyV4e6W80Q=;
	b=F/ljs9NxP0XJFyYk9Hwq4vm2SbNOby5rJUZr2FAjCPtPGpLDq6CoYKMT+7kwbz/jRuEy
	 i6ibJX5RO9C8Niagqy6rFRPDIlDWNdKz51sv2BR4eSy4nFt6sCgSJdgF9UBmJMLlp4Pcv
	 0j3+2DuZWHC+DLH8eRMlVG6IqpvT4DKod1uZwSx3Ne8hzK9iGXwkP35Iqc3BIFUwZc0Yy
	 4eygiJjwUhMLZVM4WnqIlfxeUmv6rSyRQULgxs308+5DqTuNSyLD1SiV+OjWlB3zCxjfh
	 X9prK24iPqsv5Y9e4jy9QRONRICZzE7wmSp1b7xZxVwSWE8BcXGrgkfkBThED/zd9ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UZPpGGuL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yUL0rFLv;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEA606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6EEA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UZPpGGuL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yUL0rFLv
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 51D641D001E8
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:14:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 22 Oct 2026 17:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1792703650; x=
	1792790050; bh=br6JAQzNoWvl56LWMtlWtVAqhLHHaVGcVUyV4e6W80Q=; b=U
	ZPpGGuLUfNS4DiSYCXDtpLCJgcYbWS0umRgapkiNQH1MbnfBe3JvVPVf0q0HmpKq
	w9xAl63imEa/H/xu54VHPMccVBiHCOQUo74dYnfiEBrt+42Z6vM1bvh5gLYu1AqX
	L2ttu35MvnvppMxoaNH0k8JEzzKyMiVk76sPzD1HL4ghTk4KLyPS3zf3hPECDqeq
	2JRYjR6KHJdaZigxtiJA5KYikBVDGbYFgiIyzmbx9gfrKunFNmxCn71EydsYWzZu
	CwS6DmqWXORF13927JCRYj1i+byRuOj+xJUTcoEu7d2h46n9WZY1sWv/aVIS6BfY
	WIr3botiXlGpPEvtnuTIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792703650; x=1792790050; bh=br6JAQzNoWvl56LWMtlWtVAqhLHH
	aVGcVUyV4e6W80Q=; b=yUL0rFLvnHjxQsHjNlHPkArm1Eaj6YCS8DQtqexw+pHj
	MLz1XYyNsRbuHU4rtu5z9NeA5FwfHy56QPx5sGFYml1T+1InBHPGZy/XMafTSGzm
	8dvg3j+wmta4yz5PDOn+yn6GPFrEfNqn5bNAzlz4xgAKOhs7kUwT55zL/LFX++ON
	bxPJqv5CUC7CQJGZWdIk8l5l/KHZtS8bhOKRTHEoLyYL2cXTMfFJ/d/NMEmpurvQ
	Ewv+UVzR8GJ93ogNx4y8lvJbcnu0xSk+nq8A76stDdmFBmxQXDP9MaxGzvrvZjgN
	MW3PQeG0O2E6r4LAJJG+ef/zGjLbl/OwfrcFIi83Lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792703650; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VKIG7j9epXR6W1B/OjFgJMrGDCdF7cG27SjQPwF7X+B/xQ9
	nC1YmIgN68xrn2vohGk+VdrkCZDY8vlT89sb9incKdr+YJhaCIAJTP4sy7guQS+n
	DdI4vK3hkVfJNU/RwlSsaO7fOpRRo2U3JH6HXKm3ycKGyLooNRSX6Jya2/i+pMYE
	yMhtHW+4RlJrd11KnqAKLc1zRkjnKwg0D3e5nMMmR2YxM4J7KpX9/9l//zFRkegt
	aPXmhRbtXTumIqEHcg8WLNWpCxV6P+GSJajNoSCcI8Y+dwrk6P9c17/w9eVPryvu
	JrfLfChWAxnB3/c+zK40aQfhsxeuhbH7yVg0DrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lsPgMUWJtPH2KtSKqmEeKgqolChGGBWjCf+BJU9VauY=:LmycW+gOvuPlUJx/ddz3BSt7qWiVbjWu2Vd+BCXfM+Q=;
X-ME-Sender: <xms:onzaamJSvps0_dHbdlLGjL_1pQO86NEhPEN7tc86oRSNLwXfwaz65A>
    <xme:onzaakK_-BTq0A9E8utuEkQA6fM3hhFtyzGIGKYLrT7EV-_rOGms4UwSVaWhA_5VV
    1sjYc4feoY1aM2ca5nIREP1VPcaA8oB6w_UiX9JiVnMt1sMbW-ZmQ>
X-ME-Received: <xmr:onzaakWx3yqw9Q7tNFk1xjdcVHyvFkILMp-EnjbPs4WSYMNINggytKBSB4OYM2RlcSjWLq6dvsHyNOZDLp2WDd3Iwc6PGW69cnVP>
X-ME-Proxy-Cause: dmFkZTF/3Bs04/HANI0CNNG0VP2RXfSM0a6jTTXzysdFsv+jrOJgch+dlGrAahKkpu4aBo
    8VMh7sej5BfPgHu5WIRtTZnu9m7pUGApFF/ctO0aLcPqFhve+17dnqndW7RK3yYtDMhxCJ
    F4de3EV/IvfscYzbVIqyX2KyPivE1rurMmzPyCyC3fYhxleXc8ObltknQh6ch2f1l9tw/c
    5nwcIf/kFde2py7Le9Y43gljkcngUUDQJHHNPQsI4xSLj572o1uhwZ7u4LZP4BA9l1MO4N
    wl4pgJZUmRwsMBMnNTQJEw1CzNaiVYCrwDvI7q7yymoif+mYyZXCJtXGi7WHMq8e25oFAZ
    Q2v8o8KBETTGIx41KCpsW/DPM7Kt66egb0BLvWCUohZ/CRa/8tkvWVPtmC3ipCdcmHUkIc
    ak+QVPPYUzYSDRcMJYTQwfhZttUyzIIdUHTOaOIG+SGeqm8xCeQ9R6MmGN9iSJJsjWKiTb
    cuC51dojxeHupC15Ye6KxxAGjZ8Wa/fG9KFNNnBq8xViJUF13Kw098waoeVFP4OQ3QETHy
    I9w/kgHnMLUQtRpmdfOR/LU3NOzxZWREk/Jdzw//Lm7AbZOoxCvSxzY5NcUt+3De2bbPUs
    DniSUYASlRkxhN7YrFec3u4AwTPdG7QEEDZzcKQEAW/1FFoEYSROZQb97TmA
X-ME-Proxy: <xmx:onzaamjB-KPMfVzIydq7KAqW3AwF0oiDYh0sfdLdN7nKsjOo4IlM0w>
    <xmx:onzaav9GVLSTxNTX1CrQogA8_bqR8JVzwxKVRdjuVJFil0oxW-X0EQ>
    <xmx:onzaagBAV7JUZeFkPOFygh-qDYRxC_fVlaRHzFL7FpScBd5lKyNydw>
    <xmx:onzaasLyOi4EApnona1cfyMBRoxMeZo7abFTHAVeNOeJF688UhGAmg>
    <xmx:onzaapg5Zpimxd4eYf3AWXhfoW1r9ChOn0XjQpLZnXm6iV8FsH6GZmBL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 17:14:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 2/2] MyFirstContribution: clarify that "reviewing" is a discussion
Date: Thu, 22 Oct 2026 14:14:04 -0700
Message-ID: <20261022211404.380904-3-gitster@pobox.com>
X-Mailer: git-send-email 2.56.0-336-g6ca398b529
In-Reply-To: <20261022211404.380904-1-gitster@pobox.com>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261022211404.380904-1-gitster@pobox.com>
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
 Documentation/MyFirstContribution.adoc | 69 +++++++++-----------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 682c797e3c..c58253fd54 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1314,56 +1314,33 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
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
+After a few days, you may receive comments on your patch series.
+Carefully read them to understand the reviewers' perspective, and do
+not hesitate to ask for clarification.
+
+Reviewers may also ask about your proposed commit log or the changes.
+Answer these in your response.  They often ask because the patch needs
+clarification; use this feedback to improve your writing, and update
+the patch so the next reader does not have to ask the same question.
+
+Do not start coding, much less send the next version, until you finish
+discussing the current one and both sides know what to expect.  This
+saves time, lets reviewers respond before you write a patch they have
+to reject, and avoids forcing them to inspect 'v2' only to find their
+concerns unaddressed.
+
+Do not iterate too quickly; at most one iteration per day is good
+practice.  This allows multiple reviewers to comment, gives
+participants in different time zones a fair chance, lets you batch
+feedback, and gives you time to digest comments before coding.
+
+Knowing you cannot immediately send another version encourages careful
+self-review, letting you catch small mistakes yourself so reviewers
+can focus on design and other substantive issues.
 
 If you are going to push back on a comment, be polite and explain why you feel
 your original is better; be prepared that the reviewer may still disagree with
-- 
2.56.0-336-g6ca398b529

