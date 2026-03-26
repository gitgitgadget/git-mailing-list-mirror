Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6C1E5B88
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564660; cv=none; b=rmoXSjbd5rgLghTciCBgNHey4uH8Cgb/Gvz894Jz+5vKh7e2+fXQKoL8zZspDcTL5HlCxuqsI48USEutFh8wICV/6rcxXcbpwlvbHjP5WARU0CiMdolz/ezQDvJaJO7FlZZ5kBn1U1Mz35OAqwrcwyLQ0K8WtKyVRGUSneGcpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564660; c=relaxed/simple;
	bh=23S5hWWGXAmMfM0WSl1qeMOuXMYszlnF7NY1o59Dv2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy7LHpkoc0Dtaui0fRoHlq1Vqt6b1VvLTjr4P/2M6kwJFp+G46ySGCZYYu/0XtyezqmLlABddWoZxU7q/8c8sMrWEv7JzVyhhXDiiMNh/9SMf87c//uPZPsfhGImv5SD+HiQAiMiEGzQrih74jFQ0CvkMkq3iWEMkYmmadTmyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HueNFA+j; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HueNFA+j"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7982c3b7da9so14483707b3.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774564658; x=1775169458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1odgai0ZphtSKJKxa8xiLn2Z+Y7enYVOf1QxHB+T4Q=;
        b=HueNFA+jRMGT+VVyx7MqpoPQnLRA9ngL7Cz/bCn0uDx0f3D+D5QjL53kx55sIPNkDg
         60PpN+uaY+7TPlJCCjAPKeLtWMQ0llYb+5I5ZpwVo8jH78Am1E4IifkEsZ1AKeDafWqG
         Mlfm8s64wm1VZ17EFYCv1dGhRg0ASPO8p6I1a8wLW+Th4G7mwz8yaB/QoFoKDwFaKvOF
         apOMapIZ5SeLov0h+jEDtexakbXh6S75efXZv/nFaquycYEkvXi02ls0t7tI8EL1v5xD
         NziizSsrGBRBSlWuSsVlxde52rqwtqnrrnmUc4UiMdC4LzxS4U9DVOSasIp0jFUxNdiT
         sLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774564658; x=1775169458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1odgai0ZphtSKJKxa8xiLn2Z+Y7enYVOf1QxHB+T4Q=;
        b=dRuYRM+iZFcjJLlk1T8vFUyaF4S2DH5XpD9xtqMWuxDzBw4ACyTDKwTHGa4AVA5osk
         c9uspBLx83qWmCm2utAMxDMNGR0coOG2VHelK4EwVwiOvnBnhAebdT30q8YgUSex1aEa
         I2qkyMQ8L2QT/8/w8GojVtecvHqfyHTFt+ttxgUBWGWdRlTxJzC4LIrnoWnrYw4HvJz5
         lfQhNYJqeslSzuKifUqBcBUwRy3rzyJSklbDobwH0gfcoTOMCObtoKrsVRZ+64Z6sqMC
         a3BkmnklhI740O/fkei2pJtMdyDQ+r/9p/vO47HrIc1iK6id6pSIeVh6NfgW/zHw9/8G
         MwKw==
X-Gm-Message-State: AOJu0YymomyB8wOGJNTZbxLsEI2UWoGSgGe/h3QJ6aFCvuV/yEYo6oIU
	F0qm8tk4KGWv3+vPTqmBSPRerej3XsXkzMwaaD4dNf/cu0E7GfI5wLvLU8LO8P5kyn84ZVousS9
	qKa0iOpepyjXa
X-Gm-Gg: ATEYQzzE4s6OW3TZzww0Anbg4KnjHoLdv4cgGtnHORaa/BYuYlzycymkGgVGdBUS9C1
	4m8YDL0LnHimXhFo8xan/8gZNiqvqoTDR+QDocK36o9R60/4p9YOJjk3crwgqbsYj8gEKpOeUOu
	joh6frXRE8U/Y4s6atbiUfcOpsHg5Y/gRUMfX+xGh/Ut7AQ/9U98cvyL1GkyiDQ4ea3AXqekYon
	PMVSim32HaUWAXZmXig0a+kGQ5y/dqDy0XkjkBNkTObGlCQZkQSPLZlcMlL8mBaimThoZbmTiB5
	QZ2M0MRHvu04q+dmKlGshLNheYfDQ37IdYofM5XM9N6Ra6Y7o+au2PZtaGlPA18HIijDpbWy4Xp
	h0CDfVPE+RmpZVQguyWxJQEkHrln8yMNFeOudzpnFfkdwb5KLHjVZgmjWqaRFGCVOnmpNAzlveq
	VDUgvRV6XUfqIBzJSGhcJvU34cER+/FF8HnKpglvmoWZPF8sFSSQRTFeQKYk5wOjxrLEAubaUk/
	62qbStqoKYN6C0vxbY0PeqjBpR8Rw==
X-Received: by 2002:a05:690c:7281:b0:79a:c93f:4acb with SMTP id 00721157ae682-79bde095585mr1270427b3.54.1774564657943;
        Thu, 26 Mar 2026 15:37:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e3bec5dsm20926917b3.25.2026.03.26.15.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:37:37 -0700 (PDT)
Date: Thu, 26 Mar 2026 18:37:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
Message-ID: <acW1MDhumRUvk21U@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>

On Wed, Mar 25, 2026 at 07:51:50PM -0400, Taylor Blau wrote:
> +static void stdin_packs_add_pack_entries(struct strmap *packs,
> +					 struct rev_info *revs)
> +{
> +	struct string_list keys = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *item;
> +	struct hashmap_iter iter;
> +	struct strmap_entry *entry;
> +
> +	strmap_for_each_entry(packs, &iter, entry) {
> +		struct stdin_pack_info *info = entry->value;
> +		if (!info->p)
> +			die(_("could not find pack '%s'"), entry->key);
> +
> +		string_list_append(&keys, entry->key)->util = info;
> +	}
> +
> +	/*
> +	 * Order packs by ascending mtime; use QSORT directly to access the
> +	 * string_list_item's ->util pointer, which string_list_sort() does not
> +	 * provide.
> +	 */
> +	QSORT(keys.items, keys.nr, pack_mtime_cmp);

Yikes, this is definitely not right. pack_mtime_cmp expects the ->util
field to be a pointer to a packed_git structure, not a stdin_pack_info
one.

Indeed, this fails the ASan CI builds, which I didn't notice as I sent
this series off towards the very end of my workday yesterday.

I'll need to resubmit this series to fix this, but I'll hold off on
doing so until the discussion in response to Stolee's review of this
round settles first.

Thanks,
Taylor
