Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137646;
	b=YVVhz23KAho1oWlC7bmKwDGVBsXPsCFe7+KhAxK4Mv0kAxYbMee9afBAq3DDqIBURFEG
	 W7kKs8fbAk8PIMyyX6hriX1sQJfhDV62Li8wrSXt830L5trWF+88Ub+8ehnVSHhc9QyYl
	 Y2jBB+wKknbcxPslIoFdoxlCvI6Hm70NmIaxKXhH40Bwoh6gpwwJ6vh+QHXE/xH1M+hVY
	 Ub73vsqXKvXo1/leya7vYCeeQu5bCaVRk/mg5gZrVNDFhk1TdjOKlC6S0l5+i7uT79cOm
	 ugdCxQys7/283OmhZHsUOIWPoriiKDJh8/3/ghZ1akjBetoDNE6MCsBfJ+NSeMIqY0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ee8KabCEJryJ+3q1ULdotBgQe9RxoQk7V7DGarBnhFQ=;
	b=1vP3cp1eD9dDgaeyuGEvQqPu8lckJH/v18j63Pegy9OmAQfq8OsLevjG8usp8IRbZDv2
	 +kk1yMQLFOhrJrFp+VwYtJvRXJqAoWgM08ggz00VFNsLRksOUyF/DjQI0rwsv0rnsc6ug
	 gIYPharGk8elRMPvqWz7njhg9kH4M1AVzYfwIHqzCPaVd0wJytH5dRHO786gPpwimqZUx
	 uo2D9Vbq+lk5jnfVVPixvMHVj4ingwb7s+jAuzPw3wk4YdeogMCReyD4sDNpDw/Vbi6dX
	 anKAZQSVoJR9ru3ApwqG+Y36EVbJJI2e0YM/sNvzDqYUJz1zBDHPvv+EZEp8g4HdCrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YbArrPQ6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QGwRAm5F;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78F606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 21:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE78F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YbArrPQ6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QGwRAm5F
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 028451D00169
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:47:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 17:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793137644; x=1793224044; bh=ee8KabCEJr
	yJ+3q1ULdotBgQe9RxoQk7V7DGarBnhFQ=; b=YbArrPQ6q2J5+MOt3s19dG3FL4
	Lx0aVlB4f7C/ofw97OWKNQ9i5M6PKg3SpiCJ3HS76dRaeOVpOIic1qrTAUyZvZAy
	FUu/deP+HNs4An6DTO/15SYvPfIg0tmWusQXuEghlavEoLnWMN7F42aUHPHxsn4k
	ar7siEjF/wTBPPqDnsBzWDn2p4NOAE50T7WHLK9twFUsFMd1v3D81GfQ3G1bGznl
	CqKMiit2wE2qzZSPRpKoyfOb8MVI6DsE8WKaSO6mwPCUdUA+eixhf0YtrOlxybtO
	Z7gMhmukUJhz46Y6BEu8VLt4ICGk3LB1x0pLobD6wbhUX/jdeAfZsILKlG/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793137644; x=1793224044; bh=ee8KabCEJryJ+3q1ULdotBgQe9RxoQk7V7D
	GarBnhFQ=; b=QGwRAm5FqXnLVH/o+MzY25wq2aVH2X4Y9LD+M/dnlLj93rhvxmS
	5Ur8FYA6lH8rO+EPrl3qnFt4KVtDBKkoWilGBu+YEbMT1HI4xgOYI3sc9qa/sYG1
	ubXP1YVCtfYGkNdXRI8VYPuQTZ5wRlJx8f+k4JqmUdd4ie0lEhzEgmKYUZnw3mTU
	NK0OMWJNlA+q4piMOAHpmSiExLc4jlKtz+MQja7ajk5qa/jgKkCAKozyfthYJfa/
	w12yi0luObJzPfvQrEd4ZoIoN7d5BPv0dMOcxOTqUO1DxiqOoRP8yQdsptGjsw8z
	VJpi9eEMmAVJpzLt3TJ+arP6Dfbynz7I3lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793137644; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZeTDBfVyp5UU1ncbD/ytzNBMdcDS6FQ3fdDeFCIwfqNgm7f
	UqX+WchIaExIAaW4ZAL5DNkjL0M2utExWqP9x7RBXNxywyDwHWr+xbAf9kqG/jrx
	Rdnz6gkREiPOliJgaMfx55YgcqryPUFgWFcFYPUoqsOFKwh0aMCStG8JzLLkyxer
	AzIRQ8rRg/muMR7k8cmN4zFLwHIazYxdc3Wxhxtp3dVALjl79IcN9f7eC83tAEfc
	d8kiQOw/+ZIsroqhi+kQIVbAwks7KgTB9gbe0/EDcewDo0ZECTz8qredckL2QNT1
	XyrJGY1ICQ6NLLGpQ5nl81M8rHuYOPKXy9NcJOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:sCCbRGKL13SBrNDZlk9w2ek/PBFcKWlAmhpOJzTH0O8=:5zPEw+q5GF4urZROirgMDZ7QLBUOOqSzcBRsz7/7CRU=;
