Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04564156875
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277236; cv=none; b=IJovjuXdjaz3TXBFJfNtoIyyCOiXBfNlHQNiq8CUYAx6euVxs6m2cgximRX0M6qbxLBcXpb22vQuFQ+RuWaiPFYM4SOiTcEqFWctQQkXBnoWEB4CRgG8VwNbFeLXAcW6U6POfghYqOCVCjc2oRYSXdziNPJsLjvcStjIFKLnGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277236; c=relaxed/simple;
	bh=huZWrsqsoTZGYfeGNFH9ho5yB927GOAYYL2predDn8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzJzO6IcoEBtnGAujiMtDSp3WJ/vgv/5fcopiqbEvpCaXD+o8NqI2iSEUGAhoEkEoOb5tYBAyqh8bpmfmbckVh8bA2Dna4JpJar8WPqQyvhL7OgTrJitZvhKoZ2htoLqburXLqMqzzlER4G9p4Ol0hBC4KyFZJjBet7ud/7k/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvs3B9Lq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvs3B9Lq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ee8e894deeso19681497b3.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732277234; x=1732882034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lluc1fXug91LbgVrJDiFiW6SVgYff+xa9STtbtJ5mCE=;
        b=dvs3B9Lquc7k5XGGUj7Mcmh4ZKJlX1u/yQZ6RlJm13FvrrqRhyxOSq/33zo/tC4J1z
         wxDWjACLAReru8wu90NwJ3Z89R1OrIk7wKdmTyv2c4yl/x7u2mgmHBlQNVmLaVLsyccS
         AkFn7En3/nDMy5/70JQLY1aIataoS4YTPLMeX6qyCHw4sz8fTl7YAnUB9LbJ1TaTIC/C
         DgnMOa/m7b1uUe/LNtk8JpFx0wjABsdC55FRfVRsEKU5QwfoLWMdNIc0yizM+79SCUt+
         ORRyubrRNeb18+/Qto87t714+l686orKXB3+sQitta6ocMW0vmW3AsfF5GJFbsR1dgbc
         pC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732277234; x=1732882034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lluc1fXug91LbgVrJDiFiW6SVgYff+xa9STtbtJ5mCE=;
        b=o6M+eILimwyblowD/uWVcBxKkVmWqjdjyZRdLnXW1DpaggafLBrusaMCiklFoSsLPs
         gMcKOsCnKeRrI5yBzWZCmvlKe++9fd31gOIAQpfUiVcMljEslXw7JojmjbbhUWagpUy/
         Ej6qTw5IcHkbAJlyLR/J9JJX7S3tszvZJP7flNfCh2jyp46ase/wh6R42GM8nqmg37dr
         m17bMGGNJ/o5WcDo89OLRrUAvtcq2SLY3G9ECO+4euTMPQMHytig2QryqW4YJc2jVL5P
         JnYVMxK69dGknwClHxDDDnmKoeCHmH356U+/tiWm/y6hZXI10v0lDJILuXpG1ZIOCLDW
         XxHw==
X-Gm-Message-State: AOJu0YxbbKPzMpVC08Sj1kl+PZxn7uScfE/thvjKVQrE52kqiQSFt5EB
	x756QJGd5J37yPii0EVFOhg8tTzIDSr1qdA1TKpdqGN4I+8j4JFf
X-Gm-Gg: ASbGncuQLbTpAeiwAvz3hIkHbug+jM81R54+bNRYjlswnLqrqJp3OaVaGm6vpLyQygz
	VRicXTcal5tU0o7a8qyrBW8e2z1K41RlP5zt0aMG+lJqwRl80VdzKDcIjng4bGPwiDzQVtu4CIu
	NPeIB6LGJIAY8FG/xlrwmtixO4lyekQEF09vcdJEmaZXk23xGw2+96W8ShtfNLjQywXasueRCjC
	Dg6IiQ4uumo0y4ApZobsm7Nzz/XkzRkceRWEuoDPhPdXPI2WkwcbPWtPX0dIunVsFGYjYByAujf
	H7hGMjuu9hHKVq6wnIm4IQRK4up69TCO6YU/hg==
X-Google-Smtp-Source: AGHT+IG7lKtBdOL4iyyImg1ROCgyt8Oqkz9P32lhsqIr4zftOsWg2knH0cVJMmfCm2ib+ntYjW5+ng==
X-Received: by 2002:a05:690c:3346:b0:6ec:b74d:a0ec with SMTP id 00721157ae682-6eee08ea2aemr29791367b3.20.1732277233937;
        Fri, 22 Nov 2024 04:07:13 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:79a7:3ea7:43e7:e05a? ([2600:1700:60ba:9810:79a7:3ea7:43e7:e05a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00800d4sm4118387b3.92.2024.11.22.04.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:07:13 -0800 (PST)
Message-ID: <5400973a-290f-4fb6-a4cb-28d2effd1d83@gmail.com>
Date: Fri, 22 Nov 2024 07:07:12 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] repack: add --full-name-hash option
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <93395c93347274d075c3e29b3bd20dcc221b15be.1730775908.git.gitgitgadget@gmail.com>
 <Zz+UJHclSsb+Bgfo@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+UJHclSsb+Bgfo@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 3:12 PM, Taylor Blau wrote:
> On Tue, Nov 05, 2024 at 03:05:02AM +0000, Derrick Stolee via GitGitGadget wrote:
>> ---
>>   t/t7700-repack.sh       |  7 +++++++
>>   t/test-lib-functions.sh | 26 ++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
> 
> OK, I stand by my thinking in the previous patch that this one is where
> the changes to builtin/repack.c belong.

Yes. I should have done this already.

> I do think that test_subcommand_flex may be unnecessary though, since
> you could instead write this as:
> 
>      test_subcommand "git pack-objects.*--full-name-hash" <full-trace.txt
> 
> and get the same behavior.
This does require knowing a bit about the internals of test_subcommand
that may be too much of a burden for future contributors.

Thanks,
-Stolee

