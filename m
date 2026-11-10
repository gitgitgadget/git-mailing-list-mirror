Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324359;
	b=3fNGYHuW88GUHVVfDd7bwtO/A5Euig1LNauMVPOkE0CkXS7xSKQhpqjyRZthSOYE6psm
	 a5ba07WaxY5LJKclck7clsREwR3yUVB9zVT8sJVrb9IXt8Jvu1V+/J1cEaXXeD5BK2qWZ
	 TQ4aOQHnSzNhWVYTJkMuCQHsWDtMtotjbfKglq1U2lCb+EBVKTIJgoYFZ2vs7ZSFlK6Ly
	 RC+98JQLaM8+kWPIuL4k89H6Uo9yt64wtvdwuGGweayatOpKsBEBEhbmA8N5ItoqKg7XV
	 tYe8b3HGChI/hEqogA6/H7QkvitJ33xi8arCf2We89eltrh0XnhEHxYwe57aVivEV1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kES3OxGMThr9n3d4LHW1dPR5HZ89knnVh6qxXznsZis=;
	b=ngMZlQ8YK1UqWUK5p8V5q1Tgu4IPAxRNC8D57q3EjdHrodpzHM6alWVfqxrBSL7RRlzp
	 6QdHfS/wipZdA0DnGaaLMVIF9LhUyxbZOaJ0Pkxxa9rU7DbihLwjSqXdlJL7fl7IWWn+b
	 Kmt46Fiyqvr7c0ArFHUAtlox/Lqx26SD8al6eMIQck/fxOyAeble/7c9INruydts4CbdY
	 8f5o8vuq+6pUFfOiz353/3h8hGMqIsjTs1cU2Ixa+M5hxuLPt2R5QvYirLq0+SoleXeiR
	 Fmq4yU+QGnT3UbiW1zAe8Q944N93yIQO7wJ8rVpPV3f/nvGa8SCal+hDN1i1QE7TzyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qk+EdG9a;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E0606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C0E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qk+EdG9a
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1126745b3a.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794324359; x=1794929159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kES3OxGMThr9n3d4LHW1dPR5HZ89knnVh6qxXznsZis=;
        b=qk+EdG9a2C+hu+xxh11rL0FB18oKYFRg4eaWB7ZRybcrqKPWGEfUn1CZqOROuMCbGE
         TBQexRXAwpwYPGTCLYmL8txlTYD+F7FlktWEY//05BOs5o4u+akKERRDqAamdYnMr7tQ
         Qi2kW703dzrCAzfbJZfq2TQC1gDqYUbBdmCcNVWuU0yGWm9E46DT/Qv4pZ9xfTwLnqfL
         enqOgp94O6/JjLLGN/C0DgQsG/EUIzDipe4S1yJHwI7OThcQWqRi5yQd+asDPeehLOOO
         bs1a4G88BRbWEXB1UaKQDuTXhaSw+Xa9fQhgOI+/4cXl+U+jYYXLiRQDnNKqlypSJjY3
         9ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794324359; x=1794929159;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kES3OxGMThr9n3d4LHW1dPR5HZ89knnVh6qxXznsZis=;
        b=LP02135huVA+t+yJOnxAb2fV4MVetVDxxXq2T4d5VWj9EIrojBnLbhliyk1qVB0cDd
         XLcUS0YTM0RVB2HKUJVRfiNoVT/B8GxkzaLo1D80u0s8QLrnrJo7+QiNAROjZAbKtm9E
         ctgo4wrv7aD1oAuCkZbVhw3ZRwxDHcd8C18HJFnT4lbNqS7r3DcOo/kyRsvG0JSNLlVK
         JSjPmGDP+euaJ+/OEW8opcTYGZ0CGeoBEr9gxSrZ4vyc+Ze+SXO5cnPmFzIashBJd8am
         A1bP7HGKPpIaczLiu0UqtGEna/qfDDlVoNCIarBN8mvMrAlPM/Pumbrbo63Iinht0Awa
         BCSA==
