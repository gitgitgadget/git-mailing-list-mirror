Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E414388E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538640; cv=none; b=SnQ4pL90bXMFk/U2msRwriZdVJrzDPTBwrAASnoG70yBOc/fVVsRiX57mnaF81Bv3S/bOgLaJwrEo5kVIygup8OP5B2RrU1/ZmRjOfWva870B88yRNnNwTV8iYoLXBwMFLgGwfH+ZKkOyDoFRiBxaS545cZ3BNyWyGpB49NoDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538640; c=relaxed/simple;
	bh=2kO0mH95Vh+FlcawSFf7nDj39wfkoRRb4QkY2ebEZNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty4u1oywjmCisytXUqZcSrZbOu3ZBrFh6GI23O318wUwDlifPo4LoUjaircQxGNmOHDEsGQrRMRsV1frwDbcSQE9HNoki+FABmH6P5lz1A8+rT1LPIQgUpc80EfcxwmNqZB3J9i17QgqwC1kSHVuLAvKtx8nv94RGxV9F11eVrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j0jKM1pT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j0jKM1pT"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso6092210276.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722538638; x=1723143438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oa/qwXESJEuKhjVB7LbxDfjoGJimXKAn1IGNTn/LYAU=;
        b=j0jKM1pTx4tWZy95JvILWCCMLxQXgY3reibTzXzFxQFuF1oT04dDCFE0lGtYgx4J7j
         GhUjSoCbDBJzXcFeAtwOpNdqGex09DkxbmtCihyUa/v+1gR+cl93qynIWw9ssPaMBYmD
         LaRcjEXEdw0AzMydxTX0LYtsqxZOybXtTnZaieU3Rg3U8Vo2LNK0lrfAgU+PdWqZl8vP
         m4Y73DsEOuLC1Vuq7M2860i1isXJfnho+0t8mYC1ulzNkRwxR/7JNgZw7tb6gAyi9Z7T
         RmWZOLloUxaiyxl81XrzB11EF8JU9++elwI9N09KuZPxsJPvkb+jxJmvhY46BVk2jroW
         VrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538638; x=1723143438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa/qwXESJEuKhjVB7LbxDfjoGJimXKAn1IGNTn/LYAU=;
        b=MIj3cfKBIxmot1b/AJKc74PQMOO7YqmBtD27xT/cfu1jY/r3XhVIP3b6kspiHWvF1x
         N8SHZTA7WlXR8N9X2WntrmQjvaFM6UYqWejHv5amo1wJDXEKdUPGgFwUQR1I+yh035lm
         /bsIQmNGZs6ZPWia4f1qs+TEk27FCDo3RpKi5LjaImfqdCdfuBH3KdZykv47O4y19RF3
         26wN2zC8/Nq/sSeX/Q8h3a0ucCKUV4I1Gi6eVDsvMSU8DoxuTOPqkAaw940Fp98eLd4u
         JfesDtq2wLSzaVYTO5gG6olLBx2yfxGa5ZXJ4fdSLrazmrV8szXDGMyhX+YdFX+RJvRN
         YXxQ==
X-Gm-Message-State: AOJu0YwDw/XxC0MTzfPN3LIZBqNqEp6kSw+kHmwkjtLnpXDHkRLbt53o
	7OgZ1Bf7AWNjl8USVfpdL5HbQQZCKqRWOnEn00GbD2wug8YgTQAFtGOe1I4rg+U=
X-Google-Smtp-Source: AGHT+IEWfWdc/97uUpS+8BKKp0q3/wVdbxND9nwO+DC7CluUCjUc5hCcsIzNpax87q0SnnJ4Yb9xKw==
X-Received: by 2002:a25:9342:0:b0:e08:6f3d:3a41 with SMTP id 3f1490d57ef6-e0bde21a820mr1273262276.8.1722538638209;
        Thu, 01 Aug 2024 11:57:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be0fd5847sm43144276.54.2024.08.01.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:57:17 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:57:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/19] midx: teach `nth_midxed_pack_int_id()` about
 incremental MIDXs
Message-ID: <ZqvajDLI6Rc6KXMX@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <f449a72877de97d89e31a56724b4f65be2f33f20.1721250704.git.me@ttaylorr.com>
 <20240801093006.GC1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801093006.GC1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 05:30:06AM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 05:12:04PM -0400, Taylor Blau wrote:
>
> > [^1]: As a reminder, this means that the object is identified among the
> >   objects contained in all layers of the incremental MIDX chain, not any
> >   particular layer. For example, consider MIDX chain with two individual
> >   MIDXs, one with 4 objects and another with 3 objects. If the MIDX with
> >   4 objects appears earlier in the chain, then asking for pack "6" would
> >   return the second object in the MIDX with 3 objects.
>
> I think this is "object 6" in the final sentence?

Oops, yes. Thanks for spotting, this was as easy as s/pack/object on the
second to last line in the paragraph quoted above.

> OK, so now this function translates a global position into a local one,
> and then we get the pack id for the local midx/pos, and then turn it
> back into a global pack id.
>
> That all makes sense, but you definitely have to read carefully to make
> sure which positions/ids are global within the chain and which are local
> to a midx.

Exactly.

Thanks,
Taylor
