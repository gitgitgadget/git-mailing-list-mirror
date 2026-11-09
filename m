Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231365;
	b=brdTDZ4jEqwjhFC2RBrLz22Wsm5evW9lsZEiX5FjwgvszIFM2G6+6/KsSV4dkFTBN64o
	 Aq/tiYhxN+H8tBi+/dipjbhs3DQnSjYx7AeSSOPlsevaQui2AlxTgmz+amz/POKesK2/X
	 48h+lFEHTRQxQ55rtm5bXLqvk4zJDEq/9KjsKmuZIwBhbn+mke3bbSG++m2P+Np2KccJp
	 54PhrdADC8mMM35ocrdobWQXNZNcmAcrHwLaElL+6fmoidhPqI0vcy5AQ9DmbfaWIpOye
	 0D9OE+q6QNn6cBtgncVwbEK35F0BLvAVDJ7dDPHQ6fx68cqRfUbO1w5I0SuQeWeh8yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RaaMqvYNuIfTOu6/115ekrswGfstHjGrNZ3w89b2nPE=;
	b=QaNtV1y9f3l4raRwOxG54GDlJiJNuaxYYIh7KxBHZ2+Z5qEFGFLlFS8KLGv9dCa+3BOq
	 gm1F9qHzu9rjcAfiPtU+QZb8sECg1eC2ocQ03wlAXzC9wPYbwVSpMub0NId1Rbv9RG/FM
	 91HhBezCEXqF040a+lZXRtaV3dPcFjaehSK/kH8jVr2Q5TXJUDjhC4lqbMCV2+mC6TP3Z
	 n3ls4MqpXaKBa332QLyiAHuPOVXOqFijrN6/xTyK8RhtpnHSX37BIjvFKVNJJ9xfWe2rG
	 1R6wDPspJ3vBpZ/lfaZOeUYBnT4LXQuhhj7jK7qaIIn1ywDeN862IlP/w4csmHopltQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmhR51NK;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB308606D82B
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB308606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmhR51NK
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-945ae2daa66so81903585a.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231364; x=1794836164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaaMqvYNuIfTOu6/115ekrswGfstHjGrNZ3w89b2nPE=;
        b=bmhR51NKvtNCb9VkiZozGo48md6es0MnZa2mT+D0qSSy+BvruCsd9QH9YEnWdyAi3S
         jpQBT6qdPaM7vmxG4fCm4L1EzFFRQpGRA9sBR3ss3g974XfhXiE/LLjSuq4ZXW8Aj+Kr
         yDu6tKHiCi/q7GBaTSOQHRRQu/CxTZkGEmLT/ugKvHxG4yYSRVU7mN1sMKdcj7qplzTj
         joIvmUMLQeTdI0yFgnk4bM2VekvDTF6OvPGSzy7Kf+Uue6dhviTwY1ZXzYdfjx34a8yo
         Jq3w/paYGsGoB3sdIyze6Lv5oRnF6YgaqJHNf9dQwK3H8ONts200HTfMlOrMoImMLD1L
         Bm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231364; x=1794836164;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RaaMqvYNuIfTOu6/115ekrswGfstHjGrNZ3w89b2nPE=;
        b=BmRj7XgZ5769n4NjmXI0HNdNvoxjVcuIoNHwyx7kjq0p26s8+1xWDsYD/Vtsva4Wyk
         yyYXjVLA0T/U3E+T1RiSUc+oNyB3UuI1Tj4lPXI3bYG35aS6pAVk9xg3KWHLwWrZx2PC
         +JhnQoEzD4+LI0a2d4FC9Lu8S9z+yVzYQkqdpOL9GF2ko4iFfVwldYim+rZYV8Ib+piQ
         GC67rRv3YUFyRY9aG9EvLDBURzXigYAoxgb5/ZfCDusMhgDsRJp0/P1ijQgcroaI/QfJ
         I+aWGyPTUpoM6z0+tEEfJNV4DYvgk1BkWZPr1R4wsQn214JaLmTQEYIafZ7BdUzBwJjo
         2TSQ==
