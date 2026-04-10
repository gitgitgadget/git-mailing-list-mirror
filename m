Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42463DD504
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838895; cv=none; b=thKcAqL3t1ju2PCa8CLoA+2RNsJOnYPmibxhruAkmPznpgss6390wXTNGqwO0joSI37p5xPfT98CtaEscp6unGrayA9UFPJX4Hlop/r1eaUu88jXhD5I/KDxTbK1bJBy7tfZxKAo+ot8aIxotENh98a+zverJ/9MqLai/5e+4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838895; c=relaxed/simple;
	bh=Y2On639K/Z2rUTIrISjwzc2heiCU1XQ0yCIxg36rYu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDA7TxahDMZ0B0hd4Fy0YiE7A9hCN+l9Z5+D1MzDzZjoSa2AnAJaU9uRmu1b2cEENWsP8zvqhtLqYhMoH6pTMwvYH0XGa59UrOYUYIeC3V5cdFytzuNSBUHgqR006+S3OMim4GgxeIEIxh+O50HRqHlvchePzDsGc4na+HO7Wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlqgzYAC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlqgzYAC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488971db0fdso22411515e9.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775838892; x=1776443692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWY0snVOVA0bXiik50BwskPjaqMOEqoxcrI6AxID1Mw=;
        b=hlqgzYAC0IYjzLP7YcxhGaHCPavgBDv+wEc9xt78u22mEkZwS34uojFbFpn04nEsq0
         HZJv2Bz6gv9+p94xvwSxxyLwm4dpouwH22SkWGdffDjZ7MkCTCQf80Ve8Nfv02ap0G9h
         Vp/WxGLMamD2mH9nxdxLKNsUewDGI2UZg9CAVWIfq63yf5fU1fpgT8+SzMINPMryBUom
         VfZxoTaK5UnH8KZHaXUxxkgG77/PwDOIgJr+tIuoW9Fp++wCa03LmM3o2v05CHmdaXZk
         GLfupX6QkkUL29jdR4CXn4hKWvRfwbzOZP7VFmY0eRwmOf6vWDQl0EhrkbRTqS35lsNA
         4ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838892; x=1776443692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWY0snVOVA0bXiik50BwskPjaqMOEqoxcrI6AxID1Mw=;
        b=hk2qKwinyisrxDHtgh6YWHDxctRFHXk5IcKTkysZW1F74zcskIUZPEY4uKdML/uh6h
         V0V7ftwev2FFDVXnOVl2bEZNCI9cTJoCpKmRxXLFmur4PlNdG9lwlfervcJxsB/wFnjY
         PqG4E0Hd0Z0xNtJc3rEqEjsf8AhiRN5gM6VPRfc9Nj6y9AiKa9d/DB5nUHsm3c5siZYW
         a8aMxwqUi/0hB1E/25M37bC23ClHypDIXVb6d42cb4kREZ/+Wz8WO7QiiPC0O8PnW0q0
         M/YHax52Y9LCB6AG1Y5UHa8jaKi68YnS5zSNSVgrszo2EHy0eipoR4OOQke47Y47PY3V
         IWzw==
X-Gm-Message-State: AOJu0YxVjxSNG3k/h5qZ8tsHSsN6G9QFyF2WmvpWdyrIVz/k/OF7L5iJ
	0LsQnRnVP7NoGfH1bt9EtjxTYjkCysF6AKvczxs64RzhDZzCWDGoSCsn
X-Gm-Gg: AeBDievdrbmqwmK/aj21MMMf/rXyvund5GF0aMB13HJa4OSW77HyaPTL76in8Q+iQeZ
	V1y+t170B3U5b99JXHHk2eFm00jfByRfOUeo9SwGfz6G57Uj+Ywbbi6NjXAkVovy8CgO/NqK3e+
	rBSIelGW/Z2iHW5TXSlCnD/vLJBw+GfWZ6g60SRZw3ipzSuUnkL4zcNBBSiUgveKNQ94xGQDKSk
	1Et5ctqlsVhWIJCgGjD86QSNmqp6k227dbpjTrzf9F+yC4KhoNqXvBO9vglxmNeuN5D4gmEetMh
	lmjVh0HUtIVGRjq63BSc64x2aV0ocjbUH8djDDy33AZYH1M5ym/TpHSG0fB95cLtKLdvFQTlAwQ
	8EG4JZeaYWViQIo2wZ9kg3Isb9Wq5zNjow3mW9awzmA9hU29VpX+jrsuqYBxXnsI2UIMUujFR/c
	vqH/Ynyc7sCd9h7RHxjEtVnTZf+leaGYWaLeJ01tkwCyX+uAOzReDwl7Oblgw6Q0ccqpE/hH8LB
	SfuP7qdLPdP03rc6nQ=
X-Received: by 2002:a05:600c:46d0:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-488d689dbfcmr49041605e9.30.1775838891647;
        Fri, 10 Apr 2026 09:34:51 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3d4dbsm82339325e9.14.2026.04.10.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:34:51 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:34:49 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <adkmqcOYrHaBqok_@lorenzo-VM>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <xmqqo6jqpzxv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6jqpzxv.fsf@gitster.g>

On Fri, Apr 10, 2026 at 09:01:16AM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > +			/* If <time> doesn't exist, retrieve it and add it to line */
> > +			if (line_sections.nr < 3)
> > +				strbuf_addf(&line, " %lld", (long long int)source_stat.st_mtim.tv_sec);
> 
> It should be easy to see in the output of
> 
> 	$ git grep -e '%lld' -e 'st_mtim\.tv_sec'
> 
> that we do not use these constructs.
> 
> Write it like this instead
> 
> 				strbuf_addf(&line, " %" PRItime,
> 					    (timestamp_t)source_stat.st_mtime);
> 
> examples to mimick the uses of timestamp_t and PRItime are found in
> many places; worktree.c, date.c, builtin/blame.c would give plenty.

Oh I see. I really need to get into this mechanism of constantly using
`git grep` to look for examples for pretty much everything. Still
learning. Thanks Junio!

Lorenzo
