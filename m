Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026A50C7D3
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882895; cv=none; b=A58lLS3/k/Lekx1NdOfu0qYvJ8wQeJS8CQpv7XZREUCf9/Zn/zw3Va64gabD95lAUgcssoweViu0Guu41jwo7xss6i8RQImDdsyWrMI1A/JzubDLzmeY565j1iXUwYqzqCukVTSEMQOzH2XG8iVx1GACcFwi/xJWHyGTGYvmeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882895; c=relaxed/simple;
	bh=Nbt82RJbTaq4zVJYr8cheQh9onqaLLT+w/CKfGEQSlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jItWhirFpvCzrynb2FcGdImR2nNlcma5nb+zm0KoNv92eBGIbmcZbILIvrQBE3TyvjcbjiQ19LVJkFwkI8TpzSra/neaz5l3efyyrMQXOChXhTvRuh8Ii5+IePC38lk+hOpi+nN+rFRPrx2PF+tqRGSwqULv9Vhm1Wz1kqHHFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS8qsKMv; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS8qsKMv"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so20472495e9.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767882892; x=1768487692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V1tLdnPx3/lSodbkgXMp/EaVp3rbu8Gij9idHwevcrk=;
        b=jS8qsKMvi7QzkdkLj+lOyRyxoW4ouO1z99IJ3cHnT/U+3DQrCdeP5KBht11K/uV/nt
         1m1m+WFVYouf/84tHOX53o/NHQ9SwElMb+5nlevPTMk6oYNPPVGV/dUWglJnxb6MBd6h
         9tsPIZts5dP68K+8T5upY47OJ/rsGmJHjgmhfIp1lix55v1ydIcfUnipGzNydRUYJobm
         vUO+rNxIVY5jm/NB0kIshybb035P8w3VRAkj7TA0eD8HFutJ6TlWsKSf11v9U1d9VGnh
         pRsS4FdeLLDwPfKNdReurxFUZ8m96a4wufLC36p9e8/OPU7I6A3QQTwzpW4SSvGE+qXx
         gOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882892; x=1768487692;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1tLdnPx3/lSodbkgXMp/EaVp3rbu8Gij9idHwevcrk=;
        b=GMcXAVWLGzNjTLoLuwR16DIhy9B/1FrabDqNcSs/Sla6q8I+AOjGqZzYvmiTWlaGaC
         zOWXRBKg+CPNi1m48CZ7N+8HgapRSx6b02o2wVM5DScIYWckFYz91Hs5gOJ/9Q+jMA8+
         I3s2eco1SHewxNWXS16dlvzAU50V3xbnNNIlIIwCraGaclA7N+875QgZvTFjbPy8atZw
         qK45C/s76Em5vRFhN+bSZ7hKwrHaJg4+Qo4XsAo3m4lb2oumR230BsfUyyPQgsgolb9E
         6WaR7he4mvqWQE1lLLUxbEAK5Eu2UFumVu9Dx1gKSOfJye3Rf/uw8bd/+XxD5ktPthDB
         zN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZosIrsaZUYzwfrehKjRieJ4LfwzvyE5cW2exSbKc4hXsSQSMplgWo6yvtukivo0BqH/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyVa0N2QE3cCU3ymmNubq/xqRDjRq2R8BSq1rkhdzzFAZfol/
	rIpEo+BBGd/jlRQU8poGold3lJoPHRJqR4VoWBkoaFtdpITDeKfr8rBT
X-Gm-Gg: AY/fxX76FPlHt2olq6Gh3xxxn6P6qQMCQj4jw20TruGuSG73lpwEZ6IDaF2hDTFOuqN
	LC5uGTPFwoa2oo5BClRTTWJsawbAKCFHr9n1pt3QPBwa+DmRnRxIDftYMUOtl8aAEXh9VKu5h/M
	AL7fUm6uzNC7ykr8uhjsn+yjy4elq380G2PL/ogcIZjXCKWLfC7ksuw499Coby8H13yUoCDpq2Y
	NLc8+rSEc5FVyfFZMt3bgqiEiyFMGZVmtnpW895P1uRDmtCOdDaGrMt5MQdKxvUnGCgNOABJOFb
	HAE4PVSoFO30P65k1pG3UKfr6+u9343RCroJdXfls6uiAtwmldARDH45bvaDxjkLKh0XARL1axc
	06m28aV9umBQ5nhn9UD9ZqHjuaIjo3Pi6Kfaze6jdf/T7liH4Qu+XiJS+TV1ghQiVznXRCcaU+y
	Q7t9MJvROMjVNBGMlWwBiaWXLMKQNRgNrD9GJ+WIJ0zux6v3A96MT+GXSJ48AF0JqbTw==
