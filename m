Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD726AF3
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409241; cv=none; b=b6jfbnO2DNlLpTo8e0TEnxkBX7G2qE3HsGnYDCx+EpqeeJMPIrglLzs2cLRBbhiSVFECjNzxy1tHk5Qlukxa2tcpa+ZasfO+hkmG5AyRvzyTQGyThF4X0wSSxGngjlFGsiWNzIkJPT/3GNRsGx30fHfxRuDRKnIVlq4FqtiiR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409241; c=relaxed/simple;
	bh=BB89E8j4zND5VYDA/9tOdZxUkYFNUHuNtDWtn5a75ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tAPOvjUUsp1HZ24lV1A2IV0PodreUzJv/p5s/avnb/K+wl2QYFuXUG/XmTVoVumRzm6+NpAPAo8qU7AfmmaS/2pwHnLMTVwpU4jX9FKNvI5Y4A33c7HEprjI8B/MKp4fqFSFxXvGmFI3ch7kBf/XIuDmTYchljQrDd5VKjsAQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcLiTLnn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcLiTLnn"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e73e9e18556so2213316276.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747409239; x=1748014039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1yHDxvwnfq8tYZYO/FW3lU8nrNR1OQo5ir6CG6w/gco=;
        b=XcLiTLnnA20cJQRFZHT6LJYj28Dq5G+sPgybCL9VRJIoLq6m4NEkG5aHTlllFBxdiK
         aDJEZu2MeIZMpFU1CGsE/2kgQUdt1ZqubVMmchih3IWriNrVaKU3evpjYj7TFTq4o4gm
         LpPZzKcwyV1Fxh97TueEpQXBOELnzUmKYn51HyZqqGJb6vjSRBwPb7MLDqvtlubxXW4l
         gyAQaNOfsOT7O8bfRTwPncqmJZu5giQBOhp8lKPivF4MolyqphVYlYwS9aFYvYDGSaGk
         WbR4s7wxclr366cW/zVKJBDYaNxdH6e3cNyCSCNToB6F+QemrzG0bPkKqPXPOLtvc2AZ
         l22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409239; x=1748014039;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yHDxvwnfq8tYZYO/FW3lU8nrNR1OQo5ir6CG6w/gco=;
        b=gwjJwzoA7NgPjvfwrszRDHkNwVHXe0269hmbD9Pd9k/WZvWHdJrRt014BtL2fO3GSh
         VxfbdzVgB677hSNhnuKLxvvYR4Wg8n6CgeC6thfz1ts9fHeoEiPyIPJn1apHSFJvR5cg
         IuHvaxoUKN3KAnlW5LvtMoWcSETBJOr3C6ry+6aa4jwG9sHJ/hgTgBCHUr6mvotdh8jm
         EgPVM3ub+zw6I4eDYUqgIreTt4CM+48kAVRkyFtEAS/cIKbv1wCSW5x+4nyNjvUQ4tea
         RPzSlzJHzInV/IZLdUgja7NWDO5GWm4bLIisNs9QFCjOh7TBdVVQlM4GCA2d38BxLGJa
         o7Jg==
X-Gm-Message-State: AOJu0YzH37NjsFjFZJnMITXPPLUGu+5FVXNrJgr1BETR+TduZZdL7lTu
	gYdEVhisF/Taine/Vshs71Eb+vdWHg1nis00C7+w6HXskaOqc9aZMjyn
X-Gm-Gg: ASbGncvq4qzHXHdOa5ghPE7UtR+D5g5SvtuLm409uj6t6nyIW7obKIxKf3XXA/+7Gws
	XBfU1kFOEulLzC55Bx2cfyWskaAXd3OWJloccdUUDPGSxyYpy+ldNkz56qYAYUulOeAWDQKG733
	JCxa/25suaolpu3+zd35zQbXEFs0sZvoVH9xZx8wH5n+D4+xNekIk6uc7V0+6Znmbt7abHt0/2L
	WbeCmFbbshto2nYjztesktCBHb0Gv03KoWkR2HOdxAObwoqC2wZvCGDnRaETZIZszWVnhsJ6bHG
	qpp6HvNqAbiHFi7X4zMBPMgjQlIBMaAFBPGhKGFgKU9HMEZC4ui5dT5kVcQq/ydxLQwlCesZhyn
	9E6II5LFLvnApTxBQfh9ILcKNQdab5+LO+7lsJ3E=
