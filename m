Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A575A79B
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547491; cv=none; b=owX3qdRMf1VtnnF5AqLEw95HUrhi9i9duByVpJDAvyjJLUeuSGQcepnkFISjKnS0RV33UvjwNan7JXoawZmAiRRbl+iZBV3AlanJ3TjItbzI2m4oDGHswwhRL8jZTLXRi92olZquaKlOmDSNNtdvZLapr5YvEnsZKGKq3Odddk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547491; c=relaxed/simple;
	bh=YVwQjbpo7JB9TqZIGXSzaBaEIZE/eFfHaSeFTcyuDEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFOJ+yjWcA/1dpFOcbDv5qqpWLxSiUiVolIPAUJpjaJ+UjSiSQRMGxDvE+qGaEPyjEa8eq4tqOi8i6AQ9rOTzoesaEHksLFugonX/dLvNNZxlLpD7UZvzWWsyMHE16mK+xyb4WqLpW+KjRsvEekAhlEo/GcVRIVmmFd54sT1ns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iI2jtZ/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrGJK+8G; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iI2jtZ/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrGJK+8G"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC62E1140093;
	Wed, 22 Jan 2025 07:04:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 07:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737547487; x=1737633887; bh=Hib1I78yKk
	bY12L43OK8J64GU47jnvAkgmsCxrjRtKY=; b=iI2jtZ/4Tbg/fg59LN7xcwgJVp
	e1IrJkKQbRUa6pEL74qzwi0n4DYUUq09KOIK/zlUlptXeDS3Wk5OvOXTZeyCReMC
	5Fpu1KRW5YVKPlAtrWmQxK8iYwPwaCN/+wCWJCOYLnTzPyWGt4rC7q1N5desIytZ
	gPL51hiBIEm9q1OVBaut5x9R8YIwe/yEz6YS7SuP58K93zRKU+0+7vC46OUQMl6q
	c5LkhnCXUjFfQLMK3BPKJLkougFGD2lC8MB+JhfY+e4zUrID/khez6r+bzcv+YcS
	IPstv0rUlzuSs/R3yBHIDN/ThhEB1Owko5zEJ3wr8RF31cFUOaZgQvRz/ihw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737547487; x=1737633887; bh=Hib1I78yKkbY12L43OK8J64GU47jnvAkgms
	CxrjRtKY=; b=XrGJK+8GumAMgcH7XcQU4a9XWhEdXYsXZxI3jq333IBQ4zZ0aoO
	laX/HrD4Gw6ei+lW5+zbtd1NcSugtUgDF0xFlMPoJJlXI1mOWdUEuuWR6s0q9dan
	Kfar3cbllmQNX8L6NrWpPaZ/l8Z6tuhWLeQG5chRJmRKIsOa1x8hhpijqDl6JTkX
	Mcz1dUp/htHTPXQu3a5ZbEL7MmnxwzmcRaSh+PqePmFTPynxgXolkrWwYLUaFpjC
	7ZtRvjbtJ+4RmWp6SZ+o4A/byLCiUrEF1NVtoVeRbKELflZ/8xYL0/v+KNPh2wsU
	eectGDMwr41/eo6xq0c83zDQe7/Xq+7lKMQ==
X-ME-Sender: <xms:396QZ1myPcLoCTjnkAg4dmCgBBdO0ys1BlBTgbOtNNxMP-0Uftgg6Q>
    <xme:396QZw0CgwJ0r0kXWE7HppFgNtiQpeSz7F2CR_4ZxIt47W6mIaFRJqAYlFZXUbqx5
    2Zc8kM7vaUjRYUjjg>
X-ME-Received: <xmr:396QZ7rl--ZPzjf3z3GWjiKSS4evUtZBP5QYqYm9AjKB7lBk5reOiN1BUg0f106ng9rZhlxyBAs4TqFz23IkhZlIVlUAFMIrmrVdHhCO2seXMi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhhikhgrsehthhgvlhgrhiiivg
    hllhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:396QZ1lYAQLEDpNWGWCVkImrb23pl5qA5GaMtScAisSJacaPeQpvMw>
    <xmx:396QZz1YQuzsqmqP0B5C7u44YwfTyCGA9E0sFLyngN5tVmQGwQzHgw>
    <xmx:396QZ0v8qPJOk9E8FJgudC4a9TxysfgQnCrSALV2T4cUykaQOwUziA>
    <xmx:396QZ3VfYDa08FR32bMX-gGe5DE_zHhzV-OfBA3k0xvzNzoMYSvwiw>
    <xmx:396QZz-qGT_bEh9yKMS2frNXau4UtJnUaNos4foHOnUu8da7iQEvY25o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:04:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98ece5a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:04:44 +0000 (UTC)
Date: Wed, 22 Jan 2025 13:04:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: peff@peff.net, git@vger.kernel.org, nika@thelayzells.com,
	gitster@pobox.com
Subject: Re: [PATCH] refs: fix creation of corrupted reflogs for symrefs
Message-ID: <Z5De17-Ed3K31kzh@pks.im>
References: <20250121215235.GA2753621@coredump.intra.peff.net>
 <20250122100319.2280647-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122100319.2280647-1-karthik.188@gmail.com>

On Wed, Jan 22, 2025 at 11:03:19AM +0100, Karthik Nayak wrote:
> The commit 297c09eabb (refs: allow multiple reflog entries for the same
> refname, 2024-12-16) added logic for reflogs to exit early in
> `lock_ref_for_update()` after obtaining the required lock. This was
> added as a performance optimization as it was assumed that no further
> processing was required for reflog only updates. However this was

s/reflog only/reflog-only

> incorrect since for a symref's reflog entry, the update needs to be
> populated with the old_oid value. This is done right after the early
> exit.
> 
> This caused a bug in Git 2.48 where target references of symrefs being
> updated would create a corrupted reflog entry for the symref since the
> old_oid is not populated. Undo the skip in logic to fix this issue and
> also add a test to ensure that such an issue doesn't arise in the
> future.

It's a bit curious that you describe the fix here, then in the next
paragraph describe why we have skipped the logic only to reiterate the
fix.

> The early exit was added as a performance optimization for reflog-only
> updates, but this accidentally broke symref reflog handling. Remove the
> optimization since it wasn't essential to the original changes.

[snip]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5cfb8b7ca8..29f08dced4 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2615,9 +2615,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  
>  	update->backend_data = lock;
>  
> -	if (update->flags & REF_LOG_ONLY)
> -		goto out;
> -
>  	if (update->type & REF_ISSYMREF) {
>  		if (update->flags & REF_NO_DEREF) {
>  			/*

Okay, makes sense. The error is specific to the "files" backend, which
might be worth mentioning in the commit message.

One thing that made me a bit curious is that we now end up executing
`check_old_oid()` for symref reflog entries, because we have
`REF_ISSYMREF` and `REF_NO_DEREF` set. But that function should end up
skipping the check because we explicitly unset `REF_HAVE_OLD` when
queueing the update. The remainder should be skipped because we have
`REF_LOG_ONLY` set.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e2316f1dd4..59493dd73f 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -4,6 +4,8 @@
>  #
>  
>  test_description='Test git update-ref and basic ref logging'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  

We could use `git symbolic-ref HEAD` to resolve the branch name instead
of overriding the branch name here.

Patrick
