Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F6376E9
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255817; cv=none; b=J6/j6wej98DqxNjuszO8DCOHkH28wjELKQ76uK7iX7zjF3YQjomLUh/iXDiVYgGeMGBvGpNkiCPjQxRJy5gHaX4vAIL5X5+uCIz8SFFpAlQLTSodaS4h4SykmgkDxAVW/5JDiJuShno+4ZUTbTPDzpAnn5OtBQabnbUX8AMxNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255817; c=relaxed/simple;
	bh=ps/x6PKP/AghEy/wQhGtAuk0LJmBXrJGsreczkBZXRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JF1j/Ku1wP2cJZRv3v/NxFAjh0UvAWqS02SjO6vAeF/w3SOnwzbGHfDr0beNcmbzwvhL9rxRGFs54tCPPghozULKuay42qH47necJeJXzNt6FFEkTH/3r+Bmg4kTbHdliVJZjb4Mb8VDqObmhuA5nMgv6tlGP//kn3Vr/EIbS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ao92nbpa; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ao92nbpa"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UDGQs8S6XH4nFUDGRsF0LH; Wed, 17 Jul 2024 23:36:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721255807; bh=ps/x6PKP/AghEy/wQhGtAuk0LJmBXrJGsreczkBZXRY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ao92nbpafgO2Go+ooep5lXR3xEBQNqqC6WN2LVR6+fE6wbchOB26I/+ZN8QFUQlEo
	 3k+M0pdtnrg+vkUdhQ4nvPPgkdyvKqJcjkJ6dVbYSkVtUHbuhGa80c5QkQZx1QBRL2
	 aXxGFgGK8l0RTCQgDJUY15qd0KAu6eeP1mbOgG912quVbHihNIEDSdV0wVBB0r6LGp
	 RREcovMJ2VtxkAqErOTA9gnEifRICrevNosRlQ6urd0171QPVApfgUzR2utdCDOORS
	 4xkJSVk0Zpl9fz2tvrdYWb8Q/v7L+eOD84AOmnoYNzYr1m9fVn5YAEsdz8o8o8ac+9
	 Vj6m1c+Yd7DJg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=f5frB/yM c=1 sm=1 tr=0 ts=6698477f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=_ySnQ3258A5B5aaGMZwA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-AUTH: ramsayjones@:2500
Message-ID: <0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 23:36:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
 git@vger.kernel.org
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
 <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
 <xmqqr0br26ok.fsf@gitster.g>
 <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
Content-Language: en-GB
In-Reply-To: <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO0GPPduqhqWKvI1en9THyV5peTHxv4Cz6TczxLkyg8fZS98sXEPHBmh/VRKbI7VNIpLJh4JlrQfk/LekLYDKo9mARHYeIiT7FxUp6YDOJDjHeeV1KRZ
 wm8sDwLhIOw/T/b7ZsNcCOJS0oIRpmYWTI7cSOPx3t92zbXLmoDFK3YyULD7A2HH4685fIzb0AKWgpENrFezHjOpNQz7duKL2b4=



On 17/07/2024 20:20, Ramsay Jones wrote:
[snip]

> (SP_EXTRA_FLAGS didn't exist then)
This is absolute rubbish, of course! ;)

I don't know what I was thinking, but I suspect I was thinking about
the recent _APPEND variables - except they were only for CFLAGS and
LDFLAGS! Ho Hum.

Sorry about that.

ATB,
Ramsay Jones


