Received: from www130.your-server.de (www130.your-server.de [88.198.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BE354AE2
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.195.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745070; cv=none; b=oVWYPD0h52eFvYloKxbGELORNbjoGh80VZml+4U/AmZk4KjJvUptZdZs3YnwSqzVT7n3qtNp0pL6cEhMe9ropfB2lxGG84BY+v79OXsgwzmrvlVjPQ4PXAHol+RBtBKbHQlBptUhQ+pXVJRPsdbZM1jwNE+GP957d+A+lp5M7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745070; c=relaxed/simple;
	bh=tTPULMyedqMz1JIMbtu7ZELXMLCv1RLdVMCpb09962Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qjz4Cf6UNJyR7/zLbfxI7uD6sxJvhk/SQ4VPOi6asPI38RfqueAYsIE5DBb0hRQDLhvcI0nbsKwCS1YRlk0sgzyoVV4mFIkokXQqHAyZ1MJnYl86C3El9JVJiBXUGu0W7OqgE8DAGa20MrHjPrt+yKlAkjqBn3plDjZVQsLeO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b=dYsHLToZ; arc=none smtp.client-ip=88.198.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b="dYsHLToZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuell-zuhause.de; s=default2504; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5Gy9s3tmk3Hn3G+7Jlwc3d18nNLRYhCWhTRbEhzD7MU=; b=dYsHLToZe8CDPPWDHoBEihGA+J
	JkkxUghmXalB9XOHfvxV0+esiQ4a4l53Sd0qxeNGi8RojoL6iCREPEFhLCk+pObK0dN9OkgtiJ22V
	gVMYNSKUIkYLcGiA7X+4PBLvfg/beHPG1Ikm1WJiB8Ftq5IqyUChyE1zCSTbuB2XOI/P7PvdpfmCr
	Pq5POfFA/Psms7N+FGQq/iqRBe68g7lzCfpLoAuydubbLBca+vSUdSFYs1KP/MPxUgkrB59S8EHuP
	yXXMB683tsk/lsgfC31O2QI0zY8nG9GvaCyF6Rr+KuK4ejg12K3qDAv4pyMidUr5w0+dQvAIDXCXC
	TnkXuoOw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www130.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1v9tsy-000NoP-37;
	Sat, 18 Oct 2025 01:29:25 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1v9tsy-000LZA-27;
	Sat, 18 Oct 2025 01:29:24 +0200
Message-ID: <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de>
Date: Sat, 18 Oct 2025 01:29:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Making git grep ignore binary the default
To: Junio C Hamano <gitster@pobox.com>, El_Hoy <eloyesp@gmail.com>
Cc: git@vger.kernel.org
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
 <xmqqsefhxlmd.fsf@gitster.g>
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
In-Reply-To: <xmqqsefhxlmd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27795/Fri Oct 17 11:51:42 2025)

Am 17.10.2025 um 23:29 schrieb Junio C Hamano:
> El_Hoy <eloyesp@gmail.com> writes:
>
>> I've found that there is a flag (`git grep -I`) to ignore binary
>> files, it works great, but I've found no way to make it the default.
>>
>> It would be great to have a config for this. This way a possible
>> implementation implies:
>>
>> - Adding a config `grep.ignoreBinary` that defaults to false, keeping
>> the current default.
>>
>> - Adding a flag `git grep --include-binary` to revert the default. But
>> maybe the `-a, --text` flag already does that.
>>
>> Also, maybe the next git version (3.0) can default to ignore-binary as
>> a better default.
> I am tempted to suggest not to do any of the above.
>
> Simply because we have never needed to do something similar to "-a"
> and "-I" that we added in early 2006 for the past nearly 20 years.
> Also because GNU does not have any such thing to force "-a" or "-I"
> as default.  The biggest reason is that it would be surprising if
> such a change does not break existing scripts that have been written
> by people over the years.

And if we only would have the config option "grep.ignoreBinary" 
defaulting to false with no default change whatsoever? I always want to 
ignore binaries when grepping and find it a bit tedious that I have to 
spell it out all over again. And yes I do have an alias as well but 
usually don't remember to use it.

I'm also curious what people are looking for in binary files with git grep.

