Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF122EF4
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300326; cv=none; b=hd22bBFxUsar1oQnixZ08Ov4yPIovpEAsT27hJkPqeApn0wnj5XchPIyMUGwCz2oKInwQWwg0VigVG+PvBNPQCOI0vwTFlPleatGQ/UH5Vwag3ruzeaTnGHeXv5nTLBIEW9PLjd0DeotxCbr4v4paEiKsvObeGd1ozIycmz1K8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300326; c=relaxed/simple;
	bh=3/XwTSZYROQTUZp5JQQlMeXq8Un07UenlCxIEzZMnXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tq5AJi4NsqSOfe+NaXElng0eJzu6hf30Fr019K85bpDpmgOyQSN4FyKCCWII0LfJgzkp1HaoaytqwghNxHSPa97G5HXCbJ7DGi2SY5l9a7hgrqR0uICY75XoI3fvOluUPQ3w6NOAt7EmkCQAkYPNHh34648Thf7MK/l7JoIQgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHmGAGxC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHmGAGxC"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783def2092eso3672985a.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706300323; x=1706905123; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3HJaDM09fbTjK/4jsOsOa7gb7Jt0qkZYZSUzTgffZI=;
        b=LHmGAGxCCKSMkUBIJmmKgE0+qpcyOuRLWt2DEHBHU/sy8naQcR3n9LceAvC8mQTcMZ
         Zgl8j42hI5cxo0N4OKEolv4aEvQJcfwfkamRJMJHGx9tm7LdiE51u7b+rYkQ0sL2XvmT
         CpsutvcI6Jc9h141Don1paS+CXfjsGoLfEloMF6hISZG5rfU+EsloArvSPPRZfCo3RAH
         +8+bpIGOr67eMt0V/UrgZnEXTWB+oFmhHOTEVfU5ndTqGF7nstMKgzkkCRKnwjU8Pxc5
         mLYGsCLsHdGAx2UMRuMDKWzH02LIgPp8aCYFmg3tzfW9/I1suMiUmJMIANQXH+c10as6
         egug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300323; x=1706905123;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3HJaDM09fbTjK/4jsOsOa7gb7Jt0qkZYZSUzTgffZI=;
        b=kd2OGau6VHYLqUehjPY+3NC31hVp5PoooNk8J89xRf8HyntVV6GklTNvp1DT4XnCfg
         8PuoewoY9MEbkzjsPb+xjX2BaGoQYE5Os3wPglqXw7R3UI1exa8cGCdsolBY2yxHtck+
         4XRfUcXzC/pT8YtdxZbL1RqY4T1Y64fXdPQ385wnLghh75CANG6o3mV+D6C0Yn0UdtqJ
         ZaugxzFtB6ClfFeD0+XbGJDEyVh/Z5CM/lvbal02w69L437q2TGEqfnJ06FMrjh0O/1z
         REKdbvYYGfC8Z2hVPGA8m/xj8SNnb5QUAtqphGbhU7NdMB/NR5JFTt94Y/irA2M91ixc
         /mPA==
X-Gm-Message-State: AOJu0Yw+LTKLmou+MzAIfCX7VEGwntKy6EsHGX5qMHmxKlE6+30wH2pV
	yPqhGW55dDU0OtIuPDXha9fUZIK1iIQBZ83rPG04QMvAEWkdjU48
X-Google-Smtp-Source: AGHT+IGHJpO5/eGKF/XtPDBOc2DGEQiADM29kdwEZFgNI+HHHd/+AAgIGKmDUyCwxylFF+aNIZc2Pw==
X-Received: by 2002:a05:620a:4081:b0:783:980d:257 with SMTP id f1-20020a05620a408100b00783980d0257mr613012qko.2.1706300323493;
        Fri, 26 Jan 2024 12:18:43 -0800 (PST)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id vu2-20020a05620a560200b00783142f946bsm848154qkn.99.2024.01.26.12.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 12:18:42 -0800 (PST)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] index-pack: --fsck-objects to take an optional
 argument for fsck msgs
Date: Fri, 26 Jan 2024 15:18:42 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <47AE747C-69E0-467F-9EC6-860E7791C346@gmail.com>
In-Reply-To: <xmqqwmrwm08t.fsf@gitster.g>
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
 <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
 <cce63c6465fb1e29252d7e0918e03ff0f08d37f4.1706289180.git.gitgitgadget@gmail.com>
 <xmqqwmrwm08t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Junio,

On 26 Jan 2024, at 13:13, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +--fsck-objects[=<msg-ids>=<severity>...]::
>> +	Instructs index-pack to check for broken objects, but unlike `--strict`,
>> +	does not choke on broken links. If `<msg-ids>` is passed, it should be
>> +	a comma-separated list of `<msg-id>=<severity>` where `<msg-id>` and
>> +	`<severity>` are used to change the severity of `fsck` errors e.g.,
>> +	`--strict="missingEmail=ignore,badTagName=ignore"`. See the entry for
>
> In addition to the comment I made in my reply to 1/2, this should
> be `--fsck-objects="missingEmail=ignore,badTagName=ignore"`, I
> think.  Will treak locally.

Good catch. I might as well re-roll this since I forgot to add a Reviewed-by:
Christian Couder <christian.couder@gmail.com> trailer to the commits.

>
> Thanks.
