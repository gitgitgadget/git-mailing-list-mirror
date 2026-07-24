Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E223438013
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908710; cv=none; b=bvx1GYHSZC4TthuOz49XtmlooGOY//dZgiRm3mIv5wsIrMqLgo9bRy2hjM9QQv1Fd2xNDe+5myXPi7SG/UOCqsJm4RNOzqEd8JQV+FPFu/PmXEF2KG4OASWywlyEtWjNd3G3QgIXY4rFM410d09c9Y6JJdYmLEaCyOrF+tdvxDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908710; c=relaxed/simple;
	bh=1j1kz0KVMwKyKWP/0xDVTgt5st8d6pS/cD89OAiS1Tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJOdyzkEeSqkx3rTfi6VMDMyPzUYNDp5iVlpQ1BRCFQh2diAjzbyIkWmVptq5YwSLZ5XrCaQj5BbB3aJX0/Cs1EIyo0fDbkZIuum7G3PAlvQIW//ITaX8G+zZXLo8AbOGuiLhw+Jy2FD6cPQHVaW+UmFDrep33An+pHDvAoVWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PNDVZap9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGGJ2dji; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PNDVZap9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGGJ2dji"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BA3B7A018B;
	Fri, 24 Jul 2026 11:58:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 24 Jul 2026 11:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784908708; x=1784995108; bh=0qU2IPtzMj
	hdgm+xTj4kl5We4/xesOaKSTRrICSC570=; b=PNDVZap9M3CjbFKprU3N09M9A4
	wgCozwwUztsAL/5c8vxKq3JIgd6NpuAZ9mynNNZwe/tELPpYtXyht/XjJpSFJbfL
	NyA/lXwlOr//13l5LQttsh8/Og75hAVcqDbjn+TWNmMIU2BSc/njvrFIbfVZLeXS
	cpML/Rs/5xi3FyZ/RI+Ft0PPR6tYEY1WpRvijFerLABvlT7h84mM38di6IhvbQtU
	S+AsQtSnq5extgh5YpbpQP/i75r/k103wAlD+h+tOyYzzqNT0B707DzcRbXRQzmm
	v5yulgWjZ5/G8o1x5zXjm9ufCzaVYRjmWoXjzgJswnl+5zOBFc0roD9BV9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784908708; x=1784995108; bh=0qU2IPtzMjhdgm+xTj4kl5We4/xesOaKSTR
	rICSC570=; b=bGGJ2djibB1TtXwgBkCcq0g2YlB/HtYGvZ0b+/DIxBIUh3BUtk3
	RMZjLrzI5T3x1+X8u6+v1ojYzNpIK1CkibL07j7NKW1Hib9OfmivJWxAKzwyHm0n
	qSO8xKKVcB/m0kHbpZkHvCWtRVHpFf9ZS7OXjGRnNspWPWATfcZebMDL1V3KX4ii
	gksbdZDCSKGPKwURXfs32Z7vIDafZS4xYOHjrPnvFoH4UlrfoMSDh+ixb5/hVuIe
	/zH1FlKr/5qA1Hv7roErIXtxMo1g5cN/9Tkm305elRJUYFbuxB28BHOrPTekD20y
	h4ZbxtN5gX/0BbscIRcie8PvBmwsweK4vIw==
X-ME-Sender: <xms:pItjauxKUNUNXBlgkWUMIAhW2tql3XP5p4H2pbZy97IsjVbsac0deA>
    <xme:pItjahLVPMuNDURqODl7Mj--YqJMUW-UC8qkjQRd_d1AWpQ6zwTPpqwpsLLpNg0_2
    dqXniwzHu-jDpBH2JGgX6ZnQN0juo8kwsfM9c8yARthp6aAYPkExw>
