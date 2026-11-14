Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670376;
	b=qlmj8gSYEEBDrcKwZp9KoGK7daFZjWq3dypU9SvE/zosZwB4jyByJE//QcXMiCKoPwXM
	 PMORDcdoJgkEb8WafZOMi/MTktQNwLUtEbIxD24EPe0Z7gCQVmR1yiaCSYLYdOuZOy99p
	 y49sfXCs0zZBQyu1KLChEp4iHyf5QnZuqnPSJIXTpBZMoTOXvxlWNV6Cg+NXr079GA+VK
	 d0v+nv2Jvx9dj9/WQC3O/MNc5reEHZka0eGD5RKKYq87CRLCtZfSMrM6JW67ZMrDh8w/3
	 5OFURDC2hoHgp8xY3xiF/0qrDWN8IjadzXjHonrxcwssmLOktaOmamp80ZEzV8H3KYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ug8LUyBE2NFIFeaek2egfihRqpsTu3QrU0nqaOiiuJc=;
	b=N5v64zDXF/Ix+XIu31ZhT+u1AueX/bWR6XoPbmddIf5w6jqWFEBypvmetJTyYZFSVpKp
	 nmYx2D/KbMB6QhkRxBl/aqifXt6kBonTg+zWZnRR90M4Cx5UwxwHWCz2mTJUym4x5sD+U
	 OkTkOzlnMQTt+4sqbraLAGN7q1vQHiEXYmquTxJGWkrsQSLy+7gDB5ejYgBot6UBjoeXV
	 wjLyVGSKfLTz89Vnvd87ppDBc+R7Q9NRW3chL5kZRUsQdu9ztJqUL6BJeSyFZMqZBVsT2
	 5hCFcxqivazJTUnUZSdkEDnG4W17fb7bcsnPOB16l/rB1U40m9bhz+o55O8OH0PbNlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vw+LfbbF;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB38606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 15:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB38606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vw+LfbbF
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so2212149c88.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794670375; x=1795275175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ug8LUyBE2NFIFeaek2egfihRqpsTu3QrU0nqaOiiuJc=;
        b=Vw+LfbbFq2/0LZFUGvA2hJmQcJ1/jE9A/sXL7djDI6qe6unbkDKMxxbeOn4aN/dz/y
         3RyzV5Hn062z9NfoUh+l4gs3jkCLMpKkUzx/fnbQVT6mtK5bF166/BLWBlMtAAMYsNFz
         YQQApq6jCxBxLUdhmq35AJLYk9tp8aOGiRSw7qy9HLX6SuYk+SxDmVOvXB0BlPicvodu
         jmOUNqd+eO/ywxSEM2iZ1yMYapDV8HdmIySN9fyoaNt8+lJaaH/KOzXvGJLvkkW0rMmU
         Yiaooc0t8Ip/gm8EmmHxq9PnA1l6k9kvwyTj3zPMX3ISwWIQHqJaMiSfL70TfWY8dbDq
         SfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794670375; x=1795275175;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ug8LUyBE2NFIFeaek2egfihRqpsTu3QrU0nqaOiiuJc=;
        b=XkqBBsj4PvbM6WpeiT6xA/g8oqAIuiRcOjuR7BbgPUaMrxnLErEedrjT3QSBpoengz
         frx40Tvg7AH2Mw/gYFAXDTaRA7HsRu0gRqOFsuPmtfYgdRThDsPEpq9ePFCOVksEEy26
         mR4OfGHEExTzMyOMoBqNHo+8txGESA9TXteJm0I9XtkZEdl4bsZHNhKOY4ANKv6a9wWW
         +k9brWUTRmS0xlWVRVx2sUqa6gys38SoZVCKAgF8KDh2Eu0kHGpXOy86B6SOlrMPHvgN
         oIKIS6lAXodSOUBU1r+D6eheJ9KUBo6qDsHP6GcxpKqWlUr0qbdw3eF5KgttVjVkpGAS
         lfZw==