X-Google-Smtp-Source: AGHT+IEL52Vxl3U5OC/UBYwtLt7XHFY8rh1vvj/F5SYFOCdH/xQvy3frJhrZ9TzgodrHT6T0JGRYcg==
X-Received: by 2002:a05:6902:240f:b0:e73:1645:914f with SMTP id 3f1490d57ef6-e7b4f7debbamr13530510276.3.1747409238717;
        Fri, 16 May 2025 08:27:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6acadf3dsm622034276.26.2025.05.16.08.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 08:27:18 -0700 (PDT)
Message-ID: <6087094c-2639-4262-8026-89e4d8aa8c8f@gmail.com>
Date: Fri, 16 May 2025 11:27:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] pack-objects: add --path-walk option
From: Derrick Stolee <stolee@gmail.com>
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <a271d6245c243d50d95ea6c7e624b3165f7da558.1742829770.git.gitgitgadget@gmail.com>
 <aBVTcvhW+lW0GLpQ@nand.local>
 <052c534a-c2a4-4ff6-9130-4c1e96e1ef72@gmail.com>
Content-Language: en-US
In-Reply-To: <052c534a-c2a4-4ff6-9130-4c1e96e1ef72@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/25 3:39 PM, Derrick Stolee wrote:
> On 5/2/25 7:21 PM, Taylor Blau wrote:
>> On Mon, Mar 24, 2025 at 03:22:38PM +0000, Derrick Stolee via GitGitGadget wrote:

>>> +static int add_objects_by_path(const char *path,
>>> +                   struct oid_array *oids,
>>> +                   enum object_type type,
>>> +                   void *data)
>>> +{
>>> +    struct object_entry **delta_list;
>>> +    size_t oe_start = to_pack.nr_objects;
>>> +    size_t oe_end;
>>> +    unsigned int sub_list_size;
>>
>> Could you help me understand why sub_list_size is an unsigned int and
>> not a size_t here?
> 
> This is based on a similar "list_size" used in ll_find_deltas(), but
> since we are starting from scratch here it would be better to use
> size_t.

Sorry for the delay, but the find_deltas() method called in both
places expects unsigned ints, so we are stuck with this until we
decide to upgrade it in both places.


>>> +    unsigned int *processed = data;
>>> +
>>> +    /*
>>> +     * First, add all objects to the packing data, including the ones
>>> +     * marked UNINTERESTING (translated to 'exclude') as they can be
>>> +     * used as delta bases.
>>> +     */
>>> +    for (size_t i = 0; i < oids->nr; i++) {
>>> +        int exclude;
>>> +        struct object_info oi = OBJECT_INFO_INIT;
>>> +        struct object_id *oid = &oids->oid[i];
>>> +
>>> +        /* Skip objects that do not exist locally. */
>>> +        if (exclude_promisor_objects &&
>>> +            oid_object_info_extended(the_repository, oid, &oi,
>>> +                         OBJECT_INFO_FOR_PREFETCH) < 0)
>>> +            continue;
>>> +
>>> +        exclude = !is_oid_interesting(the_repository, oid);
>>> +
>>> +        if (exclude && !thin)
>>> +            continue;
>>
>> ...here we only skip calling add_object_entry() if the object is
>> excluded (which lookup_object() returning NULL would cause above) *and*
>> we're not using thin packs. That makes sense, since if we have a missing
>> object, but we're using thin packs, then it's OK to skip.
>>
>> So I think all of this looks good. However, I find the interface here a
>> little awkward. The function is called "is_oid_interesting()", but it
>> determines that fact by checking whether or not the object has the
>> UNINTERSTING bit set on its flag, and then negating the result. But then
>> we negate it again here at the caller to obtain whether or not we should
>> "exclude" the object.
>>
>> I was wondering if there were other callers of is_oid_interesting() that
>> don't negate its result. But it doesn't look like there are (at least in
>> this patch). I wonder if it would be cleaner just to inline this instead
>> of having the result negated at multiple levels.

Double-checked now and there seem to be no other callers, so this will be
renamed to the opposite case.

>>> +    return 0;
>>> +}
>>> +
>>> +static void get_object_list_path_walk(struct rev_info *revs)
>>> +{
>>> +    struct path_walk_info info = PATH_WALK_INFO_INIT;
>>> +    unsigned int processed = 0;
>>> +
>>> +    info.revs = revs;
>>> +    info.path_fn = add_objects_by_path;
>>> +    info.path_fn_data = &processed;
>>> +    revs->tag_objects = 1;
>>
>> What is the purpose of setting revs->tag_objects to 1 here? Do we need
>> to restore it back to its original value before returning? A comment
>> here would be useful, I think.

I think this is not necessary and should be removed.

Thanks,
-Stolee

