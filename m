Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF31A5B9D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561453; cv=none; b=UwDrfgFlMkdtiC3SYA1NZQ5fXlAlexuOrmePQ8HY+eMrTTbNesC8Afl1Bj6krB5WxKOeLc/PRQDkiC3qNTOZH2SlX5q5G27WqMpGfeWFJp88bpyt9xW2dZNrCBc+V37c4PHd1VitRM56TSv/HyVSWXOHIQB7YWgfiz3OYbTVW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561453; c=relaxed/simple;
	bh=uVoXu2nkC+5C7MkbubOoE2c1C8CmWyymdH+yzjdL21g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWwc8vKC4iJasYajIB4TG129z2Tb69THaTKMm8mPl67zQTINZAv6pNP2SUP7E8Kzp/OZ2IS6uAFhdpusg4U/Vdf8mGoSO6z5C9igqz5mFMaupPh0hQVcZsxLUDPlGt86RMxI5XBXE7YCQw/lcrXUZP2GUE7yoMjs32IPDAPvIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=miR41jfq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="miR41jfq"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79628fb5c05so13713797b3.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774561451; x=1775166251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncpV2h6MT5KTaKsoXKIQvvsek8SJ+DXZ2cU0ohGNsmg=;
        b=miR41jfq7/zTVocCyNuS7x9dd8FL0Qo0w/2g3mp1uF8nnXWuZBVlt5EquWN28s0AKv
         k/DyPXGZ9LUZAgzyInNZIWx+xN9QfiVbvQroSNEwh8xn/8qLF2Gml/71XMK5JBWM8KGE
         1XMoHIqlSREUdq5TWjkNca+Rkd9rWuQmH8xxweEBeZsxNYNX8bE1/gPXYXXlOsv3AP5q
         NZHPGwa7JXJceJWIBzaLXgBokIO8NAVw7OyOm0mlYfZOrK/072idxIoQVOTmpRosPQQ6
         V0Lft3gcmUMRqyERI8igGkxQzmjoh54l64sm6tPqVKeajOnrxzBOegUJD5i5/4nT0vqR
         e07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561451; x=1775166251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncpV2h6MT5KTaKsoXKIQvvsek8SJ+DXZ2cU0ohGNsmg=;
        b=J4kZSpGz+Bd4TOGuK7gfL0xMOJPjWmfFUbFKINngyCx+0qrVj73S1wFRbTgj2m4nOC
         lESc4fGu4oPiULbz5o22zusty98KKMM7ylPWvZWS/DxxBqHbQmJv06tVy9lAmT2d3VEQ
         9FNJI4bgu411aETqHLFjGwCFTgRJAYaqBhT+8GcPU4HiiVMQnALl7HuuyAzUIqvyMnRG
         yf7gWdo6rcRvfRRL3lTJw/IxefUL4XRn57MPrNQQijgc5nllw4OuRzFWshSxuMOB/FpT
         Eb1FU+J0UejreFb8h6gKxcjJnKBm+hklcC/6eC5Nzg+EphyJ1lwyrKZhKu0D2Tmc8YXd
         vNaA==
X-Gm-Message-State: AOJu0YwksAPicrxR2i7PE9uyw3AoAtSY5cJNi9tnctmWKInkmA/TzDJ0
	WYhjHovcrtXuq5DQzw+T1rBHtzv5oQBjyunLhuWuCJLwgB5DXzQvZ2TVDtsc2uOtMHc=
X-Gm-Gg: ATEYQzwDaE90Vqo4A0rlD5xBkMg1p4mcy12wO7C35pDsPEDkcNGU49UoaZgBLlLcM+7
	E89GQfA/cEraQHi78y4hnmg5AI6MY8ka2NwTFFDnveEdsR+QJ2wEBfllL15f+NjxHVE3KanrUcP
	el6CjXbWKSVldQuf+HcvtUKN/CqdlGB713kWIFXPM9VdsDLl3uTg42uyNp8Y3T2I+01C6MlHv/8
	J6dbU9TerfC4rf25m7cAZvJlg/c4/6AOfxU62I11oC8Pb0p4THi5qJebpqPl4fMApLfdz9pn7gB
	T5H7MIoDeB2xeuqvz3gvF4gM0FyVeFJPCcfdOnRZxNoDljdsmLJl41Kjd9QcGDNGqMn3h4MMY14
	SbHx5gKNSXRPlfS0ueEaiMueP3XKV9y31vbX56QAZFi68SsE0xcxEBq3+UtdXpGRdpYiSArHZ72
	f0MxwBFngGp9HCcElQ3/4Z/cuB8RBha4SLmaPD8lwa9UGdEPZqvaRV/fpsjKub06r3hmghNbfzb
	rLZaXFZ8h4KzD+OYmL42Al3U0rjdWETat58wRrQ
X-Received: by 2002:a05:690c:388:b0:79a:c50f:d59b with SMTP id 00721157ae682-79acf335a32mr98726997b3.10.1774561450720;
        Thu, 26 Mar 2026 14:44:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e4116a2sm19279337b3.41.2026.03.26.14.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:44:10 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:44:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
Message-ID: <acWoqXUwVUB2/65T@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
 <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>

On Thu, Mar 26, 2026 at 04:40:00PM -0400, Derrick Stolee wrote:
> On 3/25/2026 7:51 PM, Taylor Blau wrote:
>
> > -static void read_packs_list_from_stdin(struct rev_info *revs)
> > +struct stdin_pack_info {
> > +	struct packed_git *p;
> > +	enum {
> > +		STDIN_PACK_INCLUDE = (1<<0),
> > +		STDIN_PACK_EXCLUDE_CLOSED = (1<<1),
> > +	} kind;
> > +};
>
> I kind of wish this enum wasn't anonymous. And it matters later.
> Let's call this 'enum pack_input_kind' for now.

Hmm. I don't feel strongly about this, but I'm not sure I follow the
reasoning here. The enum is truly only meant to be used within the
context of a stdin_pack_info struct, so it felt natural to keep it
anonymous above.

I'm happy to change this if you feel strongly about it, but TBH I am not
sure I see the benefit of doing so.

> It took me a while to figure out what was going on with checking
> *key == '^' and later checking *buf.buf == '^'. We should probably
> combine them to the same condition:
>
> 	const char *key = buf.buf;
> 	enum pack_input_kind kind = STDIN_PACK_INCLUDE;
>
> 	if (*key == '^') {
> 		key++;
> 		kind |= STDIN_PACK_EXCLUDE_CLOSED;
> 	}
>
> 	info = strmap_get(&packs, key);
> 	if (!info) {
> 		CALLOC_ARRAY(info, 1);
> 		strmap_put(&packs, key, info);
> 		info->kind = kind;
> 	}
>
> 	strbuf_reset(&buf);
>
> This feels easier to read, for me.

I agree that the above is a little easier to read, but I'm not sure it
handles the case of specifying the same pack multiple times. I had
originally written it in a similar way as what you suggested above, but
it breaks if I write something like:

    cat <<EOF | git pack-objects --stdin
    pack-XYZ.pack
    ^pack-XYZ.pack
    EOF

It should produce a pack with no objects, but I think the code above
would effectively ignore the second line because we already have a
strmap entry for pack-XYZ.pack so we never set the additional flag bits.

Thanks,
Taylor
