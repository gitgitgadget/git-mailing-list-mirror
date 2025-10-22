Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C729A312
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139634; cv=none; b=m2u2inUhY6RdSvQmfncjiKpSuuv1ursDwPDpnsLuiQBtJ7CDAd0xC+C+p8aulv2MHqF/mi2XU+dRjnWR8b95eBYVAiEpXMJmAGQvX36qLEgeVTfXTXuFKb6H3N3G/NPbfgNExlMWQ6lbzxCZw3B2vqacoQJsjedd4boREycKKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139634; c=relaxed/simple;
	bh=9v3EO7v4w5bW91Sadz2MgKnI4TO8JkRDVzQ+PELKBzg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mbWw89TzUlq4QETL7B83TdxtUwSxbd2R3gugUBYX/MY7xAmGSetv3C6FZDRam8j5M+L/NMlegURgoAz5L34JyzIKoYrkWryUWD+13A7AoNaVfOwhsPoFA5HcRC+LKdpjxnzpgg1xfDxkj2jWrUrVu9zsRuKNAk7Bl7qPdpuru8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDZhor/f; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDZhor/f"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso63280045e9.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761139631; x=1761744431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYfTlUFBo/usjdk3F5Gd+aY8/HvMwtlk8nC1WIS/b4E=;
        b=MDZhor/fLhHcnP16jPhBqtlHf/UXqqfwvRhC7eon4Ecr5XdTxO12Mpf56crhtNXVYW
         NriczOpMOuNXZE7INtttHJTcPx/FAAsfBnKpUk2UYBuFuj4ILVJZP0Hg3J6qbOP7wSBY
         Vufg//zRYKZdhW0kpA4nexKhlsFRuLSaXKay0KKMX1riL8VjeBAVlui2eQsFJYXiq4+P
         ocsKlWg2xWtMXjW+GdkYIqWp6MOhOqjvQ+Qq/mrnktfkDuXy3WmS2AD3Q2rBXQq0Tyk1
         MAdmFasNCA4CiX6qZD2d4pTD3+CVLQKOvlM49ukAj5ZOaY6CPSswdb3t+Y2HXpskjgZc
         FvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139631; x=1761744431;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYfTlUFBo/usjdk3F5Gd+aY8/HvMwtlk8nC1WIS/b4E=;
        b=vJ82gDhxtntdLJ0VtNrNU9X2S6R5Lskgm9RdXnH49VpqOWL6PZcKLYYz4ZiMACo6ok
         rzNRodiHg6t4vF+urOiAH2qN6uquREgkZKNQJo+DzaSdUc3hA/XenImBX0GbjqlHVwAK
         All02MP5kVI4QuhwScmNfDveNb0MJt3Mav+JOVLpbvb2y7NQ7oCk1R81u9Ya7iEYiUH5
         /r8kyEMcARLzwSVzcFDDyDqxOoBAI9JDk8SIMzRo5xNwb1DQkTIQHfXq0UCbuASrrNeT
         6HnBq6FBJRZPF0O8+8WRsJKfDQ6OXIZwuqR8hkLe8jkcvqCvc6me9Bc4dnYiG90xrZI6
         YX5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBb9Ydc4+lieaCl43kKL0/HERaoMAAuZAw5YVa+90fdHR5XQXF7ILngrzSZsD7Dmu67o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RWZF7qw/5ljYGQYecTxTMci1JalDtl2oSxrhWHfLC5LlsHos
	ztb+BSD2MdENkJKEXha54x/rebzxG/Y7zvFSJ2IAcsVZvDWlTCHWTv4o
X-Gm-Gg: ASbGncu+mbiGfQKLnkxBFbAybkbxYFuHPkzWNSlc/3N3C2XBaC9VVWZ4nMhKjS9bqgN
	s/j6bUbrubrHbSIq+gsLOVHyXOzGd4lPgcIVPfczpT6LG+c7FVvmwR2ICm+20YgVurqxktSTJdd
	5pG2YOsuskGpcmYwgNQnD8AdLj1ylD0QwE9kFVGwo7VLkwZK5qz78vO22BZZw6CRGl+aLw0lYBK
	jMof/kNBJxAOzFuue5lm9WpDMNA2UOO3dj5+KoU73edITaW6/Veix3ppU4Bf6uEzFRZiuHK4zWe
	lw+bCH6rf/TTrKYm2WIKq4llX7LRn13Ku3ZtEJ+xy7PjA1L6FEYJMGE4Cr7chaMu7MFOFjBWBNh
	bZM/gMb5WOiz0bIGdT+pco9O0RlmY0t5oX/BqwjNnQFgtL76gmIW3TIaZciDwCuUcUthxciARl/
	Nu3a6xzpTOL1N1iLGbbTwpv0cHnvh9V2ra2DozhmBqMi1kcCK0VsLeuTXNzVxU7VQ3Fnz2MNF2v
	w==
X-Google-Smtp-Source: AGHT+IEWPpEVNNTloerT6R1kBTt4TTEvytt3m3pOsnn5/i1HPytdtxrGbaZPU+HCic2Mh7gSMafZlg==
X-Received: by 2002:a05:600c:190b:b0:471:a24:497c with SMTP id 5b1f17b1804b1-47117919b54mr158961695e9.33.1761139631033;
        Wed, 22 Oct 2025 06:27:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42d828asm45138725e9.17.2025.10.22.06.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:27:10 -0700 (PDT)
Message-ID: <d863c518-3246-4752-83f3-469592b1de69@gmail.com>
Date: Wed, 22 Oct 2025 14:27:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
 <786d6c19-0a13-4e55-8f4b-39b57dd6ea28@gmail.com> <xmqqplagunnm.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqplagunnm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2025 19:15, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> It C "char" never refers to a unicode code point so I don't follow the
>> reasoning here. Isn't the reason you want to change from "char" to
>> "uint8_t" to match rust? Given "char" and "uint8_t" are the same width
>> why can't we use "char" in the C struct and "u8" in the rust struct as
>> the two structs would still have the same layout?
> 
> And forcing u8 makes sure both sides of the ffi agrees on the
> signedness (C "char"'s signedness is implementation defined),
> which is a good thing.

That's true and ignoring the signedness would be hacky but I'm not sure 
it matters in practice. Both C and rust would use the same bit patterns 
for "abc" and b"abc\0" and in general C plays fast and loose with the 
signedness of variables all over the place. The trade off for respecting 
the signedness is that we either have casts all over the place or 
massive churn converting the rest of the code to use uint8_t. This 
problem isn't limited to xdiff, it will be true wherever we share 
bytestrings such as the contents of objects between C and rust as we 
tend to use char rather than uint8_t in our code.

Thanks

Phillip

> I 100% agree that being honest about the motivation to sell this
> change would be a good thing to do here.  I do not think "in this
> series, I want to match the types used at the interface to be of
> Rust's" is a position to be ashamed of ;-)
> 
>> I agree with Patrick's comments on this patch - it would be nice to know
>> how you decided where to add casts. Given that rust is going to be
>> optional for at least a year we should take care to leave the C code in
>> good shape with a minimum number of casts.
> 
> Thanks.

