Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58B296150
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866766; cv=none; b=DaHcCQgaJc1Wco/Hle25LdjlmbaU4G0Rb9Q0OsvdlckGOhU8bCu8TSdC18cEfKxeAJvrel/2i/bv4sdhdgX44AFo6Pz1s+szAD06Kw3gX4L6vxMf8JJprsoq6J2JRGI99C4nYsE/hSdTKb3+UZlOi7KXt2bPcncNELHsn6PwiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866766; c=relaxed/simple;
	bh=C2wbUrL+Y+dH0waNCAsSPFEUwQ5QP1CNRQPYUzMi2Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1tM2KdykCoDmpGm0smZ+qWwwfXHSct/SbOTMtbpNREexmPLdqA26AxlgCR2voVOeQqfhn5cIM636PoQImjRfdJdFOYnmodS9LnEofy1F06EJluBxr7k+mQnh7cTdQStIEnchd1YeLN/7Oxtom/fvGK+sEehM2IL7eJ3c3yl3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+PjDQOb; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+PjDQOb"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-707d02aca67so43608977b3.2
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745866764; x=1746471564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uh81WdT/7dbR6pCECgyMPe4mzAZtiN9Ch+3vGzkiwoA=;
        b=e+PjDQObHesQ9uHjvWXWVhyV19WbDdIN1IMRX0cv054B56yK6xoMwGb9v4llAV/8yP
         ObxMt6hTb5KNeyJOGWx3KUh1d16pHTxyXKcL0qEbcYdPerXeheyu+KMU3yZx/I43VRGz
         yZtBA7AaZ2zWwhFVvo5RUYQ6vOBDULwLMSPmu+rGHjh3zvW/KHwPVSGio4oIOVxGGy4F
         Tnq1uHRdVpl20cHb9fdPQc8gSVO35SyZAKByzyAZu1p37ZLXDTwLh2HsPvi4yI2eDLZf
         Yp6wb1wRQQiH8cQR1Q2/suh1UZJbh77WKZF42UbDphnKYyNozuM1PBpKiqIEeGumdyUM
         v6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866764; x=1746471564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh81WdT/7dbR6pCECgyMPe4mzAZtiN9Ch+3vGzkiwoA=;
        b=Hv+10M2YhtqnHPRTGyEEErX8KyZeGaspH4SGNkr12foHq/cIVzVyeFnUK+s0wH15vK
         rbns1ksLkky5CmZyePct+Y654OLVAoZAca+JHU4S9Ha2ipylTCsUB+SBzDelTiWsCldG
         Zk/orqlBb56857jVBOxEcbt9d4zUdFo2ujKzaCQpNCzG4O3tq78yy28+EM/2BUMFx8te
         SXbqUYpo9mPVIUU0hW9Ne9m8WSls0DrRPGu2TFaHy/YG1redTO4JD5fBzJIHZVHucGcn
         Qi7ylR0+oqeW9GRpySxAvg+M0VLiWL8n7ReKLN7bYP+gAG6DV3p9CjnRRliuP52fg6tw
         SwIA==
X-Forwarded-Encrypted: i=1; AJvYcCWJS0VzhkYPVl0xPb1BHFrAKXYBhiozZbH2G8oLYMzTyQL6YCDCLhZ+3qRvA8zdS93QmF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxOrXKWNlaQCTzymlUdHAFioZnH/JSIAXv7NBjlNNW4WlHeXX
	FohgEwcYVstPGM6CBUZC1Xwr4jvzKHQVmubQbXjXRTXW/Cm5lpllnzCshQ==
X-Gm-Gg: ASbGncsOW1ReudYagxHBza6QLl/5oKotXmROSyu37Kw4uc3hmoY6pRa+GyY9wnRLGXF
	Ubyz04RTJ10yQ9/hTytPI672poOswwxuqBV5sjGH/Npp6+wAZztukzuU6MZ6qyeD7P7uGdL14oQ
	B7ovCcjqIECrA0mG5YlwMIDCnqPCdheHFNrvWAUn9JZaHg15/OCL4v7MrZaP9Zv4qCY5Bfcr0Ul
	3YICaKmlzywIMDeQt2hjWitzGrQ8g2hcAmabMxxdzcKeaDLGBXp1rn3K9A4b/l2Baa2i54GLOT3
	hbyCL7yeOORGrbz7Nmqk96Z59l+70HgioHCSuSKd81Ar1QFIlQOQdT6AURIT5wus7igWcHnKKsd
	+CLsDRrZPeIkmHBWW
X-Google-Smtp-Source: AGHT+IEtaneNNrqnVdPDEVKnu0uMrA/BPDnMOj1dQLvPmtKDQ8K0PfVjgejzgY788KKfsFUG9Od5ag==
X-Received: by 2002:a05:690c:d1b:b0:6f9:af1f:fdd0 with SMTP id 00721157ae682-7089b436858mr2075127b3.31.1745866763956;
        Mon, 28 Apr 2025 11:59:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2567:30ad:ba54:9d4f? ([2600:1700:60ba:9810:2567:30ad:ba54:9d4f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70841aec6d5sm25590607b3.108.2025.04.28.11.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 11:59:23 -0700 (PDT)
Message-ID: <6df25bf2-6df1-4c3a-9061-e3297dec38ab@gmail.com>
Date: Mon, 28 Apr 2025 14:59:22 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, peff@peff.net
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
 <aAsQwSfr-YvS2Mvh@pks.im> <090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
 <aAtZuU6Qqfag6OHj@pks.im> <xmqqbjskurz5.fsf@gitster.g>
 <275808ae-7126-4a24-b5f3-283ea8023f5f@gmail.com> <xmqqmsc0dyyf.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmsc0dyyf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/2025 12:37 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> Yeah, I think we clearly showed our "it's just test helper, whose
>>> callers are supposed to know what they are doing" attitude, but with
>>> proper helpers, it is not too much additional effort to do the right
>>> thing.
>>
>> But with this philosophy in mind I can change the CLI to be of the form
>> "--num-objects <n>" to use the parse-options feature. This should make
>> things more extensible in the future.
> 
> True.  If we are aiming to deliver this to end-user's hands in some
> future, I agree that we want to make it extensible, make it dtrt
> without being told, and make it harder to give wrong input. 

I'm not focused on usability, but instead on faster development cycles
if more advanced options are required in the future. I'll happily take
some extra time now to help those who come after.

> If we
> are going in that direction [*], I suspect this should not be a
> separate and independent input---rather, shouldn't the tool already
> _know_ what objects it placed in the resulting output stream, and
> should be able to _count_ that number by itself? 

This makes sense as a feature, except that we need to write the number
of objects present in a packfile in its header. If we wanted to avoid
the argument, then we'd need to load the data into a list before
starting to write the packfile. By taking the count in advance, the
implementation is simpler.

> One thing it lets
> us do to have this as a separate number is to create an invalid pack
> stream where the header gives a wrong number, and as a test tool,
> that may trump the convenience of not having to give the number
> explicitly.
But also, this allows generating bad packfiles which is a bonus.
A very good point. 
> Another thing we may want to add to the tool is to give it a mode
> that either (1) refuses to place the same object in a single pack
> stream more than once, or (2) warn when it happens.  The latter
> would be useful to create an invalid pack stream for testing.

Noted for potential future expansion.

Thanks,
-Stolee

