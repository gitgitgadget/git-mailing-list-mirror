Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795452154;
	b=KvVFKzj1I5Jcr+4gV2oEJVxJGgb5MH2WrWRI9Yl5mNgEsCdVBoa0F4gtuZNst+K3MFQg
	 mmx0fZAUFeS+6CMN6Fk/vjvaIWSpW8J6PjWEhzaQyneq7CNCFtHolA4XwKFp84a+fCVcs
	 /6EcpIXHYgVsO0ZnoDlch+Olt2MxGt+PSnNem6Plj0Egz1yhs4qrBQY+rQgN5LbnworHd
	 FrleUccXo6UnuADQkFI4YekhgoIu31tunHMlB0TYcG/CgFa/Wo3a3QXzH0NdUEXbzb5Hb
	 L7NyRQf4vmihIo1NmKxbZk8V+1Z6f3/ethCB33eDnTys30zT+WNDmZp2s6J3AUTnVxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452154;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=qqeIWkaUoS9pVqC+QTty+GMhTL97Alz2YNwoIvDOM4o=;
	b=4j3Pt5MHyxQ0wHRfnp186lOq9USgQa6LD9UM3QfoQhXb3kVnoNwxs6cxYZOAnxkvBhXX
	 EPY2zjmFVI161EqvS6IsUQ0uFlUlfzoWS0dbIDiChiq+X+LCiQl/jkSQn4JO7IcZBBX/y
	 K8TWxfjkEGE1s90j06vD4fq8hZMh4rsgnKon9wDwPH3uoNXxZpewq3gC/qcCAv+QxSTmv
	 MErmbTWGDp+/tjerGiby0KHjqRHnFbBMcuTABZyAhHsXA2SPB/qD8ErAvtTG9uc8fARh9
	 pIKuuLcWSBxdf0pSeMq57fVkfE5xTf4QK83Jm02SJoLO0bOsJWcpGVfqd4tPl31TbMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GJN88F58;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D65606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GJN88F58
ARC-Seal: i=1; a=rsa-sha256; t=1795452113; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=muhqo+vIjd1fRggNgL1Xdo3AyaXAS64lCd8ZyOqyz4jm3UDhrwZ65IOweGTTQhzq60R86lIHIdcDU2+4xJN1v4qI62hSj8GwEuqkHpyVWBRyMvygLw1r2TFNFYop8EOzQ5LLLi7go7LYtKfsQy/ofx27KKUPlPWESAk4bDO622s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795452113; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qqeIWkaUoS9pVqC+QTty+GMhTL97Alz2YNwoIvDOM4o=; 
	b=D2Q4ftflETbuJesRRE68ovWiMfOF3NfFq1lMk3PjNW1dLY5cm46fN0cenJ+FLL7WLyRGuw2RxeDsUy9fhykxPBhmDy0weABaRfNqgEFk8S6weiRp0ygCgYbrdY9SDn/IlN/Y7KdW1ctQrKbOYfz+yqjuf3ab0ODj1j+ZMJCgoRU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=GJN88F58DB1VJy4J0FrQX4UbgpvGAO3zIC6TE6MhyEx78CzfFv1JwsoPwWJl5yVWjXuNqKVlNyOMqqghbtaXwH3xE4RmBZ6LN2IsIgd5ygrK/VUJs21wuu8aCMDwUImFNHe+jjPvKJNmQK3t2TrwPY/pE4kpMRrcUlC7v1CJWOw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=qqeIWkaUoS9pVqC+QTty+GMhTL97Alz2YNwoIvDOM4o=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795452111614872.6845822488342;
	Mon, 23 Nov 2026 08:41:51 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, "Eric W .
 Biederman" <ebiederm@xmission.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] object-file-convert: copy unknown commit headers
 unchanged
In-Reply-To: <xmqqa4n3nn1l.fsf@gitster.g>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <cover.1794932695.git.adrian.ratiu@collabora.com>
 <26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
 <xmqqa4n3nn1l.fsf@gitster.g>
Date: Mon, 23 Nov 2026 18:41:48 +0200
Message-ID: <87o6bfqz3n.fsf@collabora.com>
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

On Fri, 20 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> diff --git a/object-file-convert.c b/object-file-convert.c
>> index 63ee18630b..ae21eedc3d 100644
>> --- a/object-file-convert.c
>> +++ b/object-file-convert.c
>> @@ -167,7 +167,7 @@ static int convert_commit_object(struct repository *repo,
>>  		if (!eol)
>>  			return error(_("bad %s in commit"), "line");
>>  
>> -		if (((bufptr + 5) < eol) && !memcmp(bufptr, "tree ", 5))
>> +		if (((bufptr + 5) <= eol) && !memcmp(bufptr, "tree ", 5))
>>  		{
>>  			if (((bufptr + tree_entry_len) != eol) ||
>>  			    parse_oid_hex_algop(bufptr + 5, &oid, &p, from) ||
>> @@ -179,7 +179,7 @@ static int convert_commit_object(struct repository *repo,
>>  					     "tree", oid_to_hex(&oid));
>>  			strbuf_addf(out, "tree %s\n", oid_to_hex(&mapped_oid));
>>  		}
>> -		else if (((bufptr + 7) < eol) && !memcmp(bufptr, "parent ", 7))
>> +		else if (((bufptr + 7) <= eol) && !memcmp(bufptr, "parent ", 7))
>>  		{
>>  			if (((bufptr + parent_entry_len) != eol) ||
>>  			    parse_oid_hex_algop(bufptr + 7, &oid, &p, from) ||
>> @@ -192,7 +192,7 @@ static int convert_commit_object(struct repository *repo,
>>  
>>  			strbuf_addf(out, "parent %s\n", oid_to_hex(&mapped_oid));
>>  		}
>> -		else if (((bufptr + 9) < eol) && !memcmp(bufptr, "mergetag ", 9))
>> +		else if (((bufptr + 9) <= eol) && !memcmp(bufptr, "mergetag ", 9))
>>  		{
>>  			struct strbuf tag = STRBUF_INIT, new_tag = STRBUF_INIT;
>
> The explanation in the proposed log message did mention these three
> headers, but I do not think it sufficiently explained why comparison
> started to include the equality case.  It said:
>
>> The "tree ", "parent " and "mergetag " cases only matched a line with
>> something after the space.
>
> I do not recall the details of "mergetag", but I fail to see why it
> makes sense to start copying a line that is "parent \n" now.  If it
> is not "parent [0-9a-f]{algo->rawsz*2}\n", do we still want to pass
> it to parse_oid_hex_algop() in the body of this "else if"?

It is the other way around: the "<=" is what keeps "parent \n" from
being copied. :)

This came out of my discussion with Patrick on v1, but you're 100%
correct that it's hard to follow and I'll split it into a separate
preparatory patch in v3.

Then this patch will only be about the unknown headers because they're
two different things, one uncovered by the other.
