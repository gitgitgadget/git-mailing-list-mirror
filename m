Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950613;
	b=HaeXipbJQdR9xkjBgMciZ71Z9Mm78CMVOwOu84eSIbMFiFM2FqGFOoDJIjiDza4FWDKs
	 ahyRTpT1pQMlgMEuAJDTRH7REAoTpj5HieATJ14YN62V/RFF4CIUXBEXaakjMsJW4NAPr
	 dRpn1SWmbZGmRxusrlmfJKy4GtilTpfZpwsp/+lWWXoXh03wCwtSuz4uHbbAR833o/4Fl
	 WsEsoGFpuLNKwPX1+7ACN5oUlnTScIwRv0TlcmsI1zfzvQYc5p9ScGFNbCTCbIlpvQ/Dt
	 L8sbhe+5b6ayetuZYysLyYCpCk5zrwdI++uRWM9ns7twAtO0zFWajtmcSaR/s80/Yww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fin1Qkk9zNgNv8M2VAtpPR1r7tX4bGMIhCvbpRSBqdE=;
	b=4AH/dbULjb9fod9+jg1zwwCCZBRRtoSrlM4svfGqyXBELj416LcSobjCEN9MxikvDc9Z
	 u3x9mC9No5j6kPoByU7Pvr0kK1nrDikTF2qjG5HdMjiez43zcxtucnS/atpeC7sMZ3gDN
	 JPj4VbvzpMD8rf4OBV++s43wV/1T9arcbIVrnyFLPHBcZsmiljnAU4pfSL4MDa3xOvIsL
	 1MN2esbqOj0pHr0H2X7sygmADslYfbjcL+fAmXjPPzc0XN4dXEn1DWRuckK77W5Z0O0V4
	 4HsZTSVrwaxrcJG713zo74Jl1C9IyUUg/iWZlpoDHQ2KI7HkEjVg0hEzGAJ4C2Ml4IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qwSKpYN0;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607FC606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 07:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 607FC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qwSKpYN0
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b0960fdde9so187543a91.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793950613; x=1794555413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fin1Qkk9zNgNv8M2VAtpPR1r7tX4bGMIhCvbpRSBqdE=;
        b=qwSKpYN0LxompveXaMrU8fhQke02Ags53M0pjm9XRSkApJqYp3rhJUbseEMWoMvEcQ
         ljymAWarsb6yIp4qQ6oqItdlMY8rTCg3+/Qv63pmXUdG6huFxc4qooauJHiFTYH9kQ7X
         dBUtcnILI7HAmcfEu4YaMcKUvC5yIAQoZHHP1d18/EYRxl4EHdsvJsAWZUVn9IT950E8
         umePhrvIaRtOnQX17wO1RxXLoyi3Rjj6rh5huKJD6KGKzJLxGqTE8PFBd4QJl2qXjeTk
         dDOC65j1euQT3R7z7TwLeNTxy67qpT7TgK9GSuO3hsuenVSI6kjwEAy7TJeh0uLtjR/z
         eBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950613; x=1794555413;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fin1Qkk9zNgNv8M2VAtpPR1r7tX4bGMIhCvbpRSBqdE=;
        b=ZJWzW/tm88+1x1VqUJPWy2R9iY6eRj5Vn7ChJs9IbodfiQUlPtWE4eE1V4paN4vXXO
         D0PlxQ8m9zJ2eLj0eW7GvWyZtNZEmcYITqj08HISdNm2AiyW7F4WmTJaXqErK+4V2TVP
         uNEazL0yY6hZ1ElHP6zsl0jOd6e+VcQ+bHYQhUBYV3bTVKedj7Z6ypYIiUt7U9afTwzD
         wHRU3hZPawdmeamM7EN3XQFYrpipZc59qUHF7V7GHRcNa8DHfBLhFoe/3CZU94T2sgy6
         YJ5OJKs3vze+NiIQzmw7SHGX+1b7d0MUtIdpVKMruzM76Bf09PC7dNhIOxdlZBFQoljg
         AWjA==
X-Forwarded-Encrypted: i=1; AL+hErHf/auErCExiT10UcUc0Squl6AQ14d7fIsMYPF4kBysvWKtybsu/7MsQBjEYQx7mHo2+gQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xPmr1mCUCLDTyxUatdLZRW8bo5L1lJMtkWCN1PzGkxWLt+owF
	Pl85n1OPmTCZ0n4TeBntQVp7s+Vr6e9WoxKh79ynoX+m0ZESHGO3cY6h
