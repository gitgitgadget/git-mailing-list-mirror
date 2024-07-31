Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AC1BC4E
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469005; cv=none; b=TNNzz4mwPGaRr8F/AeDkRetNYbz9UN6jZJ84+a0jXXLfxrffR1at7uZpDwY5Oy5L1Gx3VFUhnmdofpYputeHBv1kYyiS0BTe20NG7nFKQP6O8VMyx3Di1QXpMkMCkCc0xFBOYmDcfFPV+X7vDRAB7/pzBPLz3iS8/AsTfU7vZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469005; c=relaxed/simple;
	bh=oYrPnxBEuWgHIJOFZWJYJR/YIB4PXPiXDUPSPWy5IBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/YufbVGcnKOHumhE+BtyJW5/BIkvYNn6uW5gyNzvLhgsjcQdQIhCNzpUE1VzuZG3ZRwymrAB77t6tEG5u45h85Wnl0v7LiS4/v0V/+k23RjX1C6MHsKE2ySwT0unEcKy4rgtV/vWk69tSPnXqCc2FfFSKv1xW5RJDqz01RDd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ubaR4Ydi; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ubaR4Ydi"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d067d5bbso402866185a.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722469003; x=1723073803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVVGSS9DDc5yzsPTVaVQXS3kSqB7RNSANoEZt/gUth0=;
        b=ubaR4YdiPdMYqBjECJIOioHTMMyS61bFgbFYSSMgEqToUnYuR+SvdpBXzajvbfLGB9
         oI6l1hedZ4BBZDvNATcOINhtlHon3aE9tNjqJruihJDYlmRBWsGgMxW7si0ob7jIonrb
         FuO91/wrRqBtwTEoFDNzo64rwUdX+lZkT6ytFYorfEs5KDFaa/nra5DE1NJY4OzHFoWw
         5cYl9XTctTtuWmiT0dyDYbzLbW79rTHBKN0g4YlhInY0RT+d/pfu0wY8Ez3vRM7SXZhO
         vDwg/9FYONpSHGgWpN9x1ZsfewMCvzVTZ1KSgXGozlEM2+ZHDmTUF5fgUtvjMGAS9Zu4
         KkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722469003; x=1723073803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVVGSS9DDc5yzsPTVaVQXS3kSqB7RNSANoEZt/gUth0=;
        b=haaqJUhrxiMQnHoeg81hr07EBitzoyHuJaudTJUZraX8sBUVxmo1OiiJv/NkKZjPyE
         uQJNwwr60L/X/QHDjMdExY0cojt3Js4jB5M/5UA5LrRAsDwPCx4UgCBtRN2roI1nUlYu
         X+IAAFg9A5DVhUVm5aMuWTQjcZCA0+hLGCSNPCOGSldDZR6nVlIzFeBvC2Z2savmKNAF
         9Tu1xff50wLoS7G4pgUCkPMry77SOLbDQ0Z/9cQh2Dlycuj1RSIxL+e2DKsSU7rvWJpR
         XEUgh4qng3vj0fIEXOu5ddaRecHWktXtuqwXiD9jveArZwgVJiQ7p/TzP9lb04GbMfp2
         lSuA==
X-Forwarded-Encrypted: i=1; AJvYcCXDga5mPJB/cIZb4qh5EBdmLPy7n7Mv3zIh0Xu44vl0BcLMKKiAfFUOnI3myrbDSwPUxWTb9dIbDlrk78kxHK0IfoOi
X-Gm-Message-State: AOJu0YzhthQTm77thU+q6AkJF9uzQ9lyFwPGDnc6VcCStT0Hg5HJMKDp
	50vTDY8H9rS9bqpdLCCEPS0cO6+4Vvjv1zMtb4w0phXvbJgIPRogC78Wc88/IPo=
X-Google-Smtp-Source: AGHT+IFFlQ1zo0tTrHac2DFt4lLCWWYtQGBZ7Pcy7otEQ4s+ZObj3RNmqJLE4w7O+/N1sY9sMtr55Q==
X-Received: by 2002:a05:620a:424a:b0:79e:fed9:7943 with SMTP id af79cd13be357-7a30c70fb3bmr86093385a.61.1722469002779;
        Wed, 31 Jul 2024 16:36:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1e93765afsm565072085a.113.2024.07.31.16.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 16:36:42 -0700 (PDT)
Date: Wed, 31 Jul 2024 19:36:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Han Jiang <jhcarl0814@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Subject: Re: git config set --file, key-value pair without '= value', gives
 Segmentation fault
Message-ID: <ZqrKeG+alFldB7OY@nand.local>
References: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>
 <ZqqucpNgqSgZDPtA@nand.local>
 <xmqq5xslyyaf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xslyyaf.fsf@gitster.g>

On Wed, Jul 31, 2024 at 03:47:04PM -0700, Junio C Hamano wrote:
> I would have actually expected the fix that follow your analysis (by
> the way, I found it really well done) would say something more like
>
> 	if (strcmp(key, store->key))
> 		return 0; /* not ours */
> +	if (!value)
> +		value = "true";
> 	if (store->fixed_value)
> 		return !strcmp(store->fixed_value, value);
>
> but I am not sure exactly how we want to handle synonymous Boolean
> values here.  Regardless of how "true" value is spelled in the
> configuration file, e.g.
>
>         [section]               [section]
>                 key                     key = true
>
> I wonder if "git config set --value=yes [--fixed-value] section.key
> false" should replace either of them to false.

I think it gets tricky when we talk about the implicit true value
here for exactly that reason. Do we take true to mean just "true"? Or
"true" and "yes", "1", "", and so on?

I tried to match the behavior a few lines down in that function, where
we only call regexec() if value is non-NULL.

> It would especially true if the command is invoked with --type=bool
> but it seems that the --type option does not participate in the
> matching with the current value.

I think I could be convinced that --type=bool should treat "", "true",
"1", "on", and so on as matching here, but I'm not sure.

> > I'd like to hear from Stolee (CC'd), who is the author of c90702a1f6
> > before submitting this as a standalone patch.

Thanks,
Taylor
