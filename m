Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C492848C
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732066449; cv=none; b=RRxBogin1G7j5fd0dYX+xlnR+6syRZnTSR0AisZxLreIpYUPoaEZ+f8XxRA+4gPJh2HNLaEzHSjyVg04oCoXyTzugVPQXJODUBjCD++vLGPoYL8lerCXNmQuZ/zqnUgz5SNmndFO0HXE6fdyzseKExg1egm0WH0HFXnyJgGlQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732066449; c=relaxed/simple;
	bh=0Z3/1Sq5Us1MRuzPUB7Hy2lshhSLexnvA/6GSW1B1do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iX2vATjrHSIqnaOkb/V7nLhYDNazoEiKHI2cB2RQ5TnoYMTwWc8IXl4TQ8jksu+9MYTliNPxuApqVLL/AfvYp9HD4Rd3dB9MaZ0XG/W6A59DtODkCeK0at1OoKX+mw2KR6Btlc9+FzKtzB8cJD7n/vNsjr/r7YxE91bkeGLhx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZxFyNAQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZxFyNAQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CD5C254009D;
	Tue, 19 Nov 2024 20:34:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 Nov 2024 20:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732066445; x=1732152845; bh=gRe1m4Jwz0koSIejHrd7a7bGlrxfSJOszZA
	ITYYA4h8=; b=VZxFyNAQMD5iTpgxkkt7tFsUc5f2xq+thNQs+KtEewH8uDokdv+
	Ityu1bSIJul+BSNdRYxbQnIwiWqyIbEbtlThjBVveA6RpU6jUICT5jRwnH9GnyNU
	MzuzHoEYNOCYhv2/2a96Da2XZezAXHjaLjokG68vSWWWclxuDh5FkCNxaXlNbIi4
	OCkcCdjQ/JQNBdmukI2LZpJdoB5/6kC8WRJaIveA9CL7iuQAzom0a1QJetgrTfv0
	RDxJLPeEHeNQqGwOiGr21F9VyeJH5PslFnOimqqUHnIl0M0Ng2HuWIoyAtp5B2OP
	hdZd2kt1y89zCueDAlxG+imI1Qm9YhTFQag==
X-ME-Sender: <xms:jTw9Z_pjNCvuFL4snwdf95AnpWtP6KJnRg8gzUGN8vKuEjFohjfZew>
    <xme:jTw9Z5pJj7W_3nawcdUpC6TqjVLK8SQAkvrkDpTDA_ufGaDNHAXhdRVo0DtClEeyr
    3PXNj_EVIlDbI0KgQ>
X-ME-Received: <xmr:jTw9Z8MKe2fjzeliVpqDMN_aUegh2NaG-IX2ukBgIitPDtimQf0guHxIfNRm6W10xTFsgA0mUgA04EBYVGqOoSMNDdnJWOMA8etT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieekue
    efhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjohhnrghthhgrnh
    htrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jTw9Zy4ztuVn3CQtzs7Gxut8Uy4ox0pXgcUOl9js5DnbFHb0JDi4PQ>
    <xmx:jTw9Z-7iOs_ro6kKxH7DwV7AIqspLGbROG4S6E2Bywr5v5rIX7w6ow>
    <xmx:jTw9Z6gPQzzQYMWNDszunVVruK6AarKuiPenW6YkWdA802fhQQngeA>
    <xmx:jTw9Zw4sHHq4iVqiPh9Oz4WVPmrPN2mhOc4LlTqnXvoTbXHz8n-IFA>
    <xmx:jTw9ZwSdHD09Tze-KnuB5bE4I60L6K0AkeJNkBkBeWMFdLYT-aFkAnOK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:34:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jonathan Tan <jonathantanmy@google.com>,  git@vger.kernel.org,
  stolee@gmail.com
Subject: Re: [PATCH] index-pack: teach --promisor to require --stdin
In-Reply-To: <20241119185345.GB15723@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 Nov 2024 13:53:45 -0500")
References: <20241116032352.GA1782794@coredump.intra.peff.net>
	<20241118190210.772105-1-jonathantanmy@google.com>
	<20241119185345.GB15723@coredump.intra.peff.net>
Date: Wed, 20 Nov 2024 10:34:04 +0900
Message-ID: <xmqqcyiqadtf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But I think that makes the --stdin check redundant. I.e., here:
>
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 08b340552f..c46b6e4061 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1970,6 +1970,10 @@ int cmd_index_pack(int argc,
>>  		usage(index_pack_usage);
>>  	if (fix_thin_pack && !from_stdin)
>>  		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
>> +	if (promisor_msg && !from_stdin)
>> +		die(_("the option '%s' requires '%s'"), "--promisor", "--stdin");
>> +	if (promisor_msg && pack_name)
>> +		die(_("--promisor cannot be used with a pack name"));
>
> ...just the second one would be sufficient, because the context just
> above this has:
>
> 	if (!pack_name && !from_stdin)
> 		usage(index_pack_usage);
>
> So if there isn't a pack name then from_stdin must be set anyway.

Nice findings that leads to ... 

> What you've written won't behave incorrectly, but I wonder if this means
> we can explain the rule in a more simple way:
>
>   - the --promisor option requires that we be indexing a pack in the
>     object database
>
>   - when not given a pack name on the command line, we know this is true
>     (because we generate the name ourselves internally)
>
>   - when given a pack name on the command line, we _could_ check that it
>     is inside the object directory, but we don't currently do so and
>     just bail. That could be changed in the future.
>
> And then there is no mention of --stdin at all (though of course it is
> an implication of the second point, since we have to get input somehow).

... a good simplification.  Not of the implementation---as it is
already simple enough---but of the concept, and simplification of
the latter counts a lot more ;-)

Thanks, both, for working on this.