X-Forwarded-Encrypted: i=1; AL+hErGeT9lgVDbPV4m/GwZK1ppy/29gOzvScIAQPTQXEKsfNWrO23U4AkkYiyo91UOsZXgcD20=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gYuT4jgBBjiGW0GFrt/Q4noEZG67jWmlJrQ5ad6WITamEXMBu
	vsxKMvljJu/7PFD6LMWFjxkzoJF+i0PhohBUNUC777CDxz1y84oozY+O
X-Gm-Gg: AYBFou1Qieli2KFHjHmeAMkz5VmosSh2KgLff7WL1Tim8geOi3ZuVt9CM8W/RwFdRom
	xYOhJIpQI18PX8euV1GiZDneA36shvsoWVBp9EYBRWTjcvX7K74h9KPjK40AK4SnDUHAChJSbR8
	K7ncUEtPRjPdBMqhOgifjS0vnE+T52v+nRuSXvLx6H4ylEzT9pUzeOHJ7m4iPhjgGP6+8ooN0EZ
	B8W/M97u8F6maeMoTPbuRK+K2ZAwl8MR9rkbR2oYmJl2GkRWApa4KjvdKbWGEFDzOVeQ0sNj9o3
	gz85sskm6ZyCsHMacw70GKnsYptfpoJSEl6N/g2G5EaBnuV4b1AvD/bG5trQi5WAaMQdP+p87mE
	wdXAdGsfxWUkrWGMXwu9dWdnBB72jk8GuPIFrT0Llc/yUd9JC689gExkoLX7uz4PwzRVKiEUKt3
	LjoqcQNbDYG97kTuF+hyGtuW/KevFOuXGB8NSgY/zgxTsOT91FhZQzOmVr4XqDRe2vwddv9slXv
	vBQcSq+ZPoX7Sq3VAqpoG41rG7/Z6wEs5dfLrwrsABL6EFVcmhvEleF120RfORsIAEcaiGYz6+W
	QFQAM621IxjZN3ICHnmALH4SwiQLtAn0hAvXiJwGRpTipg==
X-Received: by 2002:a05:6a00:950b:b0:8b5:c588:ca49 with SMTP id d2e1a72fcca58-8ba8764699fmr3092794b3a.46.1794324358443;
        Tue, 10 Nov 2026 07:25:58 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86ddb4sm1051168b3a.24.2026.11.10.07.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:25:58 -0800 (PST)
Message-ID: <df9ed9b6-978e-413e-b001-b4f10c84a114@gmail.com>
Date: Tue, 10 Nov 2026 20:55:50 +0530
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
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
 <20261108023730.GA1242909@coredump.intra.peff.net>
 <xmqqa4nhwstl.fsf@gitster.g> <xmqqo6bxvdbf.fsf@gitster.g>
 <10dcd7e2-657c-49f8-b8fc-0c29fa55e6fc@app.fastmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <10dcd7e2-657c-49f8-b8fc-0c29fa55e6fc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/26 19:16, Julia Evans wrote:
> 
> On Mon, Nov 9, 2026, at 5:40 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>> In any case, I'll queue another SQUASH??? commit on top of the topic
>>> until v3 materiazlies to fix these issues we have accumulated so
>>> far.
> 
> Thanks for this, I don't know how to apply a patch from an email but
> I'll ask in the Discord to try to learn how. Same for the other changes.

As mentioned in Discord, when Junio mentions something along the lines 
of "I'll queue another SQUASH??? commit" , it means he would've already 
queued the SQUASH commit in the topic branch in his tree. You can view 
the same using something like:

   $ git remote add jch https://github.com/gitster/git
   $ git fetch jch je/doc-git-diff-examples
   $ git log FETCH_HEAD

Then on your local topic branch, you can do:

   $ git cherry-pick --no-commit <List_of_SQUASH_commit_ID...>

Hope this helps.

-- 
Sivaraam

