Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF824A929
	for <git@vger.kernel.org>; Mon, 20 May 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244431; cv=none; b=AFNGsJHU21UWDw0Ol87xVGeCfxZAk5p1t3mXySm6igD7m6H12dJBbLtnkAUrSDHs3V3QX3Bj3QrBsnE9pPrdFh3PX2PKs3PUCDIjQ7oBDacdMvX1pHQAx6QwAZITdioyJ3d+nT1gXh6Yr6YtqAtxDKs0kmjF85qxqOopJdbt7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244431; c=relaxed/simple;
	bh=YoC4ZC0h0WYejRdqCK05d1nkjh1LO8YSx7f6uPLzfJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls+fF0I59x+BnB9gqwq5iisKD+ye0578GfXlFcwa/Ge9APtYqqZv3pdUhEFNFqYDeqBKp/ngMZNd5gXQZFcsM2ta1seuc1z8kjRmuRbN7zbrdfXafRp6VmRaS9s3jInT9OhBlWEnmyIBcwp9eBzpEp45Va7kIndaoIfKTiu0MM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmMS8n4j; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmMS8n4j"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so2500112f8f.2
        for <git@vger.kernel.org>; Mon, 20 May 2024 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716244428; x=1716849228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goDkkyABeIiPHMgA+X0/BA6pn86PKg/T2g5+tZ4PFCo=;
        b=SmMS8n4j+BrwctrwRQesliD/v7TFcVaQ+OuQx1GrzVNXgQ27C1JZduoyA7j5B9nF0R
         k+O2QL8gXsjkKrkWV9ELp1uCio/TisDQdmmMo3tQ461TC4IBhQCLulnLKj0UKr+bGgVb
         w99YJncDq54clVVZC18WN9T+JOPECG7KqLln3DtJljXTFrolHriUz5WEI7EzDlsNA0hY
         UgbKoYRfe7TFtt7JJtZnYRawqQABfxUNuKPwqt8UZFiXVV2R1G5ZH+rMRwbQrVQbXJAG
         EA/WLTuKZb8MlugmsRIp795CWdNJYbsAFgS7ZkBeOX83yTdcO++ncB9YLdOqNVz8YvqG
         bCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716244428; x=1716849228;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goDkkyABeIiPHMgA+X0/BA6pn86PKg/T2g5+tZ4PFCo=;
        b=IrjjXg8YMPGm4ndV5t0cm+EgFd/58bdPABGbxhfAoBc5g5bju1jnGRc2or3c41wAlM
         pOtNqXFZe2c+Uf4MECMgWg0GjJz0Gj+D+2YSYGWwp/DLlyEDpgDdl34jFK7rNVTs9UNQ
         WNAJ6nQXfip0BWHSWRif0LcBQ98Hw9r2gxPXfga8rjkRonlA6RiRCJ1t5g2k0vsZss7L
         nlO9tprPX6oaF+1IbRUfrGyaUtit3zULdVzl24J6HPyWXCbh2drGJffnbFrI3+AKuR31
         JU0X80fWxK8B8M6iSXc+2xWgqVxK/bpY38HufhJipnVfMRDh8jpASFRSMck5gefGRlxl
         Ds7A==
X-Gm-Message-State: AOJu0Yx1kS7xNzYP3kCmVRUxN/uZRiPRVamPh9IEo7GST2a1xfQS0G2g
	Jw+QakB03uUFJTirjdPJb4sDdOAr+usgp3LV9nAaMRLtyJjjZyZ6KIqLaw==
X-Google-Smtp-Source: AGHT+IHK42+dsAddm6SSKfAOmPFdRh0N2Y/aVRce6/66h2Q6mgh9saxvfNKGVqvK31ODanFc9iAPlg==
X-Received: by 2002:adf:ed8d:0:b0:34d:8bc0:3f5a with SMTP id ffacd0b85a97d-3504a206d19mr22133193f8f.0.1716244427882;
        Mon, 20 May 2024 15:33:47 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bdc7sm30111409f8f.22.2024.05.20.15.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 15:33:47 -0700 (PDT)
Message-ID: <a9f199d8-bb06-479f-88c2-63d80338a4e9@gmail.com>
Date: Tue, 21 May 2024 00:33:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <80f15223-246e-4cfb-a139-e47af829c938@gmail.com> <xmqqo790fg8z.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqo790fg8z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, May 20, 2024 at 12:14:04PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > We send errors to the pager since 61b80509e3 (sending errors to stdout
> > under $PAGER, 2008-02-16).
> >
> > In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
> > 2008-12-15) an exception was introduced to avoid redirecting stderr if
> > it is not connected to a terminal.
> >
> > In such exceptional cases, the close(STDERR_FILENO) we're doing in
> > close_pager_fds, is unnecessary.
> 
> 
> > Furthermore, in a subsequent commit we're going to introduce changes
> > that might call close_pager_fds multiple times.  With this in mind,
> > unconditionally closing stderr will become undesirable.
> 
> In a new world with such a change, what does it mean to call
> close_pager_fds()?

There is no change in what calling close_pager_fds() means.

> It used to mean "we are really done with the
> pager and we no longer need them, ever".
> 
> And we still call the helper for that purpose after this change,
> from wait_for_pager_atexit() and wait_for_pager_signal().

Yes, no change here either.  In the next commit, a new client of the
helper is introduced, the new API: wait_for_pager().

> 
> So no matter what "a subsequent commit" does, it feels conceptually
> wrong to call it more than once in the first place.
> In other words,
> what is wrong is that this function closes stderr, but "a subsequent
> commit" calls this function multiple times, no?

This series is trying to allow triggering the pager multiple times.
Reaching to close_pager_fds() multiple times is a consequence of it.

> 
> >  static struct child_process pager_process;
> >  static const char *pager_program;
> > +static int old_fd2 = -1;
> 
> What does the magic number "-1" mean?

Invalid fd.

> We often use it to signal
> "uninitialized", but then what are concrete "initialized" values
> mean?  "We dup2()'ed something else to stderr/fd #2 but before doing
> so we saved the original fd #2 away to this variable, so that we can
> restore fd #2 by another dup2() of the value of this variable when
> we declare that we are done with the standard error stream"?
> 
> But that does not look like what is happening here.
> 
> >  /* Is the value coming back from term_columns() just a guess? */
> >  static int term_columns_guessed;
> > @@ -23,7 +24,8 @@ static void close_pager_fds(void)
> >  {
> >  	/* signal EOF to pager */
> >  	close(1);
> > -	close(2);
> > +	if (old_fd2 != -1)
> > +		close(2);
> >  }
> >  
> >  static void wait_for_pager_atexit(void)
> > @@ -141,8 +143,10 @@ void setup_pager(void)
> >  
> >  	/* original process continues, but writes to the pipe */
> >  	dup2(pager_process.in, 1);
> > -	if (isatty(2))
> > +	if (isatty(2)) {
> > +		old_fd2 = 1;
> 
> Equally unclear magic number "1" is used here.
> 
> This value is different from pager_process.in, and my earlier "we
> are saving away" does not apply, either.

It applies, in 3/5.

> 
> >  		dup2(pager_process.in, 2);
> > +	}
> >  	close(pager_process.in);
> 
> Puzzled...

Thanks for reading the series.
