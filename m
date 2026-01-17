Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205654652
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768658151; cv=none; b=TfVqOgC+X55S1Yus2/rNCv5TrlLds6pHenDN60by3zGx+wZPoLe2AsputZpeLWg1RCHs/GYDHFvc/laoqdowSagRWJw99my3jekfjNn3z12bWY8EvOH0dJgntKq1j7zwWIVY+4AjRhg6J+nEs+AViZgMaARPsR+XpxlQ1foFoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768658151; c=relaxed/simple;
	bh=zAzcWST21bp/qlh2HLHZuWTCGw9CE+6xBuhajSXt+24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFTqy6Tj6NIoZIwYQaBccBTck9OYMsB98Ga5Vsmu5+XQhMR+gd9+XK4TY/6f6VrHumaZ9E3WhWXY678Tne7F6Ac1/cVESLvNyx1unq3YCSXjTvdvdDb6+TsQsMPrGHVvQ6yOWw9sJ8PuK3V7OBpz4DBAdPZHFmXfw08+TZicsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJpeICvY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJpeICvY"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2282263f8f.2
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 05:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768658148; x=1769262948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1Z3flBfed3xMe8oM+3PXmG14hb5tx+irjdAjpP3fYM=;
        b=cJpeICvYr+f+dyHWCIZEdJaWeHLZVHiCRzKQu8MCzeliM1JG4/9+k+faMqwp4ruQ3r
         6C7h27GLRNdUeLg7FwHVuHhuBeZEUqoCVZQmzNDywu+bzyHXROzV65CdtY/1mQpCaEaQ
         5513+Xo/qBLqlRvvdcOOLDqFVYfFra81tOsU/G7RFcqF2tNk5+MJcmW1by0nOofXRkH5
         US8KSyK6rRt/ZIlT3HRkvbZ2UxYLkjOMVGlrWXKoQ+9MjKxrM9mu79w27BBbIs9qEE+s
         3C3JgOBlEpy4YR/taOvka03ozOZL64kNyrK6ZiLmyYlmCDqGDw51zx8fODeZzwW1Zaf8
         /yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768658148; x=1769262948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1Z3flBfed3xMe8oM+3PXmG14hb5tx+irjdAjpP3fYM=;
        b=C4Ly9NnCZVva/FMjE/amePdhgoToDGoTCTixm6phiCzzP4/RPMrjg678kXdqvgg/0q
         hzMju/0K3QpTVMNQW9rQGM/7rI9/azTffXWk7C+eH9tkRS5T2yU0bQIpEGkib2gqxGyd
         sl/E6Zxp9MgbFCwadaCp5NyBkMQXqEYXuVFX9aiQYrJp5RUJN7ikeXpw0FKKlGxZrtgl
         9CiO3sUKH8VhnwoMYKbf86BXwD2Q5HdSBhlCcEu/kB+rwE9YvOftzMtOxdfOsShgzGaC
         w3une5i/39jbDyqDTcDVJ6TdvlzBl/WuPDXZb2PPbLRGdZhVfmZ7Ey1jRSUzHXsTJPdr
         FeWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4JYn54oIC6olHy2wBpo6qZQo+xp8MoYqBcRwlQvbxVut1X/U848HotOIHG8n5uh0Em4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznE2QTjztlvYGw/cD4glGo0XoMEyupvtliBEuMNEtAMVHqWREI
	8QwKGqHEdKBrWiFQPlKIURGPel3mgTOZRUCiNSC3KyEVJFhlVwBbp0Nu3d3ZnQ==
X-Gm-Gg: AY/fxX7VS4Dj+DH1B3UjILG5jmt5Usr0lMxWw2RqPUw/b143VfSEnpukSThUXRzbdq7
	d+DGJjUdk+hLYTGXBysgJ0AhqdEHApaYp1UmuMQoZ8qzOgoTY9PNaDXD+1yTWPSN3om3tt1F5MF
	LoLgDYX47H8ZOm7eWQTwxdMw8KgTeBbqdYTgqxbkekB7hRx34zYWCkAwlf2Fyuw6bzMiWJbWrWY
	Wtm1HYU4Z2ErIamDOqZ8SQD5zC2gHvJou+FHt9rSsANu2wWkakD18KRILz+0S4wXvHC6wluw9qi
	P8QJmdPJSQ9pyRslMXLJNcJ3u5vge786eBicZiSxVjNEe1KhlmNE3TvWtPhR4cwIr9RI917gBH0
	WblpLZz+exSKfHVEMPFRvLTf2wY/GS7idq5SSPUKx9gvsp2jYSpNL/WEWO8xcid9sqEd9Alq5Z/
	WNUxxw13LwTeRoJE/wG5o/qNbOaebcdQzVnv2Gr20mo5yPwcVjZ6KZZTzjfjBCn0TOoiCKu2tXF
	y9CD7/Uwg==
