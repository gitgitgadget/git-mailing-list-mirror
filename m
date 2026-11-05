Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891933;
	b=EqatisblKTpjIumkSOdUu1Ihr4svMNZ7QJpfx9gbc+8a1rw3IOClcoj4K6VWKV3wmDze
	 kaMYG0MW5m99//mI/9SFsuPkspOtiRztWZ1vYQEAW/qHzqd68Md3IRVYhZHi6qGSn+b+V
	 k1OGBLkZFETp8SszoSwYHpc1W+CfEsUh6ffvRPhJhtONbWiedtdlc4t+ItDaj7iPq+IHh
	 7vM0HMYqdWcO95h3E44EFjiK8gF9Fu4Um7kmAXXlWFRBGVBMRj809GPoMMbM2zqQMYnTA
	 daCyOPYlPRtqY6a4WgzApukM0aOL5pCEMvCRQHZI7NyDCgpL4Ih/bplAaSbn2X+VhJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9LbUO+EP812p1DYWUbKfQ/7o1V+AzSAmpnNZLppkuQM=;
	b=LRagouV+kJvX426omW6Z0fJoPZotSb/ErViIFJJf06+8YH919NXQPBOn6IhLROrlE/68
	 oJwUWNRrRkBPFI2GMUqFMaYLAdPWcdASB+lvgcoj9+hwufVxFwBtnHfksphOVJ3PJ/Dnf
	 kMPWQ2Y/CgOHxuoXWa2bTpaNub4GoNe3rIXn//r3RTt8EA/WH14tw84a7bWZ0pK4n9Khs
	 XQtVhu21Nj4BUOiW5PpzVWW15H89PZPipFagaTccNAeyf0HzAYrp1DAKqC22gVdoXm3qT
	 s588cx9PhgLHzolIWLc197GM1DGtgsOri3VTMqPe6/uBBRhSuR+TbQd556tsasc2YQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJI3z2cu;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B07606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B07606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJI3z2cu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f3c89594cso179547285a.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793891932; x=1794496732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LbUO+EP812p1DYWUbKfQ/7o1V+AzSAmpnNZLppkuQM=;
        b=QJI3z2cutQShHFV4NfnBphPU4bIKNCZIbExe+Ua+uI7ca8dbhUZUwNLY042VpMzwwx
         ZHyN248LoEuinJljN6YAZXAofqYKcQFDr8+DdqeGdA4hiLGk8YgbCUSJDLlA1I9RidEb
         z1a027Ez7L+gkWgxk+Rk7ZzVr9lJqMrblwiDhfiD6/06au9l3q4R1IigIlsNiJnn6nii
         u0iJI8s8uxyGg1FJV2bH5SnsopZIjvU679b71BSujuqnn3CgWahixCoFiJpuFT9+Wptu
         yfDvbrqHdJUuGuJeroGwuXDJZxk0WIC7fqFB9foGyUoea7aXDgjWXQ3/Yk3iDNQGEGzQ
         IITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891932; x=1794496732;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LbUO+EP812p1DYWUbKfQ/7o1V+AzSAmpnNZLppkuQM=;
        b=lH8II649kIapgctghLovmnN5Wvu+85hRERqBnMGwLYImfwTiqQ5VUGdZltDf/N9XB3
         t/ShsHqn+WSgPYZE+Opwvju4y2bjvQ+WfDKdpUqaOIV9U0sXrNHMXsqkvWKapZXQmjr2
         WuCQAggS52xmHWdXfCHdCGC3m2hZn7zK8zs96IoBbgM+f4kN0US8NdJyTDNOOLIRdbO1
         HJtKpW1BKpZ14XK0GQAoFqgPJyoEeo6x3WaisoAM8etP/NE3hO6DNsSedLW6EpH0MVCe
         h5d02pYuxDAXDOniVQqwG3+7/w8qITWJTA0IGAw0eVztxrSSVupXdVCVQZHPIN9pTqcG
         iVQw==
