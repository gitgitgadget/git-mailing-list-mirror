Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C5846F
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625532; cv=none; b=ALUsjCWI+FYu4cTIRzMUSaU+4OsjeZjKQ+oGoy0+cGfwCuppYLL0GgaVbF0g/ftiAFPs5JOtpef+9TO4TCe6wjEsNy2ZPDmVamyz9pFNsgf24wBip/B7MToFh6IANzSshpNsoXp0joVM3EYyyyYHngMj49YxE+Y9047bQAAdFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625532; c=relaxed/simple;
	bh=nqbYUbrRUe3HzbFHLnQe90XokjYP6VPoZSl7xyQrnuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPY7f5QhGyJdOtpDJhsEJ5MMZ2Lpupy2aQZPo6ZVxV+goenJ7U07f9ygb4wrqd3FB5ZUpx08hub4Y1p8jRKOpVzNI6NEkXBeAXL9ZfKDZpl6QWa5Htx35wsmqM2HlGuiRTlini40TCCVE7h1TrNXbAgUvUsOge7uk6YymGKyHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AVD/Ic2w; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AVD/Ic2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752625528;
	bh=nqbYUbrRUe3HzbFHLnQe90XokjYP6VPoZSl7xyQrnuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=AVD/Ic2wzC2jLfmfnCX09PaHTAbX6rd6JT4uSBfBPxWRWXS9F6IH4muo1DdBLBasj
	 qjhADE7hhWkHfK41ZQS2CcvxEQ7i1FWjkn0fC0WS5rvkk09WbKxMvagNzw50wpN2lf
	 Hu7WkobJlT9ik2MhLwhcHJYGEFqPHnLW20pTAbGR2xGHHOzeLyO5n9kpKHeXxoT+EA
	 ObVnsMrBa91gcr5m1uH/mAjIGFDiEdcKgaXm/fCyskSTRUoHNb+ZEHQblFTE07eLXY
	 /mMYMSNnWnthwZ7lYACWsW56pUl3uOPCRxNRzVszavEKtUH3E+CKqvL7L57782fci+
	 pO3vB+dUp3+xMWmp82+tN/OlZz0tRvvnyDhVYnSs0VkI7cMlzM8WqRPHwXXPwXFqlQ
	 pwWgr8PZtf2UvZCC0AtMi65M8Jyd5cNamUFepKzAApYDEdu3IopyVn8z4XmztRsHao
	 874uPsAIFZkeM4SW6safPiGucezITAfaHCjRoUPTb4aq30kQXGX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ef36:e137:e56a:1fad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E3E012007E;
	Wed, 16 Jul 2025 00:25:28 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	redoste <redoste@redoste.xyz>,
	Jacob Keller <jacob.keller@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2] SubmittingPatches: allow non-real name contributions
Date: Wed, 16 Jul 2025 00:25:23 +0000
Message-ID: <20250716002523.1392423-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250706163009.335780-1-sandals@crustytoothpaste.net>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our submission guidelines require people to use their real name, but
this is not always suitable for various reasons.

For people who are transgender or non-binary and are transitioning or
who think they might want to transition, it can be a major obstacle and
cause major discomfort to require the use of their real name.  This is
made worse by the fact that Git provides no way to change names built
into history, so the use of a deadname is forever.  Our code of conduct
states that we "pledge to act and interact in ways that contribute to an
open, welcoming, diverse, inclusive, and healthy community," and
changing this policy is one way we can improve things for contributors.

In addition, there are some developers who are so widely known
pseudonymously that they have a Wikipedia page with their handle and no
real name.  It would seem silly to reject patches from people who are
known and respected in their open-source community just because they
don't wish to share a real name.

There are also other good reasons why people might operate
pseudonymously: because they or their family members are well known and
they wish to protect their privacy, because of current or past
harassment or retaliation or fear of that happening in the future, or
because of concerns about unwanted attention from government officials
or other authority figures.  As much as possible, we want to welcome
contributions from anyone who is willing to participate positively in
our community without having them worry about their safety or privacy.

In all of these cases, we should allow people to proceed using a
preferred name or pseudonymously if, in their best judgment, that's the
right thing to do.  State that it is common to use a real name but
explicitly mention that contributors who are not comfortable doing so or
prefer to operate pseudonymously or under a preferred name can proceed
otherwise, provided the name is distinctive, identifying, and not
misleading.  For instance, using U+2060 (WORD JOINER) as one's ID would
likely be distinctive but not identifying, since most people would have
trouble reading it due to its zero-width nature.

We prohibit identities which are misleading, since our goal is to create
a community which works together with a common goal, and misleading or
deceiving others is not conducive to good community or compatible with
our code of conduct, nor is it compatible with making a legal assertion
about the provenance of one's code.

Explicitly prohibit anonymous contributions to ensure that we have some
line of provenance to a known (if pseudonymous) author who might be able
to respond to questions about it.  Explain that this is the reason we
have this policy to help contributors understand the rationale better.

Use "some form of your real name" since some current contributors use
shortened forms of their name or use initials, which have always been
considered acceptable.  This helps guide people who would be fine using
their real name but have misconfigured `user.name` thinking it is
intended to be a username or is used for authentication (despite our
documentation to the contrary), but also allows for a variety of
circumstances where the contributor would feel more comfortable not
doing so.

Note that this policy is the same as that of the Linux kernel[0] and the
CNCF[1], as well as many smaller projects.  The Linux kernel patch was
Acked-by one of the Linux Foundation's lawyers, Michael Dolan, so it
appears these changes have had legal review.

Additionally, retain the section header ID for ease of linking across
versions.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
[1] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/SubmittingPatches | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 958e3cc3d5..86ca7f6a78 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -408,8 +408,15 @@ your patch differs from project to project, so it may be different
 from that of the project you are accustomed to.
 
 [[real-name]]
-Also notice that a real name is used in the `Signed-off-by` trailer. Please
-don't hide your real name.
+Please use a known identity in the `Signed-off-by` trailer, since we cannot
+accept anonymous contributions. It is common, but not required, to use some form
+of your real name. We realize that some contributors are not comfortable doing
+so or prefer to contribute under a pseudonym or preferred name and we can accept
+your patch either way, as long as the name and email you use are distinctive,
+identifying, and not misleading.
+
+The goal of this policy is to allow us to have sufficient information to contact
+you if questions arise about your contribution.
 
 [[commit-trailers]]
 If you like, you can put extra trailers at the end:
