Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1217C9A9
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726868555; cv=none; b=azhT/eIfQJzCd+X/alGTMva/Kr6cFcWfZUvjwOFMMSHpcXA5KeHze65Jopk9rogc391uyqB5WzyaFi4NymPSGhaoqp9sgfq5+jr2JnnKmyAhoz2ArwHZDZNpG0x80Nr+m3T8BOwZ9zD4MXfkPKzXHnSzVu78dYFS/psCJae4gTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726868555; c=relaxed/simple;
	bh=KCKZyC+c6cTqlDR2c+Z9UC1/X+UhmrHKLQydl6dzFK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9/kA/JiaSwb6J26LzoUOHZ374nhn1fcoHSS/ehD1peFBP8HI7ak4fCegLeKTuJGks/9MpWT64vLUGwwHsuEA84RIKADYL68PQzD6xwR+3nrG8uuW48izdVxAFUKspPWnu1ZFqs6hDsgYNyKwKQN7j/9/msSgtvNXEKqwzDLwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9/s/bSD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9/s/bSD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so21031475e9.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726868552; x=1727473352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pDYm7NTgVXdz1QWPZslK9XPwp6Ro605K/pEUw9MPME=;
        b=X9/s/bSDvCvcr6LYr4gPVTrqDagNks+exByS3vWYE9q/fVpAZNeE7nQaMUDpyuVGNF
         lwfSFA52diCI2Vt0om5N3J7KIDWcBQ1PZsO8VgA2qq/tOXsx15KijGPNiJpyC2B096d4
         GFdCIfY4U1l5bgYGE2biF1DNvkg2f+30RCRIHFmgtmvH7JFnvKW/fSlUiHiNrOw7Nomc
         hcQdT0X7VrrYZPtBAKDbL7KvH6/n9pxrjYUaFzQD1EpeZCSFe4mWIgRlfz/CJQdftn5O
         051Tlqigbwf/g+l7vJrFXTdpCi3ARq2LTPKqITXKmQMv5smx8FKJW52ApCjLgy7ZPssp
         P2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726868552; x=1727473352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pDYm7NTgVXdz1QWPZslK9XPwp6Ro605K/pEUw9MPME=;
        b=kwUAW6iZVA+OZymka5kys01Fq5ViDtd3OsyUoeGD4pSXMI8bORbXgarDHwEDNVZEq+
         2T+uh/8zR7eDvpk0YlqITW9iYRQMdFIIbUQiqi3L12CwI5w5e4+uintw1n/cZtX2+gKc
         UgXD8SOdGiQKNreXdO2Tzss1qH4cqAGCsBCL43pRexpDPX85QMFb+NYtqgHcmcQLNCnJ
         OXbe7XIuYxw+1jVUeM3NQ7Vs6QvEolz3e2KfC9vERn+3ms/VQRSwf0eTdyXn6AQUCHym
         AQblSu638MMV3YzwJxk11B3W1IUfNcStW0MBLcuyuAXAmT56kVMOOsFnLFUBSPWf1kaR
         CW8Q==
X-Gm-Message-State: AOJu0YwcWUJDfPN5IDRTJ2raSj5cVM27XCZO5vScbBsrg0hZumHOZNBK
	vRE9pvWwpZl9BMX+y3D+UTUE2Ov1lJ81ucPgWXFtCd6ims84F/Gr
X-Google-Smtp-Source: AGHT+IFzAJDAjnD1UxTp52uGS4iDfEcshbSyRVBxCbze0PTtQfngNYXh/rUXoufCRvgG5K1GnhiIxw==
X-Received: by 2002:a05:600c:4f0c:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-42e7abe140fmr32531505e9.2.1726868552125;
        Fri, 20 Sep 2024 14:42:32 -0700 (PDT)
Received: from void.void ([141.226.14.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ac7d315sm33800615e9.0.2024.09.20.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 14:42:31 -0700 (PDT)
Date: Sat, 21 Sep 2024 00:42:29 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation/technical: fix a typo
Message-ID: <Zu3sRbUM0z65kZsC@void.void>
References: <20240920082815.8192-1-algonell@gmail.com>
 <xmqqbk0if5jv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk0if5jv.fsf@gitster.g>

On Fri, Sep 20, 2024 at 01:12:20PM -0700, Junio C Hamano wrote:
> Andrew Kreimer <algonell@gmail.com> writes:
> 
> > Fix a typo in documentation.
> >
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > ---
> >  Documentation/technical/sparse-checkout.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
> > index fa0d01cbda..d968659354 100644
> > --- a/Documentation/technical/sparse-checkout.txt
> > +++ b/Documentation/technical/sparse-checkout.txt
> > @@ -287,7 +287,7 @@ everything behaves like a dense checkout with a few exceptions (e.g. branch
> >  checkouts and switches write fewer things, knowing the VFS will lazily
> >  write the rest on an as-needed basis).
> >  
> > -Since there is no publically available VFS-related code for folks to try,
> > +Since there is no publicly available VFS-related code for folks to try,
> 
> As a general rule, unless we are doing codewide sweep to use a
> single word in our glossary to refer to the same thing, or
> something, we should honor author's preference, when it is already
> written and it is not blatantly wrong.
> 
>   https://www.collinsdictionary.com/us/dictionary/english/publically
> 
> I am inclined to say that we should keep it as written, but I am not
> a native speaker, so please cite a source that tells what is written
> is blatantly wrong to help me accept this patch.
> 
> Thanks.

My bad!
