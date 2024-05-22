Received: from gosford.compton.nu (gosford.compton.nu [217.169.17.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C53D97F
	for <git@vger.kernel.org>; Wed, 22 May 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.17.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409089; cv=none; b=mHmcOdB4YLKI9G9bHiszLWNN9RqeJyk+6B7QMOW0dGuiOoC/E2Dik70FizQOyUKaehALg/Q/frDkKPNprMEpIeZ6tMAJfynIwXKkAJZ/+MJOdwFeyqUDEoHs3gek7jfFv1RY7zH7g0dVL3zZ1NH9F4ivxt8swe5Vs7yXW//n5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409089; c=relaxed/simple;
	bh=yKvm7hJDaaV8h3OfvCbk7HdGQmFjrCM3aWlkOUkY2/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMIrWrMh22BiwlW5Jp2WjJ1oSuOzhhtkpteGAeCABVG+g0E/DhKCsktRSn6YgqJ8dr/TWw1A+P/WvKy0pOTHzH8Z+3LFEwLNQWqY8O57v6JV+rJIonuY/QwIsKm/jH5mlNiD1cmTtUQd/rWzMYwdz8oQw3Byj/wFQe1/LW4f83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu; spf=pass smtp.mailfrom=compton.nu; dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b=iKlpfMHd; arc=none smtp.client-ip=217.169.17.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=compton.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compton.nu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compton.nu header.i=tom@compton.nu header.b="iKlpfMHd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=compton.nu;
	s=20200130; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KhBlwq7ZEEV7Uk+3aj7oN1/rKcBdne6TbXzDDm8Ozs4=; i=tom@compton.nu;
	t=1716409088; x=1717618688; b=iKlpfMHdtbV007fVJm1iOGqLD33aLg9Ba7vMm2dJZ3L/tNY
	UmAPVdsNz7wHG0eelsP0tKGfAExfG7q9nXjQ1W2s0Rg0Aorh7ftaW+8bmXahLFjHlhIMyqHU4kifD
	fbPseQp/XFW3jsxG0x44D6UBKoMNgoMWMzIj7GJ9bbJgw5pOhJIeZPpHMzV6IeLBGjr09akezljR3
	X0Di7N5CBnt97fRvaTkt2HHT4FA6TRxcJhuIqEWvJ0ERTzgKWCyjnUJWT4sQ7LXxo73d4ByYmWLYY
	sxWETxRS2arm/zXkmLOXaJ+Oa5ko7q89HIpposMK1Zn5sgFnewIQaPVr0vTPO6mw==;
Authentication-Results: gosford.compton.nu;
	iprev=pass (bericote.compton.nu) smtp.remote-ip=2001:8b0:bd:1:1881:14ff:fe46:3cc7
Received: from bericote.compton.nu ([2001:8b0:bd:1:1881:14ff:fe46:3cc7]:50354)
	by gosford.compton.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9sPQ-00000007xz3-3cKm;
	Wed, 22 May 2024 21:18:05 +0100
Received: from arden.compton.nu ([2001:8b0:bd:1:9eb6:d0ff:fedf:c161]:55576)
	by bericote.compton.nu with esmtps  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <tom@compton.nu>)
	id 1s9sPQ-000000072eY-3Et7;
	Wed, 22 May 2024 21:18:00 +0100
Message-ID: <a546ca21-22ab-4a0d-9afa-e5c91830a5c2@compton.nu>
Date: Wed, 22 May 2024 21:18:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] push: don't fetch commit object when checking existence
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240522133621.1308393-1-tom@compton.nu>
 <xmqq8r014pyn.fsf@gitster.g>
Content-Language: en-GB
From: Tom Hughes <tom@compton.nu>
In-Reply-To: <xmqq8r014pyn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 20:16, Junio C Hamano wrote:
> Tom Hughes <tom@compton.nu> writes:
> 
>> If we're checking to see whether to tell the user to do a fetch
>> before pushing there's no need for us to actually fetch the object
>> from the remote if the clone is partial.
>>
>> Because the promisor doesn't do negotiation actually trying to do
>> the fetch of the new head can be very expensive as it will try and
>> include history that we already have and it just results in rejecting
>> the push with a different message, and in behavior that is different
>> to a clone that is not partial.
> 
> Interesting.  Is this something that is easily testable, perhaps by
> preparing a partial clone and try to push from there and checking
> the non-existence of the object after seeing that push failed?

Sure. I think I've managed to figure out a test and have sent
a second version of the patch with it added.

Tom

-- 
Tom Hughes (tom@compton.nu)
http://compton.nu/

