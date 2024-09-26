Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905C13777E
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358957; cv=none; b=rWk3V8JJwuxVrA09bBgseS1g5odRnDG5Zk/gplwk9Al36BHfAi2ydoOQR2zweItW2BWFw/epbydLlv686gVkhPpP48gyDVwDTUZD4wid4ybYKUBOYU51B/pKLeEEDO/ORNVPzBDsmapIEVi4EuoIACeeBT/JDgBfzJbze3vYYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358957; c=relaxed/simple;
	bh=o+4Bz6x+vGwAjly8nccwCF1LJj0ykar9GEPn0/6hEwo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EPzfaqQcz2z7GgY2m9D4sAqCBKt8fqSqUuuy8NybZx8k9LN8ISosOEDr71esggPaxm9tWT1jY604t2V1dEnJFLEhKnLAq1uvDkwTd0C5BwTVJhpWx+hyGLPdYS350WWsUo57zO+CSAQzAM7FCLol3KVxevGz0RAB6RWlZos7Lr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZUMMqUx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZUMMqUx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so133739266b.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727358954; x=1727963754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/MrMzAsY5w4oOzYnOGdR/ijIj061s9g3JfQ2GKRFkM=;
        b=RZUMMqUx6H7elgD+qA2WG620U5Sa2poRClnAss98r1eNnucS61M5LXLlXkpR9qqXOy
         PSr/YF5t3zpxnrGEuUr5++Hhvzl0ct46n55wW2GGwEjqEnD2Hnfnx/lENZghGiLD+WTd
         olmEx2F8oVq+1PApyYOAP/osLpOXWdJDOuj4m+hakOloDoGty6hcsxqlXfeTAt1yIa7E
         T6yRl4rOFGIFKbLqbkBB8kepHBTcfbrfCcE89GptXF88KTcroh3oZr3rw5n/GIur/4OX
         7cj33hZv+06fqgfzM2aYHGDZlg3XGZdnwQKLQlF2iWuRk5yblP3/BPw36QW1tIfc6cfC
         UvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727358954; x=1727963754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/MrMzAsY5w4oOzYnOGdR/ijIj061s9g3JfQ2GKRFkM=;
        b=EbRj28Bk1wKf7y1iiSletBDEDvgceW4NMKL65vvh6eXqOI7mRFcMshnwjm/1SJKGOH
         GcW9PZCU1To84d1RlcCeQxnw3TKfYR2x0AtYB5Rc/J8sd1mXMC4xeCX7v5bPCGs7juMI
         sXQeyHKE4VBcNrHOzy+x+Ha16SQShidrIw35au0Tx2U4hCwRI+7yyDz37/8XEnPtHsz4
         F7yyy+no1ZAM7jqJVWMFlavybEkPW2XqOgoTtBqyJxEx4zlLqM4/JLFyCbqXq15q9frQ
         KWNVT56dCrGUO5c8UEWuXKZDlZooIed4ycmSZbz0NGOE+8zyo25FwOenoQD7m1OS85Rn
         ZSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+wFUK77FICTzIS3leByDSyY8aM0KglLZp3OOi5ftWozkLDBld52rtRmdHOdN+dHTV4sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O+vbvI1IMglo5bXlR5aSre0Y1viJj3l0O/4bp9UWs+wwV5Iq
	9cXcS5RzI/JBttZIhBZpCHEZPo9rPUJExRl2XVIQtyL+nFtwXBzV
X-Google-Smtp-Source: AGHT+IGj7dzfoovTLIHDA6ADfV1mb6zTpsXlzEihHiQDEQ/8mzD1YA5VUaNpoHrFwl3nnzUlOv/0Dg==
X-Received: by 2002:a17:907:d2d1:b0:a90:4199:2a73 with SMTP id a640c23a62f3a-a93a03269fdmr540827366b.5.1727358953740;
        Thu, 26 Sep 2024 06:55:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5dfbsm624466b.60.2024.09.26.06.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 06:55:53 -0700 (PDT)
Message-ID: <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
Date: Thu, 26 Sep 2024 14:55:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Patrick Steinhardt <ps@pks.im>, Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jonathan Nieder <jrnieder@gmail.com>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im> <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
 <ZvOn_wChzEgXtpMd@pks.im>
Content-Language: en-US
In-Reply-To: <ZvOn_wChzEgXtpMd@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 25/09/2024 07:04, Patrick Steinhardt wrote:
> On Wed, Sep 25, 2024 at 02:02:34AM -0400, Eli Schwartz wrote:
>
>> I'm probably biased, but some of these failure modes are *weird*. And
>> they basically never require the CMakeLists.txt to do something
>> considered non-idiomatic in order to trigger the issue.
> 
> All of this is very valuable data to make my case for Meson instead of
> CMake. Appreciated, thanks!

One thing to bear in mind is why our CMakeLists.txt was introduced in 
the first place [1]. Visual Studio's CMake integration means that so 
long as git-for-windows is installed building git is simply a case of 
clicking on a button, there is no need to install extra software or 
plugins. I'm not sure the same is true for meson and I don't think we 
want to end up supporting both.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet/
