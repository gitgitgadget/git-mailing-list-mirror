Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325084;
	b=pJ14JCNNyemKjmvk5G/gfxrlAgLto0sBHzEUhm8DbSBdvOKmH75KLn5m61KDy3Lchutc
	 G04cd5VmNb4d1gR+ZTCFvOzIjomKdpzr4X3A7M+Q7arDj30M+L9ESKwnxRJzaZcFqvvMU
	 b4cX70OMBocKQyTjBkrrAS9f2cZzboRHtZgucx/wMVfgafhNfqw5CdKukpAMEZSzyGA7m
	 V+aEiRnLl1JKyQ9pCFNpFT8x/z1g9K6LG80ctlH5jYXIsDgPJr91C0wwb2P6wfif/Mg17
	 Yi6C9SpZeOWx83zxCXGqrt+LXpUwERpX2vPauxEgoXvzJIHobBTmPIkSp8nPkYFFnYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7PadSmnMm0Za9ZJmT4m6GyrfLk13yMe6VchvcZ9qJok=;
	b=pQlLzxIWIqUbo3TsGA2EnO/nBvGbxSF7Xn4Xe2cS15IDlPdET+DtszvWX9OolAV6Fs88
	 dMlt9QmrkCN0h1mFci4WvoXGuJ2RkCmPa2GgAXyB51JH4eBeOAKhTR4/VCMbE/RefG7Ku
	 Iysp3U6ZJ4rg94ne6pz+c/Llz0I417V1NZCyPZAM7GNBxQAui/J6CbJJU3N2bpKpGRoiH
	 5tTB9kqS9e5XwRaYj9i/psURBOU/1ml42iWK1UrQNZH95K3+ylOypBrMFAUH9BWBphfMj
	 x7g0JdymErSKF4dHJEYHhy966Shn2CjFip8Rju/aUd2Y9TvJUlOnTvfxtPXt5lJZDnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nuo8Cjk;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7690606A326
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7690606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nuo8Cjk
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso2358991a12.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325082; x=1794929882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PadSmnMm0Za9ZJmT4m6GyrfLk13yMe6VchvcZ9qJok=;
        b=0nuo8Cjk8Zk087dM5y4hoCZF0klKYy2vtjrQTR6iiy4wrhE0P5PXl+eolIYam33vaN
         5fB4W9KvQSbfMrAUyNaw9JUjp2EvimogTNhpDfxwBUlcSKnQT4BPpK0x6JvNp3xmLErp
         kgwa3RChbzbgLwoxIMJTsXX/RcVVqHFIGcfKVR1RPGnSSAq/+kj/WFLm3VC86z3nopSZ
         jrRtBWanWCH74WWKdGVePKMGUstVKJAk1Mzxyx72X+xHZ+f7/bLyHr3BEpfyazjJWHfc
         8fmlSRB88RdWQhMo2ynf2WwKV1g1qo2mrsNXgbeX5gg3saBzl2GruOJnWut2Gqm2qM54
         D6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325082; x=1794929882;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7PadSmnMm0Za9ZJmT4m6GyrfLk13yMe6VchvcZ9qJok=;
        b=0XAHJL94mgC6f8TzK1zxNE9ET2QIa4V6gaO9k/leyb4n0i0vdyjmYIWvj5XkJEehz3
         D5TVP43a21c0dPvhBMnsdrtNdwD3DFImwPwZfKnn3TtEpvMuTAG0i0fhnBLVgKEQJnue
         uSv/zWC7J6uWtHixCX+hHv6g3LiZjfaCNNvqzLM/C1zZYXgO5SQF7a0vI82pnwklG/pn
         BLUmuo934ismp2O9LLdLrMKiEGmZR6QlvMvtKIVShvHseeySgdzyiy+ALBx+aYRmu6qc
         fTVhN25s/ENOkMinHSWCiY+yYvlyDH6Un8JmH1AjTa+J2yEmwr4IDgiRAzEESIV453O9
         Vhhw==
X-Gm-Message-State: APuU4Z+XVjUHrPNNX4I5PgM8y/sJl0rTEq8jmSLlwcQF3UkHDmK7nsWY
	AVEZvdjgKu4EK/vSpgL4H+0mMWinfoncCIJHqMfO+iwfkPmbxZX8l2lc
