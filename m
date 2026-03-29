Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B526FA60
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774769131; cv=none; b=INF9qIrx1+TO47nl97C3cC/h6qYhYF1b7mnkDfjclCxTXj/zXBTjgIWL0LlrzHCm3QLwAOoGl+SyM+HkOLQsLl3wUpbNlKgeLxPf3kNE6Dwa3HYNd0aTPxs6rfXA7iaZDkAvAgWFAzIWYUvJiqUcDiwvnM/1iM26rEQV/k+dLBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774769131; c=relaxed/simple;
	bh=YdhDc3B0wLhsFdj8NCUSR+GFQb/btyuFW9ssjfDiNrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFhNNhhgEfPPPxS5cmj92WWr7uhuP89P+4+rIzhPcGYHYM+LUkiiuS5EZgFW7hCx+kxpvq5EQ5qs92VnhlXrbej5GN8MCpQYgOQvPipnOY72pBcuX0XleumzBukdWHcJk7LF1fwMmG9JiJpvlLqFkf3olNm8E5clqq+mtidAtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzU9DB2w; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzU9DB2w"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so2030542a91.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774769129; x=1775373929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGyAo0p0jU0iSoGUX+6kAiDErM+/dvmOC/BP1Ak5x7w=;
        b=DzU9DB2wdMRh3V53Gcp0d9myxzTrAZ1UXm2abSlx8BratXHdgjq/ZmT9mion8B+tDR
         6EG7iQaDD+tTXOpKt2gH7CtxhNlJL16BGbge+08QAXyB6KKWdtSTM9xJurzipwGbZERU
         k88WG06N1vhoMQ3pVCt1WSK1eaa2r75s7SW4M7ryRMz7jsxlv+gOPim/Jt++Ieq68GFD
         pQg+J5EFoswak5nTFS43amMfiIM9a5tXFkkfaM8WjEGl45dfaWpynguwE/YcEosKMTEK
         gw9gvoY/EVKWdLpz0C8m2EpHQ4jAxdeTBjsqKDAONSA7Q/GtbVyC/hhpxNalHqDeVMuy
         9Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774769129; x=1775373929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGyAo0p0jU0iSoGUX+6kAiDErM+/dvmOC/BP1Ak5x7w=;
        b=YZ0vuzfi5gQhLGoqawuKMb3XA6Xhq7MwY+NqAhUI82QjDZrKZHshQFG5IDYXDsPyxW
         T1lVN8JfntcQwYWggQP2wfeef9VcJ9jY4rGSbmy1RWXuCTeev1XsJs0HqlMtYGQRuNGQ
         3NwkrSCHIXc4Ws1v2DaszjncXdTw/Ym6WPlh0cKXmPlZuOwvyftUJOLfW38QR5U0zBEw
         DAOORz0Qu8lcK07BuhnhZ3s1xIRKpwRtLk+S941JFvD/pULk/lWas1gbOCksdw4LSLse
         Bsiihn7xwvScuL+Gcku3Zc9AuDMgzqV2bl5QN0a3gmtnfKVEXvODpZarGToRS3Nb8I6N
         o2CA==
X-Gm-Message-State: AOJu0Yy4FfvTAiuSyhx3IUc0q3B5rKlcIkOKbTKlZlDtZhRMiMORIC65
	WfQWCDUX8gd4AQCK+HJX1eUK+8KlAvkzUN7aPgRapDmxDZL7qSxVR+s9
X-Gm-Gg: ATEYQzxqUpSgzmSPEjC08jhIPvZ62xbKw+rTCRh34kkyuFaBZvX8Axr4aUGKm/dhxcs
	jj0eEK9i99z5bdRMbNCe7uFSZx5DbrkAQErktkWVJboAZzpNAMGqUHcQCY7z5d8U4OnihZgcC43
	/HT8POTTMSskO3/IIVcBAbGeYPfZxORS0DCwTXGvD7VO0Tbl1FFm5fcW7RIo9IMK+oHfRKdHy/v
	Zd5ZIh0xaI1CT/tVDC1gR8z4N2iEKyVEg5FySV3/cHbN8xaskhsjbFUMuAG/tl1FmeSwUedCXfJ
	dxlrqZPj62qe1oaAbchuxzAPhVilT9LG0smdRmVVxGp3Lvv/ePKhGPIqseCDuUPyl9YRi2TmRVe
	pqL5B8/aSt55gKv4AJ1z8X6BkXnt0FdSnUo520F3J334O5BZF7TgKVbNnYw/eo0gIZez+52V844
	/TKOLWVsbxX2xxI5E0oZpuYHbS6VjYZNtNCqB/jXfPHPmABUynSF7EdiWpc/x63lk4xiHG1YD9S
	cHmyPyixCYscyU5G9DAJzBNBM51oJ5yXLk=
X-Received: by 2002:a17:90b:28c7:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-35c30093f99mr7425098a91.26.1774769129177;
        Sun, 29 Mar 2026 00:25:29 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:e924:4f3e:5a3a:f1f1? ([2409:40e3:30ab:6862:e924:4f3e:5a3a:f1f1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d991559fdsm3083980a91.5.2026.03.29.00.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 00:25:28 -0700 (PDT)
Message-ID: <a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com>
Date: Sun, 29 Mar 2026 12:55:24 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cat-file: add use-mailmap/no-use-mailmap to
 --batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, christian.couder@gmail.com,
 ps@pks.im, toon@iotcl.com
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <xmqqldfbh32d.fsf@gitster.g>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqldfbh32d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/03/26 06:20, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
>> but this option needs to be set when the process is created. This means
>> we cannot change this option mid-operation.
>>
>> At GitLab, Gitaly caches git-cat-file processes and it would be useful
>> if --batch-command supported toggling mailmap dynamically with existing
>> processes.
>>
>> Add `use-mailmap` and `no-use-mailmap` as new subcommands to
>> --batch-command. `use-mailmap` enables the mailmap mechanism for
>> subsequent `contents` and `info` commands, lazily loading the mailmap
>> data from disk on first invocation. `no-use-mailmap` disables it but
>> keeps the data in memory so re-enabling doesn't require reloading.
> 
> And the cached information in process, if any, would be flushed?


No. The mailmap data is kept in memory. Turning it off only disables 
application of mailmap; turning it back on reuses already loaded data.

> 
> Because in your design, these command words are parsed separately
> from and have nothing in common with the command line options, I
> wonder if it is easier to understand if you added just a single
> command, "mailmap", that takes a single parameter "yes" or "no"?


Agreed, this is cleaner.

I will rerolled this as a single `mailmap` subcommand with `yes|no`, so 
the dispatch table has one entry and the handling is in one function

I'll send v2 with this update.


Thanks,
Siddharth


> Then this hunk would ...
> 
>> +	{ "contents", parse_cmd_contents, 1 },
>> +	{ "info", parse_cmd_info, 1 },
>> +	{ "flush", NULL, 0 },
>> +	{ "use-mailmap", parse_cmd_use_mailmap, 0 },
>> +	{ "no-use-mailmap", parse_cmd_disable_mailmap, 0 },
> 
> ... need only one addition instead of two entries and you do not
> have to write boilerplate-rich helper functions twice.