X-Google-Smtp-Source: AGHT+IGAx9/l0tiWxOrm+mhRJSi41PrFl/8aTT47jHOsSuBqMgRjCW8QG5gP6J69y8rPs8SX3+SY/g==
X-Received: by 2002:a05:600c:6096:b0:477:97ca:b727 with SMTP id 5b1f17b1804b1-47d8e4a3c5dmr16906305e9.19.1767882891780;
        Thu, 08 Jan 2026 06:34:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9afsm18123319f8f.24.2026.01.08.06.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 06:34:51 -0800 (PST)
Message-ID: <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
Date: Thu, 8 Jan 2026 14:34:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
> wrapper functions) in Rust is painful because:
> 
>    * C doesn't define its own vector type, and even though Rust does
>      have Vec its painful to use on the C side (more on that below).
>      However its still not viable to use Rust's Vec type because Git
>      needs to be able to compile without Rust. So ivec was created
>      expressley to be interoperable between C and Rust without needing
>      Rust.
>    * C doing vector things the Rust way would require wrapper functions,
>      and Rust doing vector things the C way would require wrapper
>      functions, so ivec was created to ensure a consistent contract
>      between the 2 languages for how to manipulate a vector.
>    * Currently, Rust defines its own 'Vec' type that is generic, but its
>      memory allocator and struct layout weren't designed for
>      interoperability with C (or any language for that matter), meaning
>      that the C side cannot push to or expand a 'Vec' without defining
>      wrapper functions in Rust that C can call. Without special care,
>      the two languages might use different allocators (malloc/free on
>      the C side, and possibly something else in Rust), which would make
>      it difficult for a function in one language to free elements
>      allocated by a call from a function in the other language.
>    * Similarly, git defines ALLOC_GROW() and related macros in
>      git-compat-util.h. While we could add functions allowing Rust to
>      invoke something similar to those macros, passing three variables
>      (pointer, length, allocated_size) instead of a single variable
>      (vector) across the language boundary requires more cognitive
>      overhead for readers to keep track of and makes it easier to make
>      mistakes. Further, for low-level components that we want to
>      eventually convert to pure Rust, such triplets would feel very out
>      of place.
> 
> To address these issue, introduce a new type, ivec -- short for
> interoperable vector. (We refer to it as 'ivec' generally, though on
> the Rust side the struct is called IVec to match Rust style.)  This new
> type is specifically designed for FFI purposes, so that both languages
> handle the vector in the same way, though it could be used on either
> side independently. This type is designed such that it can easily be
> replaced by a Rust 'Vec' once interoperability is no longer a concern.
> 
> One particular item to note is that Git's macros to handle vec
> operations infer the amount that a vec needs to grow from the size of
> a pointer, but that makes it somewhat specific to the macros used in C.
> To avoid defining every ivec function as a macro I opted to also
> include an element_size field that allows concrete functions like
> push() to know how much to grow the memory. This element_size also
> helps in verifying that the ivec is correct when passing from C to
> Rust.

I've left some comments below but I think this is a sensible direction.

