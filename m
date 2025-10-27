Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D71A5B8B
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586725; cv=none; b=i4z3YEOFt3k77EiFHgqFQzK7zUbxe4egf9sOtnQW/Xe1SkY1nz1z3133Yf1jkZgTWSCL74paBmmGuGQTvtpo4qyIipXNiEQIRiU5rD3BVjqMed5lCQN7DgvVegVdkDSbYjZGaU2B77QPGNGd/Z5JlaebIneRHtS0yPB+COCzWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586725; c=relaxed/simple;
	bh=L3bvHZqcb/uHYpYu9uBBPswQXdCI5p13X7dQAOg8+78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLz22jDioJ9zVu36oXIbn1gDAUk3AHB3fNTzX9k9z+VPC6tKqavcwsc5kw5o7UiCSkfBN/6FlNwItAnEtRnm6vOEFxgn4Q4lBCHd7Rs678wEjyF/Q1/63frod8j+SYHSHBWcITGvmu0v7Mughc7w1x5VEMvYM8XRZ/eJEUwVZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FQrYUMpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M62GesXI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FQrYUMpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M62GesXI"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EB689EC0271;
	Mon, 27 Oct 2025 13:38:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 27 Oct 2025 13:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761586721; x=1761673121; bh=7ilKytk71D
	+4dmTRCp5nzyUNra7UNrfWf2Lnd+sujwo=; b=FQrYUMpBEuo93lEY6PHRdVz9nA
	PNG4gZpZl1t4ElEaFtW/ssYA0+QgzI/Sjsua4APt/Ig8J/QfAoOPPn+QNvNakSZk
	kMfIM0h9Fg5LKfF/pHDydGCk/PaP0c7D0R+3N26zD5KoFIs+FJvj5g9peSc5V+CV
	WtCBi2+klWHGPUKiIRVH1MCPLnKUMyzbuKBkv6JiRywehY/XjVdz7WdxGn5syuMM
	aoYr7qoyFoBCYL9/UAGk5mhs/9/FgHacYx/4UECzDNnxsrbubEXwQwrwvG0wCpzk
	jY49U/xG0Ge6x/iJopWhvUOFqq2+aRqVkVQ8DpFhD5jLb/jnxbOqIOD8IIrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761586721; x=1761673121; bh=7ilKytk71D+4dmTRCp5nzyUNra7UNrfWf2L
	nd+sujwo=; b=M62GesXI4ab9kAQ3XtO0CaHXeESqzxjPVp3aieOeqKA8v1sUxyO
	ipv1rz11hN5SQyoIhJ/6aqo4Usy2viRkfXPbSKXXzDn8YCTbDWO4JSXsGB7ISUQs
	JQS96sv9yjLFcKe0HXNIhHLAR+BYblIVVIm+1Xs6YqGZHKiK7RW6zj0Or1Hb+0Ho
	+huEMBhC5cLGq5E8apa4zeZgHLs0Uu2fWhiIZNidwumna+cCkve731fdqJNiw9hU
	v74PSUWm75ykAyete4F9/0KwnrQ9uWR76E3rJqsbyJeAsk6kY1tGjEDqofsphYEc
	SiHvV3qODsp7gSDN1xAQnN2StidAOrYHJNA==
X-ME-Sender: <xms:Ia7_aEmSGCNcENlQj5V357PVt6UNNu4KYjmp7qwFqQajmPWvths7ww>
    <xme:Ia7_aHggoSVuEQahhxIc8Hok1_dwwrbGvDZHMOALHND7SFCPNgg0eSOHYs5k2i8oD
    1pLNbIrX4bliBp8LfPq730mCYKxDpBO6xJQI1bZypV90z-jX147XiI>
