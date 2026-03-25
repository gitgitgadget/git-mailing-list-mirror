Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5337396580
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774480440; cv=none; b=IQ3rPAi+HNulcwDGedsyHKje7mSeN3jvTPNCLnb6z6HwRnSKe/Sfak4NASDAHPY8HNlW8OZcdDOFrW6VxLzjqlLWWQ0DWmYtFPSzbeLisarhPc8pEd8ZQENJTR7Zvx+hMPPNzPAYf2F6Ebn1ywN67B2C9Nc7MYArO4/HiUsEr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774480440; c=relaxed/simple;
	bh=Q3jTCizlfLfhmTNwbE4ex8PT7MGgM/8sZw1oiDNz+pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+hrD5LtaA5Pzfncy65D66fk9RLVBhPS2eWBVT5Qa8UTx/ssf+LmVIMYYrv6YsSW3xRoGMnzWqW2HMSkArx89U8UzragZ8GsCUBlxwrDVMR8gLzy4ngWStl4ixpHXZKVrpydfk0dyfxXM2aBkLmQImTNi6NuHoyFgx9GBUzvhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UuxB3cjn; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UuxB3cjn"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79ab3e26cceso3571507b3.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774480438; x=1775085238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxjR+/BhbfFNd5RxP3ANQwFbym1dxpGyxbwmKcx9Rao=;
        b=UuxB3cjn1W8wtKEdRBXttIaobsSPxdZ+u71FkMYqLiw+pW8dTZKp3TfP9EtSYnHYP4
         46u8cLADmFRPUuUuI8pfVb37kDWmD30kIatUANV+X92rUGsYMSV+zZmKAfMGtBY44awD
         MnxH/NK4Sf9B/t8tKeIuuyorbgHu5IxwOnqz/oHBaV3D2ifpybgzfEIfLrZbX11WmFNX
         pKn2dFBnoPWHnfUReRn8p6SC+AzyszyHrOGIoknpbLuK52tb1SCSDE7OJwvhUqRnmtSv
         abYv7+2MgvKesOKYNgwOFkHfxrp5G3g30EDYfTtwr3kj+smqPH92UpncJKJRFSPtvnFA
         +nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774480438; x=1775085238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxjR+/BhbfFNd5RxP3ANQwFbym1dxpGyxbwmKcx9Rao=;
        b=Cjo2O+kWz3t5kL7sNDVRwBpvJdO02nhyaDCC89K0Kg6J4DPr7ScSgAPTqQb3leA7g5
         MdHk90Uzsuvp/ebe2ESXh/y/4/z0Ea04rofC6HOu2GqP9DmmGZZrGpN+AUiqlI1wdBxl
         QEGih037MFlu6/Z7YxDZiYcCN3tPvIPs3m5E9cWBG+qDn318yD94djL+ajLHwrH+BkZO
         FBitdEISnkCmMvs4Ij4+a+0syivvsYZ0u3U/Oh3Rd7JRv0U8sr6LMTKsNh8nUBtcy092
         +Q4u6rUGd9zykiqN9LQ0yv34FZg9Uiz000D61S8AX7H7FNMF7WhE24WVj2zK3lchj2vT
         Uk8Q==
X-Gm-Message-State: AOJu0Yxc7dwZwrZvZ7I0ie//iSmQ2q7iRpVnRTHZOoxKK7KyAnbPjU5q
	g9ek895dntlSYrejPDQ7k8BSsiQRan/qxcfLLXn7UZW1ypfu5dOd2Z1AqPK6N//4ifA=
X-Gm-Gg: ATEYQzzqxSGdML4Hcl+e/d8HyWfNs7aEBosS+Z8r+Mh1objp9M+FhL3qN2R1GX65QlB
	tFp3U/UGYhTw7ClNdVed4/pt43yE3Raoz1Wjd0kP/m6k1sWD+YonlIPgTo1KZQDq9ZoKpwz9BPE
	MN+QKXQG9AQsNvxN+/xM5j71BoggvYsbD7INJKSiYHaTkpWzxwCiggrzEfFunNyDBf57SwFN3ET
	NLYtRExF1qMZwSKiGgVGgZ7fn0V7Nx7bvQqtmIjLikVo6TWY/tcC73r/v1iYsW6vU/lGwibqawK
	mGKVTKBx9kZPpjJqH3rWMOIf1C3utEP1E1J71jcqd3qVOD8gRO7oxctQls9ahh4Fo0d6BuSOWyZ
	JOXXsuocsS05IThp8amIugIGMHmdYRJmmsEnZYnHEn9WYscJZ21RbcOpAAKmYGSRZfpUY0t47a9
	6gWitIHsU5KkuV7K+4JEAphi/utiQF3douTN1yG8QdUp+B3BK9fGQfxI1v/RyORwkcVh655i+Qo
	GLZOK1d3sgR1qc45+O54sgBiVGWUw==
