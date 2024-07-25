Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4519219B3D3
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922581; cv=none; b=IlsGi+vVNxnwZ8Y/FvpCsUcH+SJ977EWINdg+NUb8ceV5w7v1GXnm6Uvp5T7IiOl8Yw96tP8ujaQT+DWQvh3aUSPxGvBFWUKwmNEsdO+P48TRytykf93SGF2wGyuY0vE0vJoFuyWO7O0UcE4fYbccoH9mnR5e9akxxzc5uDFAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922581; c=relaxed/simple;
	bh=f7p/8b1qm3c/pkAeC1dRtv9/98BsvCGBNi5KUl/MdII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpi4p7mcFkv+8ci726yatyzSLDqz8UxWIXL9yhX9+F0I26NurY1HC0BcY4pPl4Ve+m6B2FERnhAc0dhmGQatxbQYaPawd4ciYyExAQtMK10q19zyVvQbwnO/pkIm67T4FJAiKKn/LaIvmUM2jnbdAFW+Phyue2aAqfI2ulF3+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EAknX94P; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EAknX94P"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C66D328D60;
	Thu, 25 Jul 2024 11:49:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f7p/8b1qm3c/pkAeC1dRtv9/98BsvCGBNi5KUl
	/MdII=; b=EAknX94PO8ejc0hjmOuOQgUZ1s4v0ikvEdl1o6TDjvfArZ3NSiS8No
	h+zvDW8OLpq4AG2txrGgm/Tj//ERAWN4rcwqNSwBS4gxRVeY7XmiUqLHsaXe4ptr
	YirZwyYVtJGWIRbuOGWOEPETND2EtepPIUgBLEqZTMHOB6B1FkTgA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ACA0828D5F;
	Thu, 25 Jul 2024 11:49:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C52928D5E;
	Thu, 25 Jul 2024 11:49:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] ReviewingGuidelines: encourage positive reviews more
In-Reply-To: <xmqqsevysdaa.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Jul 2024 14:14:37 -0700")
References: <xmqqsevysdaa.fsf@gitster.g>
Date: Thu, 25 Jul 2024 08:49:34 -0700
Message-ID: <xmqqle1pjwtt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E5ACF56-4A9D-11EF-B831-9625FCCAB05B-77302942!pb-smtp21.pobox.com

I saw some contributors hesitate to give a positive review on
patches by their coworkers.  When written well, a positive review
does not have to be a hollow "looks good" that rubber stamps an
useless approval on a topic that is not interesting to others.

Let's add a few paragraphs to encourage positive reviews, which is a
bit harder to give than a review to point out things to improve.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Thanks for comments on the initial version.  I spotted a few
   typoes and grammos to fix, so here is a (hopefully final) update.

 Documentation/ReviewingGuidelines.txt | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
index 515d470d23..6534643cff 100644
--- a/Documentation/ReviewingGuidelines.txt
+++ b/Documentation/ReviewingGuidelines.txt
@@ -72,12 +72,29 @@ guidance, and concrete tips for interacting with patches on the mailing list.
   could fix it. This not only helps the author to understand and fix the issue,
   it also deepens and improves your understanding of the topic.
 
-- Reviews do not need to exclusively point out problems. Feel free to "think out
+- Reviews do not need to exclusively point out problems.  Positive
+  reviews indicate that it is not only the original author of the
+  patches who care about the issue the patches address, and are
+  highly encouraged.
+
+- Do not hesitate to give positive reviews on a series from your
+  work colleague.  If your positive review is written well, it will
+  not make you look as if you two are representing corporate
+  interest on a series that is otherwise uninteresting to other
+  community members and shoving it down their throat.
+
+- Write a positive review in such a way that others can understand
+  why you support the goal, the approach, and the implementation the
+  patches took.  Make sure to demonstrate that you did thoroughly read
+  the series and understood problem area well enough to be able to
+  say that the patches are written well.  Feel free to "think out
   loud" in your review: describe how you read & understood a complex section of
   a patch, ask a question about something that confused you, point out something
-  you found exceptionally well-written, etc. In particular, uplifting feedback
-  goes a long way towards encouraging contributors to participate more actively
-  in the Git community.
+  you found exceptionally well-written, etc.
+
+- In particular, uplifting feedback goes a long way towards
+  encouraging contributors to participate more actively in the Git
+  community.
 
 ==== Performing your review
 - Provide your review comments per-patch in a plaintext "Reply-All" email to the

Interdiff:
  diff --git a/Documentation/ReviewingGuidelines.txt b/Documentation/ReviewingGuidelines.txt
  index 31fd60aadf..6534643cff 100644
  --- a/Documentation/ReviewingGuidelines.txt
  +++ b/Documentation/ReviewingGuidelines.txt
  @@ -81,13 +81,13 @@ guidance, and concrete tips for interacting with patches on the mailing list.
     work colleague.  If your positive review is written well, it will
     not make you look as if you two are representing corporate
     interest on a series that is otherwise uninteresting to other
  -  community members.
  +  community members and shoving it down their throat.
   
   - Write a positive review in such a way that others can understand
     why you support the goal, the approach, and the implementation the
  -  patches taken.  Make sure to demonstrate that you thoroughly read
  +  patches took.  Make sure to demonstrate that you did thoroughly read
     the series and understood problem area well enough to be able to
  -  say if the patches are written well.  Feel free to "think out
  +  say that the patches are written well.  Feel free to "think out
     loud" in your review: describe how you read & understood a complex section of
     a patch, ask a question about something that confused you, point out something
     you found exceptionally well-written, etc.
-- 
2.46.0-rc2-56-g5eee0f42f3

