Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BB195
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723599355; cv=none; b=otfHjumWJHKGgN6XZmE/6X6cY5aw3q/lsjKmr+Tne3dwC+Oo3Vt154W7lQw9BHdXCqQnH3zJcyQPJemwPyJiqHAPvG+3jXtzkyrGdEQT8k/szv6lpEAJcbSq/62y3PMBuPDgVNS/XtrqN6orVUUbCZBDTTnx7m/nYOihSOigwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723599355; c=relaxed/simple;
	bh=usfMqPhAKkhV0tGZ/k7SGC4cRx+FsF2GDJkV1DdXEYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDtbpKj7GK4o6xUcS9X8hU05/Hh2cVw0tgYAWu37bb4Dxar/I6fGeCwd5s9N2bGz1UzOimVtEzWh7eOw6gEGO5PQ+UCRhU/s+fNSNo/3srR4YLZ3T1X8GxdbKht6I+PaRFAFyyLoYWCFJAmhdRGzj96PkfuGVISiKMLJZ8R5TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9GTRnEv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9GTRnEv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d1c1fb5cafso4119032a91.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723599354; x=1724204154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JH1jhSxftlZq5AMuHfFkIEqydORulda0yY0xWMCsg5o=;
        b=T9GTRnEvLqn8Zdig0+48TCC67F03CNQaTNkO3SJDR4hIv4HZBmLe7XDgN9DDzxM2VJ
         MC1A1r6w+jHWsb3FsmaJAXlO/u4DnEwKble/9eV/uu2GPdwZZBNkxjrAoL3EUNmjcbhH
         +VxVSfrmoEua2WbjaOjXxprLGQa1K2L4DYsyUJKgvz2Gt8uXfiaRN6tcpgOvk99yMhKN
         uGWLCHOwuuceBBlafjDEHpkdga7SjWRuz5nStxBU8VoynFlrR2pNB4KMg6Cz5awTba8v
         cI2+mrbB0XsXTBYq2XUBYSGzeZqmcb6mw6Xv5RpXqulUOb8d/PeGOYasYdzVh331rEWU
         32Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723599354; x=1724204154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JH1jhSxftlZq5AMuHfFkIEqydORulda0yY0xWMCsg5o=;
        b=rRQDnjCANMPpJLE7/0ySK8+aOF9ZyIwox/Noz9VUWdDDAQDAei6hrwHXFHcHGi4o1m
         bIKxLCigCdcVrRhyJZktFCU25n/8VKvWqsCoabUY7Gz8bxJGyNIVb5cLpiLXnn6sjb2b
         99AizuvoFWZ8LLD6gc8vupW+jjQBsIvEtk4U1R0WnIikm0KthgxCCtuQ4hygM5Rw0e4O
         f6nX2Bgm+305Udsi3/K/+3GtxDO055a64Zzp1f4BphvW5m1dcTp63mWspHgANnfGquIT
         Qc0QFn1Qqo+dACIB96Wo8krxdpii3hicj2G9qZMYdI4/N3MAp31/Ez1qup/zqXCU+5GH
         UuHQ==
X-Gm-Message-State: AOJu0Yx8HIXoxczhgPA6Jq0jI2fL1Lckn082WtEc1aa7QF9Dugge8IRi
	MnBfmsV3k54AbTLXCXAf1yL2/WOSpnuaLigAv0fkdCQIVe6UVmN6
X-Google-Smtp-Source: AGHT+IF05pp1DYLM72kUyY33r1M2rYlHd5hNWJ33xO2sJRxO3RbiOAGlKVqMvCfdIobmfKcKfrxIiQ==
X-Received: by 2002:a17:90a:128e:b0:2c6:ee50:5af4 with SMTP id 98e67ed59e1d1-2d3aaa79f7cmr1554485a91.6.1723599353661;
        Tue, 13 Aug 2024 18:35:53 -0700 (PDT)
Received: from [192.168.208.42] ([106.51.26.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac843874sm264900a91.45.2024.08.13.18.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 18:35:53 -0700 (PDT)
Message-ID: <b369797c-37c0-4f17-b857-a2ff8680cb4f@gmail.com>
Date: Wed, 14 Aug 2024 07:05:47 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][PATCH v2] t: migrate t0110-urlmatch-normalization to the
 new framework
To: Junio C Hamano <gitster@pobox.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>,
 Christian Couder <chriscool@tuxfamily.org>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <20240813172432.55487-1-shyamthakkar001@gmail.com>
 <xmqqh6bo448j.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqh6bo448j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/24 00:52, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> I wonder if we should get of t/t-urlmatch-normalization/ directory
> and instead hold these test data in the form of string constants in
> the program.  After all, you have the expected normalization result
> hardcoded in the binary (e.g. t_url_high_bit() asks the checker
> function to read from "url-1" file and then compare the result of
> normalization with a hardcoded string constant), so having the test
> data in separate files only risks the input and the output easily
> drift apart.
> 
> As a side effect, it would make it easily possible to run the tests
> anywhere, because you no longer depend on these url-$n input files.
> It of course depends on how burdensome the limitation that we can
> run the tests only from a fixed place really is, but it generally is
> not a good idea to have these random sequence of bytes in small
> files that nobody looks at in a repository in the first place.
> 

I think the reason these inputs are present in the files is solely
because they are random sequence of characters which contain unicode
and even some control characters. This makes it tricky to hold the
input string in the source itself.

I'm not sure there would be a straight-forward way to have these inputs
in the C source file. There may be some way to represent them in an 
alternate form but I suppose that would sacrifice the readability of 
these inputs which I believe is also a significant factor for test cases.

Feel free to enlighten us if we're possibly missing some straight 
forward way of having these input URLs in the source files.

--
Sivaraam
