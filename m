Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91181155C97
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848975; cv=none; b=OtYSdyc+U0+Etx21SggaTi7ZEX6Na2MtrI7oCmpEWIIkIbqFv2oUfX6Diu2QzRkHxRhp8JrojXnSkfWwr4FKtKfLEO1F+3nHj39/lwjhqGCWVzo+KXRc3SzAYJkGdSob4i8FeTc3AFsbnzMnfeSMJwuJLGcYv5bc6y4K0Id6Dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848975; c=relaxed/simple;
	bh=aBM+MSzCluRQSU+yrJCXju1/s2XLSvrCd+Gfns2spDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU26Nky4HqjsRHT0JAIhQVUkKNpZRgVMTsYphojAXJPLouuVG/rx9EUMNTqfThj7PV83S+DcICjJliK8BX4Paa09PEcYZHFOcLVjTyRqYRwsOKaCyTHjEGZABvXYqVgraLejFYOOH2Ywq7r7WgkIP3lx+PNCv3GUJfXhJrMbAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXHPR27y; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXHPR27y"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c76607b968so1842779a34.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765848971; x=1766453771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZg22tRM/+xKu1P20BqZtCq8nIEFwMlrHD43SlZQ8eY=;
        b=bXHPR27yodFbM61rxh2wj3FxUQq22AzDK+ft94fv53QjyClgbWbiX1c1/HeAQPnc+D
         NYoTO2IxezHHidE/Mt/LR3wGb6LW4vf/XakOVPmY4RQMk6jfpoJjUuYyFhbA/c7M574L
         NrCEV0WaSa8tVOh4HmIM8q0C6cbivR6pDVtqaDXVVp+vYfLadhRPGm+Ok322LI9szRRa
         zXslKyNmNDKH7f46OQSszmtBrb5W7xE6CQoZYTetVQIAeXq4eE43RudBAcBUQZzwe/PH
         rU0joZGhLCclJ213MfP4p4h5ySH8ejs0QLTssKe8FFeHGNy0vpy9tr3AVv42JgiJijoA
         qUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765848971; x=1766453771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZg22tRM/+xKu1P20BqZtCq8nIEFwMlrHD43SlZQ8eY=;
        b=qh84RmQW0rXJAwM6w16CGkm3PdbBVsh0K+NyyQXjSglHhAWXjiSBpccEfjxrbGObQV
         Dcaw/3aUgp2dFpcmNr3rqfl5e1nCeODPbotWOtZiWhhU7v4E7n6TIaUMq2XLHsZP7ygv
         bsdHKyJGywFUWD9Xbfg2OdUAf6VRgAfg7QhJy7c/c2vGv7VkYxq+Up1CYB+6aQr78ovb
         qplnlrJIquHSn4zKSlIK/IT7tztPaZaGw7maaO5/uIzxMrcMFUulXX/SorhV2AgBIzAB
         KvVV+eI3RTNlc30L+7ipOxqU2cbZ59sBbUMwI3ceD9iJLMQw/lHbnEsiwT25x4GY7uPX
         6ApQ==
X-Gm-Message-State: AOJu0YwcN9ArdnWAJ1+40Qak0dRsQcmSkj5z2I8UL7FFu4QIC0aYPTuP
	93h5y/Z8E0V1pcNNZ8OTuL/TioklwRB4nE/OWp5gBjd56A+kHNbdkO2O
X-Gm-Gg: AY/fxX4idFj8ZVPGl297IwFY0zuznRPF3U9pK/V3bfGcVuJntoy7h70vKhfKPv96rVE
	ChP+3uWQ7zlUN4ZGeOBSVPoeWHgOVoQLzv0e80fXYOjOKh5WiU8zLUvrumW85E9xBZ+UOF3S6TH
	TxaDffXuP2x3yVkMl3bhkweM3NfhyU10lywCpxKWrdEf25Ws5u51MbjcrPILtwYJBQ7hJGoZl9c
	qyWArXxL+0fr+2QNzL1JVhr5F4ICBhWx34wvOv5pHjuXyGuaKDhdK/kOek+Vtdu2Ku5X5N/lKjw
	wNes6gRfrCPJa38bHfYzbpUW6teW5wy7wJ61608J5N1Ehf0mxWzPwGD5yid7e2pvz74PFMWEBWm
	eP4ulclSkuVlKtfrqorGuxPWdW8ttO0DBgMLA7Mr7GeNPrHmr2SFjV2QdjO6f62kDo6JM89Twr1
	c8aAkV
X-Google-Smtp-Source: AGHT+IESwmKOQfLsoUhyNh1JOKNlNyxvuMj6T+b4v+wzcgokZAUnjpv0yAgmAA/dfzxtmTWI2BuQsw==
X-Received: by 2002:a05:6830:25c2:b0:7c9:5e2e:297d with SMTP id 46e09a7af769-7cae82ebc6fmr7387449a34.3.1765848971387;
        Mon, 15 Dec 2025 17:36:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb3261bfsm10351663a34.25.2025.12.15.17.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 17:36:11 -0800 (PST)
Date: Mon, 15 Dec 2025 19:36:10 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 2/7] strbuf: split out logic to humanise byte values
Message-ID: <lftfcdnv7cn6ajrkjiim3z2ympvlfmlvtfco3x2wwpknytorif@3uutxricxy5d>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
 <20251215205639.2700270-3-jltobler@gmail.com>
 <xmqqms3j5il1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms3j5il1.fsf@gitster.g>

On 25/12/16 10:19AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +		*value = xstrfmt(_("%u"), (unsigned)bytes);
> 
> Does this "%u" need translation?
> 
> I very much doubt it, but if it did, this does need TRANSLATORS
> comment.

Ya, I don't think one should be necessary. Will remove in the next
version.

I think I made the same mistake in humanise_count() in a later patch.
I'll also adjust it there.

> 
> > +		*unit = humanise_rate ?
> > +			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
> > +			       Q_("byte/s", "bytes/s", bytes) :
> > +			       /* TRANSLATORS: IEC 80000-13:2008 byte */
> > +			       Q_("byte", "bytes", bytes);
> >  	}
> >  }
> >  
> > +static void strbuf_humanise(struct strbuf *buf, off_t bytes, unsigned flags)
> > +{
> > +	char *value;
> > +	const char *unit;
> > +
> > +	humanise_bytes(bytes, &value, &unit, flags);
> > +	strbuf_addf(buf, _("%s %s"), value, unit);
> 
> This definitely needs the TRANSLATORS comment to tell what is going on.

Ok, will do in the next version. Thanks :)

-Justin
