Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B61862
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771029040; cv=none; b=Xtga5s5o5oHFLUjrHiL/KBZ6PHnHVPujuOUjmONCOOxxuUCata1dsYvwrzYkX48bB4xtWjIJrzyNa/Xw6iLVJA4+gJOTIgyT7O6QJyp9ITSRkVYhxz/cDRNfTq3EtjNElG25tTZborFhi3NSPjQKBbHae6wWTfMZb4/0y6luVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771029040; c=relaxed/simple;
	bh=uJbPhhsWW4L1sGXeOOjW99/PZnpZuEQjVsUc+lpPle4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYiqPJJqUEc3lP8Z2E61WchpoYbyp5c+SpZ7xWdBRZe4b1lriOnD25fMlt0iJ0kU3uGA/ZkMyvT+IG5H8cvYygrOSUe3+Q4k9SbL2/XOoZ1Q3XvSplRWPEadB8akEuMDqePpyw7NTYQalUbTaHbBPkTW6Vx45ZzEa8aNAHFW/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ3ZScLI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ3ZScLI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-894674a4c4aso25101856d6.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 16:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771029038; x=1771633838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcyT7QLsZGVYFZPCpblQUnQFaMJDsHD4I6+y0wMrv3s=;
        b=MQ3ZScLIjqUu91kSkn150ajhQDSoA5Tw0iYKFrTijxEtBGony8Y0bB5Xj1e4sLf+nW
         u4LdOl3np97i4x9akcWl/538OrEa71fBagB8y5pLdSlNnvvcMw2gGZ9qKkYlVuUMP0Hu
         sCuZQklxnG3ggKFMNcJKStX1IH/Q3v1jSYx68hsOkp8vMsIPFZw5cmLA3obatfntHavY
         QNXfbI5Px5saPx4kNWPNFXVmlE0lnNvDb0STs8CzUyq8Q44fLeqTgN+4RSx6byOugq8H
         uXfIaG0u2BPA0ZFaCKxMz/b6Qw2cxSehqRSDgq1Obyul7PWZ2Z7ROCkGrnUpG30CLAIm
         hV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771029038; x=1771633838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcyT7QLsZGVYFZPCpblQUnQFaMJDsHD4I6+y0wMrv3s=;
        b=OR/Wwfo1TMb7Z2W2hXC43nCq/9hvlVkOAlGg1NF3lE0W5rStd8k6k2eAfZAGSUe4/q
         mi81FclGP2AtPRpIQ50K2KltQquHEvH+Kb2gEq4G4s0ZVqO68JPkjKheNjiAJUVf7BPK
         1WBWwHDqnjmcu5y4rmH14sJEXSp9wHUGzo+7PUceKW4wZoRJ3hiKH5TQ+a2pF67+YpzR
         2rU7mCvXFLA27nfi24Js0lDbP6XDQ82dNNDHhz12PJ4W/dBpEz+0ZSWMz8bkFGnF1Udg
         IJYbU3UeFpu/phQlWwIrgLmRpyyRiCkLXcEKTVsYSdu68b3tYsnlwN7OFbMqshYTImST
         xBzg==
X-Forwarded-Encrypted: i=1; AJvYcCWuLVn5/mH/dhx6lymmRCKdJGhapFcgsAzcy8k35bqfTreD8UqUiKPyYfetb0M09mZU4os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3GftLOXR8pBuzgsKy1kTXsfQwYKo1IUQsiawmJo/PBw8NS3q
	HNqjxDzTEPXb4ZbUIvD/yqHvHrqHl8Jn0OBGP2H2LTs73ERpApCN9arx
X-Gm-Gg: AZuq6aKaksp4Cg5hIGrTKJJ1NNJyFB52bsZyKQrhq3zMzjEVKiHtQYl7aL8vd3CU3zZ
	oZGnWHArvKDAgq0b4yDf9AIh+vcPlYfF+by2qAvBh11DPadzXlzFQ1Y3uYSgaLjNFbQHnkcOCqv
	GD7QcW/gbHFxwfSkSaYiSkyoFqY2wk3tNU4k83byvrryt2xkzasxD5EdQdML8+FDLPNIe6tl6pg
	6qkzdxiG2O2RX38AQjskIjpZcHqcZ0LQLY2QZaYhGgLQ2LmpLNgBl8VR7v0c3iASEXHT7FPF1Vy
	AECYt102Dwjn1b2bGN6J4bJWVwKXxLCjzF14IxvrEG4reJOKe6Z3/GS2ojw3nH4qL/TmbzBUbyv
	yXGJKi2GJ/R+LU5l+Z0JAu+foNMMqjSkq2ZngNsYOCCqBxQCxVE7yC58SJZB/efrBZkTdWvSkz2
	M/0T7QwqjIQXTKboyUE3b/+EDoPELGCwtflh4h2fZde5SR1DvQ8Xwqw04gfznRAQmWjxVQGEDAT
	57+JM4rBcAXkCErodPPdkfymvvBqZW7duv9s0MIzf7vBIEC5VI=
X-Received: by 2002:a05:6214:1949:b0:894:7051:bd9d with SMTP id 6a1803df08f44-897402ddfeemr20987416d6.9.1771029038353;
        Fri, 13 Feb 2026 16:30:38 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:8479:5909:7f7b:b823? ([2605:a601:a6b4:9c00:8479:5909:7f7b:b823])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b20f5desm714230585a.41.2026.02.13.16.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 16:30:37 -0800 (PST)
Message-ID: <85375ced-a62b-4f1c-a1c8-4fc4ed09102d@gmail.com>
Date: Fri, 13 Feb 2026 19:30:37 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] trace2: add macOS and Windows process ancestry
 tracing
To: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/26 2:54 PM, Matthew John Cheetham via GitGitGadget wrote:
> Updates in v2
> =============
> 
>   * On macOS do not filter out PPID 1 or 0, to match what the Linux
>     implementation does.
>     
>     Stopping before PID 1 and 0 means we do not emit the launchd init process
>     on macOS. The Linux implementation does not do this, nor does the Windows
>     implementation.
> 
>   * Add t0213-trace2-ancestry tests and extend the trace2 test helper.
>     
>     The tests use the "400ancestry" test helper to spawn child processes with
>     controlled trace2 environments. Verify that the process ancestry is being
>     correctly captured on platforms that support cmd_ancestry.
> 
>   * Drop USE_THE_REPOSITORY_VARIABLE macro as it was not required.
> 
>   * Updated commit messages to use more standard format to refer to existing
>     commits.

I took a look at the chnages and the new test code. Everything satisfies
my concerns from v1.

Thanks,
-Stole

