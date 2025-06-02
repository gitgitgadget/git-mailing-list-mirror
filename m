Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1B19CC1C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858842; cv=none; b=QkWocxU9zwRNiFuTx9oTU7s5kJJt7XJFOgGsfuWAYIsSnWFhAxeg5ueIgogmNhWPPdBywa7HlcAhh/1WPoJD+dsAqLbmrvy2eLqyDC+jI2gX5xZLeCt2afVa2mB1yA3LsHQoBkrBxz/uT4KAhi/xHRkEa5ORyT+gvTyRoqj1Wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858842; c=relaxed/simple;
	bh=pKlfmlyYtYa15YrXGY/NnP2fxhA21jbTpqxV3FaowZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ePok6BI+M0zyER1Ho4ejABWrUp9hj3eM8DJMxeeWcLwwCJ44IVQsNcelG8na/JTTAFrSP4wqYSdDdLS9VwO4f3TmZOPENSGOkeDwXxhByC1jr5CcNgqAXW7javzXteonELrNgpntE2TNjQt8jCX+yrK7rJ/BPT5G5cSsLTV4lWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbY/HgTW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbY/HgTW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so44924795e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858839; x=1749463639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EbaZrjDcEhS3v5Hk/wEohymcO9uVBaGIalAlAoI1rMo=;
        b=TbY/HgTWEbdY2z8DuVeDe+x7dwftV0h6caUMCjR5aeKfBRXujsJFLdu418DxTcNrK0
         z2zSTY8EZzqLOzYUKYFRG8WvzD5Q1tCvpWTwJb/jfaRLeavGm11jIKkpFkGlat3LxhAL
         7lYlyAf4KZlma2mW8TWJpA7YG57Maaz/N5J3H3z+HVQY4ZbKZxediiOH9IwdMK/yDpgt
         cNa0txhUSMkQFVpvr1+Oxcg/2t6IiL9flYIXD1gfguJA9G0jeDq/B+Mr25cOdCWkOkTs
         F5CtogctDgZU+cYsBAwoWeMOmthkpPmC2wtaow1RFDBf+/t6EdOueZgxFaS0UpgymIIM
         whRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858839; x=1749463639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbaZrjDcEhS3v5Hk/wEohymcO9uVBaGIalAlAoI1rMo=;
        b=Y92vzPonrTrOFcTeUNabGLYuVe4iPqWCsyEe486SorPcq1WVxXs7JYtkPtbljvCMLs
         F3G72LcpPSVpva5d504ar/qlZ8w29OeEOcyldtiJNdOTCP7gK+p96uHs9j7uUYBH8NOt
         uebz+E04NqcrOOppgG/11ZZ8C7jriSlJhAO0unrRfZbabtFRoQPqdlAGqVFOUtlwPcRm
         0Bxj3Y7actY5B6It6/6BYtNpJvBngrpbrz5SL7Obm7oVFesCtiYtmaahvxQc8caUw7y4
         dHd0JJ0ZdgNwcDYTu1cTXTzbcSAFmJY7xob3LNwiwFLPh0VWvL4nS/T1bDoQpv4T3KNF
         kkrw==
X-Forwarded-Encrypted: i=1; AJvYcCXuqPkb37OOllxrUuFO5TjJ0c40hCINCd1Dip+/rA9Y/zQMxC+BCIWR/8maoba4fh23dKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VPevdSsOFwspa+qZ6tKQj8H8gasjWKQOfoHiw1uotG8CBk8X
	rCN4LTRG05dra3eujkP7P4ijs3s3mcl/+Wv9rSHhZFT2B9nWHln01J7Zftkoyg==
X-Gm-Gg: ASbGncshChyhSIYZB2tPBufqkN6t6u1jAEiR1D+Hd/XcwQ5foXVKPUo1It2TGsGOJL6
	rdjchoAZyjFi0aSp7wRpuooo1pX1T76D/abk+g7obHfqmkY9rZw0nEWM9i0y3oDzgHRBZSAafso
	dydRa6v7ah/AJ24TuFyaXDzTuNVMO8sPYXiCw7DEgzvEtEmye26PZCjO0ciG/gvOFRkXrd0Rv3n
	JbeZ4Nk7goDCmF9WVoCPW+i0uAw0xSsqxpS3+6nRO+m43GerMRVozk+qdv/BXFmuFeiLuIr1Tdx
	t1554jLU05GDMRWpX2Y24GGCfJcdvupXSKkiOQdl6AiMTyWeBka8TPDvCrQg4qaSXo+aCH4ftW/
	i0MVW54BF50qwa+szchPz0kEIH3k=
X-Google-Smtp-Source: AGHT+IF9/wccnoE/DIv8CoZoGOxshgyF5TyZOdGIiZCanwu4NLy04u4JhPAUq6WD+kSIzsvb5gL1/A==
X-Received: by 2002:a05:600c:35d2:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-450d6585955mr98291805e9.26.1748858838627;
        Mon, 02 Jun 2025 03:07:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa270csm117465735e9.16.2025.06.02.03.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 03:07:18 -0700 (PDT)
Message-ID: <e790367c-6777-4b4b-97f1-3b3a2cbdb177@gmail.com>
Date: Mon, 2 Jun 2025 11:07:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG]: Non-matching exclude pathspec causes an error in empty
 repository when the flag "--update" is present
To: Piotr Siupa <piotrsiupa@gmail.com>, git@vger.kernel.org
References: <CAPM0=yCcOAGsUE8tX-o8ioihr+oWrORD6Tz=WH1OnmhpO+uqrA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPM0=yCcOAGsUE8tX-o8ioihr+oWrORD6Tz=WH1OnmhpO+uqrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Piotr

On 27/05/2025 09:14, Piotr Siupa wrote:
> I found a regression in version 2.45.0. (It's still present in the
> current next - 2.49.0.1266.g31b7d2e469; earlier versions work fine.)

So it 2.44.0 there is no error message?

> When you run "git add --update" with an exclude pathspec on an empty
> repository, the command fails, showing an error about not being able
> to find the specified files.
> This happens only if the repository contains no files. Adding any
> files (even with "git add -N") or making a non-empty commit fixes the
> issue, regardless of whether the added files match the exclude
> pathspec or not.
> 
> Way to reproduce:
> git init
> git add --update -- ':(exclude)foo'
> 
> This results in:
> error: pathspec ':(exclude)foo' did not match any file(s) known to git
> error: pathspec '.' did not match any file(s) known to git

I agree this is inconsistent with what happens if there are tracked 
files but I wonder if it is actually better to print an error message 
when an exclude pattern excludes all the files. We do print an error for

git add -u does-not-exist

because it does not match any file but not with

git add -u ':(exclude)*'

or

git add -u builtin ':(exclude)*.[ch]'

which will never add any files (the builtin directory only contains '.c' 
and '.h' files). So I think maybe the bug is that we don't print an 
error when there are tracked files and an exclude pattern matches everything

Best Wishes

Phillip
