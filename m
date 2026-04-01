Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C73BED40
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058092; cv=none; b=XqsY/9uoPzkOtyuDP84mUvFN20KPj/66NncKPbWA4AAzhyF5ro+A8MBD/56a82NyarPr8o0zX1mo8twSaPpBORP2MlK0I8eNPi3/m+F8U3UtQFqmsEdCIKyzNlMFRkGPpLIpOjfWuac/hEj0m3LRzjCkfF+PQu496u4oFc1l4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058092; c=relaxed/simple;
	bh=jrtOMfnyM7c12koMcxs+yNUqj3mNPlRD673hD2fFo+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTlWDO1Ou878QuKgjfbbj4e80W4K0vVZPwV6E75YffDGHWaTOxcZcOiZ6+4jNKpX5moYwWS/A6IbtQe5BA+nFZ1lR+CJThNF7vUT08jJOA/RUy8iQpmUoTM3sRLSK39n+P1TFsKYdzRqgv2wzrP0EfjpUQ1+gA7SxMWDDchacW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hJ64G5VJ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hJ64G5VJ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d9bba96f7dso3746512a34.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1775058090; x=1775662890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu3O/RwhG9ROEttD4AUWfCdf8OFNWAOvWth5o2F9mx8=;
        b=hJ64G5VJ0fGFs1hbMesjBVVGi3rSSh+Emn2u2KbyTuckT23fvqUw4aUFDd7SUE5Kdu
         lJaiCpbAhoUyBc9RfLWgYm7HpVfc87aT4DoOwy84f9YleKafl0Lv2LfKsZcR+UwH9cOb
         1+zMdzcUySvzL7tBmTy7BXOEZxZdtIy23JIE30GExuiCa2UWP+qaa/S34fZLsUTImTQR
         nhHmI73QF/pGXlWX5S+lv4+o25hpOQo0krHqnIukzJRAlKhxSgFpikwcI/MFQz7PAp2l
         Xe3m2TxEvShgukbMuql6G3GxJF6FsjgTh06T3riL/J53tfbRvVmJxGiiyxkyBuGEuSrT
         Dqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058090; x=1775662890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu3O/RwhG9ROEttD4AUWfCdf8OFNWAOvWth5o2F9mx8=;
        b=alFxkq9d5J9DM5ldEoowD+InGKNrgB4DluXa16NJsTnWPd4ACqIqUCN4mDFu7pJHSp
         sGWJAh8SwdAstuP2XaxpfaI3gjzwc8iiLA5VR7qR4MMs7J/bq069hnK34rSaQk9Y/jT2
         ZV+brKrUXZigq3Td7uATpWVqYOwtlvADCN8Racbt54z1YElJ028gY2BaxzJUybL4F7wz
         kPR95CT9dlv4oFbwDo+cRSswyAXoQId6r7HggryCxLcW/OUD/TguWd5lIKUVrK+g2RVS
         ++GS9Cr6RqweDjsVJPyUyFl5O3yhcAvLgmQXhm3aw0jXvHm2FZO1MGSIUasxY99A/kw+
         62WA==
X-Gm-Message-State: AOJu0YxwO0oM/F+Is2rwbmwLRgEJjk/Uw+g/W1BfZTfkXSH/QqLCUS20
	c16ULRfqZbOQsckZaJ2MNshDBH3V/axFc5SGeG9LuxdZq/TTse4JZ3kxuYBef2/ebF4=
X-Gm-Gg: ATEYQzzqm1ICDBofeKV6OuMr1/AUkTh7EpadJG5zddAwx+Ryto1Xttif2Xn/Pz4Ioo2
	PajIVqUQMkaTP4TJQ/GShTCXs0+LCpMDpTOO0M/ZYcVqL0ASlwgaozHrM4uIP91GgQ42GwR0LRj
	mIPBZNlN6W4BQahnDIjvzgUNZzVPOSnuzYp4tdnbWy0L+K2Zid5FT5JZhxQi7re0L6j/+4Q4Eik
	6kiB0OYw7GGy9dufg7v6J0f3CDpgHa1E9KRGPzAk9JMQZWV10va9pXgkTYQCBtik/eKDbJxZzjQ
	+Ivt4CP/ASfojsENGN16bLGNHpIiNn/GeuWicaEaQuBbMbonC/oVlb8kNYZU+zz8GZRZvXi3gZV
	wE1cvThCH+iYfrD5R1WP+gT6yNmkMdWFgy6PetLBViU+dsxqsFtf05l3J1tGbsKYdB9VyTual7O
	Leci0e8jIbyW4Zz3EtO4mfdbF/71gKhBwNgRqD1vbXWFoDZ28BxMrnRZTFu7pSMBtQpwgE3EJ7C
	xTGlEhoq2mWm1emGgWGCR7aWL6S3sTbdEUfihuE
X-Received: by 2002:a05:6830:4c0b:b0:7d7:51af:4aa1 with SMTP id 46e09a7af769-7db993d7620mr2525155a34.18.1775058090606;
        Wed, 01 Apr 2026 08:41:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72fcb47sm105750a34.15.2026.04.01.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 08:41:30 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:41:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/16] midx: use `strvec` for `keep_hashes`
Message-ID: <ac08qYDcQ7z/2/bC@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <5fc72d5049a602ae5ede6bb243f44546f02d995d.1774820449.git.me@ttaylorr.com>
 <20260330230130.GD41843@coredump.intra.peff.net>
 <acxJ/NfLNloCv3o+@nand.local>
 <acxPyXnV8HtxtEHl@nand.local>
 <20260331231713.GA2325145@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331231713.GA2325145@coredump.intra.peff.net>

On Tue, Mar 31, 2026 at 07:17:13PM -0400, Jeff King wrote:
> > @@ -815,6 +817,9 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
> >  	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
> >  				     clear_midx_file_ext, &data);
> >
> > +	hashmap_for_each_entry((struct hashmap*)&data.keep.map, &iter, e, ent) {
> > +		free((void *)e->key);
> > +	}
> >  	strset_clear(&data.keep);
> >  }
> > --- >8 ---
> >
> > which is... pretty gross. I think we may be better off sticking with a
> > string_list for 'keep' here internally.
>
> Yeah, this is horrible, and this kind of "we own it, but only kind of
> and strdup_strings is not set" game has been the cause of many bugs on
> the string-list side.

Indeed ;-).

> Having a "nodup" variant is less awful, but still error prone and leads
> to complications. For example, if strset_add_nodup() sees a duplicate,
> what does it do with the input?
>
> So I would probably just either do:
>
>   for (...) {
> 	item = xstrfmt(...);
> 	strset_add(&set, item);
> 	free(item);
>   }
>
> or if you care about the extra allocation, then:
>
>   struct strbuf item = STRBUF_INIT;
>   for (...) {
> 	strbuf_reset(&item);
> 	strbuf_addf(&item, ...);
> 	strset_add(&set, item.buf);
>   }
>   strbuf_release(&item);

I think the latter of these two makes sense to me.

I'm not necessarily of the opinion that the strset API should *never*
have DUP/NODUP semantics like the string_list API does. But I do think
that we should punt on taking something like this up as long as
possible.

Thanks,
Taylor