X-Gm-Gg: AYBFou3PXUctuRv8E5ggISBDBmp9rxyRgaJJlZyAOdCRhuJdQN+rKgAhFkItmOwLygZ
	xZSdq0JFDHM+rhh6VePUYBAUPpbA9MiP/SSin7X20vnKHz7nGgIpZ7ahNohdu/xJsg+BEb1wT9i
	s9sw+vKi8qA1DJubGlV/Nk2HX94b4G390VeUeHTV/golQ1aD5t3Am6gDMDrevcRuBf+oMFfS7dI
	5DvoLLs7BimNZFcIJC4BsuK/1mxCU/UXmR+hv6lRuWD3O6SM1/6/XGEu+Cr4+6C2wKnS/yeG2DZ
	v7GzLOVspgAvqNuAZoIHCNqCjBEV4r0XIFZWATxRwnxfwYZPQajsJDPNxGtWTGFdwFu6FYRG39W
	+77Ekw2ZrMLbHKv68L+zIcfr/kBZVfbo8/FX7oxdKxl+w6q3eqtuiWqIzXxQJyxjmEGb5m3Zk6N
	cSZOjVOgVYePQl96NqRQAHOOGBVjdgUgIKvdybpvQUz4TDNJm26oLOA2sOTODGXEzuVXinfHs4H
	3V+T9XaXZwIG6vOMosxr0ulmi+6P8OIJi0N0dwPTVosiBNnoCJUH21iBILqXtQqCL8h2AsMG7zP
	me7rQALc4NDWlXceeae2vOFs3Eo8EDn3Wg==
X-Received: by 2002:a05:6402:1ece:b0:6b7:6c8:70d1 with SMTP id 4fb4d7f45d1cf-6b7564c45bbmr2582614a12.12.1794325082026;
        Tue, 10 Nov 2026 07:38:02 -0800 (PST)
Received: from [192.168.0.172] ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7578d57c4sm1214501a12.18.2026.11.10.07.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:38:01 -0800 (PST)
Message-ID: <b77fcd1c-21aa-4029-91d2-38c89a53f788@gmail.com>
Date: Tue, 10 Nov 2026 16:37:57 +0100
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
Subject: Re: [PATCH v6] doc: git-rebase: update incompatible options
To: Julia Evans <julia@jvns.ca>, Junio C Hamano <gitster@pobox.com>,
 Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org, me@linux.beauty, phillip.wood@dunelm.org.uk
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
 <20261101082230.141688-1-omri.sarig13@gmail.com>
 <eaa965fa-05fa-4945-aacb-2fc99b02159d@app.fastmail.com>
Content-Language: en-US
From: Omri Sarig <omri.sarig13@gmail.com>
In-Reply-To: <eaa965fa-05fa-4945-aacb-2fc99b02159d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/11/2026 15.06, Julia Evans wrote:
>> @@ -217,6 +217,8 @@ OPTIONS
>>   As a special case, you may use "A\...B" as a shortcut for the
>>   merge base of A and B if there is exactly one merge base. You can
>>   leave out at most one of A and B, in which case it defaults to HEAD.
>> ++
>> +See also INCOMPATIBLE OPTIONS below.
Thank you for looking at it!
> Elsewhere in the document we're now linking to the section like this,
> since 2fc11e33820:

As per Junio's request 
(https://lore.kernel.org/git/xmqqjyncxrur.fsf@gitster.g/), the current 
version is built over the 'maint' branch, and therefore does not have 
2fc11e33820 available yet.

I've discussed  whether this update should include the links, or not 
include them, and understood from Tuomas that the right way to do it 
here, is to keep the file consistent with itself in the maintenance 
branch version of it, and update the links everywhere in a future patch 
(discussed here: 
https://lore.kernel.org/git/20261029080317.wWchf%25taahol@utu.fi/).
Additionally, the INCOMPATIBLE OPTIONS section cannot be a target to a 
link yet, so this won't apply cleanly to the 'maint' branch with these 
links.

Please let me know if I should update these links, or keep them 
consistent with the rest of the file in the 'maint' branch.

>
> See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>
> I think it would be good to keep things consistent.
>
> Also it would be good to try to convert up all remaining internal links that
> aren't using the << >>, I may try to do that at some point.

As far as I can see, the only place that does not have a link to the 
INCOMPATIBLE OPTIONS section in the master branch is the --trailer option.

If you want me to, I'll happily update the added section, together with 
the trailer options, once both are merge.


Thanks,
Omri