X-ME-Received: <xmr:pItjaop3_9vpMt8gny8k2jvJE5H8YVsI7SjZnK2eoFwdQn9a65WuQqXbHVF5zeuIggxxsCtA7xEiV37uxGC6iib5VNJW7FsM2Q>
X-ME-Proxy-Cause: dmFkZTFj8nskDNkswBtwjqZW4h8beSyyuJ/VKJ6ANouO33DjiUot7n1szPVSvJCEgpGMVb
    LE9eVi3tvUd3AkCjWLpyCDRFU7XBLrtm02zCJ1xCDe2bT6I8Rg5aoDrluZjDv45p1zLxm8
    S56nNe1TLJ7V/MktO3Zkdg3aI6JTp0lsb5MesVQHeAqi12fGoraM6c6W1ueEpAT2bOsb12
    JU4m40c8JkGofZ5cNizLtp2pPAEoPLnu0j/ql/isMYcnYCqavaejHLMezjWYThcB0EQDYF
    TP8koen3ZILSWB1C5m5w60Gl9BrhWquVC7PHsm+IB0viZmNhnuiJpJwmiRp6rmjwyLJSZ1
    +Ck37WWA67dXNU46seaqPeqp/bHKAG6tHK6rbU3UlZrcJ5bc3PZ+SgnNnkyDV6c9NWN5Sr
    QnmtB+IyQd9LJn489DvIK46nD4pK6cjCZ7sQRX3Njrw341nU3wjS0A3R+Pr/X0Lk6qGjsQ
    MbjVncQe9uvGqhjKFPsLHtkyDB8SZkW95FKXiyNMQd1gPL8TKSw4GBpWff29fqMjrsag36
    j9/jKBEcfWu+pWioSak1jo5cyilagpmhTpYxbu+LqZul09sCHTy/E6217atLtOMWaXlmWL
    CqGw9krClJdDP9TqdKckYFwBDYjzf8cKYC8uCc3J/oaYrc06A47GPOgAgRBw
X-ME-Proxy: <xmx:pItjagIMBZb1FmjPJ_Edbw_RyPkUETwE35zzEnzM8IlmGO--FOlkvA>
    <xmx:pItjatSl3WuZfltz01fJouFqsd9NvIAkcGbI_7sg7CvgvJGeZgCBOw>
    <xmx:pItjavtsyMvWDQdWGGAlrNv1NkmV3RTcM5hgQxSDZfJo-rYBUcZG8w>
    <xmx:pItjauYw3U26FkmzVEQ3i59yAov-ioeRGVJOVK9aZDNyv1wuyK9yMg>
    <xmx:pItjaod9kZanaDKnIvRqmn-iOoJWqyDvX1NWPR-Ao5Mnt1YIrFR0eCpW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 11:58:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: tnyman@openai.com,  git@vger.kernel.org,  haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
In-Reply-To: <20260724114948.GA825505@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jul 2026 07:49:48 -0400")
References: <20260724091152.27794-2-tnyman@openai.com>
	<20260724114948.GA825505@coredump.intra.peff.net>
Date: Fri, 24 Jul 2026 08:58:26 -0700
Message-ID: <xmqqpl0c8jml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The static-analysis CI job uses the ubuntu-22.04 image, for no reason
> that I can really discern. It looks like coccinelle 1.3.0 is in ubuntu
> 25.10, according to:
>
>   https://packages.ubuntu.com/km/questing/coccinelle
>
> Why don't we just use the more recent version instead of trying to work
> around it? That would fix this problem and prevent future ones. Looking
> at the code in question:
>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 42f2221547..2415a275ea 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -797,10 +797,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
>>  	struct strbuf key = STRBUF_INIT;
>>  	struct hashmap_iter iter;
>>  	struct strmap_entry *entry;
>> -	size_t i;
>>  	int ret = 0;
>>  
>> -	for (i = 0; i < upstreams->nr; i++)
>> +	for (size_t i = 0; i < upstreams->nr; i++)
>>  		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
>>  			die(_("'%s' is not a valid branch or pattern"),
>>  			    upstreams->v[i]);
>
> ...there is nothing suspicious or wrong about it. It seems likely that
> somebody else may end up writing something similar and triggering the
> same problem.

Exactly.

> That said, moving the iterator into the loop declaration is perhaps
> nicer anyway, because it avoids two unrelated uses of the same variable.

Exactly again.

> Notably:
>
>> @@ -809,7 +808,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
>>  	filter.name_patterns = argv;
>>  	filter_refs(&candidates, &filter, filter.kind);
>>  
>> -	for (i = 0; i < (size_t)candidates.nr; i++) {
>> +	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
>>  		const char *branch_refname = candidates.items[i]->refname;
>>  		const char *branch_name;
>>  		struct branch *branch;
>
> This hunk is not using a strvec at all. Because it uses the same
> variable, if we did not change this loop, then we'd still have to
> declare "i" at the top of the function and the other loop would
> introduce a shadowed variable. That's not wrong, but it is confusing.
>
> However, if we are going to have our own variable here, perhaps it
> should use the correct type? candidate.nr is an int, so probably this
> should also be an int, and then the gross cast can go away.

Ah, very good eyes.  It is a disease to try appeasing -Wsign-compare
without thinking, instead of questioning the value of the warning
first, and in this case there is no reason to try forcing the use of
size_t, even with the unnecessary casting.

