Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344332BCF45
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507521; cv=none; b=G/wrhSB4UUHsHg9XjSNei9BNjdIPCG/EikutCJAnU1GjI97oKsNvXjdSWxIxwQ5IbO7gXlEapIOI+bTvCRwO/DzozJOPbaG4Es34IYm+Sls0/GzZBP7M8+wTaykUMc9HVqVZzrzW1iccgNE98DHaTlf8xUfYzEUV9o0he7cyC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507521; c=relaxed/simple;
	bh=uShvoJysAt6bKNaOGvZRgQoX0t5ZyldTN2uUw59Yk3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS16T4BD6AK6BAw5K06So5Yk6I2V27kM3uCQ2zk69PcTyArTxpp50WXxuers7MNqVfTRRJReV3QnkpBe3Vptl1ewS9VvvFlNj1g+KJu1/yrctMEfOvu3oGNb0vQ2WNXEWMJQfvfyN1ljxyPeku4ruJOtWc2zaGYYOIdhgPxv8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppM5cmdH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppM5cmdH"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d1872504cbso4125558a34.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 13:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775507519; x=1776112319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqmuKOY/3ZYG4L+k3KzOiz5CoAelEzD84zbZeNLp2rs=;
        b=ppM5cmdHUbmpFFAhvyVc8XGAJXoOG6gXnkokS6ajzt/Di1PXbzkufUT4ooHmD64SuE
         goqAbrIYLGAl0ZV4NkQ+BMd3wZvUY7HKls0VK2umhw2xzt8RV0ImoVvqWzT7Kamb01ha
         QclG+Qn3qAEVWCgIi8N5i+emQlWF9vIShctdXMsFlqdbvtLAJUxYFdcfQI8OGFpK6wPo
         qQr1QV5sEsjSmIgT3lvlodLBtKOxSK3FJ3mBE3A2QlbcnO9cLSWxEQPZuM5da2EpjiX0
         BiAzl7JvLaWzVpLrF/3bdtrgVfPvR+LgmavvERfbsbLCYlI0N5jcqyd7cLLq2+VHs60l
         u9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775507519; x=1776112319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqmuKOY/3ZYG4L+k3KzOiz5CoAelEzD84zbZeNLp2rs=;
        b=SG6GbMHod8++T722TBNXYOn/3Ry3AXvGcQjJClr7Gx+CwixUmRWxBMoENxNXxFEiDO
         INTAabbJlPf7JNYZhqpYiwOYACAB+KwgZwhDxIF9A4TmKmPbn5Sb1YXUQiUNTQEwkakX
         6VMtxiOAMPAQDZJ3mIHqMAslrKHoyBxRcGqOml884HA4fY41TspxLIeG/yYkDvyhYu60
         KoOo5MX+THuHc/sv8T4BrZ50PORbh0Cb29k9G/nJJLT/IDSA+JNNAXVjZmrVpfukzL1G
         +hKUbE8a7O8K7vjvKoKeomeCEI4h98IuyMIxKgJiEyXm58lc+TaSl7Hv0YOf3VgWXpPJ
         CFxw==
X-Forwarded-Encrypted: i=1; AJvYcCVQCVao2AZguV0/bGcgpAdLuHgh6GDEYdKsndRRMIU+mgHzCQmQWMVZ4SM5dQctQeEMSHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6crpiSsOLaAJp0HSxGJhhkrEV2KwMQBxQbQQ7UkFAvzeepBZ
	BSVoe/TzyYwyIZmJl6UNr1vICR4FokGIGUzK60xC3YxOMglxJ6OX4B5zmLP3xQ==
X-Gm-Gg: AeBDieunRaoPOMDQFEDNCdzXS3GbuAol4O9c73bqD3GVuBLH1vKvHLOxFAfxLRiPMLs
	AUVd50YvZ+w6ddIRTWnxDIholZ/xCcmFtjFUbrJ1rkS2tZ8hp895zSFfRMWiuKQYcmbc0w5ur2A
	M3LZs7saCvDBY+4OUxK/VmRf/i3xsUa2KXzvrjm7Fn2ZorIBeG0DJKiqOzH77sk0ZnL+Sd4eNG7
	9E6GHAraEZ4707psp93wyfdN4A6Jh5Fw3K1/q6EEaGLO2b6j4WfjPOKifsLOZEPBqRnCoV74kj6
	35UgRM18gIYQTgcQq9/EmvEt6E+V6+z/csQpgG86HVc7kqqzXZAquJ1Cw6geTTOEI2157y6LW8+
	feprC4k2zTywilF1COwwDoWvfhRHBDRzMLVYV3W8rX55pNfDtNWjAYZUSB6+zWpOhrVdbjayz5Y
	st90Hwtbvw7W5UESTV
X-Received: by 2002:a05:6830:82a2:b0:7d7:ec47:79f6 with SMTP id 46e09a7af769-7dbb7b30b54mr8846923a34.13.1775507519003;
        Mon, 06 Apr 2026 13:31:59 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbc05e73f0sm7308651a34.2.2026.04.06.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:31:58 -0700 (PDT)
Date: Mon, 6 Apr 2026 15:31:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cat@malon.dev
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
Message-ID: <adQX82EuEbVhpf8r@denethor>
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
 <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
 <20260405191750.GA1525850@coredump.intra.peff.net>
 <adP0hnV7Gl08qqqf@denethor>
 <568cb40a-373e-4ad1-a6a0-fb7289da92e2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568cb40a-373e-4ad1-a6a0-fb7289da92e2@gmail.com>

On 26/04/06 09:31PM, Luca Stefani wrote:
> 
> On 06/04/2026 20:17, Justin Tobler wrote:
> > On 26/04/05 03:17PM, Jeff King wrote:
> > > But I think the actual code change in your patch is the wrong thing, so
> > > I also don't think we'd want to just squash that test in. I'm hoping
> > > Justin has some insights on how to do a more complete fix.
> > I agree with Peff here that the correct fix should continue to use the
> > object streaming mechanisms. To avoid this segfault, we really should
> > avoid using ODB transactions when there isn't an ODB in the first place.
> > 
> > I replied in another thread[1] with how we could go about fixing. To
> > summarize, it just so happens that I already have a patch[2] out on the
> > list that appears to resolve this issue.
> 
> Thanks, just verified it works as expected.

Thanks for testing! :)

> > 
> > For the use case here, git-diff(1) is only interested in generating the
> > hash for the "large" blobs and not actually writing anything to the ODB.
> > This patch introduces a separate "hash-only" variant of
> > `index_blob_packfile_transaction()` and is used to bypass creating an
> > ODB transaction when object writes are not needed.
> > 
> > If this is the route we want to go down, I can extract this patch from
> > the current series and send it as a separate fix. :)
> If this ends up happening CC me and I'll gladly stamp it with Tested-by :)

Will do!

-Justin