> diff --git a/compat/ivec.c b/compat/ivec.c
> new file mode 100644
> index 0000000000..0a777e78dc
> --- /dev/null
> +++ b/compat/ivec.c
> @@ -0,0 +1,113 @@
> +#include "ivec.h"
> +
> +struct IVec_c_void {

We normally use all lower case names for structs but as this is shared 
with rust it maybe makes sense to use CamelCase so the names are the 
same in both languages.

> +	void *ptr;
> +	size_t length;
> +	size_t capacity;
> +	size_t element_size;
> +};
> +
> +static void _set_capacity(void *self_, size_t new_capacity)
> +{
> +	struct IVec_c_void *self = self_;

Passing any of the ivec variants defined below to this function invokes 
undefined behavior because we're not casting the pointer back to the 
orginal type. However I think on the platforms we care about 
sizeof(void*) == sizeof(T*) for all T so maybe we can look the other way.

> +
> +	if (new_capacity == self->capacity) {
> +		return;
> +	}
> +	if (new_capacity == 0) {
> +		free(self->ptr);
> +		self->ptr = NULL;
> +	} else {
> +		self->ptr = realloc(self->ptr, new_capacity * self->element_size);
> +	}
> +	self->capacity = new_capacity;

Not if realloc() returns NULL. We should check for that, probably by 
using xrealloc().

> +void ivec_zero(void *self_, size_t capacity)
> +{
> +	struct IVec_c_void *self = self_;
> +
> +	self->ptr = calloc(capacity, self->element_size);

We should be handling allocation failures here probably by using xcalloc().

> +void ivec_reserve(void *self_, size_t additional)
> +{
> +	struct IVec_c_void *self = self_;
> +
> +	size_t growby = 128;
> +	if (self->capacity > growby)
> +		growby = self->capacity;
> +	if (additional > growby)
> +		growby = additional;

This growth strategy differs from both ALLOC_GROW() and 
XDL_ALLOC_GROW(), if there isn't a good reason for that we should 
perhaps just use ALLOC_GROW() here.

> +void ivec_push(void *self_, const void *value)
> +{
> +	struct IVec_c_void *self = self_;
> +	void *dst = NULL;
> +
> +	if (self->length == self->capacity)
> +		ivec_reserve(self, 1);
> +
> +	dst = (uint8_t*)self->ptr + self->length * self->element_size;
> +	memcpy(dst, value, self->element_size);

If self->element_size was a compile time constant the compiler could 
easily optimize this call away. I'm not sure that is easy to achieve though.

> +	self->length++;
> +}
> +
> +void ivec_free(void *self_)

Normally we'd call a like this that free the allocations and 
re-initializes the members ivec_clear()

> +{
> +	struct IVec_c_void *self = self_;
> +
> +	free(self->ptr);
> +	self->ptr = NULL;
> +	self->length = 0;
> +	self->capacity = 0;
> +	// DO NOT MODIFY element_size!!!
> +}
> +
> +void ivec_move(void *src_, void *dst_)
> +{
> +	struct IVec_c_void *src = src_;
> +	struct IVec_c_void *dst = dst_;

Maybe we should add

	if (src->element_size != dst->element_size)
		BUG("moving incompatible arrays");
> +
> +	ivec_free(dst);
> +	dst->ptr = src->ptr;
> +	dst->length = src->length;
> +	dst->capacity = src->capacity;
> +	// DO NOT MODIFY element_size!!!

As the element sizes must match maybe *dst = *src would be clearer?

> +
> +	src->ptr = NULL;
> +	src->length = 0;
> +	src->capacity = 0;
> +	// DO NOT MODIFY element_size!!!
> +}
> diff --git a/compat/ivec.h b/compat/ivec.h
> new file mode 100644
> index 0000000000..654a05c506
> --- /dev/null
> +++ b/compat/ivec.h
> @@ -0,0 +1,52 @@
> +#ifndef IVEC_H
> +#define IVEC_H
> +
> +#include <git-compat-util.h>

It would be nice to have some documentation in this header, see the 
examples in strvec.h and hashmap.h

> +#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable).ptr))

This is a bit cumbersome to use compared to our usual *_INIT macros. I'm 
struggling to see how we can make it nicer though as DEFINE_IVEC_TYPE 
cannot define a per-type initializer macro and I we cannot initialize 
the element size without knowing the type.

> +
> +#ifndef CBINDGEN
> +#define DEFINE_IVEC_TYPE(type, suffix) \
> +struct IVec_##suffix { \
> +	type* ptr; \
> +	size_t length; \
> +	size_t capacity; \
> +	size_t element_size; \
> +}

I wonder if we want to define type safe inline safe wrappers for the 
ivec_* functions here. I think the only functions where the element type 
matters are ivec_move() and ivec_push(), for the others like 
ivec_zero(), ivec_reserve() and ivec_free() the element type does not 
matter. ivec_push() would certainly be easier to use with a wrapper as 
means we can avoid forcing the caller to take the address of the value.

static inline ivec_##suffix##_push(struct IVec_##suffix *self, type 
value) { \
	const void *ptr = &value; \
	ivec_push(self, ptr); \
}

I'll try and take a look at the rest of this series next week

Thanks

Phillip

> +
> +DEFINE_IVEC_TYPE(bool, bool);
> +
> +DEFINE_IVEC_TYPE(uint8_t, u8);
> +DEFINE_IVEC_TYPE(uint16_t, u16);
> +DEFINE_IVEC_TYPE(uint32_t, u32);
> +DEFINE_IVEC_TYPE(uint64_t, u64);
> +
> +DEFINE_IVEC_TYPE(int8_t, i8);
> +DEFINE_IVEC_TYPE(int16_t, i16);
> +DEFINE_IVEC_TYPE(int32_t, i32);
> +DEFINE_IVEC_TYPE(int64_t, i64);
> +
> +DEFINE_IVEC_TYPE(float, f32);
> +DEFINE_IVEC_TYPE(double, f64);
> +
> +DEFINE_IVEC_TYPE(size_t, usize);
> +DEFINE_IVEC_TYPE(ssize_t, isize);
> +#endif
> +
> +void ivec_init(void *self_, size_t element_size);
> +
> +void ivec_zero(void *self_, size_t capacity);
> +
> +void ivec_reserve_exact(void *self_, size_t additional);
> +
> +void ivec_reserve(void *self_, size_t additional);
> +
> +void ivec_shrink_to_fit(void *self_);
> +
> +void ivec_push(void *self_, const void *value);
> +
> +void ivec_free(void *self_);
> +
> +void ivec_move(void *src, void *dst);
> +
> +#endif /* IVEC_H */
> diff --git a/meson.build b/meson.build
> index dd52efd1c8..42ac0c8c42 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -302,6 +302,7 @@ libgit_sources = [
>     'commit.c',
>     'common-exit.c',
>     'common-init.c',
> +  'compat/ivec.c',
>     'compat/nonblock.c',
>     'compat/obstack.c',
>     'compat/open.c',

