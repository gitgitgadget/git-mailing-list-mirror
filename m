Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A1137923
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771756127; cv=none; b=eFhce1xT+dCQ4G6vZDnEOsYKxg+ZcO79O6xE4VwMJ5mXjEJBEsEv4r26d5YQzvP7g7yJRx5nXzHBciqhy4ymk9eUgFwxtPNIEMK/WePbeWVjMdhtaF2UeOBs+wtL9eKjaO3JIzrK17yAbd60bRcffjIU201C+gjA901Li6vZo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771756127; c=relaxed/simple;
	bh=dTs9crbA7PyWNSMLVvgW1KIdom9YuqK3KiFjV0ibUz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMyC4XfcSK4KXk+5I+gIAGCLZjlM2YdgXNz/lCB983bB+YHU9NI+u8Yta+aIHaneHjxYejnIoan0hhrPXPk2io87N5W8sVnVBofp7YfnChIPouGmIlF1NaszZfnrnIZevJHzsrSM1ztDjxU4zbqwenKU+xZZ3vZKmJy3gFwHyY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNzCZdy5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNzCZdy5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c632ca0c317so245306a12.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771756125; x=1772360925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOv52rj8RoqxU1VHxNQiY9Xym1Wg527E31e8X1jQXg0=;
        b=QNzCZdy5yFT1rUD571IVPjpy8CG1gl7gxjMz1OxxgN+m9GZR76+DjDdJYrgkE/VJl8
         l7HBJ8vOuGRVuYb50khONvBtXA/X7O2nA0dCYJravTj8uPTnw5TGd1Tk9+fxSxuH/T4R
         ganmh6U/9rly7U0vWXXOzh+hlIajj7NgzCk7F+TSTmnqfBNOVHxFrfp5ZOrMeYHLFH88
         iqXx+9NiD7+TOYu9Rx6e2YN78H+gUjZ7viu6BdfQE1597bCHLKFgrBPjMjLmVlcUlqhp
         Oh7Qlm93ulFyVD0nY0QgeNVqsunbYK6yuWkmFnjWxGGFMeZKz62Ve5ISff79Wfr5q2sU
         bF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771756125; x=1772360925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOv52rj8RoqxU1VHxNQiY9Xym1Wg527E31e8X1jQXg0=;
        b=SvUTdTBklknpqf4ZqmW1EjYsfxecjwQtJYbYEWvgJypzMcwLnkTwTPaP6/CHBXQJDi
         psqW3ceNW9s8NaMR/pYgC8rzg3BKf8pRhFUB1XtgQM8Vp/yUov9yEjiLCNpe5B+pwGp/
         Lr0REGq/pMWEC4c65w5N1sapS0rIRvjjubq3qDMYQh6XaTsvQgA7BGOIATsTNE/nawqT
         xfqyAEk7gQCAuIdsZSLdcL35MW2ZW3ldEL8XOOXQIR9gIYzsyi+EleU8ldDC31OFAI6q
         4VntTABCgkL+qPnfZuKTyxRY4pEuAU348AkzytJd2Y//avgPE/2n2Z/SVLhIWq6oMdkb
         vymg==
X-Gm-Message-State: AOJu0Yw3bOpTtULqMhRhCsr5yfqpptSRkfhhjGl0B1MV/oT4Q3o/vxi5
	9dqGMMH/mazw4Oenkml7+m8KFsWSwH7rd6ngxzw9gNO65KHrpHlNjL/a
X-Gm-Gg: AZuq6aLElnlG+8UL41ePgsxtt5qizoYhl5BS/Uzii2Wty33zaRylnCDuntPuUTdngTT
	P2FejWFnzp/M8Che82k2DjavDoEJhKr7N0evhKZKZkKpWwJtSMi8PBDHBh3pE15di1nna+Y74Rx
	CmIqmW7kF23uKmJJwXxMWYSL/7Q7dM3/huNegKslOYq7bwUd7xIZvZpx9Uj/veEw/3S+1q6vFxx
	QaknOMjtZSzbEH8nRnejSWyXg+dyfO8XD/jETtJyN/apJ++u87pFo18JDV1Ic8CkWVEaYUFT1zC
	TBsjXmo2G/KHOQsmh23Z1Y+2H2DDfWIaYsoTi3LfXQm5gzEN+3frYioZv4qStToiK4Ld6yH45cA
	1oFWqw+M3okfuuTVUR/lsm7QZy/LCHIOk5cEQJkejrSwwgF4l4A9yfXzoqLdOCjQJ9JnE0mTxBB
	EWUvEVizz2vrrpbH1g6xsHfnUlImU=
X-Received: by 2002:aa7:88cb:0:b0:81f:3920:77ed with SMTP id d2e1a72fcca58-826da8d7a31mr3315593b3a.2.1771756125078;
        Sun, 22 Feb 2026 02:28:45 -0800 (PST)
Received: from [192.168.0.101] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd86c5c1sm4900219b3a.39.2026.02.22.02.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 02:28:44 -0800 (PST)
Message-ID: <9d79bff0-eb97-4332-8260-236761c9c3da@gmail.com>
Date: Sun, 22 Feb 2026 18:28:41 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260220164512.216901-1-a3205153416@gmail.com>
 <20260221083001.220061-1-a3205153416@gmail.com> <xmqqseatqqpr.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqseatqqpr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

On 2/22/26 13:42, Junio C Hamano wrote:

> The changes to these two functions require us to audit callers of
> them that are outside the call graph of the main focus of this
> patch.  For example, we see the following code in submodule.c:

Oops, I was so focused on setup.c that I completely overlooked the 
external callers of the API. Thank you for pointing out!

I ran git grep for READ_GITFILE_ERR_STAT_FAILED and 
READ_GITFILE_ERR_NOT_A_FILE across the tree and audited the hits. 
Besides the expected changes in setup.c, here is what I found and fixed:

  - In submodule.c, exactly as you pointed out.
  - In worktree.c there were two places relying on NOT_A_FILE to print 
the specific ".git is not a file" error. I added 
READ_GITFILE_ERR_IS_A_DIR to those conditions to prevent the error from 
degrading to the generic ".git file broken".

I have also added the NEEDSWORK comment in the switch statedment, as you 
mentioned earlier.

Thanks,

Yuchen