X-Gm-Message-State: APuU4Z/RZ2sQP0cRreQV/r/mOIGMLXxjriqb0xIcfe6F2faDW6fMGi/P
	6ZbJAx/xHE91n0Awf5iHKFEBkRk9malvJG4mymxfxJsH2AgK5x31hsFc
X-Gm-Gg: AYBFou09jQ9qu+okTzcfN2y1G3hlwCtuX7dWjoX+c2Y+xdLBcApj8Axj65Xzhr91QP7
	l1JYdZj61hPDluxQk5Uy/C5jn2LTs/3M3qNf82MNV7FVcrHP6BxCmmm2zzQdrU+yoPp5aLjNeXZ
	RwecQz5LUuzjame9Vtks6sHATp56hs//rnAomvBZH0AXmEKfkNVmrAptXzs8cIzLS71MCcEww/L
	tPCY8m00v6aMvP7TS+bJVRRSZKhYdovZxoiUabGk3zNzNZZMpBc7v5AqgB5awYYj/1sYPQtgXl/
	QEzZfzZBM+ZAG0CXQDd9CgHAOQe9az27c+lHTYJKugyIhdlXBgsxPI2fhx4P8FSqz07qpTCnUia
	QioY5aR+0D43J5incDtfB6Y+IK68P20C6QxmSYtSSWrXv5/YoAIERpv5YOBn/JkhpZD5kslNNMf
	0kSdASfEL1OT+kvZ5XGA+AL2l1iaCljlk4egqmHquVaR40LKH5B+zVmTs/NGrJdG9ZC1LLpYK8J
	lteg1aNQs8yXLIrnTiVz4CSi7O/nghcBOj/TPmYFiXYxDwC5jKnGrpzkbJXSfrAtL8JSmsH9dh7
	ztOKfT8wbJFttB7aOEqtkqmmR3N2S2Q1vWqDGDHHm2E77t4+6IqMUzoS/k1tZDrQiskzESHkVNj
	MD+RtpgqFLuQYPnOTsBb68uScAtKaou+FKUFW3VZNjLPXFfFzpSU+1rnz2K5jfa5i94CwnU0W7Q
	0pHnAXpJeDOU26FFDU+Bzv7G05jqO8lVvvSM2Lqk6Y0s9CXjI6g8LriTRtCkP//axjEQmSNnUj6
	w==
X-Received: by 2002:a05:620a:3181:b0:944:907:8f64 with SMTP id af79cd13be357-9442174703bmr3228934485a.67.1793891932302;
        Thu, 05 Nov 2026 07:18:52 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d483d762sm484895785a.27.2026.11.05.07.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:18:51 -0800 (PST)
Message-ID: <ca5986e3-8f66-4628-9f06-eb2416378bef@gmail.com>
Date: Thu, 5 Nov 2026 10:18:51 -0500
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
Subject: Re: [PATCH 00/10] commit-graph: several refactorings for writing
 commit graphs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com> <auyLRZ8TWeqdIaRm@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <auyLRZ8TWeqdIaRm@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/2026 8:57 AM, Patrick Steinhardt wrote:
> On Wed, Nov 04, 2026 at 11:37:11AM -0500, Derrick Stolee wrote:
>> On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
>>> Hi,
>>>
>>> this patch series includes several small cleanups for the interfaces for
>>> writing commit graphs. Most importantly, the series refactors options so
>>> that they all get passed via `struct commit_graph_write_options`. These
>>> cleanups are split out of a bigger change to make reading and writing
>>> commit-graphs pluggable via the object database bakcend.
>> These cleanups look great. They are carefully constructed to be as
>> simple as possible at each step. It's good to bring some of these
>> conventions into a more modern style and to simplify things in the
>> process.
> 
> Ah, by the way, one thing I forgot: I noticed this recently already, but
> you don't reply-to-all and thus lose the Cc's on your replies. That made
> me miss a couple of your replies already, so I'd appreciate it if you
> could keep them.
Sorry about that. I learned that Thunderbird replaced the "Reply All"
button with a "Reply List" button that led to this unintentional
behavior. I'll figure out how to change that default.

Thanks,
-Stolee

