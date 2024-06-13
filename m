Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD113DBA4
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270492; cv=none; b=gMs8VmfyZLzzjslXDKlM8tlImlfOLF+nBw3J1jcdq30ndWKwk2Tw1U8uzSMZ5qXc+ioUw53m7avFiH2VjcywiVPt/n94nRc6cFa+Wly0i9wX9oWnxnmC768IIaMiptI2zs3r6ouXg7iaZXNG/Slm0fKc2TB8840M1GP4JRZIkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270492; c=relaxed/simple;
	bh=x7P1nTKvP4knYuwVs47v+Ok3/9JdDwsKfrMISVzdC+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u5DY5ywzXqv6qka+TIzjhSMk6IabNt1ANt5ohzQDRhfN5Gw3phVCH+nmmbNtvZZYuwD78OM2gMuXs745TSFV4Y112QDmxFiK2ZIMtGsWrcT/PxPj+Y1ZgS/ePd/kfk7xZrbWa5YdOMWpj+79M5IhaxQ+oqL6HYseGRVIaE62L3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Received: from [192.168.5.3] (c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 45D9LJR4088762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Thu, 13 Jun 2024 02:21:20 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-98-42-44-116.hsd1.ca.comcast.net [98.42.44.116] claimed to be [192.168.5.3]
Message-ID: <7fb83cd9-5a15-41d8-b047-c69e9026e4b2@rawbw.com>
Date: Thu, 13 Jun 2024 02:21:18 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
To: Jeff King <peff@peff.net>, rsbecker@nexbridge.com,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g> <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g> <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
 <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
 <20240611064847.GC3248245@coredump.intra.peff.net>
 <ed33cfa9-d0e2-4e98-95e9-e210b24ac337@rawbw.com> <ZmqpQ4FkfXRm2jAE@lan>
Content-Language: en-US
From: "'Yuri'" <yuri@rawbw.com>
In-Reply-To: <ZmqpQ4FkfXRm2jAE@lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 01:09, Gabor Gombas wrote:
> $ git clean -df [there is no output - bingo] $ git clean -dfx warning: 
> failed to remove xx/.nfs[... long hex number...]: Device or resource busy


'git -dfx' does warn about the .nfsNNN files.

It turns out that my git repository has .nfs* files in the ignore list.

So it silently keeps these files with the -df flags.




Yuri

