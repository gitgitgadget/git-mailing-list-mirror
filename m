Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F31DE2C7
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334619; cv=none; b=ubJxlnnVbcyMMen5UTFnWQpkvZzpgi1wkh5FWZmakwwdFszvb8s9ksAcg1QehSOHDQ6EBIYQ0ENQ5WRLADywa8ZBwNIhCWVrtzYUq1bIfI6xRVdW2mgwgG3nA85NPRqqtnl4XOjPaEy+naVM50Wj1G81yUZcmoIKn33Pr/BeqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334619; c=relaxed/simple;
	bh=x0n0NsQeuvU0ERJyzmdALSCkb23AJnbURpG3RiqF+N0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uyGZHts+h54S2ZO3xZCq22yZAnWVCZqqiQddkDJTemDqgWyKGEReu/DlqD1+CNbIVHhk59KC0uTiXgB/PPsewEmrVpf93FiVF7+kTMUFzWJ6po8BR9DoMN7dkyaE9sFPYT0TJ61so3qg32O6laTfyOFOMNLNstoh7prwpTjVlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Eqf2F/ed; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMdJyL6x; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Eqf2F/ed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMdJyL6x"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBF2B11401BE;
	Mon,  7 Oct 2024 16:56:56 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 07 Oct 2024 16:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1728334616; x=1728421016; bh=018tVMrUv+5uSONSzO4phualsaIDDMzB
	JctSKap/zzI=; b=Eqf2F/edeoq1R2RgVsl9AVwjxNmG+tS2d/js0hniIvsP9rkd
	Jj7bknOaWG6olX3wr+KCJSE7PHtlHKjKQA9KnbAtyig14jk6B6D+KMhNbBKTZNQo
	VnYWd/AHkSUqE0U8mXVod5atO1vyp2yRz2kiBMi9tBfpm+K4mtLhmlaqcYHU8ukC
	3MvXU4Zj+Wb9W2Ie751E/6dRvfbgZLNhmZ7/MIHUMOos7/5GFGlECkJZuFzStZzp
	ujIDrAgSaIUI8IhEgytR2sHubCDNtcWciDS33csPvak64LTXM0uXJdr9+lHzolrc
	z+kmrkjlHcU9g86KHCkShYDifGI7bnu7qcwmyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728334616; x=
	1728421016; bh=018tVMrUv+5uSONSzO4phualsaIDDMzBJctSKap/zzI=; b=G
	MdJyL6xi43PmaCM+SmLfqf49ho7pr1i/e+C3wyD44zTJ+jp2qIHlqlmykMnVtV9V
	sQSVr/UDSnidijOm045eZB0ez2pdZftxvyNLAuD/ZZdkyiitTfjFT5+4CR1skSBE
	O+rqbvg65OA+TbuPXFO6AaIIMI72CS3yohTNNve1/pL5BxoVIpNgPje7totw5cK1
	ZWhfud7oICTvdPr8IJ723b6W6cj/4uCC00DqI5MsoPM/sHx6Jo76RIaDWmotwVAk
	l0CPmTQ4Qzvj9vBOnTcL+OVS1yiR+vQTYedG1nlycPbeV1Wbc/00wUBbliRiFxaa
	ibNJH/M++/BobxbFFwlZw==
X-ME-Sender: <xms:GEsEZ8aDIpvJvONn9GE0mRqXmdJAzPto1I0DyxYh42j66EoU7uVXikI>
    <xme:GEsEZ3YblIatOyRq-TcFR7HxvhIZkuXkb5juHOX85mr3Lai52hrjBgK5E5W4cA61B
    bnxmLcp3ZYcihz25g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqne
    cuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdujeelgfduffff
    jeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GEsEZ28N5PnU0hVqUta631etk0CbW4PNwu9gkbH9oJ3zXtYC_qT8ow>
    <xmx:GEsEZ2reYjMfpX_sQSw8fvN3CmbepCfMrbGuOLKYF3vxjJ4cQAo2yQ>
    <xmx:GEsEZ3qz5-YwtN0e2owy6Z1LmkKpc7jtMpPFiFTed6Rp16PmqEQBxw>
    <xmx:GEsEZ0SjRT1J6oMunxMMZIdrnmcr0wIWvFj0Xp09TZay0Jur267ndQ>
    <xmx:GEsEZwCNix5_dUKlUA6l_5G03jQ1gtSHmFFOAihNQaqN1vUrydlHKRYC>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E1C4780068; Mon,  7 Oct 2024 16:56:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 22:56:36 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <9a64a58b-3d08-44b4-96a5-9031863de4f1@app.fastmail.com>
