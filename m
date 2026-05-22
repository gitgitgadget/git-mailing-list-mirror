Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E029357CFB
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474245; cv=none; b=q8Bs5K7E5R0yjXsV36XqVZMvYhn8jwzuwJi+OZeXWR7F9MaC6JRA8xPIOcbrPNaRAeH0lO3u0qpYlmSCnF2dTn+JVDL9e/DWBgu3SgUfc5t85d9AxdL/DN0LlaCE4ksGX5lseaAdqRZPtvzwu0VTkun2xtmqf0pBDXMzeMAJqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474245; c=relaxed/simple;
	bh=le/DFIr9ZBIKOZj9+O/ib8+HttXUJbZP7wB0cHOW74Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAx25KgFDEd8iTi4NWnT/sKFWX46HIfcR/tYaeBfrWshu1fe1ZSYPmRppeZjhEKsaWYp9TErxRt3tTkZ32ENCNDJ7smIYlDiqhKiTDAFTjwE98SV4qLsLc0L/IUDlMvYPpqRXe9IYb6pQXxl4n4QiXdUMUTQNeLY263PUVJ5IMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4SGUkhr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4SGUkhr"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso115052466d6.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474243; x=1780079043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C52W6dlI/rCHUeFXxQHGtEKP7Jd2Njy/i1jxiQHOz0c=;
        b=n4SGUkhrvbLtW2o0HTogPBEcWn7/9ESUFG2SDuMv2xPXfm9pMmZ8hTAJtzcMP3XFgJ
         YP9oFrr6o/Dlh9zB8gWcMK4dZSblkCsitugzHu9sBj++pip/4kuP5HRABU1UaVdzNeZo
         iL9AOLl2tntkzBbV1x2pj7hiVScaPKloga50rsIYcSupMpi6uBRNHj0EKFgS4M0y/PTo
         q85ue96M9Vbnon1YBfL+efYjwWc+7SJa9ZODlIpwwZMItxkKpk1GWMsft4s/bpITDOqk
         Sbc5qNkz3ZprZfRnRd6ibqCp4d3sU94x8ep2+Zkl4OGJ0zo04WRASrLta7j1HEznaclv
         4luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474243; x=1780079043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C52W6dlI/rCHUeFXxQHGtEKP7Jd2Njy/i1jxiQHOz0c=;
        b=WTNxQCG+c/qANoOkSfYI2Rl+1y67DBjwQjyE09GMmpBDRL7lWq8ljQuLW1pbEzzGE1
         D9qjp6QZ2n+P4OqE8BZeGugY+RHVyqXyUMgwEFpAV8Rwt3P+vmTkDY0bqyXaRBynPx8x
         T7m4QrhrqClLLt8UK00M4ZyqtZgYBNRfNoLwnJsxRkuLBDm1M5+p+7jGMhcc0oGI2UKf
         6v+z43oveswSg2rv1+C1t6enkHxChnEsWPOn+uNANj+0tIno+rJLy0u9z6cap0QYAroW
         HcCmvf0RkfZwMMhm55Wxr0fMV56/UVQyfU0Tli34qnjp90tVvOBxwoBpfXok83FlSfVZ
         zXbA==
X-Forwarded-Encrypted: i=1; AFNElJ9ckxmqjrlI//WGA0c7I3k06gWP8PPj4j7GYs90uBn1GRXLW2kVV9k0eo+fdAVBS2nhzw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmzgVEmy1b52U1z92zZWQQRIMvfn2PmlM5lciYAupDgpM6f+V
	67YzIyA0vzlmoBRq7UbpFKTNZvkZ0QCzt/Q5xDnn5/SUiyos5pgieXsv
X-Gm-Gg: Acq92OEsQlHuNizp51keKtNL3tMuwwJt+VTcs1VRdK997i0ARQmkEAJs/nD8Rz2VZBI
	nTnUQG2gr9B1IZXrVxVaibZNmZPq+eZmG9YeNrSxN3yBrO0YoF4LCTw3aItmViWABWDuI/xfs4k
	3oz0sbE99yM2fO0KfMEvzpMuj4anMB4DRQ4M71A7tGr0wemIY5vJItd/5kvXbTdyXKQzPp+EuCt
	6A6lZ9shP9HUKdoqkcdpQvgjvSgRB44uXuo7UTBE5+JSP4QTXzC63VrHPFtgntfXAZ1EcMA5djc
	xgF7+rq61Y/OmTME5sW2LtW55HRU3RBGh+4fpY1nneMhldAS5Z3k7nhGF+A4/mXhPiuMslpI2vs
	Z7lq1NrZNImuWYUDvNeL7urpv8/JJHRfQelp4fUNisQJi/kINqMhSFErX+/6NTUsYSECmJUTWPl
	XJwZHx2A7dAS8cIiztI6ZTFHzrBWdIBJ1hSdIadu8o19fLL3ZcWXLgCbRTzNQTOB+KlitzdQ==
X-Received: by 2002:a05:6214:626:b0:8cb:e78f:21de with SMTP id 6a1803df08f44-8cc7becc501mr62462006d6.11.1779474243326;
        Fri, 22 May 2026 11:24:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306d70sm25135566d6.35.2026.05.22.11.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 11:24:02 -0700 (PDT)
Message-ID: <6d8d0b30-99f2-49f1-bd82-3515aad9aacb@gmail.com>
Date: Fri, 22 May 2026 14:24:02 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] pack-objects: integrate --path-walk and some
 --filter options
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <agz3/ZxZZHBKofR9@nand.local>
 <4d7a75e9-8260-4e33-a786-72e0aa3026ae@gmail.com>
 <ahCGL+AsIaR+63Pr@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ahCGL+AsIaR+63Pr@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/2026 12:37 PM, Taylor Blau wrote:
> On Thu, May 21, 2026 at 07:01:33PM -0400, Derrick Stolee wrote:
>>> I'm curious what your thoughts are there. I think barring that things
>>> are near-complete here, though I did note one issue with the t/perf
>>> changes (that is my fault for having a bad suggestion on the earlier
>>> round).
>>
>> I like the suggested change to t/perf but I don't share your concerns
>> around the '/' character in the path (I go deeper into why in the
>> thread).
> 
> Sounds good. I think a minor re-roll for that would be good, but I
> better understand your viewpoint around the '/' leading character now,
> so I think other than that we're good to go from my perspective.

Thanks! v5 is on its way with the update to the perf script.

Thanks,
-Stolee


