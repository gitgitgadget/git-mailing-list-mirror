Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB33FFAB2
	for <git@vger.kernel.org>; Mon, 18 May 2026 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106640; cv=none; b=pSqTsKq2O10kp9fOnDPubaq9oVqs5sIxOX4UdbvaAS62CrmXPe0w8LqgzWIWA4sLCutacDVcr+f7MzctJiuWfgWxp6p7Aa0RgJMjmjAFW0js2gT6X88gfZSYw7vuiYmFgl2GOuQJ3/lEOQT8UZKZd6OXflsEEajMnBbExnolQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106640; c=relaxed/simple;
	bh=lYazJi496icQkf5128S98w5bRZgx8/8ENGB9+fAIo/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eb27JEl3QHWqLZgdaGOUTAmGiXqc7W4vq+hSfp1WeOlRdFIQQMmbYzIzJFHiJpW8f0aC7Dt7KGsLtFYRjK+/k25L2cwrkbju027eNjszDGNNhDGcyhzOwnt/wYo4GAyrIgrjbPouiYienSMk3QWbFgY+XAODnNkXVPEz6r1hujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkM2Ele2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkM2Ele2"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911488599e3so275030285a.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106637; x=1779711437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeqDAJRVgfgvXfB2PzBjkzs75+kXlCfWlAPAWxoKDN8=;
        b=rkM2Ele2vKfSjPrv2Ij+1rChgPy5aI+C9EwUjRizcZw+v7v2+LBNZLjPy9IsmtL25X
         /3lXehcY7oRfMJ97MQq0e+6u6esW8N23IZdcimumNiR1uDhCmzF8KOMANU0zvXRxUQAm
         9lf2Es2dTMxwzYSK4lI/l1CclQqC0iwCi3Nm1W/7o/PPw2wJpjdrnCk+8D3KR0CU6QDJ
         oWwKUmbmcboIs9q523Q5KywXEaNYY9c16K1Zr+09kDUyLuCj8fUdTwoY8QulFnI27xXj
         xEoC/PJfBxxwHIdPfk7gUTUoKqCAt+xhRC56gQlAdp+UbTk3A43umznIE4pHAqNVc22F
         C35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106637; x=1779711437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeqDAJRVgfgvXfB2PzBjkzs75+kXlCfWlAPAWxoKDN8=;
        b=inREWmPWjLlrKl3UTmc4JPBHeaS7u3JiI/1+JvtJ0IwYA2NHpWH/GT237CBo1qSLrp
         vN/6YMfRqBPA/l1SItCalQRP7iUczALGNBk/1mDt8jFDwHcNjZDu+mpgBZRAgbJ8C/6E
         qeXiemOresLKUsZj+ueKlR88oqqcfN6Mn96njF8LeXFNhacpvqupVtLalIN38CRk5L2v
         lVnoHgKI4j5aMy41ep/X5podY5ixB1RAkbAIVtYPSTVvpAqahH51WVJ4iFSsetgNxnmC
         ddjcTY0pFh3+wGP0TD4P2crY4r9ihULSM3P7Y3+ooSApfP2v8jkvoXPUeSE54GeMNWgm
         Q/xQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MbTe8H8GTutMccdIGtZgsnhNk1ek0MXoa1WFRXSxRazN8QRXwZux1pWIpEwZJyssbDDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIiEglUPj8CRSiIx/OqFauO7cH6j9W8ubPagVR0XMlBPR5z0c
	GE+2OQ+Yodc5x20mO0LVVCIewiNHAe6+AlHqt/rROFp0sDgkVybke/1M
X-Gm-Gg: Acq92OGZKJDShDdEDsTRN7DvudsX0MVQD298x3Bsyz8LdQm7jdiFN4VrF9H/3kkcsjW
	jtDuI0/QrOIh1BN9Bx1wm1nChTAhUFIxL38xrxFxAGbY1jsopFoTU+3do9o0p18pJI3z5FKWEWr
	iMLKRB2zSxbA65bZM1r5Lq3JjGgBHz6gkpeHRcJk1X4SIn7rrpoUIwcbH3GbGc73PoLix5EUknA
	Ijkr0d1+qiECrV3PdLWYZnc7CZ233uhTKRlJz+D1ufAxkviRUE9/4sNAsWjtFwVcIf+e764dENK
	a0J29RArquVRJSHswcSm7reO9++diZxY8TQXWkWLymIuvqv1NS+4BEYPHBdVSLra0+6bkk9lArf
	8pf4QNztdLhzsgaCwpqcUyKhBkMvcucT3nwE6bbnP0YEdnXVg8F2MMcKd1vi6EkbyuUf9+kJfcv
	X7O5PNxaXSARCGlJuPvDmUw3nmus3XRwhbwb3ChE4gZHuOyLbNy610ZO2HKcCcy2CgvheiHw==
X-Received: by 2002:a05:620a:3705:b0:8ee:cbf0:8311 with SMTP id af79cd13be357-911cfdd6266mr2207534585a.54.1779106636524;
        Mon, 18 May 2026 05:17:16 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086a61sm54347656d6.4.2026.05.18.05.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:17:16 -0700 (PDT)
Message-ID: <0da4f159-8d4b-49e2-93c1-25aa0bf69371@gmail.com>
Date: Mon, 18 May 2026 08:17:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Batch prefetching
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/2026 12:25 PM, Elijah Newren via GitGitGadget wrote:
> Changes since v2:
> 
>  * Modified the final patch as suggested by Stolee to include pathspec usage
>    in the testcase
>  * Modified the last two patches to not re-download blobs we already have
>    locally, and adjusted the tests to verify
>  * Inserted a new first patch, containing a documentation addition that
>    would have helped me avoid making the above mistake in the first place.

Thank you for these changes. I reviewed the updates and documentation and
think this version is good to go. 
> Note: Stolee also suggest some code sharing or code movement in his review
> of v2 2/3, but possibly based on a misunderstanding of v2 2/3 (that patch
> isn't about a diff) and it's not clear to me what could be shared or moved,
> so that's not part of this round.

Your detailed responses in the v2 thread helped me understand that my thought
was misguided. Thanks for giving me extra confidence in your approach here.

-Stolee

