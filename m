Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381734FF45
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882003; cv=none; b=BJDNSb3aKaoLJQp7Mofj9lJ2tTpEuBAUYhcBQNg/PcMX982ZxHdxHbIT+Pw0JeaVFUQ3mLveg/nxekYodT10OiG/jzCV9EO6iS+HPedsDr4F6bGF0UugJsCR3Ml4NtyRjHFjKpkgGvH9lFjNV+s3e3owDtOzc1vVwrGleq3UBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882003; c=relaxed/simple;
	bh=UOO5Rn3MOr/rCUyrUvTEji1SQTbCKmbmDYgjm7cTzlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4hVD/uFY4lAGLzXL2Xqn+PaqTswXvBqcWhCre+hrx0THnjQaQlqa00ygR1W1O1NgRV/u1gI3lK2Gd8Ul1MLiED1v/DpcK43ruNk/AwLX56w+JOJfz0cMsbE+/F+2/yHu3fUhTWpiUyIB8xMWmiUmccmzNiC/LLXHiTJNxinAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RgFGbeap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7m+Oo5+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RgFGbeap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7m+Oo5+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CFB3AEC01CD;
	Tue,  4 Aug 2026 18:19:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 04 Aug 2026 18:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785881999; x=1785968399; bh=mxzgmPZNqR
	LZulKoM39PC41c+0LCasuIJGvRLVyxsUc=; b=RgFGbeapELVrRAcIaBTlxDL6qu
	CAmbStcoDNJ6shYzSeQPDJQGXnB4u8hYZ+7H/SfYvVcmVVnSfsZo8m6+2p/9LlV3
	3eLqGUIL65k+f2X5hF/+1WhA9MqucbZ+E38swQ3RpZxhaDPvRUjnb8gALpnnRWAx
	a0PWhhKwmSI52uh0ytXdXqbQgwJtlPI8bcrGsBlVElpFCGCAPyZvL/Fpgo7NEnMC
	GFDZps5/BS9SU9i1cEtRxCa4Ea13pnCO4kIUWHWE+vOeKbKnIuP1n5AvR+jXecq8
	9CtoGahPTWgR85vITojBCILPN2p0SMbg5NrgmSriaiJBv+jKYrUP3Idt+KtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785881999; x=1785968399; bh=mxzgmPZNqRLZulKoM39PC41c+0LCasuIJGv
	RLVyxsUc=; b=h7m+Oo5+o8wjypRoFIvVGrZ2O56Z0SnT8Rs4g34znU3+EnEU3YQ
	OewE5u/uK1cDgEJWDHSshsuCTUKlNNyoUXfWI61kjAM7lLoUFpZtHT1LWDRIc5pd
	OoBWVJSRWY9ksW8VdsAOG9N8Ve6sC2WK+LPof6rlEvS3CXKxoUN6WF3JPujzGKKy
	oB7TYAKzPZfSmzLInifuPPJUoO7Z6xenxkqO5yYpudAvNsTMGNa6GSQI2r9JO9wP
	ixNtQNr9SAsqFixZ+B6GW0HYk1guq4Hb0ceUrNXe3ldgt5KoRe/45/K+J5LDKhd4
	Q/+fCZuy/6V2XRam9p+J8aPFGnbuS6D3lqQ==
X-ME-Sender: <xms:j2VyakDHutWYl0bLdRHzHRchTOXcQlINZ1urMpip38ScgYnWKArU9A>
    <xme:j2VyatY8txl7-_Jq0rEPQbvcj3ZJr7MKF6DOjuvTWTfyPmrxEUjpAiSH2w0yvgVaR
    xHdM4AxdDQFW8DdEOV-nl-VgRtF8ojISQCeISjeLUHXy60blO50kH4>
