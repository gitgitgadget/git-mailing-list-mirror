Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F912B83
	for <git@vger.kernel.org>; Sat, 25 May 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716631832; cv=none; b=kQAY/VmNscGsKrh70HJq5EipmobdEYgKR9EGrbmzHhLKsxMIWBu7/eKb6odZnDfR+OYT9Ifk7yg6PNMEO+g68wUTCfnDgmapJEoFOc2Q4s12ryvEydvtS7srI1v3FUdvSicvEkqhPan7ze80YbIMKHLOHrHkyW9OJuoRBSDd9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716631832; c=relaxed/simple;
	bh=4Z+OhK3+0Hqq9rNasOWNcazrrTIYtdmMO4/4afOjfbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9t9B6bH/CqsRF4bK3itBANYrp3A3cgumkGT9U8HNxxIwslCQtOqJiMeYjA3xVGnUyT3pl6Yqz2rbzrRaYqmqHjePIpH87+EBBD0JY7kiyNhaj4i9O/F5pn1nuFOBKz0+bsPlYqG5p9N1oy7SsF1iz1NT8CVk+YyFvMPy01Iahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=p8G8sd6a; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="p8G8sd6a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TiMuxHwHVnt5LtmGR5r6ODwTx/aCMjUvWXvPJwZkWyE=; i=tom@compton.nu;
	t=1716631830; x=1717841430; b=p8G8sd6aNV8MpLp8cE6cqcrSOanalwpcItttZdP287lpK5d
	ZF5l8Mp5UqS8hEZqllourYuTHAnz9A/bmji7mnuYUd9gGVL3D8Ke8cvAuG205LG6ycbHgZRwX4tr/
	SY1B6WJlEZqw8xbrgxPQTHAnXKdjmlgePzr5jP5UyS/YIkPFtl8+870eQ05jwWX06SCTOoCSPCCjQ
	O5y3b/qUieA+iBo5y9BKprI6G4wuXiNAvrcZR0r9A/cZixqFcTLGkrcfSRVuGvKeBAEfc/tbiFmaZ
	mHnlZVs/jtoMlDkO+eAjF0izWBkqGWYIKtBqgP8XXPucXivNoHQfFWkVEIG+L5Qw==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:38432)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAoM5-00000009r3p-06vq;
	Sat, 25 May 2024 11:10:28 +0100
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:57550)
	by bericote.compton.nu with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1sAoM4-0000000CNWH-3wHp;
	Sat, 25 May 2024 11:10:24 +0100
Message-ID: <ab69eeda-65d2-4e38-9abc-fb1230fe8ab6@compton.nu>
Date: Sat, 25 May 2024 11:10:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] promisor-remote: add promisor.quiet configuration
 option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jonathantanmy@google.com
References: <20240523131926.1959245-1-tom@compton.nu>
 <20240524090937.2448229-1-tom@compton.nu> <xmqqa5kfkrsu.fsf@gitster.g>
Content-Language: en-GB
From: Tom Hughes <tom@compton.nu>
In-Reply-To: <xmqqa5kfkrsu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/05/2024 19:06, Junio C Hamano wrote:

> Wouldn't we want to see this as three (or four) tests,
> 
>   (1) "setup" that prepares the server end
> 
>   (2) "quiet=false" test that
>       - makes a partial clone,
>       - sets .quiet to false,
>       - runs cat-file -p,
>       - makes sure that the lazy fetching is chatty.
> 
>   (3) "quiet=true" test, which is the same as (2) except that it sets
>       .quiet to true and expects the lazy fetching to be silent.
> 
>   (4) "quiet=unconfigured" test, which is the same as (2) except that
>       it leaves .quiet unconfigured.

Sounds good to me. I've sent a v3 with those changes.

Tom

-- 
Tom Hughes (tom@compton.nu)
http://compton.nu/

