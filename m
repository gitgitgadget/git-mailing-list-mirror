Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5181D8A0B
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157452; cv=none; b=bJWfCCG4sv45r7cILcFXnizGXmZArulPTQ/OQe0SJsQn3nq+lz8LOTsjUtuIWEnDc57cZkDdRFKLYjomBhl51FMbqPrcGrHyOxOLqGt12138eK34kxG7tN7xVnZ0xzfixY4idq+C5cT+klE5bOo5YwOtBndsvmnS0Rt+OLMIivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157452; c=relaxed/simple;
	bh=kzXdPuCt9X22Ac0TTU0LtTux4LFxuHLzsMsJ44zrrfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWV2Tz5Op163kL/SMOgGvs7cyN50Z3Z2uhF89jKQK1mdO6Jq1efDbbGiwdxJ5fPaIfDKUjZz/SdZcGl28j2NfFz05DY/xjFaN2gFRQmwz1X/mr4Qjtogoi5d1m77xak4kundo1cmhhGzyytczixMOCnGe8rf0Db9QLxP0asd4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=vMNZ2ah3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="vMNZ2ah3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729157429; x=1729762229; i=tboegi@web.de;
	bh=kzXdPuCt9X22Ac0TTU0LtTux4LFxuHLzsMsJ44zrrfg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vMNZ2ah3xaCuZ+KRvaHDPtLmlODN4Y4v5piIbM6E50JelhaY+jLF9uKPcvXtLrcQ
	 5TkqXUecQsnJrfgCHS2Bw+ZaLMxv/XLXnS4Nfi8qLlcNM8Xq2uE6iMOw+crF+hwlO
	 ykaj03afb3sIC4WecClwv8QQ1LOBV3V20EnvPJqYNnBm71+wAV9nz14L3Pff74NlV
	 xhctIepmoTvmj/na/z1EOd+EDdO3DzJmBt6ycvXhTg/H6d/uKrDAU0qcw1iKwIaW3
	 wE7BkAkGf2SUn4n0hwdywoRRsrbMAs40hdIAnbr7y27jMCK2be/jXgHVx3gt1hp8U
	 2WVyPC2KwWQwjGMLQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1t9Lyb3QOT-00GpQL; Thu, 17
 Oct 2024 11:30:28 +0200
Date: Thu, 17 Oct 2024 11:30:27 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Alejandro =?iso-8859-1?B?Ui4gU2VkZfFv?= <asedeno@mit.edu>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	sandals@crustytoothpaste.net, asedeno@google.com
Subject: Re: [PATCH 0/2] Restore support for older libcurl and fix some typos
Message-ID: <20241017093027.GA19306@tb-raspi4>
References: <20241014131346.3556163-1-asedeno@mit.edu>
 <Zw23K4zPN9e+JyNA@nand.local>
 <CAOO-Oz3eQ+fpWU3qLHtF5oCxj2ieoc6P4R+iKJTG3DoWrb6W3g@mail.gmail.com>
 <CAPig+cRENnd9cV5yFfVVwbuux84k10_vcht-TTtKGJmRNYEttA@mail.gmail.com>
 <20241017065936.GA16141@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017065936.GA16141@tb-raspi4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:M9sIpMBWo3k9Jt6Qpb+Q32syd6fynVW//lUnREkEvEbLYEpHfPs
 rvukPzikVToSCqKZePzEJ1kjdfj/2hd+dIvh/iCF8IdqSKjYa85JSLB8BXFG/4k84Z9niOB
 N16bFku58FRBW9zDJWSKsLR42E3Eq2Y8akiBFAj345NAZ42ktYuO4WK6+hmAfDtCbwNtXiY
 Y4bPpqBAHeKZq7MKtpBbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/gJZqQygJe4=;dhlbdPh0UbZb1Lv6hRLJ5Becn/J
 dTnF0t3AlAjqqElpl8AWfFj+LXwyrcW1+cq+xOpQFNcdv5R5wFB8/5nIYuha4Jl18j5/SNpIo
 Atnc7BsuQipfw7ry9M14QMB7scP5+CJZ3Rr0nqEFEGkbtBg1RYIFv2D9GJRzwHmMrMyblcwoj
 i7EzXDgkLoVrz8ZxoSzVEyfllvFGN9YWwo78tTMfGAuuf/tc6MhWynVwUsizDfmk0mWnQIQYW
 FhuBm+ELLNbPski72AX+b4sXToCTlLiSzDgPvtZ+fSHBAC+n9ej48WJOfo9daa6wswdZzbK8S
 8gbPOFWQfBuS0RiUpHYktr8qrF5/bMHATDlvVbyKr+4K4I+ssPfJkolJQSdWk4aNscrFm3CWA
 MOvT3YXjjdHh33xWouGw5/JCOm1xzUM+YVAa3H79DshBp9C6Q8lKES7Hmj4yrNeokPYUlgSUf
 r+SUi/siwiWPhNEHceMeVujj5M1RGqpXgJ0KqMmNbN2/QpfcT2B26DhQthBTSMT+NRCK/LbBJ
 kD3bYoeS10+BsdTJMTeIF75ktWsN/nDVt7R3wVHDPWGCpqKP6mLjM8I4sfTVtI0cW9iv2oaJ4
 8US7OrI/QeLI5PNJmUZiCPj0tGlYy6PgXXOrH5tdU+/OwFs89D7AGAGkcKttu4EB4VaOi/Ayi
 QpdvqJoYzqxfjYfq5NR1FClC++du08aQ9ic4cQ8JehWcOWwehGyT/r93M9xMfxc2IA7NDoKtV
 KGuh04CQtiX/XGedV2w7vvttOcjuFJgY3ac/mdg31SlbonbtbNIvr5TUJcacHjFQfYNqFCul4
 tRNcAWYev7P1UGyQYSm4MYUA==


Just a short update:
This make git compile (again) on the mentioned centos system.

