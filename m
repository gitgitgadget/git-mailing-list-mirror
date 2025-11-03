Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6F32142F
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193011; cv=none; b=HXwh2RJX+jSznCs+RXgjnA3tqsGX2AmtlpULZmIRQ/iis5vOYCs5InEShI2MtRN+sJbmYuvUTw0p8pVaIi2J8WcUSpMX6HYhFtTb0zgN3c/rjUWDnh3SF1Rr4HqCctDE4RgpURYcfyHP7GCa16oylI9/V0TAysty/OWy1O+Efo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193011; c=relaxed/simple;
	bh=+T31xdPJ+fXXuRblo9clRTDV91ckLm+2cjI7EWCo+bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DszJpBPaMJ48JedL5DKzhssqr1XdBHJdZyFWX5eRG2qQzpiDLcBm7jIeszFWYzOPfhcrVv93bswV7l3DzbgAgUTUH6H/K1C23ikukpDuN4DiFixg93kR5uSnmPfWQpCLLXvY2K5fliaE84KiuiI89GMBhvb2h7mZ8NBizxP6SZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3nC2I2p; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3nC2I2p"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c281c649ccso3263605a34.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762193008; x=1762797808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1KYyMn4GmxcsWbsuywJCRk4cZtkh6rN78XXq/7fcfk=;
        b=J3nC2I2pgRt2+aqKBmXmEIXWF+H0o24JDxI7pipJu1QTH6O4yzxmlZg6m/hG3aFLJE
         qKbNm0GfNwOUZR0rydkN163ub3FplSv4FkbLxUP6fDNnU+nV7mWGsAUdqzpmi4aulovX
         64mzLfNwB5/ebYFjcofHdEdl142mlvoINhXpsi8PUyVl/KQq+/ukHlAbEzVHDqA2Plqw
         GolwSr4X4U54P/iv9klbWpI4plUBA7t4pcooq/sNi4cCHrtCBw54lXvNU6BfLXHXDG4L
         8UnLWOyE4HGdf8Fi9Ww9QuXdb3KAYanccFNbtH7F5AWhqdWXkFQHwF6vtDZXYUvT/gLT
         GRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193008; x=1762797808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1KYyMn4GmxcsWbsuywJCRk4cZtkh6rN78XXq/7fcfk=;
        b=tbeS7UugEViLdgIxAkJcVOBU95ckfgdHBHx8cD9OLIEcChXNVY5AEfmmuu0VrdVBZt
         zcZlqz4s/sMhoH7cNgFluPUbt+ijZ8ru73uN8naCYXfCEH5dkEvT1dnWFpqeLittQUHd
         pctBk7oMnPBRD4MdT43xvZr3ERFd5Z3shbpYeA1dy7LLWk5r90GF+fkEPIx9KFVIUEuZ
         5N6OtYv1nmS8zZZeF9aIreJAA6mJyXV2RzuyZw7sZhzRRYsQhe4htcI0W5CjLCDvX8cf
         nLuDZ2CXgTTd9GlAVjjqqNcv/Mr/a6JqvgiDyM+WZALlzM5vBzDztRPiaqgM8PI1gasw
         Ywww==
X-Gm-Message-State: AOJu0YxoXsgID774NBrpi+/MNGC9iKVKojzUTKIxwh4RgEmIOeGy5t14
	bIpL4aunT0/0JcolBgSNlWYCpSF3B1gisnl6JX2dfo9fZn9VAImoN//IOlkO1g==
X-Gm-Gg: ASbGncsND7IVjbJ52uh9Mas+SYqxIUIAFCJcnvaUyTQqNRr1eEI+aLFYQBbLXO07Iqv
	wInnnW5oW8ogtlbjF2/tZ54msusouyVDh95ABDnP7dZsBQ/nE8P/ijUMo7tM4PHuv85usjrNp1l
	M624gSq13vt13udtXZwaG3N5DBZYoKaUUgzc5OQkDHPzHld2BT/LEGGHL+LRwikCpzfYy8R1TXc
	s4eaogQCOqnPXT1koPURDO9F3rIHM8Vfi/jQ4sGm99h4pApZpAx7Y5Axrimog524SrBVipnZ3Fr
	EpvzLYb5bgEIcVSfYgeqdRHLWkTY3hYmnncpQ4vX3OsS10+v0ayO0uAdNo6ooB7r1nwkryjKVZ+
	6ioTxw3PKm7sSjeeUFUrIv6crOUTwg5cDeV02p6aWg16919FRSy7gJRvr6cc/opPbn6VCooDBLu
	Hh/21GddlR57Poh5Y=
X-Google-Smtp-Source: AGHT+IH0MXuUhvELKqRQsqrx2NJMhTeNUfdACXG0lmihIGcFZrc1s44Xo4BC5LuY70i9Do7l4L+27w==
X-Received: by 2002:a05:6808:3204:b0:442:39a:7bc3 with SMTP id 5614622812f47-44f9600963dmr6027744b6e.59.1762193008234;
        Mon, 03 Nov 2025 10:03:28 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44fd888363asm234846b6e.19.2025.11.03.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:03:27 -0800 (PST)
Date: Mon, 3 Nov 2025 12:03:27 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] reftable/stack: return stack segments directly
Message-ID: <2nr5ig2cg5bc2zvtinm4p2fxssuim5kb4bsflrx3xnos2pwkk3@tya7zuj4pgg6>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
 <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-1-a03d53e28d0e@gmail.com>
 <7gjrsjgi32akawqwcamzil2rblqelfvgmrxmgef5ssrslntmc6@43cra6zhledc>
 <CAOLa=ZQa21A+fF=ukZMmx3zu1DrMFU-EcZGrZConS-L16+ih1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQa21A+fF=ukZMmx3zu1DrMFU-EcZGrZConS-L16+ih1A@mail.gmail.com>

On 25/11/03 07:05AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> [snip]
> 
> >>
> >>  	if (segment_size(&seg) > 0)
> >>  		return stack_compact_range(st, seg.start, seg.end - 1,
> >
> > Do we expect the errors returned by `stack_segments_for_compaction()` to
> > always be negative? If so, I wonder if we should also have it return the
> > number of tables in the segment. That way it could also handle the
> > followup `segment_size()`.
> >
> 
> Currently yes, since all 'REFTABLE_<error>' errors return negative
> value. But I must say I'm not a fan of combining errors and values
> together in a single return. This only creates confusion.
> 
> I'm not sure removing `segment_size()` is also a good idea, because it
> describes what the check is. Otherwise we're looking at something like:
> 
> @@ -1655,11 +1646,10 @@ int reftable_stack_auto_compact(struct
> reftable_stack *st)
>  	if (st->merged->tables_len < 2)
>  		return 0;
> 
> -	err = stack_segments_for_compaction(st, &seg);
> -	if (err)
> +	err_or_stack_size = stack_segments_for_compaction(st, &seg);
> +	if (err_or_stack_size < 0)
>  		return err;
> -
> -	if (segment_size(&seg) > 0)
> +	else if (err_or_stack_size > 0)
>  		return stack_compact_range(st, seg.start, seg.end - 1,
>  					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
> 
> I'm not sure that this would be better? Or am I missing something?

That's fair. I was thinking that we could just make
`stack_segments_for_compaction()` responsible for the boolean check of
whether compaction is required or not. It's probably not worth
overloading the return value though.

-Justin