X-ME-Sender: <xms:7Bvhaml5lMrBavsYom1aGmDT3eszivBvueV0EnbVBJca8hKiCLE-aQ>
    <xme:7BvhakvuRLyHHNn6JhfNJMPhE6BKPCtDSavvtCBVibBRwPXFJV9rU0juYjlAjA3d7
    u3E49uhihYiq6-5ugW3N5t6AIsI-YXh-DqPh0S7adOFOMN19POwzw>
X-ME-Received: <xmr:7Bvhas9qp3HFdZYO8wZTwFzdu0M__iYXf8JGnE4eh-4n9hetu5LRjBhbFxDWdKARBMOWaOBag54scDZL5jER2-YZGWlU9YGZa7DL>
X-ME-Proxy-Cause: dmFkZTGuHGbM0KIiucDiKZ4VQT370QZTe+7DC+NVo1qHV2MAMTLFzdOlK2KoofT9MM26Ml
    L34F0T9p0Idui0NJb3khQyAuKcpT0NbnjzfVVsTdPqX/FnX8mgnRx4IKqhgE8DesOntuZM
    tm6edhZ9+WEJJWTtiGu1NVYFeudrTOpHNYN2vwvHZAHyowteouyMVlin4820bpJ2qyk6HE
    /XMVehnPPa2O3mGrAUEE3qnTqk34Mx9ASOjN1isAubeVJG4FWzblDauRIBgz6uEU2B80Wd
    zlDQH9wDGwazJqebs+rejsokejk8WVdW5oj7nuFdDf4DbxuyDV7/V1oQn1Ax3qIZBsb+Xq
    D2UzRCASt1Uycu6V2FZDZzW4hXx9TgW3OMio2rB1EjnHtiv5TxKoK0Tq8u1WU6X8rcASIf
    eL8BwHY1C9ln8wZIZZro+0GRNQ8a9fPx9wpxKvIf0NmLkLoZ/6nxkpK82BWAoB172HvQ2I
    mLTWd1GG9vmyjn9HbOQTnch6D4TCkzW2oF8bvbfpc2hscCmvEJfiGQWcL7KsMZu8ZZ/dI6
    9cWh5zLS4wiklVy11TbONyxIUb7e8MOBFvJDsAiY0oC/QarFqqtGCR3cDa9Jb2Ul6nI2hF
    SpokI5lr0pyK+Gsku6YBxBly9EkAkFtN2bKeWnm5lJgagV/i9JIimkt+1+sg
X-ME-Proxy: <xmx:7BvhamOes0yQgZUNmJVz_je4DOcXKHz4kRL_7XMqINB3jNbdPc9aRg>
    <xmx:7BvhaiEfIRv4iW_3cpBwMTEAHK_niGQ8H5W-sLs49L23aKnQcvyeTQ>
    <xmx:7BvhasRAeqOtygVSo63bCiyXPWf_NztWH-eQWiSM9jIIgzmDHPH3qw>
    <xmx:7BvhanvzJnT4UMH6XwZxsdAysfaIelJBbJj7JbJU2nMn0BCvfuXEFA>
    <xmx:7BvhaotTAXmCvCmB4BVvEo47x7pTvSXOCMal-gEgnk0v38v8YupAYadD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 17:47:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
In-Reply-To: <20261027212349.GA774120@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 27 Oct 2026 17:23:49 -0400")
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
	<20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
	<20261027212349.GA774120@coredump.intra.peff.net>
Date: Tue, 27 Oct 2026 14:47:22 -0700
Message-ID: <xmqqpkwuhl3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Oct 27, 2026 at 09:18:28AM +0100, Patrick Steinhardt wrote:
>
>> Due to the job being special it has a higher potential of failing even
>> though a local test run succeeds. But running these tests locally with
>> the same environment is somewhat painful, as the developer has to
>> manually set all of these environment variables.
>
> OK. I've usually just cut-and-paste them, as my first step is figuring
> out which is the culprit anyway. My biggest question was: what if the
> culprit is a build flag, and indeed, we leave the one build flag here:
>
>>  linux-feature-testbed)
>>  	export OPENSSL_SHA1_UNSAFE=YesPlease
>> -	export GIT_TEST_SPLIT_INDEX=yes
>> -	export GIT_TEST_FULL_IN_PACK_ARRAY=true
>> -	export GIT_TEST_OE_SIZE=10
>> -	export GIT_TEST_OE_DELTA_SIZE=5
>> -	export GIT_TEST_COMMIT_GRAPH=1
>> -	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
>> -	export GIT_TEST_MULTI_PACK_INDEX=1
>> -	export GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1
>> -	export GIT_TEST_NO_WRITE_REV_INDEX=1
>> -	export GIT_TEST_CHECKOUT_WORKERS=2
>> -	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
>> +	GIT_TEST_OPTS="$GIT_TEST_OPTS --feature-testbed"
>
> which makes this feature only half-work (well, 11/12 if we want to be
> pedantic).
>
> IMHO this whole thing isn't really worth the complexity, but if we are
> going to do it, should it be "make FEATURE_TESTBED=1", and then that
> enables the right build knobs, and test-lib.sh respects that variable
> coming from BUILD-OPTIONS rather than the command line?

Yes, I love the simplicity of that approach.
