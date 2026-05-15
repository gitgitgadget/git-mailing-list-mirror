Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622236894D
	for <git@vger.kernel.org>; Fri, 15 May 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852043; cv=none; b=ZYJeidj3AuQd9I/mKVPNXT7inDhAXUvCrM6zNMH/0z5Umm+daZC5OicJPTEQ50B7nJ9wci6AsJqjPs7PPtEYOv+wr48V1d615q/Zx1N0TjYvNvWTd+2lrx+TIo1KxbzOKKdwlzt/2//3tU1c34d2na6onOjDgw4iVhK37V7TNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852043; c=relaxed/simple;
	bh=CyFe+J89TJW4zYLU+xJI/ns1ePrA4N1F9TXWrnyLUM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvtC/ljKdJ3DWCP7rHstiIX90F7CRBMjlL/KGvzL9NPFXa80gvQI/owDO7i0xkq40bSkrIcVrLR2QIdTjAaawxH8qStJeq9+r/m6iMjZ09viCTFdDbfRwloacSWLDiDOlv+7RAmlNC5WnrSAMTMA2OyBxhcQUqBPFAMQ/ATHy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqmPgfhZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqmPgfhZ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90d042fa745so657882785a.1
        for <git@vger.kernel.org>; Fri, 15 May 2026 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778852040; x=1779456840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xo6WmeVfEFERVKOtwUv+fKsmwWbKevbNH6D2YrfSMwk=;
        b=nqmPgfhZ1XsbfQO2VeJKeSbARfIrvCVV7TAtMEkInhQ+eayeDEWchSuEw7IMcEgNQW
         ENbSQip2bVpq0dd66pO1SI2/CwRfIvpMzWAIfx9WfnezuERsYqRWc4mDZ8qAVcWUUk2R
         5lzWFLJiGkkkbwmZHm4RRqsY1tSx4oEYcnkSHeNsg74kmcJPr/vuwGUZ7cnbih0qw3YG
         x7t7osC5dapqDlhKkg53JczNibx8IjOAJdLd/x4mZoxz5l9/J3H158OMvpgKss2sAfNM
         QAaFpO379IcsGEm1lsCjdvv/oZSRMk6ZNezunuVsIU7dN7SJoGy8XCtgKdCeSh3hTtP3
         C2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778852040; x=1779456840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xo6WmeVfEFERVKOtwUv+fKsmwWbKevbNH6D2YrfSMwk=;
        b=CuWw1Gw0p8VnL8Ppv2+6N3qSVIhANmTcPWWGXQcu/7TCTM535+lP3MkLh7W8QCjrGH
         DbaNJ4c+hixLrKiIh7/wPGdNSPABg4lax1jVxg8YCmSJvyEdgpnZ1LkG6sL9/9gL4due
         Be1tAIGYtLmbTvGWiRD3AQ8P/OF12hd6OjpIg0NBC5i0zAm+239k36rTLNlh1oigc2Hr
         F/G2+0ahsNN0TI0AbLQUgx2T4j5BZ9LYvGRe/djDx/j1+IqnQlXR4RNctEa1IbfJm39G
         8iyvGmrqXu3EEUxd/YOqir94pjO9G6yQlLsJdDE4+EnsvdTIwk9gvSnfELIg4I2CC1d/
         RRKg==
X-Forwarded-Encrypted: i=1; AFNElJ8HzP6NU24LqZirBWPYirHm3kH9rnLubFOwrMJ04yCdIlJLLVpNdI3gl0rOymVkp4cketI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdTpMn8MZF63YRXDP5Z7SniGHL1DaH2CACgddPRms2qvYS5Dh
	l3u5d9U/OSRXHj6xiBK4irgoAaNxQmhaBpLnj3RdMhXLMo2EJagv1vaz
X-Gm-Gg: Acq92OF+iBMsrxVKD/+3hI/d06s6gV1UaKkPcHT9nKXefLum+0O+E+VEYpk0bgEIKY4
	jp44FxP2wKWNCWGJ5X9s5Qxoq0xmzdgAX83y28mL9R0eckFkLji2FIiqtyLb5A77802+u4a4vGd
	XTYZoyJEn+uMNe2R5XvSJtbMSTUXGcUyzmCEdw+k+CWAp1RZQEf7/F37wo/UvteOyZ88L6eBnnL
	SOxuIctJ6L2la/G1mq5idxAK/6V5/XsJEzFAdup8P3thkPUTdWsXgHuIPhHYmHI3nEw3AfwNsun
	3CRlsjTqmuuFgbsV7y2+HiYklkSYnjni2QWdpU/Wumbo0z5SnzER1vxgq2WRxylB6i1+a+5X2C2
	IRwSwg7+gdBkSg6kkDjbk6OPo3z86bwEl38Nb7BGwQR+6AP+RoKkMl+2Px58WgGZDe8ydRtRio2
	E6GiETMg9B7daccJuMPaJz8OGiNVqlkQk1aBH78fSSr/vao2xzqr3t0pCZ9T++TBmx/9WD8/c=
X-Received: by 2002:a05:620a:4593:b0:8cd:8938:f000 with SMTP id af79cd13be357-911cfbd1daemr668823285a.28.1778852040046;
        Fri, 15 May 2026 06:34:00 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm545989985a.28.2026.05.15.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 06:33:59 -0700 (PDT)
Message-ID: <6483a7a6-b1fe-4047-8c19-ab14a3284e0c@gmail.com>
Date: Fri, 15 May 2026 09:33:58 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] git-gui: put choose_repository::pick in a proc
To: Aina Boot <bootaina702@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Shroom Moo <egg_mushroomcow@foxmail.com>,
 git@vger.kernel.org
References: <20260515110027.426-1-bootaina702@gmail.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <20260515110027.426-1-bootaina702@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/15/26 7:00 AM, Aina Boot wrote:
> On 5/14/26 2:33 PM, Mark Levedahl wrote:
>>  set picked 0
>> +proc pick_repo {} {
>> +	unset_gitdir_vars
>> +	load_config 1
>> +	apply_config
>> +	choose_repository::pick
>> +	set _gitdir [git rev-parse --absolute-git-dir]
>> +	set _prefix {}
>> +	set picked 1
>> +}
>> +
>>
> Here inside the proc it create vars locally, "global..." is missing.
>
> Aina
Yes, also, I missed copying the check on the return variable ::_gitdir. That proc should be:

proc pick_repo {} {
    global _gitdir picked
    unset_gitdir_vars
    load_config 1
    apply_config
    choose_repository::pick
    if {![file isdirectory $_gitdir]} {
        exit 1
    }
    set _gitdir [git rev-parse --absolute-git-dir]
    set picked 1
}

Mark
