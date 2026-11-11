Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406365;
	b=Jz/hJuiuEbdFeO4w1P+y+PQKIsONFn5nJJu7uwtCv0+fdycf4G21irLAj61ceyQJQFu3
	 Qumf3+TzsC4Y/63ycC9getKVz08I3Ng/VHlpG79J0m/1TbL61DkUaxUMw02ktcCVxmuVI
	 fuMOkOuCr5zNQnzjxtfO8TSmh2bcrTf+9HnoREiUHQjUXU+/g94dymqa337l7Q0SbhApB
	 xuAr1rheaALcclHGFFPTMxl/CVlBIbaHdY1h/sjdDlFLg36kufnQ/LCjtn8TryysqXlkf
	 if6IMcTwCsadVEIa0FVeONKLJYqvGCVLJIN/aBlrQ0PKcPAssfhMbseaqSkbqlY/gpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KBWShuvPMjS7769KGHsIArZuO4fJTcrLzfelrNB6fjo=;
	b=462rEiNQ+9E+271XOUb2v12jGsk6cduoS0S6BCotQDVUvohKmMxUH9YHCm5toVBUv+yz
	 64hIsTs1dgNMyXz2PgA+j9h66K1BtikA/19pZV9X82fu8oTyjhB2dq3MXccsZkN28V4ba
	 kU4N2yI2rWhuHGfQXTUkIOSJJKPHhbzdiXn1OggLVsREhZgiBgH22vgGdGvsMVb9nCzBd
	 KIVlJccF5PK8VP7QAxvbTLOTc7F9e6Jap/1msdZudcu23xpb9GtIQVKALb5cCnyrmF5zy
	 cqMVM4ombYXnhTgMk+6nSk6MrQXY9yBr/55ubdCUl9po/E4kJ2ZY6UxiZkpYbG1JDaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhpHLj6c;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E6606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 353E6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhpHLj6c
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so38030185e9.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794406363; x=1795011163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KBWShuvPMjS7769KGHsIArZuO4fJTcrLzfelrNB6fjo=;
        b=FhpHLj6cFdXB0kV9ggN/Tqr++5YLrQRskd2R0jmWYyE44USjePBjLyK0xJnet0fyOj
         sTNMhGx0/8o/SxSh76S2ZbK5gId7jNv3290yFwXtCK4FDMeeQ9NKSEhV4gN4ItZQcHsI
         qpIFhCLH/Gb54yrlHIx2DPmCdSuSidZIAtrqoesktO3spAdo7sp/GyueJ0u8wotLk+6X
         cGuxS+y5SsLXN4X+8cDjpH2MgdyhcSOrJAtQazTN1T3fNAHh2OW/dy2x45cskdOtykNV
         /wXqqgNxvl86D3W5mZTUiX5T8tIc4qduGKWWBKtemhuWhrR5v6CsuQ0IHWc7xbvwW9jK
         s2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406363; x=1795011163;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBWShuvPMjS7769KGHsIArZuO4fJTcrLzfelrNB6fjo=;
        b=hCpa8tm1fBeJWM7hHdkjYJqhUsipuYHOIvVezWvziHr5UBqUGKWx34+tRprojXFBLz
         UpF3jnNhqWsUFWMFB4Q4qmwBo6alOq4xrwukLOTfc9IWUjaVh2cR9UAMXBXg03IvOXYM
         g/8Xrg+51sPLbA0uIV9fmYeU5T5x/V5cUwrjCeSNgdZ0gmHVwDnnRQWFPG3qUDSfiFvH
         0nHYs4799h4eEVFrdiVmhmUi/GCRGiQTLOLfaHK+q7ewBKM3MUra37DjIF+oSX53FWUj
         JZuK5ATM/MeC4ZsdaunXpmA96JLmqeGrmCNMb+3Vu81fhwpzxgPmOoy0LSdb/OHIcO6n
         FKRA==
X-Gm-Message-State: APuU4Z87J02tZ6Tl2EM0jbJTX2eSdZlS+9Foi5zJoY5aZoHbTii2aEhm
	V9fNxchKLKLCN/6Cf0nMaX03y4DpjpA/yXhMy+cu3NyQp52pQEErqhU/
X-Gm-Gg: AYBFou2VWoQ39E0adJ4+Bek/mceM6WO57UKN6XLMe1EZmMjvb2BLLpr2IZkgcQdYoR+
	i2VLmAbPdPRiIgSz/zhs6uS0k1GaKv+JJgsPYU9xboDV/ZRfxEg7zvd4AlZELtvtnxpRMyqKLxz
	IYD6RI/ollUWpEcB5fHEcos8qQLbzNJLYUn/CIOPLb3rfyPb8CzB+nV+b7IztS0ou+OCG9CdkN9
	Q6lSC0x/FiWWnCKnSja/hQmG64+ZrVQZMU2/VbmFH1wOMbYyDsuF1F3hzUAHUG91GL453UrZCNu
	z6ORhlOHodeO3PRIYPIal8wLxD0y3hogKCMmtu9kUUlpp9C/GHrDW72cQJm5jqkZ16ZfTuWydsV
	HvhL4aKRi+YRExhTCL0wxKMKuSaZKghi80qtq6+VSqcNBNum5hCXsD+cb69VK6w7qeT4s+k16rs
	+XExbh+3FzLfIg4CTgME+N1Oh8GGGWMQ0Zy8FDn5mo9wFPeFegYGKnihvUzsWEhmXfJxJddXMmW
	5NEOha3fdaUMoJenJvsB2m9Rk302qWfFpjsPBc/iolYvaGYK1VKYM8SzmNaeJabjDxJSQzqwM1/
	BD6sSIAlCL6JXJIVynKNDuRBN/TxG1G0MYcqXPq4cx+2IzD09qcJZwkmQQ2pazM9cd/jlZlWVNH
	1kVwgyDWGnw==
X-Received: by 2002:a05:600c:81c5:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4ba09376130mr41783235e9.15.1794406363433;
        Wed, 11 Nov 2026 06:12:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:1921:262:1f9c:7285? ([2a0a:ef40:724:6601:1921:262:1f9c:7285])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a763sm144034195e9.4.2026.11.11.06.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:12:42 -0800 (PST)
Message-ID: <b64387b3-294e-49da-b40a-0e757956bafd@gmail.com>
Date: Wed, 11 Nov 2026 14:12:50 +0000
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
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
 <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 11/11/2026 08:31, Harald Nordgren wrote:
> Hi, could I get some (hopefully final) reviews here?

The diffstat for this series is

12 files changed, 593 insertions(+), 33 deletions(-)

which will take a considerable amount of time to review properly. Yet 
the cover letter which should explain the problem being solved, how it 
is solved (i.e. the design and any trade-offs that entails, alternatives 
that were discarded etc.) and anything notable in the implementation is just

Avoid fetching every branch of a new remote in a shallow repo.

I've no idea from that how these patches relate to the discussion on 
separating "which refs to fetch" from "where to store those refs" or 
anything else. If you want people to volunteer their time to review your 
patches you need to make a effort to explain what those patches do.

Thanks

Phillip

