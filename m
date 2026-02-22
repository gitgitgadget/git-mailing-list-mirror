Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D918A6DB
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744032; cv=none; b=XjcsGPW1rg/SdvLg3EEgnXgG4tiFuPUd73lghzSVTHrnT+EfUHOW8TDYV4G9kln2Y0E8Rhn8j3U7L+eCH85lPy+qGjnawuSqFNIq3ZdF7SAa4JEHt8mfO3IxS0fBVixVGL7Oi92iUrXnX+KykpqOjyO36svWPOPU1In7SfRt9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744032; c=relaxed/simple;
	bh=T6xOfN/q9S6mM4CBHWbvxIAVtWt7/24Ehqar06yUeTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKf/CMlIQmAVy57JYoHa6J3pNnI8XybcyXNcoIiPqa2r4+Uuc2lW52HDAHnpGc/Wusb7w2+sB6zHBKRafcLsrYGXaqn7bCWLaJH86HufC9k8SW2rVjH/lBiNrfGWW25XfhJOtuUuVVKKJFwbQDcwwT0mt4i4sSjIAD14RUXCX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E4vecgwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kH4N4qbn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E4vecgwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kH4N4qbn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34D48140015D;
	Sun, 22 Feb 2026 02:07:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 22 Feb 2026 02:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771744030; x=1771830430; bh=45FH5X6l7D
	RFXup9yN4VNct6djPHHuxYlY1AxObVcBE=; b=E4vecgwCvFwFHGJ5asrch+Czwg
	LfvKwpGmGHCmlGdAoADmEbO661qv2DhMKf7sKooxF3WFH1+LU/crmkgSvjR08E5Z
	PgEfL4GjX0EwM1UIb1lJmcjqcpWA+LLV9+Zg8C7CPZHejj4j5AcsxCdQ3Fih6UOG
	4R1Pd5nJOoYe+LXLLzynMDFO6Vdoxii2wozbFQuSEGOT3NXn7X1V4p5Qimvu/WEc
	IgKR+9UQ75rEYwAtWwdSM/B85IeSWwfHwjtO7CVqkfi8jltKETWVV9jND7aOssue
	HIp11u2WNAMspam9EMt5RtpFSZedFQqHPiH6zpla/eHfRHpkZWL6+rMIUmKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771744030; x=1771830430; bh=45FH5X6l7DRFXup9yN4VNct6djPHHuxYlY1
	AxObVcBE=; b=kH4N4qbniPyGgIZvrTHMxTEf2UV+qUlOUbFWnDkiowMV9OPemMK
	/FvyFczRRjKMMNRryKAyTPQJ/TsLzN8Ka0vXq9L5fGqElBkb3heTB0CLMGlWmsbP
	4wDwooO9ST/hQ8H2Mz9LydT+5nlNvcNMSax8d909IJqTO8WkYB741xspQc+SjoVd
	tuKJZkBYsDytGyd6+RRoRdNG+jyEikHHhXLxr2x2PP8cinBcGRUKjexI+J0K1l5p
	nQWWLTjeja2UNp55GHX1mkERNbD4Q7g4QN6GFpBx9uVw5BWWXtauWG7eITUTCaAu
	xbNUILsxjxqhQwVzAw+PT2NRFjjv7ztKd4g==
X-ME-Sender: <xms:Hquaac68qdqqIWiD9oLxJOv7YBBt-q3jhtY8upXQRPixWMtvcDaOwQ>
    <xme:HquaaRKATIBMzHcPPtS4Cd-gur4eRmhajdqci68V12Rq1obMO2lqhLU0He_nT1ovy
    FKJQpsLYL_dqLMHxeVCKl9kcaEkES2-SpOkpPdadNHm_nKQHNs5fQ>
X-ME-Received: <xmr:HquaaU43BfHZnckkht5oAJtqcPlGwRJBBkvO2VRaNzgTDr8Et5up7bb_RrFXeayo6V2mFvA0-XTTuzlumtYSZuBUr9kqGXcfaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepudeiudevteeutdffjedvfeelffekueetfeffhfeitddugfegveekhfeludeh
    hffhnecuffhomhgrihhnpehosghjvggtthdqfhhilhgvrdgtfienucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:HquaacwbMlmpaldGqUsWzZeP_cR1FIfC7ULpSPzIyQ47nbX-MSAG9g>
    <xmx:HquaaQaf8JEmOMilcxtXkYMoa3tBuusBPRtr-QuJ8v3DFQAQNtJNbg>
    <xmx:HquaaWQjro2WdOmKBhrWeMSlYF4zQFcLKdEIAWXgqOtYtaw3_2hV9w>
    <xmx:HquaaSyqT4I0r06lUJUTRwlFIRHLhh8d7-gl3S4vGxLDb_2D5_zDFw>
    <xmx:HquaaRz_SM5epzszjIfziBgeQm4YEQrCSxYRG8DKB6TneGPtfsd7ydpW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 02:07:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] object-file: use `container_of()` to convert from base
 types
In-Reply-To: <20260218210120.1146078-1-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 18 Feb 2026 15:01:20 -0600")
References: <20260218210120.1146078-1-jltobler@gmail.com>
Date: Sat, 21 Feb 2026 23:07:08 -0800
Message-ID: <xmqqms11qmsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>  static void prepare_loose_object_transaction(struct odb_transaction *base)
>  {
> -	struct odb_transaction_files *transaction = (struct odb_transaction_files *)base;
> +	struct odb_transaction_files *transaction =
> +		container_of(base, struct odb_transaction_files, base);
>  
>  	/*
>  	 * We lazily create the temporary object directory

This conversion triggers undefined behaviour sanitizer.  We see in
the post-context:

	if (!transaction || transaction->objdir)
		return;

which means the caller can feed NULL as base.  Taking 0 offset is
unfortunately a no-no for a NULL pointer.

Unfortunately, this patch is already part of 'next' as of 7a30cb26
(Merge branch 'jt/object-file-use-container-of' into next,
2026-02-20).

Perhaps a fix-up patch on top of the topic branch like this?

----- >8 -----
Subject: [PATCH] object-file.c: avoid container_of() of a NULL container

Even though the "struct odb_transaction" member is at the beginning
of the containing "struct odb_transaction_files", i.e., with offset 0,
using container_of() to add offset 0 to a NULL pointer would be
flagged as a bad behaviour under SANITIZE=undefined.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git c/object-file.c w/object-file.c
index 1a24f08978..d69cb9b7e2 100644
--- c/object-file.c
+++ w/object-file.c
@@ -719,8 +719,11 @@ struct odb_transaction_files {
 
 static void prepare_loose_object_transaction(struct odb_transaction *base)
 {
-	struct odb_transaction_files *transaction =
-		container_of(base, struct odb_transaction_files, base);
+	struct odb_transaction_files *transaction = NULL;
+
+	if (base)
+		transaction =
+			container_of(base, struct odb_transaction_files, base);
 
 	/*
 	 * We lazily create the temporary object directory
@@ -739,8 +742,11 @@ static void prepare_loose_object_transaction(struct odb_transaction *base)
 static void fsync_loose_object_transaction(struct odb_transaction *base,
 					   int fd, const char *filename)
 {
-	struct odb_transaction_files *transaction =
-		container_of(base, struct odb_transaction_files, base);
+	struct odb_transaction_files *transaction = NULL;
+
+	if (base)
+		transaction =
+			container_of(base, struct odb_transaction_files, base);
 
 	/*
 	 * If we have an active ODB transaction, we issue a call that