X-Gm-Gg: AYBFou30nRdUYORork7L1eZVRR1S5IIdpn9WkbWRbaXLjLg1j5H55CWJn/eT5tF6m73
	HUSKRne5tKMDERoSBqvEx+C3a756So0xeAYdKpSPZbDnKduvzfaidQ6CO6SBRGfZMr8it4vnenT
	U+PuIskiPNv4VxcKPrJZahTZ27NIbE7E8exFCuhLubMyBAgu89wB6CtOGNpMDLdSJh7YI7y46Qf
	kL0SSoC/SXvb/DmTia7BPgMtBaynw/wMeFJLMJxZ40Ba4kADwamHih75lZ8ZEOf5n6LL07VC1T5
	il3wbC8cTiL1Ebn9hyfQEG5A3k482lIMSnzJjvVUroIFP4GVBoMb7TUDeyctmjUCX+DL8L9C+pE
	hR6INQ9/KZUS0bLskja1KO8wnkVYXrTJKaiG9YNDKGp9xiGpKdHWOe8mSzcWz63JIsCS0T4z7IN
	Rg9m5+vHHFHT1AgGyg/peAZk90aZjCeaZx086MdQbjgkYlQqn7RhigOV0vv4B5pHCNIcfgSJbvE
	xSWpeEJ/3g3wi/rEEW64uT5sX9IGcU0Yy0wLYg6Gc/2rAZT0OA+Uu2OTm/t1ARECtLBBoZ2ivZU
	SF5gwGVcFXpNQRuUyimaVZ1rdu3JsJR3hrXRR3psbYJMFXzBsodWA3/4Xl7ldLAw2h1QNu+D8xK
	y4CkvYmdT
X-Received: by 2002:a17:90b:3d4e:b0:3b0:9941:ec79 with SMTP id 98e67ed59e1d1-3b0db725895mr1404488a91.53.1793950612589;
        Thu, 05 Nov 2026 23:36:52 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:225a:cd2e:c0cb:5270:7400? ([2406:7400:12b:225a:cd2e:c0cb:5270:7400])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e27fa814sm528580a91.0.2026.11.05.23.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 23:36:52 -0800 (PST)
Message-ID: <4ce9dd0a-5f27-4e15-b9aa-ac5eebd015dd@gmail.com>
Date: Fri, 6 Nov 2026 13:06:46 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
To: Junio C Hamano <gitster@pobox.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Shashank S <shashu8660@gmail.com>
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
 <CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
 <xmqqzewgosyw.fsf@gitster.g> <9c905a79-22a2-4db2-b434-00ad8a287300@gmail.com>
 <xmqqzeweopov.fsf@gitster.g> <2a050885-a1c2-48d6-b561-3c2ea0a05dbf@gmail.com>
 <xmqqecczrmsf.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqecczrmsf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 02:58, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> Got it. Does the following change read better?
>>
>> diff --git a/links/mentoring/soc/SoC-2026-Microprojects.md
>> b/links/mentoring/soc/SoC-2026-Microprojects.md
>> index 41354b50..17519e2d 100644
>> --- a/links/mentoring/soc/SoC-2026-Microprojects.md
>> +++ b/links/mentoring/soc/SoC-2026-Microprojects.md
>> @@ -49,8 +49,9 @@ with Git's dedicated test helpers like
>> `test_path_is_file`.
>>    - Start small: Pick a test file with just a few instances to convert
>>    - Run the test suite after your changes to ensure nothing breaks
>>    - Follow Git's commit message style
>> -- You _do not need to_ include the command you used to find the instances
>> -  in your commit message
>> +- You can include the command you used to find the instances in your
>> +  cover letter or between the three-dash line and the diffstat, whichever
>> +  is appropriate. Do not mention it in your commit message
> 
> Yes, this reads much better.  It clearly guides contributors to put
> the command below the three-dash line or in the cover letter without
> cluttering the commit message.

Thank you! I've updated the description of the microproject. It should 
be live at https://git.github.io/SoC-2026-Microprojects/

-- 
Sivaraam

