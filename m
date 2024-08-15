Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115691A00CF
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730657; cv=none; b=r/AzpymkM7zzqIh3C+PK912jP2IsUGJiw2p1lMqUkInWEHOLK4BffgF1EeBk9mUbpO6wgrODN90TJS5udugv2qMG9z+cVegcetic83BCKBIlMhq9EQrbO+IrpIlvdi51mEi2UxhQ7qE9sE4CkZN5LfQLwgx3SEIV4T/Gs1InwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730657; c=relaxed/simple;
	bh=C/etkKq0U8fq+D5k2enVj42ucBg1gMZATr234LrSyxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CaBKsKrhOSXVYXc+RABHi+yfpQyqheE2U44flMAcvfPVluV/V64FZFz5Qhj7NOroWni0E/AxWr82jrX8nLdEk2vHW8OPnQdCVdgZHHCLyDcMGwUKRXgwSdzXfNsjx3TGgLcMIG1QSgQVDW+B3+WPE/t7RumHImzg3VPYGGjSjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmPRBIM/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmPRBIM/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d394313aceso677843a91.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723730655; x=1724335455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtyYcH+RNgQIIWb0cOSJouIj7cWLSVoofdwMMzU+H0M=;
        b=LmPRBIM/ECjS68H9z4bz4OFjgX7jsU2psc7HetjWgHsmpZO6zMdiQBpNqngNFbhoxH
         1d2R/6wZetlC104J+KBWgwxbpSpo+K7yZ9k0ZLAVClCiN557EUt5w0aKOTG8A9opCkMx
         BkBMBaWmF5tkSOyzEeaIMbGqLNugkS65T5pydTiFMRY8DH/2MmtJqJnXmPO5nqeNSKaS
         ZKFlaxRB+HXEKc3jtF3H4YWT6isp0fx0nymdmTS/agXM5ElsnfCCbNLtnDt+C/+Hz+5q
         QrpAvlcB2asYA5Cx+BByiaP3yLrspowwAO2YrLmkOoHpPsaujakQPB1sxRyIUTfQbb8j
         EXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723730655; x=1724335455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtyYcH+RNgQIIWb0cOSJouIj7cWLSVoofdwMMzU+H0M=;
        b=H9UYyTnPzw4iRuqPnuAGJ5vKmhxwM3km007rp4CRuRrgVq15i/5SRPgiGRKQG3HRd0
         DAdzPSdDX6PG15zX5syKuhJMYaDR7lDqdmoK1mffZe8oq/oP1fhKzLD5sJ/2hT/FMz4D
         N/7VLBDPC5U6AzZ2Ta1KC5SxAcYsOkOxr4dSYwTGyBQifodKJ1ifXUv64Pq3V+EyfQ6r
         +fLOxD8O9OvgWetzYX/FkBnkDb3+fBodawrBuTt+kXw+nMbpfZ8QVoJ3sleQfcaEPn5d
         kK+1CotDoYfImD1cAxZMRI7e5BprB4jNp1Q7R/3sEctrFti5ESuIootXmiLO+8Y8WUqU
         n5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGoF0VIhOXZhzaUgT50ox1+1kw2NDvxZRkzeQD7uo3DEm4TFkBhfmA4i2AMZ68cUVOAIVJF0vaYxudf2dqoDZy7E06
X-Gm-Message-State: AOJu0Yy3Lw9iZ7JbwqhAglX/dRo/tIBHjDxNvS1erLx1DkHj6Jw+qPqE
	jgio4TzlnTxwYh66xU6B/XJ5J+sl69M2rD8XWWqsC0vpiilmbziIdZq2j35l
X-Google-Smtp-Source: AGHT+IEnOM99KnKanmduEIO146Xe6l0ZIXXrKzjM6FH15HCrjkiqvGesv9mBjdi3rCXeer88YDdsHw==
X-Received: by 2002:a17:90b:805:b0:2d3:b1d1:b62d with SMTP id 98e67ed59e1d1-2d3b1d1c6f1mr5561184a91.24.1723730653639;
        Thu, 15 Aug 2024 07:04:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:69ca:a1c4:ca16:9d53? ([2600:1700:60ba:9810:69ca:a1c4:ca16:9d53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3d5695634sm692996a91.29.2024.08.15.07.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 07:04:11 -0700 (PDT)
Message-ID: <de298972-a359-46dd-b808-4edaa8701d40@gmail.com>
Date: Thu, 15 Aug 2024 10:04:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1723533091.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 3:17 AM, Patrick Steinhardt wrote:

> I recently configured git-maintenance(1) to not use git-gc(1) anymore,
> but instead to use git-multi-pack-index(1). I quickly noticed that the
> behaviour here is somewhat broken because instead of auto-detaching when
> `git maintenance run --auto` executes, we wait for the process to run to
> completion.
> 
> The root cause is that git-maintenance(1), probably by accident,
> continues to rely on the auto-detaching mechanism in git-gc(1). So
> instead of having git-maintenance(1) detach, it is git-gc(1) that
> detaches and thus causes git-maintenance(1) to exit early. That of
> course falls flat once any maintenance task other than git-gc(1)
> executes, because these won't detach.
> 
> Despite being a usability issue, this may also cause git-gc(1) to run
> concurrently with any other enabled maintenance tasks. This shouldn't
> lead to data loss, but it can certainly lead to processes stomping on
> each others feet.
> 
> This patch series fixes this by wiring up new `--detach` flags for both
> git-gc(1) and git-maintenance(1). Like this, git-maintenance(1) now
> knows to execute `git gc --auto --no-detach`, while our auto-maintenance
> will execute `git mainteance run --auto --detach`.

Thank you for noticing this behavior, which is essentially an unintended
regression from when the maintenance command was first introduced. It
worked for most users because of the accidental detachment of the GC
task, but now users can correctly customize their automatic maintenance
to run in the background.

This was my oversight, as I was focused on scheduled maintenance as
being the primary way that users would customize their maintenance tasks.
Thank you for unifying the concepts.

I sprinkled in commentary, and most of it was just things I noticed
while reading the series in order but then later patches or a careful
read made my comments non-actionable.

This v1 looks good to me.

Thanks,
-Stolee

