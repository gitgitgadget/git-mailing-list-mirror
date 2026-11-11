Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378262;
	b=J4c8do7RkNZBPgU1G2BpB/7mL63gZUkHjR20lCkPqLLd1h0mJxD2xgu0ip0GyDPL0aGT
	 ugdjqX74JsDpoKAsRuH3xLL5apB9dr4ZvUNMxJk1led0paKnFkxMnFdI0yOdlldONXj3f
	 uwD1Drtv9rz5PEpT/X1M0JIaAkCNVPN+FXe5tV5DjhmiMGbV5YTXrnuJXYW3c6rltlYvY
	 Enclt0f6gNDGku2lCCp9eWVXbwR2772+b+WunZDOSdIWxwNOIwqRi9CTYVQqto3fxssGD
	 Xa36duIF4W5L/vo7wxNMTQptQ/ZhRbnEsF2rgGtawUUJf5/kRBdZXEe4uGly4BFWf2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6HouB1SCrTpintJ3duVt8t2ME2e1zZRdM9Bn/lj3dBI=;
	b=W+dQqj9XbhPs0VndYTxupM7Q2mODkTsPeuTTvyODl0bONcpOf9SdlgO/6Q7CQIkoVu0f
	 SFlNd3191i/D+qxU70JaYtjXtUGP8CSzy8U9WByO0HxlemfU7GOh6MaGyJkL4n8wmVZ9+
	 YULMIAozedCM1qFiWBPYPyibofby52qWryvdjwsQXZmtZk1ssOTdFdhNya6Z2/mLEsphr
	 6jZFsh5AlzFUlvwTL7gJ0ZIKqZXPxwLOcw3qEDL5f/IiYH+YTdaASKJhfWD99IwNCRXjO
	 Rj681JTGPKHZYObrGc+cPcodbD33n1a36W4tuxZHRc/Bnft2czrps2Fz1yqvA61F58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E1TYNHDg;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54E606A339
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A54E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E1TYNHDg
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso568180eec.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 22:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378262; x=1794983062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HouB1SCrTpintJ3duVt8t2ME2e1zZRdM9Bn/lj3dBI=;
        b=E1TYNHDgNnj3eSlxxyJwCyeIZozl+zYCaMqZorAESPXknkG1v98WkLJQBscE+NJOzy
         tnf/ITH1Tg9UJeusUMn2PJ9YoowqU/Ggw6ZCKTteao2+YJNpm1Yz1X2WDLp0DFGssq/M
         74EIMLt4WLl7ZufCN731JM99mH05TDmmIKOngpZcB6HxpUTTcl0X1LNG3kNuyWKqq/6i
         pwnJrOSYhRkconYLWLOdTvjmmz6rDJ1uEIJ/Ky5EYNuy0/8h/GeB1t2sTJWYQjhrbXN4
         OHClJUCthVYOH/Z2Wfqnc+N5Ez4FKbAf0wnYL47kyr1DY702uHfKezayBoiyl4f2SdcF
         RzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378262; x=1794983062;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HouB1SCrTpintJ3duVt8t2ME2e1zZRdM9Bn/lj3dBI=;
        b=GfeGwMmRM0F4b3rBvuCS96wL5Fa8QSIyzLSuUxWQX0RTyUVtGQ9fTjU4cR3JuMDdsM
         ZXa9HisozoMZ3gWm7fOGLSBzGTCKOhIkXzsZIzpKo4pLKHDI7qTCRXHDDZWX4ZLLOCgn
         kVehNzSaSP6n9AJlLtPCHUi6fHoy3cHGYSGV+Lq7/MyiAkTNBkm7nDbp7yhSbGRpax2u
         RTSzegLVMAX8qhRqm5TNfZXTXj/kTjZDTx/X+xkCBZZmFrKauOGqbhxVjqLbU06KeDsR
         VVkpVgH+rhoYkpwnb9hC+311VKAJiuvInRlDJkbMLPtbdS1AeOh3XEwLEFkn3/9OQFi/
         S8eQ==
