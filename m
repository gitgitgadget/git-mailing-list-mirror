Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CF2E1747
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778161; cv=none; b=tSpxQa4OJDXFaE1RY5zOw34Caz3ithv78ajAbL7zsMXH4qW7QcO7Y8H5qteehNblSTeltUDJCz4yG597UCX64v3CGn9aW7+HgoDTK1mERJLDRnM2tLao2zCo0Ck+mn7lbN8unHIHmxFPLcYSd9xhh7k9O370MLtk7FxiUIiuQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778161; c=relaxed/simple;
	bh=rpNPFE563X+9Vos/BdlKrdpP0VFKMK2owR6pW39AkXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I92TWY42Anovcu9YdXx6uSPmEWp+f3T1NKGBVhstF8irkwBO7zABoPX7tbWV+O4NPtPmYLoEwou9SjFpKlIkPjENFPsZ9pdd0RTGF6uA5cLHETTXhyejq2ZOixzsf315s8Ax+FyQX5hd6weHszV4GwYzVy2q6Bb23F4XhPnPEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QbhZpL2R; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QbhZpL2R"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430da09aa87so1427585ab.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761778159; x=1762382959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4po2tznXdxyJ/G/kvNn7UgWtNABss/kMGUQJ/b3bdA=;
        b=QbhZpL2Rp23l1Gkhpkq+ewaIh7tH3K1wZWbj2ll2I4960HlWcQCen4yDWvwRVIDYCW
         0BXzYRp/VJGDbxnl04S1UFHDu3PeEsHoJCWMRBjkUHI87ZNghDCzBrIUwHT9I2jqlG4D
         8z59GYVu2Q1r3afBARmo1v1oPzXEp64p9ssmXDlOtoNF2t01DshXew0soQwbSQ6ZwGNK
         7JszdburluPOvtcRUX+zl/XPRsKhJirRJcLXD5Oy4PEjWZTMXPCF+JBmBpL9tagCnmVm
         vBE2PH44/Q6lncnXmztyCot1AAly5cjTZOvStTdVLrntLtCxP3BeRdNuz/va2erM5Mwm
         /JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778159; x=1762382959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4po2tznXdxyJ/G/kvNn7UgWtNABss/kMGUQJ/b3bdA=;
        b=MFEgxoyKGHIcf3EHbPY84m50WOtZFRDgDmgUZ3iJRS04xXVv7yIX25LG/i6O11JHp2
         pS/bGNjlIpPM/r7BoSb3KrU21xfiqquoSLWbVCPGoE6aMG7hEXKr6YT2P/toThfO/Fuc
         xmaDRCkzmgMspE7DqaSvVCscgGddRrdMn5r0nwRtZik3PmNX3UdjqR4epL8dvb5AQHLY
         5qGDRhM5/3sCDv9afOtPQAFjTR0B8nI/wNVZDPYIunKl1B9Bk567kuzm8zBKsRhuHmVz
         NYhKiltLTDYZp/Xkfl8vHh8clR4ctKReSNLHzxCvup4GlnMo64u2SYgX+LyJE40g80FV
         L//Q==
X-Gm-Message-State: AOJu0YwbcaZD+vuOVU6M++5uM8X1LdPfIAg4iKxQ/uLxjZolpd2FUeaE
	lOkDTcP0PCY1U3AQEXpAH73B8QTFUDJVnugoDkBu7VkoPc67+1xzhOU9pvucD93nSmY=