X-Received: by 2002:a05:6000:2281:b0:431:16d:63d7 with SMTP id ffacd0b85a97d-4356a05d461mr7943982f8f.47.1768658147728;
        Sat, 17 Jan 2026 05:55:47 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:31b4:1316:18dc:6259? ([2a0a:ef40:627:1f01:31b4:1316:18dc:6259])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569998240sm10850056f8f.43.2026.01.17.05.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 05:55:47 -0800 (PST)
Message-ID: <ed06232c-4c48-4d5a-a269-8663b32787ea@gmail.com>
Date: Sat, 17 Jan 2026 13:55:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <fc291b3a-5ee5-4488-9b01-d3de32f7c257@web.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <fc291b3a-5ee5-4488-9b01-d3de32f7c257@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2026 20:19, René Scharfe wrote:
> On 1/16/26 11:39 AM, Phillip Wood wrote:
>> I've Cc'd Peff and René for a second opinion if you have time please.
>>
>> On 15/01/2026 15:55, Ezekiel Newren wrote:
>>> On Thu, Jan 8, 2026 at 7:34 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>>>> +static void _set_capacity(void *self_, size_t new_capacity)
>>>>> +{
>>>>> +     struct IVec_c_void *self = self_;
>>>>
>>>> Passing any of the ivec variants defined below to this function invokes
>>>> undefined behavior because we're not casting the pointer back to the
>>>> orginal type. However I think on the platforms we care about
>>>> sizeof(void*) == sizeof(T*) for all T so maybe we can look the other way.
>>>
>>> If someone finds that this code does not work because of this
>>> assumption I'd like to know. But I can't fathom a case where it
>>> wouldn't work.
>>
>> So we have two different structs
>>
>> struct IVec_c_void {
>>      void *ptr;
>>      size_t length;
>>      size_t capacity;
>>      size_t element_size;
>> }
>>
>> and
>>
>> struct Ivec_u8 {
>>      uint8_t *ptr;
>>      size_t length;
>>      size_t capacity;
>>      size_t element_size;
>> }
>>
>> One the platforms we care about they will have the same memory
>> layout as all pointers have the same representation. However I don't
>> think they are "compatible types" in the language of the C standard
>> because the type of the "ptr" member differs. That means casting
>> IVec_u8* to IVec_c_void* either directly or via void* is undefined
>> and so
>>
>>      struct IVec_u8 vec;
>>      ivec_init(&vec, sizeof(*vec.ptr));
>>
>> is undefined. For the compiler to see the undefined cast it needs to
>> look across translation units because the implementation of
>> ivec_init() will be in a separate file to where it is called. Maybe
>> that and the fact they have the same memory layout saves us from
>> having to worry too much though I'm always nervous of undefined
>> behavior.
> 
> True.  The GCC docs give a fun example of what a compiler might do
> when using different struct types to access the same memory:
> 
> https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Aliasing-Type-Rules.html

Thanks for the link

> Not sure it applies to this case, but the point is that compilers
> can and will do terrifying things when they smell UB, with little
> concern for safety or original intent.
> 
>> An alternative would be to pass the individual struct members as function parameters
>>
>>      void ivec_init(void **vec, size_t &length, size_t &capacity,
>>                 size_t &element_size_, size_t element_size)
>>      {
>>          *vec = NULL;
>>          *length = 0;
>>          *capacity = 0;
>>          *element_size_ = element_size;
>>      }
> 
> The ampersands (&) should be asterisks (*), right?

Indeed, that's embarrassing - I must have been thinking of the caller.

>> and have DEFINE_IVEC_TYPE create typesafe wrappers
>>
>>      static inline void ivec_u8_init(struct IVec_u8 *vec)
>>      {
>>          void *ptr = vec->ptr;
>>          ivec_init(&ptr, &v->length, &v->capacity,
>>                &v->element_size, sizeof(*(v->ptr));
>>          vec->ptr = ptr;
>>      }
> 
> Mixes "v" and "vec", misses a closing parenthesis.  Looks viable,
> though, and this method should be applicable to the rest of the
> functions as well (on the C side).
> 
> I guess this doesn't require an element_size member anymore as
> each wrapper can pass in the sizeof value.

Good point

>> That's safe because we cast the "ptr" member to "void*" and then
>> back to the original type. On the rust side the implementation of
>> IVec<T> would also need to split out the individual struct members
>> when it calls ivec_init() etc. It's all a bit more effort but the
>> benefit is that we don't have any undefined behavior and we have a
>> nice typesafe C interface to 'struct IVec_*'.
> Right.  No idea how ugly this would be on the Rust side, though.

I'm hoping it's not too bad and `impl IVec<T>` just contains the 
equivalent of the wrappers generated by DEFINE_IVEC_TYPE()

Thanks

Phillip
> 
> René
> 