In-Reply-To: <20241007204447.GB603285@coredump.intra.peff.net>
References: <cover.1728331771.git.code@khaugsbakk.name>
 <b88c2430f88b641d69e5f161d3a18cce113a81c9.1728331771.git.code@khaugsbakk.name>
 <20241007204447.GB603285@coredump.intra.peff.net>
Subject: Re: [PATCH 2/3] object-name: don't allow @ as a branch name
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024, at 22:44, Jeff King wrote:
> On Mon, Oct 07, 2024 at 10:15:18PM +0200, Kristoffer Haugsbakk wrote:
>
>> `HEAD` is an invalid branch name.[1]  But the `@` synonym is allowed.
>> This is just as inconvenient since commands like `git checkout @` wil=
l,
>> quite sensibly, do `git checkout HEAD` instead of checking out that
>> branch; in turn there is no practical reason to use this as a branch
>> name since you cannot even check out the branch itself (only check out
>> the commit which `refs/heads/@` points to).
>>
>> =E2=80=A0 1: a625b092cc5 (branch: correctly reject refs/heads/{-dash,=
HEAD},
>>     2017-11-14)
>
> There's a bit of subtlety here which makes the term "invalid" somewhat
> vague. The refname "refs/heads/HEAD" is allowed by plumbing, as we try
> to maintain backwards compatibility there. So the current prohibition =
is
> just within the porcelain tools: we won't allow "git branch HEAD"
> because it's an easy mistake to make, even though you could still crea=
te
> it with "git update-ref".

Got it.  Creating this one (or something like `refs/heads/HEAD` for that
matter) is allowed by the plumbing tools.  But the porcelain ones are
blocked.

Also the plumbing query `git check-ref-format --branch @` now returns
false.  Since it has to harmonize with what the branch creation
porcelain can do.

> And naturally we'd want the same rules for "refs/heads/@". I think it
> might be worth adding "...in plumbing" to the end of the subject, and/=
or
> calling out this distinction in the text.

Did you mean something like =E2=80=9Cdisallow in porcelain=E2=80=9D?

>
> It might also be worth mentioning some of the reasoning about the test
> you put in your cover letter, since that content is not otherwise in t=
he
> Git history. I'm thinking something as simple as:
>
>   Note that we are reversing the result of the test in t3204. But as t=
he
>   comment there notes, it was added only to check that "@" was not
>   expanded. Asserting that the branch "@" can be created was only
>   testing what happened to occur, and not an endorsement of the
>   behavior.

Sure.  I didn=E2=80=99t even mention that removal since the comment stoo=
d so
well on its own (i.e. explained its own presence).  ;)

>
>> diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-n=
ame-interpretation.sh
>> index 594e3e43e12..7dcd1308f8c 100755
>> --- a/t/t3204-branch-name-interpretation.sh
>> +++ b/t/t3204-branch-name-interpretation.sh
>> @@ -119,13 +119,8 @@ test_expect_success 'disallow deleting remote br=
anch via @{-1}' '
>>  	expect_branch refs/heads/origin/previous two
>>  '
>>
>> -# The thing we are testing here is that "@" is the real branch refs/=
heads/@,
>> -# and not refs/heads/HEAD. These tests should not imply that refs/he=
ads/@ is a
>> -# sane thing, but it _is_ technically allowed for now. If we disallo=
w it, these
>> -# can be switched to test_must_fail.
>> -test_expect_success 'create branch named "@"' '
>> -	git branch -f @ one &&
>> -	expect_branch refs/heads/@ one
>> +test_expect_success 'disallow branch named "@"' '
>> +	test_must_fail git branch -f @ one
>>  '
>>
>>  test_expect_success 'delete branch named "@"' '
>
> I was a little surprised that the "delete branch named @" test
> immediately below did not need similar treatment. But I guess all of t=
he
> "check refname" code in git-branch is split between those two cases,
> because we want to allow cleanup of broken names created through other
> means.
>
> So I think the patch is doing the right thing. But it might be worth
> mentioning this distinction in the commit message.
>
> -Peff

Yeah, I=E2=80=99ll do that.

--=20
Kristoffer but any Christopher-variation is fine