X-Forwarded-Encrypted: i=1; AL+hErEUqjUXReIGQi0cLivEN4VrU4HFgpTfFOKB6iHoaSDt4yF1X4JbkAJ4cQuGvhTc0bKfwNA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LtJ+0IT1R15MkKK2/ClSqeGeA/ay3VDqQINj73WHcSlprIvKv
	RvNJBYMZpp+R24lTZCH+Wu6j4PIq77zqLA+rx4o638CgAu427ukne1oi
X-Gm-Gg: AYBFou3sANn96C1jF/RKpthS6m6NNse8wqIugJ/PZJLm5knGiy1WqzJ32mhjbI78I8a
	vGkvhg1tcU8H02XXCSDKOyPf333ypFruGc4n8c1zKRGA0A+LPSuWAC7u8t2A4NYBAGi+oy4qx9q
	XIUX1GrHiDgvZyIYvdIExRaaN6TYrEEkSLNQKCz+WPAX4JgYsQ152dfsd+BzSmXzDzY5KbIRevX
	SmTmcW/d1ZTa3cd1xITWi8Ytpf2LDrOHetnjtKKj7ZdTxLhvNtNuGwrJNwsmjcA3c77KNqO1WiC
	5lhvTh/IyT9rjPVjUuls+EJAh69zKZbtOI3DTGVO0TmUme7SsKYSqa6w458jkSPW9P/URIf4t/h
	7qqjs/EegGN4w7RtNIu31s6iYb/Pbr2ad9qVi//gfeOPMWp3UcZ4DU5NNHb3wjsVvn6wu7WoFC/
	m+hAI0GDNVWYhcXyvxuwmvaPZBlhACvdy+rn7BptYz3rL3PZpJmCdXCCnR6dF9SwVgmS2yXhBZ8
	j70JTQEKp0fKShpnVSNUWayUfqNAtQrQiStJJD4FXTrFaR8eEuX+E7OOOTw5XW6llgI95EKlH6x
	oSj2xSLstuzIVr+9HcsxDBQdcwVpKdUTKkJu2hieFlTvGTEF1ceGrC3x8wv3dmT3xApuUSHl1S8
	6MJj8Z8cVCsZpe69S6i7oIHD2zAISf3zjNITUa4OxCSH1UpcNyE05hEQFtXE9n90KCsnY6pswEX
	0/FpgFv8Ko2BXdK0lMu4ZkR/WOH9Q+0zSNna545tNs5LnhT53Hb3oSuw==
X-Received: by 2002:a05:620a:468d:b0:93f:33a8:8e84 with SMTP id af79cd13be357-947842871a3mr627842385a.56.1794231363680;
        Mon, 09 Nov 2026 05:36:03 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782d61ddbsm476823885a.15.2026.11.09.05.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:36:03 -0800 (PST)
Message-ID: <79ac692c-4ae9-4b9a-860e-224accdea928@gmail.com>
Date: Mon, 9 Nov 2026 08:36:02 -0500
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
Subject: Re: [PATCH 14/15] bundle-uri: handle NULL values in bundle lists
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <ce4c190ea2ff1a1fee77582f98b023c87e7dee41.1794040968.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ce4c190ea2ff1a1fee77582f98b023c87e7dee41.1794040968.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2026 3:42 AM, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> A bundle list that gives bundle.mode, bundle.heuristic,
> bundle.<id>.uri or bundle.<id>.creationToken without a value makes
> "git clone --bundle-uri" and "git fetch" segfault:
> bundle_list_update() passes the NULL value to strcmp(), relative_url()
> or sscanf(). Such a list can also come from a server, through a
> bundle URI that it advertises.
> 
> Reject a missing value with config_error_nonbool(). That makes the
> list invalid, as an unknown mode or a second uri already does, and
> the clone or fetch goes on without the bundles.

I'm not sure that this is the most-helpful error message for the
bundle URI feature, as this isn't an error in a local config file
but in a server-provided file. In that sense, it would be _better_
to provide a hint that the server gave a malformed bundle list.

However, this patch is a clear improvement over the current state,
so this isn't necessary right now. Doing the minimum "fix the
segfaults" fits with the rest of your patches. We can do another
pass later to make this error message more helpful, if necessary.

Thanks,
-Stolee