X-Received: by 2002:a05:690c:81:b0:79a:8eee:fa3a with SMTP id 00721157ae682-79acf62cca4mr58518647b3.25.1774480437580;
        Wed, 25 Mar 2026 16:13:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e41e735sm4843317b3.45.2026.03.25.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:13:57 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:13:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
Message-ID: <acRsNHna6IJHQNZq@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <ea6fdbcc46f608c3fbe65298e9ca91faf43a1b16.1773959041.git.me@ttaylorr.com>
 <acI_sP6ZEdw-xGpR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acI_sP6ZEdw-xGpR@pks.im>

On Tue, Mar 24, 2026 at 08:39:28AM +0100, Patrick Steinhardt wrote:
> > Extract the logic for sorting packs by mtime and adding their objects
> > into a separate `stdin_packs_add_entries()` helper.
>
> Right, the ordering was my first question. Interestingly though, that
> function doesn't seem to be added in this commit... ah, it's called
> `stdin_packs_add_pack_entries()`.

Ah, good catch. I had originally called it `stdin_packs_add_entries()`
but renamed it before sending, apparently without adjusting the commit
message appropriately.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 9a89bc5c4c9..72c9ddbed6b 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3837,90 +3838,120 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
> >  		return 0;
> >  }
> >
> > -static void read_packs_list_from_stdin(struct rev_info *revs)
> > +struct stdin_pack_info {
> > +	struct packed_git *p;
> > +	enum {
> > +		STDIN_PACK_INCLUDE = (1<<0),
> > +		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
>
> It might make sense to provide a sentence for each of the enums to
> explain what they do.

I'm not opposed, but I am not sure what information would be helpful to
add here, since these correspond one-to-one with the three possible
prefixes for packfile names we receive with --stdin-packs.

> > +static void stdin_packs_add_pack_entries(struct strmap *packs,
> > +					 struct rev_info *revs)
> > +{
> > +	struct string_list keys = STRING_LIST_INIT_NODUP;
> > +	struct string_list_item *item;
> > +	struct hashmap_iter iter;
> > +	struct strmap_entry *entry;
> > +
> > +	strmap_for_each_entry(packs, &iter, entry) {
> > +		struct stdin_pack_info *info = entry->value;
> > +		if (!info->p)
> > +			die(_("could not find pack '%s'"), entry->key);
> > +
> > +		string_list_append(&keys, entry->key)->util = info->p;
> > +	}
> > +
> > +	/*
> > +	 * Order packs by ascending mtime; use QSORT directly to access the
> > +	 * string_list_item's ->util pointer, which string_list_sort() does not
> > +	 * provide.
> > +	 */
> > +	QSORT(keys.items, keys.nr, pack_mtime_cmp);
>
> Okay. I was briefly wondering whether it would make more sense to use
> `string_list_sort()`, but I guess it doesn't buy us much.

Yeah. This is actually carried forward from the existing implementation,
and uses the separate QSORT() because `string_list_sort()` doesn't
provide access to the `util` field of the items, which we need to sort
by mtime.

> > +	for_each_string_list_item(item, &keys) {
> > +		struct stdin_pack_info *info = strmap_get(packs, item->string);
>
> We could avoid this extra lookup if you instead were to store the pack
> info in the `item->util` field.

Good idea. Funnily enough, we already assign ->util = info->p in the
loop above, but never use it. Something like this on top should clean
things up nicely:

--- 8< ---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 72c9ddbed6b..c9b33d1673d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3859,7 +3859,7 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 		if (!info->p)
 			die(_("could not find pack '%s'"), entry->key);

-		string_list_append(&keys, entry->key)->util = info->p;
+		string_list_append(&keys, entry->key)->util = info;
 	}

 	/*
@@ -3870,9 +3870,7 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 	QSORT(keys.items, keys.nr, pack_mtime_cmp);

 	for_each_string_list_item(item, &keys) {
-		struct stdin_pack_info *info = strmap_get(packs, item->string);
-		if (!info->p)
-			die(_("could not find pack '%s'"), item->string);
+		struct stdin_pack_info *info = item->util;

 		if (info->kind & STDIN_PACK_INCLUDE)
 			for_each_object_in_pack(info->p,
--- >8 ---

> > +		if (!info->p)
> > +			die(_("could not find pack '%s'"), item->string);
>
> This case basically cannot happen as we already `die()` further up,
> right? Should we rather `BUG()` or drop the check completely?

I think we should drop the check completely here, there's no way that we
would have a NULL 'info->p' by this point with the check that exists a
few lines up.

> > +		if (info->kind & STDIN_PACK_INCLUDE)
> > +			for_each_object_in_pack(info->p,
> > +						add_object_entry_from_pack,
> > +						revs,
> > +						ODB_FOR_EACH_OBJECT_PACK_ORDER);
> > +	}
> > +
> > +	string_list_clear(&keys, 0);
> > +}
> > +
> > +static void stdin_packs_read_input(struct rev_info *revs)
> >  {
> >  	struct strbuf buf = STRBUF_INIT;
> > -	struct string_list include_packs = STRING_LIST_INIT_DUP;
> > -	struct string_list exclude_packs = STRING_LIST_INIT_DUP;
> > -	struct string_list_item *item = NULL;
> > +	struct strmap packs = STRMAP_INIT;
> >  	struct packed_git *p;
> >
> >  	while (strbuf_getline(&buf, stdin) != EOF) {
> > -		if (!buf.len)
> > +		struct stdin_pack_info *info;
> > +		const char *key = buf.buf;
> > +
> > +		if (!key || !*key)
>
> The first case of `!key` cannot ever happen as strbufs always have `buf`
> set.

You're right, this is just muscle memory, but the left-hand side of the
condition is unnecessary. I'll remove it.

> >  			continue;
> >
> > +		if (*key == '^')
> > +			key++;
> > +
> > +		info = strmap_get(&packs, key);
> > +		if (!info) {
> > +			CALLOC_ARRAY(info, 1);
> > +			strmap_put(&packs, key, info);
> > +		}
> > +
> >  		if (*buf.buf == '^')
> > -			string_list_append(&exclude_packs, buf.buf + 1);
> > +			info->kind |= STDIN_PACK_EXCLUDE_CLOSED;
> >  		else
> > -			string_list_append(&include_packs, buf.buf);
> > +			info->kind |= STDIN_PACK_INCLUDE;
>
> I was briefly wondering whether we need error handling for the case
> where a pack is marked both as excluded and included. But we didn't have
> it beforehand, either.

Yeah, I think this is a consequence of 752b465c3c0 (pack-objects: fix
error when same packfile is included and excluded, 2023-04-14).

> > [snip]
> > +
> > +			/*
> > +			 * Arguments we got on stdin may not even be
> > +			 * packs. First check that to avoid segfaulting
> > +			 * later on in e.g.  pack_mtime_cmp(), excluded
> > +			 * packs are handled below.
> > +			 */
> > +			if (!is_pack_valid(p))
> > +				die(_("packfile %s cannot be accessed"), p->pack_name);
>
> Hm. Doesn't this change behaviour though? Beforehand, we would have
> checked the packfile for every included pack. Now we only check the
> packfile for every included pack that was yielded by
> `repo_for_each_pack()`. So if an included pack wasn't yielded at all we
> wouldn't notice that it doesn't exist?
>
> I guess an easy fix would be to mark every pack that we have processed
> as seen in the pack info, and then loop over all pack infos a second
> time to verify that we've seen all that we expected to see.
>
> Which you in fact already do :) That post-processing happens in
> `stdin_packs_add_pack_entries()`, where you verify that the `p` pointer
> is set as expected. And if it's not we die with a message that the pack
> wasn't found. Good.

Thanks for double checking.

> This was a bit more demanding to review, but I very much like the
> outcome of this.

Yeah, I really struggled to try and find a productive way to break this
up into smaller changes. But in the end I couldn't find any good splits
that I liked, hence the larger-than-usual patch.

Thanks for reviewing it, I think that it makes the rest of the series a
little more palatable, and the resulting code is easier to reason about
IMHO.

Thanks,
Taylor