X-Gm-Gg: ASbGncvH41y6xQXGmUYb4X5LwYdVRK1ey97H7L8tEDqoJqlwMa1NzP/H/2Q2+JwviHY
	tyAfdno0RsVDXi8C3oV7FvUv41Rcu9o+HSiCiIKGLUhAhDmfDgS3SSAB0K2shYqVm0RgC5KrqB4
	Y8PZ4ob2JNrJiHpjXCBoK4uYz+bRa3owDjefpySEsUgvkoIhmIyrBfFquT+Hh5L72TM55j24DxS
	//C42ZImAPBBXQVacU0zWHIk1H5c4XG9mlV/bCD0wVBnAxGbVQut81o/50yMNUSPm1cAZyYiVjk
	QPGdp6J+pA/07k4uBVLmPseVZhG5Z+mPz6K40m3xY88IyLuBhWngJxWIqMCsPY1CEHwnhgIddoE
	j0DFeuY5AaSbueawEVDsKSQB11tWbXA+E9CJCJhF5dcLMEM+IPElnx4LWHQmLmtl8N164Os/QuB
	IMktUipzZCh+vm0saFnKLHpcDYVpsMnUD0b5uFsgK7BBWznLHt7Rog72Y2NFhXIficgRIk7LkOd
	9BdJJU=
X-Google-Smtp-Source: AGHT+IGsHxMnWjy13sKvvTdq0iL/saZZckZIhwM/hIh5WQ6hFEttcplFpjg3foKPannwQFxtejQ3JA==
X-Received: by 2002:a05:6e02:3303:b0:42e:72ee:cde6 with SMTP id e9e14a558f8ab-432f8fad6eemr73354965ab.12.1761778158896;
        Wed, 29 Oct 2025 15:49:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-431f689a0c0sm61774285ab.35.2025.10.29.15.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:49:18 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:49:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] packfile: fix approximation of object counts
Message-ID: <aQKZ7FW925zvscgh@nand.local>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-4-1a3b82030a7a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-4-1a3b82030a7a@pks.im>

On Tue, Oct 28, 2025 at 12:08:34PM +0100, Patrick Steinhardt wrote:
> None of these are really game-changing. But it's nice to fix those
> issues regardless.

Well explained, thank you.

> While at it, convert the code to use `repo_for_each_pack()`.
> Furthermore, use `odb_prepare_alternates()` instead of explicitly
> preparing the packfile store. We really only want to prepare the object
> database sources, and `get_multi_pack_index()` already knows to prepare
> the packfile store for us.
>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 6aa2ca8ac9e..6722c3b2b88 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1143,16 +1143,16 @@ unsigned long repo_approximate_object_count(struct repository *r)
>  		unsigned long count = 0;
>  		struct packed_git *p;
>
> -		packfile_store_prepare(r->objects->packfiles);
> +		odb_prepare_alternates(r->objects);

I was wondering how this worked, since odb_prepare_alternates() does not
eagerly load the packs belonging to a MIDX, but get_multi_pack_index()
does, so this makes sense.

(Writing this out, I realized that you wrote this as the last sentence
in your patch, which is helpful and I think worth doing.)

>  		for (source = r->objects->sources; source; source = source->next) {
>  			struct multi_pack_index *m = get_multi_pack_index(source);
>  			if (m)
> -				count += m->num_objects;
> +				count += m->num_objects + m->num_objects_in_base;

Oops. This fix is definitely right, thanks for spotting and fixing it.

As a general aside, I expect that we're going to find some more of
these. I tried my best to audit all the places where we use
m->num_objects and m->num_packs, but without having great infrastructure
that encourages the use of MIDX chains, most of this code is all dead
anyway.

Hopefully soon we will see some more usage of MIDX chains with the
incremental repacking work that I've been sending patches for recently.
I'm sure that will flush out more of these issues.

> -		for (p = r->objects->packfiles->packs; p; p = p->next) {
> -			if (open_pack_index(p))
> +		repo_for_each_pack(r, p) {
> +			if (open_pack_index(p) || p->multi_pack_index)

Do we care about opening the pack index if we already accounted for it
via the MIDX path above? My guess is not, so I would probably suggest
writing this conditional as:

    if (p->multi_pack_index || open_pack_index(p))
        continue;

to avoid loading pack indexes unless we have to.

Thanks,
Taylor
