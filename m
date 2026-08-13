Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFED34CFDD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640457; cv=none; b=Xdhbzbvs6tTYDoUAZ32HtAgA0b7Vfq5GGXIgrdv9mh7LHUs5ZXUAKHjv0CHXaThA/NXlPXOEkp3CDSCx3QjAFiMn7HnyIux5hJr0VoKUvfNcuG1/dnTIYr8H/bSd/REiNJNtBjoBFazxchNy8CeqwfXedHd/w2c8I1Nw2JXaoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640457; c=relaxed/simple;
	bh=k18C/Z5ScakXfVKbnE31Y1gh0gOA8HqwLc41g89VauI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBnU4jEWyLdI030RJIP05Mtf7jOm5pGWXtxMxyYjSeR5Pfq+K2X/0GV0NacgOlf5s9vwsytvRZeR3/JGVtEPX2PSv4/JS5+EWDD8r5xe4nAigL/JQ3XOrEDY26ytBw+Tkj+s10kXAHmte3VyPGPkvBYEDkWdv/bDr/w6gZ27M7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/ELcFPY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/ELcFPY"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2cce930cso1574441cf.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786640455; x=1787245255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2itv/d9dK68Lr6uL6eptRcwMyedUnYN/NiTOn2DTfEY=;
        b=B/ELcFPYHk7b1nzdDR+vkJ7UuIzLgnS9A8OaxzQBqgAwuZITS3P/lSzO1L82TXEfny
         NpXAuop2D1iB6YbojR3+U2K6OEWETnpHWK4EYHimRpYMrdPiQoALfuf98DwT5eemGgWU
         Rq99DNkOxvoPoY/tjGLMqwsuTb9xiLpiKB1fmy8hkz3GdnSz0aY66Kw3uqUqpP6o+v4z
         E3mwTOmfn34kSRhl7oBM/toWywVytY/g4yLjdpC/RBPCo6HcuA/FaNpIYwwGHpT6LXNR
         vOC8jU9+C2q9mrsMK51MAlFkgJe/m1ehho+QecB265xOmrtSsPvwvQRE/KVGim5fkOcd
         Fuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640455; x=1787245255;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2itv/d9dK68Lr6uL6eptRcwMyedUnYN/NiTOn2DTfEY=;
        b=Mkvr9Iocy7TaGJbhgSDZIeSMqBDeKjnTn2GYLX6JINCZ+GNbzFQePbX2Lz0YPJai7R
         pYKV/LLgLuF3gvM0mvGSL8PsdOn8jeOE9NWutAg2JNKJcmyK1sj+sBwYk3f55gEtsU27
         p7g4MQMpfq14RInOiHeox4xBkKxTqrw2QTfq1iNcYbq1LWn7IO0j0MDUM1EVkhx/DXYz
         tOiWHpk+UKXE7xq4WWwi/jIpTP7t8oqozGXApEM07xiXNhu5AZFFnxOiInX6J7cJN6cE
         1liLp2DbZppkkXfXv7d3hlvK1VP8F6yR5j8cZ2KVLTWZER/eD5Nc5hg6uvCeHRmjE98h
         ZkTA==
X-Forwarded-Encrypted: i=1; AHgh+RpTz47relA2ihVC0kxRtdwFTa7lCaI8xnvyq+/cIZw2lBRltrzZBMc7bwOxV6XS9ShuFU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWY6evZCCNXQgKbh8L+r5g7hgI1MRKmiffy2I6vgvwup3Q5C/
	4LY45e2RnvLJE6u/jgoHcy4xH0r+bhkRP84K1wFP5/6Pv5doN+iU3CZPncwJ/0+A
X-Gm-Gg: AR+sD121to3giwSRiC0exy56prdHcLOlt6pnSMYLbx78M+r3ixXxCQP/9KiWG0DglVg
	h5zK4PVFCAWptITNStN3bhPfDt3THMQxcwSc/80VqOCrrM0jlmgMfMxl7U+IYt9UFQFqwM8UjOp
	3Q6JEXzHErmwFXKixfEYtR5GawskHdN9xlEO8z376dj5adoJfWGUDjY6PvZRfLUxkG9L+v8xHRM
	ufpLOq2Z6uKdcw1nxoJK02WssaN9GF+HnkVHxUOEKHbnWtWIEmzza69RJJt0oNLFoMKbwFMEeGJ
	7x1yVdqwqP2AoKVrzb5TjAc3Do7yYspxo8XtiEIzKLaCGLm/PA6ez8ARcQIS8T+xPBP1GTFHKVW
	VGf18TGCJDzgbFD9HO2KJrl2z0Y3i50Ci62ksGoYA27PvdZOM1CFSyQkit+e9mY+7RBVZqrQCaN
	cHlNc2Gtu5CDwtO+AvY7u+wKf/ryaKHwhBgzsj4t1wnKy6eIparL+TVKB8J/a+Z7dEfOLzgvipb
	IpG2GqvNcy+d9XUKcnHHYjrZTBzdvonk0pujBDuQY7cxKk=
X-Received: by 2002:a05:622a:15c5:b0:527:7d0f:709c with SMTP id d75a77b69052e-52d73de7060mr78665291cf.42.1786640454918;
        Thu, 13 Aug 2026 10:00:54 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d84043844sm394081cf.15.2026.08.13.10.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 10:00:54 -0700 (PDT)
Message-ID: <9b7d3630-6584-425d-9927-849dd764cd6d@gmail.com>
Date: Thu, 13 Aug 2026 13:00:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] gitk: show color preferences on the button instead
 of the label
To: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
 <75202a52d7912e67f6b92662f5349127c26c70b7.1786540582.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <75202a52d7912e67f6b92662f5349127c26c70b7.1786540582.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 9:16 AM, Johannes Sixt via GitGitGadget wrote:
> -        label $page.$uielem -padx 40 -relief sunk
> -        ttk::button $page.${uielem}btn -text $label \
> +        ttk::label $page.$uielem -text $label
> +        button $page.${uielem}btn -padx 40 -pady 0 -borderwidth 2 \
>              -command [list choosecolor $colorvar $idx $page $title]
>  
This does make the new buttons stand out much better. Good.

Mark
