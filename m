Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795030429;
	b=HvGylcxMQudx+RVQWYVx/XVqp6sO95QY6j6M4lIqzQZy54By64bKWHLOLmSkocz5bxn9
	 l97NXxAIEaBMpg03IDu5o1XAk49t2Huyu85Gcjqv3nzHFfMTu7N2TuRiO5VMAVePCytqr
	 s3e6qFgatped3cu8F59a0pTu014LQekrTeztCVI0BeFqkr6Gn5UfG2SCH7sYFX+nVi9bf
	 CFrKCO0ln/ugzvVpZhhWkAnD/Z5c3UrOnjQPMiB1tdsJnvVzxGi+PTgNPUZdCwojN78bj
	 VmtuSMOoOc2KYU28WAJct/kidkLRVJrEaD6p8xz5GpsJ+7ofRxtACsQjOaR9rRRDx5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030429;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=bobzesAlZx+G2IcjZ+oR/JrlT/FIVHHDu2foaEk3mDQ=;
	b=ipfQOEc91fqjPccNIgwPlgrmXM8XNW/ZqvRvcNgPhCwT3Zt53q0M//nHXICVV+aLQNzS
	 oyVfmWw7gxkqrt6Rn5w6sT2RsYXzZmj+o1rXM10xh5GKt0gYZ7Sco52wliOZbCDFJC5yT
	 GoFBgn3Xivuk91ugqoIbbASuBpQww+hSTgWyQBS1yfSCDMZFWgZBBUR0z7jkFOPotLllD
	 f03IHzTvgLrURNKYMl4lQK0S5IEO5znsOImgn2kYOZ8+xYtjo13xgsEUKlls8mLvu1x81
	 9EXIM7rYN1EAdAdY0eS/a7Cu0P7hPnfj8ut2fHxufftLJUu6qHEwQPAXYzWwzFA6ggg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Vl5u79G6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6C606B411
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D6C606B411
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Vl5u79G6
ARC-Seal: i=1; a=rsa-sha256; t=1795030415; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ROLt7USlZnP9AH+0EiRhLDOUG7wKg0Q3+ms8deQtFUCLwnwHfqrqVqtWqYuQL5vI8FB8x6WuIfZt3EUXItgeaOWMJVDEIvZnm0azNS4j9RB0jXpC7jszIs+RLQfiYbPyw+M+W0k22HHbIq9BuUM2VSul7VQJxwAkOkN7istMt5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795030415; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bobzesAlZx+G2IcjZ+oR/JrlT/FIVHHDu2foaEk3mDQ=; 
	b=oH2D9WsbM6UyGsT4pUEi0fWAj4NRDMEZiWSkeWeyUnl/a/gACdgOANKeykVV7xJC+LDK5+yQ+2D9cvFhaynxWPdeRxE68HE2HDIwPTWqr+Yw2Pewp3TRzrPQ66J8guOhuyszcyKb6mjL73V0njV4eX9XsIOGLYmzT96QtAOQ3xQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Vl5u79G6yfofM5iKqn2MtkMMrpigMgJjWkpoCgQTyRaGyf/G0MW1PwJBaqfQjeI/k7hIwAobFt43OSK4kzA2vCPWVY04y9ip5EnVtVDygr1RXGDG0kD/bA3BbXZxIyCltLOWDILq6eNgAap4p+3+aUXC/V5+mHGtfOLpkG3TM9I=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=bobzesAlZx+G2IcjZ+oR/JrlT/FIVHHDu2foaEk3mDQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795030413964194.5349348168229;
	Wed, 18 Nov 2026 11:33:33 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Andreas Wendleder <gonsolo@gmail.com>, Phillip
 Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] submodule: return an error instead of BUG() for an
 unexpected git dir
In-Reply-To: <xmqqecci54tw.fsf@gitster.g>
References: <avuJBGlB3pRU3JU0@pampelmuse>
 <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261118163249.1693361-2-adrian.ratiu@collabora.com>
 <xmqqecci54tw.fsf@gitster.g>
Date: Wed, 18 Nov 2026 21:33:27 +0200
Message-ID: <874idej5o8.fsf@collabora.com>
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

On Wed, 18 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> 9cf8547320 (clone: prevent clashing git dirs when cloning submodule in
>> parallel, 2024-01-28) added a caller that passes a path read from the
>> gitfile, which made the BUG() reachable.
>>
>> Return an error instead of BUG(), so the command dies with the same
>> "refusing to create/use ..." message as when the submodulePathConfig
>> extension is enabled.
>
> Makes sense.
>
> The above archaeology was quite illuminating.  It seems that the
> offending commit came without the usual on-list reviews as part of
> the Git 2.39.4/2.45.1 updates.

Yeah, I wasn't part of discussions on this, so I don't have the full
context either, but I do think switching BUG() -> error() makes sense.

>> Reported-by: Andreas Wendleder <gonsolo@gmail.com>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  submodule.c                 |  8 ++++++--
>>  t/t7450-bad-git-dotfiles.sh | 14 ++++++++++++++
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 1302c11ddf..d00d820d42 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2410,10 +2410,14 @@ static int validate_submodule_legacy_git_dir(char *git_dir, const char *submodul
>>  		BUG("validate_submodule_git_dir() must be called with "
>>  		    "extensions.submodulePathConfig disabled.");
>>  
>> +	/*
>> +	 * The git dir may come from a gitfile on disk, so a mismatch is
>> +	 * not necessarily a bug in the caller.
>> +	 */
>
> "is not necessarily a bug" is not incorrect per se, but it is only
> relevant in the context of turning what was originally a BUG() into
> a "return error()".  If this had been written to return an error
> instead of calling BUG() from the beginning, you would not have
> phrased the comment that way.
>
> If this if() statement needs a comment, we should state why these
> two are expected to match, or why it is an error if they do not
> match.

Good point.

I'll drop the comment addition in v2 since we don't need to over-explain
the BUG() -> error() transition.