X-Forwarded-Encrypted: i=1; AL+hErFxVu+9PsnFdZZc0cmF8P+C3QtC9FEnjrEHJFe043BrM1u/HMBYf3s9unz7enNZ1Xiu9sw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dqjiKpQILuixailtJgiLcf9eex0FYwAuLoMhpDYgPt5Te5GNm
	tD0DuoNsEB+uXP/B1vJXpvHV3wk8PPEkyzqeJ6uSvpAXZ1xw6sufjLrK
X-Gm-Gg: AYBFou2AcIbZhZMGE6H86iW+JweQsdiwH2cC/oFcj93RWkqrMkytpjtYa3zt5kZhPaE
	fdJvHIlKGPwDCm/Kx7r5tR102zfweufXJtcuC71VA1MvkW86/6nd92fvSgi3ZfcgUqiSh6WfQT7
	pHX7rxnGucrfK6UWzXDsattZxcwsBE8J50LMbmJxRE7/79PFhzDG+o/BZDvQlpamM8uwzcnb9eS
	N8OYEJ9saSeIUFHSBym4BNcbq/DhnTxaNkw/VJtroGH3LtwGoSmuZGWkyTt/SHMive4KQD5/mAV
	fiyA5pTQk7M9patrhAd6cf7SRS41D/GyFFoibfWqOuXtdRsXOuSNH0P73wQrs1bY220uhRQBFnl
	RyQnrIrLuks5X0vghPeAPvLqd63bU2Q2kJfDcxbLNZftfFGW5S2ItGhvezZti9WAbjJCBzEXReL
	9JyqLmXV8QLKr+0t88akFBVrOkDEFUhMB0XnYvP9bgDJYWsxXhfTDRTHr/meO56GueyB5feypQO
	wNKCyNh0R6wQoD55hG79vGLkR1zwadWhccCOA61cFQY8flx8ejIYZOZjEyJiDSCbg05D2mckTBw
	GrWyyz/cuDNbxLgfPj/Bfl+swJ5UOs7apas4BilaIa10jiG4Lx3sRkoiaGABXEs1x/9X9EatqmR
	M1/U21ahByQ/elsQUjHimNA2+p9pizQ==
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id a92af1059eb24-1b5030fb74emr6296206c88.19.1794670374973;
        Sat, 14 Nov 2026 07:32:54 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:37cf:a789:a247:8b8a:69a4? ([2406:7400:12b:37cf:a789:a247:8b8a:69a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm15985035c88.2.2026.11.14.07.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 07:32:54 -0800 (PST)
Message-ID: <f3b571fc-d39c-442b-b1d4-cac78daa995f@gmail.com>
Date: Sat, 14 Nov 2026 21:02:50 +0530
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
Subject: Re: [PATCH] partial-clone: document promisor remote fetch ordering
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
References: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
 <xmqq5wy89rq6.fsf@gitster.g> <1c124d5d-790b-4d22-af22-c53573e6d2ec@gmail.com>
 <CANRKfoCTtHrZ233nZyYQod6JJsNXve+Lofia7=8pnum6oEPF0g@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CANRKfoCTtHrZ233nZyYQod6JJsNXve+Lofia7=8pnum6oEPF0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 19:53, Hussain Sitamouwala wrote:
> Hi Kaartic,
> 
> Thank you for the context on the project and for the offer to help,
> I appreciate it.
> 
> For the record, the discussion on this patch continued in the v2
> thread, and the final version (v3) has been queued as
> hs/doc-promisor-fetch-order. The commit message explains that it
> documents the ordering introduced by 8808e61fd3.
> 

Sorry if it wasn't clear. I actually intended that reply to Junio.

I am aware that v3 has been queued. Thank you for the context, though. 
Kudos on getting it queued!

-- 
Sivaraam

