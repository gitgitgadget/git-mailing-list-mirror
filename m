Received: from 3gy.de (3gy.de [202.61.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CCD482D7
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.255.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435490; cv=none; b=p3kT4tTD1MQ6W5QIuRAOCVqf1WRYWDyNqn28ky9LjLN0+I26zSnQSVxBJ/eADzJmIKQsjCslbZ75U58YEjBqoLJOPEV3FnhAnA8rVNepuBcHHXVORf3vTC5TL9YXhkHep0vt1hLuh4h4IDJ+cykfZ1aoYTuqxmoDPG7zUuiHqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435490; c=relaxed/simple;
	bh=nZPOpUiryeY2DvwJz+ptu8zFo++/ChY2ngif37apI6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRU+VRmMkLPchuhUNoxW0QF1zwfZ7jCxc5zC9mWrP4VXKkRY2WfXShEXBskf647nox8f6OMFW8Gw9GlLdyG1oH1hk80bqXl+TQA8tsPUgcAx5cvPrzu5h0yL3aeTc8d8nv+7HI8pBMxnYgqNsRarxLSmgyOWBzr0/ldJ01uYgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syscid.com; spf=pass smtp.mailfrom=syscid.com; dkim=pass (2048-bit key) header.d=syscid.com header.i=@syscid.com header.b=I5Llh/8M; arc=none smtp.client-ip=202.61.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=syscid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syscid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syscid.com header.i=@syscid.com header.b="I5Llh/8M"
Received: from [192.168.5.158] (lysergic.at [185.68.249.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384))
	(No client certificate requested)
	(Authenticated sender: georg@syscid.com)
	by 3gy.de (FREEDOM) with ESMTPSA id 04EA73540796;
	Mon,  8 Jul 2024 12:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syscid.com; s=light;
	t=1720434950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=9NBHBaL524Q5AXNuDb6sokceIfsF4EjZN0l0ewpGsNM=;
	b=I5Llh/8MV8XMmkPXRu1ho/BWiBupyCvwgNU7POtkOW1wwIIi2x7T8MLeSgg46gswNtx0jo
	k5Sb5UmbEMPe6/CmppkIKfsvu8SkcJtYPPa7Q0SjHMLu3wZ3Lqpd4BwnEXHUf4KSmkB5ss
	AfvIne13G4AzyQtqqWdm+Ddj5C8cYoBvLW0RpFwSRaUQA4IQkNmsJxQk7CI3RUxd4xdJZU
	jSlSq1uNJynkvc+ya0Nn8KJ3eQ+sRgA0KXyPh2wzobIPDSTw2YPsZpsgmAG+dMZSM/djeJ
	PzCWmpttlUR7Zx+NDlnMFFenRtPFBTJd6Mt4VXDdY8Vg5tgiHDDe3f+OGXnEqQ==
Message-ID: <d3921679-eeb8-4cca-bc0d-967e9e567fd4@syscid.com>
Date: Mon, 8 Jul 2024 12:35:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is
 provided
To: Chris Torek <chris.torek@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com>
 <CAPx1GvfkC0rv_8_q5_HfduhuKX4csO+sBZiZqV+Sh+Q0dV8+4w@mail.gmail.com>
Content-Language: en-US
From: Georg Pfuetzenreuter <georg@syscid.com>
Autocrypt: addr=georg@syscid.com; keydata=
 xjMEYP4ABBYJKwYBBAHaRw8BAQdAGRcet1cOGT+IejiQ4pe4FLnoQjFlftdc7RQcy1GXYAvN
 J0dlb3JnIFBmdWV0emVucmV1dGVyIDxnZW9yZ0BzeXNjaWQuY29tPsKRBBMWCAA5FiEEP8y5
 xN1VTzTg6AyMPa/ybD555YgFAmD+AAQFCQWjmoACGwMFCwkIBwIGFQgJCgsCBRYCAwEAAAoJ
 ED2v8mw+eeWIUJAA/1la/PBCwI2SCzryFSkO9GBVkmr+T0bNDLRgRGpFH2/DAP9brlOfg3jd
 ypCRS4E2i/angkiZtrm7308U4JOcA9ODA844BGD+AAQSCisGAQQBl1UBBQEBB0BdKJwL2WgH
 sH4xx+ZhWkw4kF6pRpJmG79K8cvhpS8wCAMBCAfCfgQYFggAJhYhBD/MucTdVU804OgMjD2v
 8mw+eeWIBQJg/gAEBQkFo5qAAhsMAAoJED2v8mw+eeWIdjcA/R7NYDoA23hdax6XPKrjeM9H
 4N2JhY/CO8+qHVtClUjUAP9erXFrEtTmuB1fXOjruD3EPbO6tj75gk8QZbeHFxTnDA==
In-Reply-To: <CAPx1GvfkC0rv_8_q5_HfduhuKX4csO+sBZiZqV+Sh+Q0dV8+4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/8/24 12:18 PM, Chris Torek wrote:
> The `test` command has AND and OR operators of its own,
> which give `-a` (AND) higher precedence than `-o` (OR).  In
> addition, `$#` can only expand to an integer value, so quotes
> are not required, and the whole thing can be written as:
> 
>      if test $# -ne 1 -a $# -ne 3 -o -z "$1"
> 
> (which is what I would do myself, unless I wanted a separate
> error message for an empty "$1").  It's fine as is though.

Hi,

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html states

"The XSI extensions specifying the -a and -o binary primaries and the 
'(' and ')' operators have been marked obsolescent."

suggesting "&&" being preferred over "-a".

> Chris
> 
