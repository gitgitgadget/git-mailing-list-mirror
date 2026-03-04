Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470B310779
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635158; cv=none; b=LWDS9uiLFlBRYFUcBgGx10+jjax7v3c4LKZajfcx3YFiId/8eWPk4j6BL8teU02UqsPXcMRQdgIBKVtIqCYZnXBw3/LKVzIKJAKgXIMQYfQ0Ty98qhLwJlmY2Uggw2sUWny5Y0OJglMVDYUiN6eGOrqDS91xq5z9TwssRcHphBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635158; c=relaxed/simple;
	bh=ATkmSc8iSXvaWYTXWgg0t1Vdr4KxxUftv7JrErejqvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTNMDHiKZpTGFbbQtzAEysqEf19pai27GAPkuIIrMS+KjWt4gUiEZGciGF2qIj0fOaeGgXx9Tj+mOnUkfML9NmbmzBWgfmU7l5HPZ4I7K4AIA0qzWF3KlhztNoxXJQ3dWmNGCzhibQrk/7tQwKuiFElgJRmvVBcu7xQzbAVD7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=oOJA7GBq; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="oOJA7GBq"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 056961D490;
	Wed,  4 Mar 2026 14:39:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 056961D490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772635155; bh=ATkmSc8iSXvaWYTXWgg0t1Vdr4KxxUftv7JrErejqvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oOJA7GBqzDKcc4/Ch8mbWNJXwLi1v4DMZ4PwORuh0RbBGBBfHDs+AcFc/GpsdbCKq
	 8x/cAowm/kVUSXYwgfiB6GUJdcAPQLWSNkrAqNcocXMm4xpSHbIRIIs8r9ChuMJB/l
	 zFg8PdZj0Mdqn2/NCjcq7ejP5Ql9rMUISWaT32k8=
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id JiNpJBJEqGnMuAEA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Wed, 04 Mar 2026 14:39:14 +0000
Message-ID: <012adf08-d33c-43ca-91ac-802c3c61ab6c@dev.snart.me>
Date: Wed, 4 Mar 2026 23:39:04 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] send-email: add client certificate options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqo6lb4fuy.fsf@gitster.g>
 <20260302032048.260209-1-dxdt@dev.snart.me>
 <20260302032048.260209-2-dxdt@dev.snart.me> <xmqq7bru41xz.fsf@gitster.g>
From: David Timber <dxdt@dev.snart.me>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <xmqq7bru41xz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 01:43, Junio C Hamano wrote:
> Shall we declare victory and mark the topic for 'next' now?
By all means! Keep up the good work!