X-ME-Received: <xmr:j2Vyav69B-ATA2NifuKPGUB-r-sqbjwPZYrQhfEP8OYuVXS8MkXJmGxImgcPGC1JZezJCJRzkkKs7RPd1Bm0mTxVzizX4zZxRg>
X-ME-Proxy-Cause: dmFkZTGW5zLm2wZe15j9Dn/LBbRxPxj3OaYExWXfEO4K7UBvUEojTlXHNYf3Rllc2EzuFb
    yYNmXAWdnoWXkTinVaJFIcig61yu9HcrGLQa9JfQeOqkjt5OIFSD6NprTrCociMWWmE/YG
    YyGT2EvZEXgBYFnfMLHYZ4XJho8GwKOIg3X2jeqpRWfm1txKJmstz06KybrvV21N1tqq8u
    vcrHVXAs7wnJLofIPDnhBTYgnow+XL+AiMJoIUHAtBuf9af9ziwhP9pL/QT/H0rwkgFo28
    PaH0pkgN/Ziww96EAyhEqLTcDTUixxrrUiFwgTUVdNI+uZsMnavsxBCZKl9eXLMxF66je5
    WPBjOlvJrQxIR1/el0DRih+BGxEwXMs+bhO3J1dyFR376HSevDZVwomu6hXEszOwieM4wU
    MiM14K11f5q73HFdXGaddjRKgqJVBnY0YT+FHiKkDj3s7oF2ZEzWbaMr5sTHYmBnkUUtHV
    uaHnMLjdP+48kYNLw75cXbbQizdtuMeE9a6zXEwHyO834FFPX0syijpo2bwQiqFtQd+Avu
    OjZxXQlv/Qgx+0vs514+iVhLNe6pOH2EcEVjqJJehT9qQIBa+HqgLnrVwPjjzdCATdMb5O
    ajfvxR0BEy1BljXNIwcyhMMxv697LLIH8rgDAHichndYcZIEzn4+h8V/J4ZQ
X-ME-Proxy: <xmx:j2VyamZDx0c3sfLWxVlM3-iEk8TbJPJUcVWK6xCfWNsdl0j2UFH4OQ>
    <xmx:j2VyamgTg2F7_3TdiBZuERAF9AnBN83UgF_N5KeJQMLeRaEvBxg6Yw>
    <xmx:j2Vyav8MG2AqXhTyxDFZIoslo1eUo-3BXCLcZDC5uX90XWjS16L6xA>
    <xmx:j2VyaprqfqyrN0kG_SpSaPN276S3HunDE9NTt-PwqFm8iKEIu8rAQQ>
    <xmx:j2VyarN8-RHc_2wRrgPXyFq2B0VI2S0KChcB5McT4PP1lNveATnVBWNo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 18:19:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>
Cc:   git@vger.kernel.org,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 4/4] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <20260718081407.GC22588@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Jul 2026 04:14:07 -0400")
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
	<20260717-toon-speed-up-last-modified-v1-4-410418f18614@iotcl.com>
	<87a4rp1l65.fsf@emacs.iotcl.com>
	<20260718081407.GC22588@coredump.intra.peff.net>
Date: Tue, 04 Aug 2026 15:19:57 -0700
Message-ID: <xmqqzez1sf3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Jul 17, 2026 at 09:16:34PM +0200, Toon Claes wrote:
>
>> > +	/*
>> > +	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
>> > +	 * without a Bloom key. Restore it so the per-path check keeps working.
>> > +	 */
>> > +	if (!lm->rev.bloom_filter_settings)
>> > +		lm->rev.bloom_filter_settings =
>> > +			get_bloom_filter_settings(lm->rev.repo);
>> > +
>> 
>> @Peff, as far I could tell:
>> 
>> * This change was not needed to be able to use the Bloom filters with
>>   the pathspec.
>
> Ah, right. In my earlier attempt I came at it from the bottom up: I
> found the bloom_keyvec, saw how it was populated, and then worked my way
> back to prepare_to_use_bloom_filter() without going further.
>
> But it is much nicer if we can rely on prepare_revision_walk() here, as
> we don't need to make an additional function public.
> ...
> It's mostly academic, as both of the pointers (if not NULL) would always
> point to the same setting that ultimately come from the repository
> object. But it feels cleaner for them to keep their own pointers,
> because that pointer may also signal "do we have usable bloom filters".
> We are a little lucky in dodging a bug here: last-modified uses the
> pointer for that purpose, but if revision.c did so also, they'd
> conflict.
>
>   Side note: this is really a repository property, so it would be nice
>   if we could just do:
>
>     repo_bloom_filter_contains(filter, &ent->key);
>
>   without managing the settings pointer ourselves at all. But the cost
>   to fetch it from the graph linked list is not totally trivial, so we'd
>   probably end up having to cache it somewhere. I don't know if that's
>   worth it (plus last-modified would still have to keep a boolean
>   somewhere to decide whether it is using bloom filters or not).

So what happened to this discussion?  Are we happy with the set of
patches in v1 after all, or are we still thinking it over?

Thanks.