X-Forwarded-Encrypted: i=1; AL+hErGfcmaE0sknI38C7DFsbHOBFJHp8CerNMDuD98yzzq/7a6CcvHiWho4wIi1QnyIba4KYC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oycUxG3De7HA6W+tHRHfsfUgJTE+yX8WOMr6zUT2RsbquZtXp
	f2lRJ7TSjiJZn2HN/ffCq0t9r+ZL0nwAaPbe99nSsr4yKokrhhmseK5H
X-Gm-Gg: AYBFou1GMJaiZXuSbeaNBjg7NDvFed3zFWCO0VAllCDXi3T3w5BxGLF5K4/LsuEH5D/
	fUmydTm48o99ChJt5dF/Zh05ezeEEFwopKIAp3g3lE+gtR4t/pX1vCoJU5umtAmLPwz9m0LRihK
	/B8XHQKm0UKa8vvfiURxPZ393AEYpSgHqT+lJU5uhGBaUcjFtoN76FvSLorXTwrWcvR0ZT07cFT
	glMTuyribyjBlrtwZ0z5K5VjtuaiVpKa3Rt86AqQlTOYTzBFD+Tb+bT9r+v5j+ulRxmfrIrS4MG
	ifaTPnLYn/fscwzzSdXrltgdqmaIMvjNLLegrys8d7Gf9hCW3NHMVyILaafcylXeKBtbaU0+9Pi
	Es1TYkKQSyTJG2d6MDAJcnKuJxELQefqhhsDckMocn8J/ieBaWYWNosRpoCByxArWX0hiQMEoks
	6B+uaJNnnryyACSuH8RdwcmDDkUHAa7RlB1KkJ+eOQy4iWYPzkd5pUTunTibsVnkgO9lmyL7uzC
	Lsi+8URoORayBub0SO8dKJlS1DilU0cXGFEmeOxRTXCsoc58AKemfgBC+DxHnQyFSz0g2Bd1OQL
	KCUnz7DDIBJ38g2xpPt8VKyKXD5Eq0/ozhwZV31AOdJX
X-Received: by 2002:a05:693c:41ce:20b0:36a:2382:7dab with SMTP id 5a478bee46e88-37685d724f6mr2591547eec.6.1794378261543;
        Tue, 10 Nov 2026 22:24:21 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm23347969eec.18.2026.11.10.22.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:24:21 -0800 (PST)
Message-ID: <e12a9cd6-d61a-4e80-a459-954c4b26724f@gmail.com>
Date: Wed, 11 Nov 2026 11:54:18 +0530
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
Subject: Re: [ANNOUNCE] Git 2.56.1 and friends
To: Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Linux Kernel <linux-kernel@vger.kernel.org>
References: <xmqqh5hosgw5.fsf@gitster.g>
 <20261110221253.DBFncUIG@teonanacatl.net>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261110221253.DBFncUIG@teonanacatl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Todd,

On 11/11/26 03:42, Todd Zullinger wrote:
> Junio C Hamano wrote:
>> Credit for organizing the set of these releases goes to Johannes
>> Schindelin.  Credit for finding the vulnerabilities goes to Luke
>> Martin and pwn2addr.  Credit for fixing them goes to Toon Claes,
>> Karthik Nayak, and Kaartic Sivaraam.  The xdiff hardening is based
>> on a patch by Jeff King, with help from Toon Claes and Christian
>> Couder.
> 
> Many thanks to all for the effort, including Junio.
>

Indeed. Thank you all for the efforts!
>> This addresses the security issues CVE-2026-111760, CVE-2026-113408,
>> CVE-2026-114466, CVE-2026-114467, CVE-2026-114469 and CVE-2026-105437.
>>
>>   * CVE-2026-113408:
>>
>>     It is possible for a server to advertise an unborn HEAD that contains
>>     path-traversal characters (e.g., `refs/heads/../../../TARGET`). With
>>     the files ref backend that can lead to ref-updating actions to write
>>     to unwanted files.
>>
>>     See <https://gitlab.com/gitlab-org/git/-/work_items/809> for details.
> 
> FWIW, this and the other GitLab work item links appear to be
> inaccessible to normal users.  I'm guessing that's not the
> intent.
> 
> I added Patrick to the Cc as one of the folks who may be
> able to poke the right folks at GitLab to open them up?
> 

Thank you for pointing it out. It was indeed not the intention. Those 
work items are accessible now.

-- 
Sivaraam

