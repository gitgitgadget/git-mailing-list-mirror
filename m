Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C172FF14A
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939081; cv=none; b=FU+nmUWLu1DO3zQSxz43ONnszEj2a2PJXhrjc2jBrxO/f5vy0WGUbbobJsBXZ0qQZvLGLaSJ1T5Jqp0TCmPdoPNRv/aNrFKKpZw8pnqvqMj4op6QhlaWorypmoAvgRtOloEQqXSvzsLwWOZuxRG72tebcKfYp42KS2B5B151AHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939081; c=relaxed/simple;
	bh=cgTnfTTZPBlx9oLej2+y68bBC3xZFW2Fk6jrxV+RNBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4burevvChmmN4uEjADJL3wtplPfnaYa0SdbpQiGU6fjQCfZpP1rx4aVzuibcXS6PwsothdwKDIN2Ntg2nSkeTOi5zh942WdhgQ1G9eg4Rbl1nR9Z5Ld2zKeDZl+uSMxl21XDr7VUjEfcKyj7+Jao9yBkDEUhgapnY5PNIQJfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ2kvEp7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ2kvEp7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26488308cf5so9153265ad.0
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 05:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757939079; x=1758543879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgCINZodKHpgbOPlScq7MTu6EwQK3JAI8sb5JHEWFhE=;
        b=AZ2kvEp7bC9u/rPPptFzq6hrukvFhyUQb1UZ8ksYfQEeb6g5ginSj54Jvmyh24ID6R
         n3FuyH7cga6J54HheLnCnVncrh4W4cPyZoe+7J0+OqoT5FaZ5q8IKc0k0uw+hZqCii+c
         042lCYJXhY+rJbjH/D16oe56TmnGM3Ab/0qE3i2hMgCAuUZe94jzCpEwTo68vcPwfRCp
         C0n9ljbHaf92Kfeiero1mqSuJkvSw8pNBGrHiTzk3ZGxS9opslnNmZyAdCKZqybRrA56
         UIVW+I6DjOIq5totMiNK3rX4hoxWmp75hqlAhe5SFE/aHAuz5090F462glykjkT7jhzM
         oYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939079; x=1758543879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgCINZodKHpgbOPlScq7MTu6EwQK3JAI8sb5JHEWFhE=;
        b=cFEAGPSSajsVa4d9o4QR4XPvbQ/Od+pofXaOT07MomB9b36UoX67X4CCtb823PViNS
         T009UvlYflOoFxs5N8PKcRXQS86Gu1ikf7IjCg5ZwQxt8yNhB3y8+Zwpbk0ikfD5GAKy
         hoB4aVc1IjFXiUZ9ouSsjWbCQs/yU1inuQeqnjv6rJwg64OsRR10OOUIOe/1z+QZF7nC
         sEMR0WdqkhQIlXA1a8NjjuxH9Dfuus1jkBAMqRF/K4bNfp4VdOc6g+inpF7MU+j83WTd
         PzQ4BN9xGP4LiKk6DRAeI3GpA4kKWcw7ckyqhC8LxCxMr3s38qH1L7kBlpYuHmQf5rXi
         ASOw==
X-Gm-Message-State: AOJu0YyRXRvrD7aPxdd5y2rXPzReIsNfzMIaV5EW/JN1PDhOaZj9zMd9
	MZyAFkqZYjj206nYPxiTPigPADaRBrnFf56ZfYdYYr4MiUM8fSh9MIUZZ93uew==
X-Gm-Gg: ASbGncuJETl1IXsBrsAqTXX2e5jvkMld1caWwetMZ0BHI5400AJlbke1h85od5t4Ygg
	xikfHJQV5K+1cKNJfXztpMJJwu0LlItu3tv05kNBLSbG0L9+TXoHfCqt5eMhKoYbOB+kgKrVO7W
	jfr6v+hF7AvQVwN1Em0bzL/YTH6fiSJEr8BAHFoehP1rSck1sIFqNngASC65c2El15/LlempXer
	pBAy3aobrLirQtj3CMac7z6P7FPSSZ/kaLBdxQ20USjP6FMyb83vQJFD51L5KiGBTsZvTm24+jV
	ORQKDIIfvEl+6yi1F4ZzijqlBhIjHhl6pZJe8NummOj0aAY6bnYHe+1W5oTF4GDpF6FI02y+vbd
	igUSV53eGNqN2Fk6uEKUJt32L3wmLcOJqmRfrtQs=
X-Google-Smtp-Source: AGHT+IHravziYeLtbYMS5f6dZrFCObB9BaPNxCaeBYVEjKG0i/AFIr60SY+1BBgQcT4WENIzGENpDA==
X-Received: by 2002:a17:903:1d2:b0:264:f714:8dce with SMTP id d9443c01a7336-264f714a550mr61054425ad.36.1757939079295;
        Mon, 15 Sep 2025 05:24:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dd990e44esm14245209a91.28.2025.09.15.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:24:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:24:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aMgFjTqYRB4A9v_4@ArchLinux>
References: <aL21gazVeyHMeG-s@ArchLinux>
 <xmqqv7lsx4rb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7lsx4rb.fsf@gitster.g>

On Mon, Sep 08, 2025 at 09:56:08AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We would return negative index to indicate exact match by converting the
> > original positive index to be "-1 - index" in
> > "string_list_find_insert_index", which requires callers to decode this
> > information.
> >
> > This is bad due to the following reasons:
> >
> > 1. The callers need to convert the negative index back to the original
> >    positive value, which requires the callers to understand the detail
> >    of the function.
> 
> That has pretty much been the convention so far, not convincing that
> it is "bad" at all.
> 

Good point, I somehow like to use the words containing emotion, which is
not suitable. And after googling, I realize that this is the convention.

> > 2. As we have to return negative index, we need to specify the return
> >    type to be `int` instead of `size_t`, which would cause sign compare
> >    warnings.
> 
> That sounds more like the tail wagging the dog.
> 
> Construct your argument the other way around, perhaps?
> 
>  - We NEED to be able to use the full range of size_t to express the
>    index in the array string_list holds for SUCH AND SUCH REASONS.
>    But string_list_find_insert_index() uses "int", which may not be
>    large enough to cover the range size_t covers.
> 
>  - In addition, in order to signal that the returned value for a
>    query is about an existing entry in the array, or a location that
>    an entry would be inserted at, we use a signed int and use the
>    bog standard "-1 - index" encoding for this purpose.  This
>    further halves the range of valid array index.
> 
>  - To allow us to use the full range of size_t, use full size_t for
>    the index, and have a separate bit to tell if that index is about
>    an existing entry, or where the queried entry would be stored at
>    if we inserted it.
> 
> Your argument does not justify the first point, your desire to use
> size_t in the first place, and that is what makes it sound
> backwards, I think..

Thanks for the suggestion, I will improve this in the next version.

Thanks,
Jialuo