X-ME-Received: <xmr:Ia7_aMf9KRDVJkQycWL3n_uide89Jpc9gJDnNvsEBqfVZUxHuwTy1pjiaJ83U_4OXPu1H1jO_0AdU_QRZ13e7WMN6Hwdin3_WiUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomh
    dprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ia7_aHhHQwUcMhUO-qPW2Nx7TIB4gu8ElWBnsGzFCaUFNlHISyMjGw>
    <xmx:Ia7_aEwN8Qhmv-nuumnrgotkCB3MMD4y4JruLduLJma5Y66SlZkgBA>
    <xmx:Ia7_aDMQ1Rl1NZZ1innkQCza2hFBDwvMUS_KXn60mVy_DTf4F9VSqA>
    <xmx:Ia7_aFUuUqPy4FPahm8mcA55NOCjWyBbEAR4MeWgrFl80hIqmvZ56w>
    <xmx:Ia7_aPwJ0k8JCGjwm-O6-J49PlejqJlwi0MuUCSM2Fb01qndL1XK8W-N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 13:38:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Todd Zullinger <tmz@pobox.com>,  git@vger.kernel.org,  Kousik
 Sanagavarapu <five231003@gmail.com>,  brian m. carlson
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
In-Reply-To: <87zf9c8glu.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Mon, 27 Oct 2025 11:16:45 -0500")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
	<xmqqbjlump3m.fsf@gitster.g>
	<87zf9c8glu.fsf@email.froward.int.ebiederm.org>
Date: Mon, 27 Oct 2025 10:38:39 -0700
Message-ID: <xmqqqzuoi6sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Eric W. Biederman" <ebiederm@xmission.com> writes:

>> I am tempted to do this in the meantime, but I'd really prefer not
>> to have to do so, assuming that these tests, when fixed, would be
>> materially contributing to the health of our codebase.
>
> I just dug into this a little and hopefully I have paged enough
> state back to understand this.
>
> In my testing a missing GNUPGHOME appears enough to prevent the
> prerequisite from succeeding. So let's fix that. Todd Zullinger's sent
> some nice patches to do that (up-thread), or you can take use my minimal
> version.

Sorry, but I am confused.  The above "tempted to do this" was meant
to come on top of Todd's patches.  IOW, I was seeing flakyness with
Todd's patches that fixed the missing GNUPGHOME.

> The only possible source of flakiness in the tests I can see is the
> possibility of t/t1016/gpg not getting called (which uses a fixed
> timestamp).  It appears you just fixed that problem in commit
> 516bf45749bb ("t1016: make sure to use specified GPG").

I think that one also is in 'seen', and yet we saw t1016 flaky X-<.

Let me isolate the relevant topics and test them again, i.e.

    $ git checkout --detach v2.51.0
    $ git merge --no-ff jc/t1016-setup-fix ;# 516bf45749
    $ git merge --no-ff tz/test-prepare-gnupghome~1 ;# 6cd8369ef3
    $ git log --no-merges --oneline v2.51.0..
    516bf45749 (jc/t1016-setup-fix) t1016: make sure to use specified GPG
    6cd8369ef3 t/lib-gpg: call prepare_gnupghome() in GPG2 prereq
    a35952b493 t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
    $ make
    $ cd t && ./t1016-*.sh --stress
    FAIL 10.1
    FAIL  5.1
    FAIL 34.1
    ...
    ++ eval 'diff -u' '"$@"'
    +++ diff -u signedcommit3_sha1 signedcommit3_sha1_expected
    --- signedcommit3_sha1	2025-10-27 17:34:58.237496945 +0000
    +++ signedcommit3_sha1_expected	2025-10-27 17:34:58.145497051 +0000
    @@ -1 +1 @@
    -de9cabc2419f97eb665452c198ed93e890a7ef87
    +c87cd5157461a81b60ef6d3c47562c12b328ef54
    error: last command exited with $?=1
    not ok 163 - Verify commit signedcommit3's sha1 oid
    #	
    #			git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} >${name}_sha1 &&
    #			test_cmp ${name}_sha1 ${name}_sha1_expected
    #		
    1..163

> With that commit reverted I can reproduce the flakiness locally
> by just running the test manually a few times.

The above is with all three patches mentioned.
FWIW, "gpg --version | head -2" says

    gpg (GnuPG) 2.4.8
    libgcrypt 1.11.2

Hmmmm.....

> I believe I used the GPG2 prereq because I don't have the older version
> of GPG to test with.  So I don't know if t1016 would work on the older
> version of GPG or not.
>
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 937b876bd052..c4bbedfe081e 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -62,6 +62,8 @@ test_lazy_prereq GPG2 '
>  		exit 1
>  		;;
>  	*)
> +		mkdir "$GNUPGHOME" &&
> +		chmod 0700 "$GNUPGHOME" &&
>  		(gpgconf --kill all || : ) &&
>  		gpg --homedir "${GNUPGHOME}" --import \
>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>
>
> Eric
