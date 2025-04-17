Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C17322B
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849532; cv=none; b=bALjUKW4lh4EnZCpwdbkJFbTLr58jbHyuSPltKtXq3wuHMCAffeeOdS5Ok+HVcHj5wGhQpmUPlDB3sIpTjrPiiapmD8nAlaKCldFkTDqKymUHptsBlJeUOMvui1jYmILMG2jlCKlk1KWgUnNK85cXD0ExBros1o3M/ZEmQbCzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849532; c=relaxed/simple;
	bh=MvkDM4OFslm5YLz3TGCyHXZZH3ws4hqvLJD9bS6dQR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXR1fBwdVrgbC2pxlDrf3kt1z2L2djU+0HLAaTDQOXMf+EXqjwUyfGKEfJZZMdmjVzOv5rumvFd28i9jd02PM6krolpUm6BFCZ8qDnDtA8/5ajQg92fwfONuju11r8pmsc+qIepS1TgsJ8BdfPZXxEUPZPUYUJNFsgLAt7DZt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEEHzKP3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEEHzKP3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f768e9be1aso14499697b3.0
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744849529; x=1745454329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m05Y4Ak88xsvJ9YVkRU/hmd760jSwrR8hs0hAxosjaY=;
        b=iEEHzKP3IdI9eIZTYIutA6PNoHHDC7uqnpD7yHzVydIW4T22OlOH/zSiaShOMm4Lzr
         pBOLy0WDVT076llBoCgGRbUFJ71+oLbVBTOQcg5udycghAZ0X1nNynivYd76D7Eqi53C
         jYDDCNx6AR5AcxNd342XyxvMwguzv1iQkkVm5Tfdh/HxgkPTVqT2yy71tSPN3IUh4Uu5
         SkZD7wXb3+RuV3/jynQf9KQJfrQi/zFfYANUy+pjUo2g6dMxQdZ9f2XxxiW4Ys8HXI1M
         nurFz0EHlAnpnWrd4wvZqbCWjYnqWzu+fs9xHtjNzGN/CKG62apHhoBhr11VVOROvY2y
         +qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849529; x=1745454329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m05Y4Ak88xsvJ9YVkRU/hmd760jSwrR8hs0hAxosjaY=;
        b=kqPSvksKLhVnMBzsBeJ1ysAAYJ+QvfjOJP06EL0+1DQndGzRTNQubL0d9N3RgRL9md
         iTqtqi1kS9ZCFkG6J7+lg+xT0hrKEHpGQ0SNcHXRn4UEnz03ZFHhrBVjAyWgbTTr8VLM
         lhtZdkUiM16H2TlEItDlGL+iPNAvz6ZXlCsy4/uz0PyNSgIRXLD0CLEFZqlcSsP1SqPn
         W+XScBHHSBxiGnpcxHy86yTRwT358AwWsBjfWsiq4LFM8meubNUDe5vwM8G4pyNmpNpn
         hb1RnRmBUfvLRJXb19yppp4zC04VDCSzv2S0G13Q/aCtPSY3R078oU4eqy4vh470VtBY
         +oTg==
X-Gm-Message-State: AOJu0Yxer6z9AWFJRupJG/Q8crPHCBvRNxygHg59TNsgtngSuaSCQpA/
	e5niVOYO5HImw1XKXkRKSmk1TOLuprbrTh0iuf8glsNJ8szd3sAH
X-Gm-Gg: ASbGncs55xqh/HjV4dVAJ2YE+i1Mpksmpo4M6SDbrhJkqKBsXBOuQ0703VARF7OJRje
	fMNLrLdWvOHJ+IpUWzKuoaHIYbcTbU1naEYXr33pWSFkN5SokRIImRqa7GGQVgu6ebLRCi5we97
	JklFUx+jSCeB11LK/oCiSqI4MVdWnq1Jup44oMp5Ojh0GU5RwiU9iOEtgAe+5E6wxI3OUJ+syvn
	w4qJh0Z/8iy/lfjkOMQbZA52ri9+kgC/oVOX5Wo2VYucdxltE9GzeFkyGAr4yDuxTL9WoSVIlo9
	kC9LfN8nCKpcuVPNIM2+hHKaa3mGQY/+50UHF9qYqPdy7OraJuwtGOwy/tx6Cao5xsN9sFfRLHZ
	sYp66hfklr5Cd2g==
X-Google-Smtp-Source: AGHT+IEi/LY5nGvF2uXkkiqhOKM9TtbE6s++xDuAw33mxMdRPFh8vVTakONjoUO1GPHyaoM+DvVa+Q==
X-Received: by 2002:a05:690c:6a0a:b0:700:5107:ca0f with SMTP id 00721157ae682-706beb979a4mr12113327b3.16.1744849529536;
        Wed, 16 Apr 2025 17:25:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2473:276:c095:5974? ([2600:1700:60ba:9810:2473:276:c095:5974])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11a44dsm44032427b3.33.2025.04.16.17.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 17:25:28 -0700 (PDT)
Message-ID: <9e14443c-e549-46e1-9fbf-ee72800e6944@gmail.com>
Date: Wed, 16 Apr 2025 20:25:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: document core.hooksPath=/dev/null
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
 <BD8FCCB1-C97D-4057-982E-93A7F8B01AB9@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <BD8FCCB1-C97D-4057-982E-93A7F8B01AB9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/2025 12:53 PM, Lucas Seiki Oshiro wrote:
> Hi!
> 
>> +You can also disable all hooks entirely by setting `core.hooksPath`
>> +to `/dev/null`.
> 
> Personally I think it would be better to focus on the non-expert user,

I absolutely want this to be targeted for expert users, so users self-
select themselves into the risk of what happens when disabling hooks.
This is a "there be dragons here" kind of warning, implying that you
better know what you're doing if you are messing with hook paths.

Thanks,
-Stolee

