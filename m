Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4D10FA
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260981; cv=none; b=G8ZebT+JTPijjkzc1qufHHwFGxUGVCWNaGx1z5u3he0NZFC7d7SqGiO2ZIWuc/kN6cIla8FpCb2CbGr4HTPYV8W/FBOE2Srtjfvq+C1CLuUIfIaHkFXm0RTq5ugUA4IB+SZIEvPQs7gE3d3OXZOH/axCUNyjs824JvayYlqQEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260981; c=relaxed/simple;
	bh=nvqBAYmmjWICa7XJJTkwxc/cC3AJZhG+oHBvhqMd+Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SffASnXPGzw4LgEDagWq74L2sGsprI3R1GhYUh3HzmaRWzl81irrXd3LWkOAae23+UkcOQJ3h/BTNyZLBsQCQ53cABbv9AeQ8oPa5pjc1fOyM7gGtWOese5oxtE6UMufJq3P960Ts2YKc5Q9bNeUNwZ5Dn08VN5VdaKF6kYwXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ivRcl04A; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ivRcl04A"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UEbms8XZlH4nFUEbnsF0wU; Thu, 18 Jul 2024 01:02:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721260975; bh=Gh+fu3WLhJaK6MbPhMavtY6Va+CIUm+VLVeFlqRXf1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ivRcl04AZT2Jhh8XM4lhhoT5k8n6S14V4LSBr6s+IDGtcdrGT/BVPl0XcpJk2Ac/z
	 IpZZYMyQd13k6nIhUaUcE35/SV40f3BMvjETFjbpyxZJkLhLU9a3qbwLOJKZAVIX1M
	 xqflmN45D9Hw49EgKYzV5BEmcelwMXvUmbBoGWp/Zfd6S58u3cAl88vJ/mZlTvCHxb
	 Ujazs3JPkUO8EnrnMbzuToxAh+XQ6ge0rqgZt4FDqhte0lkGUtCrx08Azro7xTFfu+
	 y78Msc6uI9cZ5GYHjmC7Kil3m5h7SI4eL+BCuSQkAjYaTMu8zI4JtvtkNcGPvDFZ3Y
	 tlOHCqmKmIgQg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=f5frB/yM c=1 sm=1 tr=0 ts=66985baf
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=B8b9aWka2ieBsoxJgMwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
Date: Thu, 18 Jul 2024 01:02:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
 git@vger.kernel.org
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
 <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
 <xmqqr0br26ok.fsf@gitster.g>
 <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
 <0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
 <xmqq5xt33a10.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq5xt33a10.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOxcN6HN+gJcQkIr6DiwaUSn2drhAk6gAoqLutbp/2mwHfeO3RLtx6HuMz4jd7LVtsfeK4Wqc7tuglluLm1bB71XhoMAK6cysRFK+YBO1s003CGWhQqu
 xvBEjIgrt/ej8CIifQEvqdSD64IACcFPxOS2gemx1mk1zg6pDD9NQaRjBxk43W3oeawL6cDqSsTF+ookLB+Ln1SqByy3FE3eAiQ=



On 17/07/2024 23:53, Junio C Hamano wrote:
[snip]
> That's OK.  So in short, with a separate SP_EXTRA_FLAGS with "-Wno-vla",
> Luc's patch is a sufficient fix without any downsides, no?
> 

Yes, assuming you're only concerned with 'make sparse' usage.

BTW, I didn't expect it to take this long for this issue to come
back to the list! I expected it to almost immediately cause
problems with the sparse ci job, when the version of Ubuntu was
updated to the LTS (now previous LTS!). So, I just found a simple
solution for now (which turned into 2 years).

ATB,
Ramsay Jones
