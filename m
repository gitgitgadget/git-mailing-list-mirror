Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9928373
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270034; cv=none; b=FWqEBFCbZIkdKl6NpqFYIMunU2OdW2jtyT6HHB7c2CttmCGgWCbPED3Zh3UTypswa4K+jjZuZSv3hIYZeKenAqsyCHMQdAF4CLSPjCHhxpPjLSDBrhhlSRDMCmzM0yW992LNTnhk1+jas3Ww7F9wRvo0xzM7mTcqEuMfSimvG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270034; c=relaxed/simple;
	bh=A5Xg0E9eldLmTSVFml4lnHp2htJymVzABUbYa1zDtgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTi9Xo7euGhoFPBS1bNlDY8qI+UvV9qHGLAnRV8RgMyOczeIpCpdqFg28Kcjvx/2/HO3p9xQWCsNkit5gwPJlU3XbG5EjGb5NqljTciHEHTcYL/e8lG8rCtO8JtE+MSQ8/u4pR49M4OduDlaswQOo8G1sej1SYiM8+dQPIo0l74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrkCTpVv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrkCTpVv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2347d505445so3861265ad.2
        for <git@vger.kernel.org>; Mon, 26 May 2025 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748270032; x=1748874832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PJbmjTwRkwfPmeg8pi1+LBNHVGmCG1g9wkJh2pS4e0=;
        b=HrkCTpVvPasA043VCM57Qzun1Utxpx3e9thBB5I3ViDnOappNscy5VRupLHc+kSXLJ
         A5b4Tdb0MRDEaOLHq3XHZ8av5staKt1VUZWwkjQ+SzJfn5oEMhYSMP2Bl6Q5FKET7HEg
         gAl5v0nvuz7AU3Ih+Uw9eLSc6VoLqZStxtdbJxzik2dBoS9HsqoLPA3CAjr5jWw7uk7v
         MWpPcE3QCniriLT0Q5uUKBa4onGv5iEQ07bjkpFX2wPQU0JZQEg6g5SOWcNG+YjXRgAm
         3TetghuuOvIsAFsyyg+DQUVTe6nJx/EkYYGc8DM/AXWBLOUzr4WbcQ9mTd5w3++KLIrO
         vgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748270032; x=1748874832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PJbmjTwRkwfPmeg8pi1+LBNHVGmCG1g9wkJh2pS4e0=;
        b=QMwc3uft1VFMv6aV8bXA1NIFyvo7FcQhpdvu4kmpEiy5joJG9zj+LSqQdYQuwGts7u
         8Qp3WEsKdER3AwOPwUQD3pUkhcept/ski8atSV6ogq87gKfhsGqT6iFBWHEk/kCaqepw
         jB3rLsnWVhhbTM5oEobF0s6IIy5rCBj2jieqXSt35yEZmRXTk3KuzJaQAg5iilOJJanU
         /0ypHHibrZQt9BOUy3A94fHkFtzcCeAJA+puqcPgY5ONDXAL80PDhcKHXH1aJyT7H8jd
         Oodamtd+TPbAKbx+2Uwqz6LnGRMRpLk6tE6TWz2wzOFVsL3hJBP+BxQykTlTxxbxaBoC
         Ar+w==
X-Gm-Message-State: AOJu0Yw4cnOapTomkcxD4iFEjAUe9+4MRh4r7Bg53Rf6sySn4DdSYSn/
	OuG+JGM92aALNZBbDK2wwu2YRvYtHIwfx0v7aVR5ZEnX/ewTEP1GlqV0S6uTUrGN
X-Gm-Gg: ASbGncv9az1ej6IgWVwLEEYZ95GtEnJrDJDFEgnkCT8Jw0PgUgpLMhQMgcRfCvQkesu
	hMT8gbYvx2ZZDR5v6eI9QdL8e9RBfVhoGW9zHcrQ4pBfU88raRQmLOTQE2em0hGs1bLU6HXqZfM
	MX1xsu+tuPjpYXo0omGalsvNzdaM2f++OJstLw+MJYYmxPhirHrLSRfKnSG8XLOGcbthW1XGLgS
	8y7MMfaAJDf1OKAwq7m1JC+z0fvAvOq1V9R7v+F5/Tc6RkDFsbNxGa2JJbs+DgUTg1NLX5tGE0f
	SMAoywmwmrJ/B50JbgGbk1iLCgpvLZElGcVOqO/KFML3RlQ=
X-Google-Smtp-Source: AGHT+IEhswIxJd6ulubOx/QDkyhPjp8RhYNxqa5oxS1Lvm/ChlQGZjtAlVoVR664AdfHxNbhaEHAmg==
X-Received: by 2002:a17:902:efcb:b0:234:748c:50e3 with SMTP id d9443c01a7336-234748c5152mr42065925ad.22.1748270032417;
        Mon, 26 May 2025 07:33:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23401ad400asm50568495ad.68.2025.05.26.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:33:51 -0700 (PDT)
Date: Mon, 26 May 2025 22:33:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] u-string-list: move "filter string" test to
 "u-string-list.c"
Message-ID: <aDR71ftk0KJVTA62@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDkaAyxRGgYMJZ@ArchLinux>
 <aCrbLoElTJJq6jwZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCrbLoElTJJq6jwZ@pks.im>

On Mon, May 19, 2025 at 09:18:06AM +0200, Patrick Steinhardt wrote:
> On Sun, May 18, 2025 at 11:58:09PM +0800, shejialuo wrote:
> > diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> > index e4b8e38fb8..be2bb5f103 100644
> > --- a/t/unit-tests/u-string-list.c
> > +++ b/t/unit-tests/u-string-list.c
> > @@ -103,3 +115,57 @@ void test_string_list__split_in_place(void)
> >  
> >  	t_string_list_clear(&list, 0);
> >  }
> > +
> > +static int prefix_cb(struct string_list_item *item, void *cb_data)
> > +{
> > +	const char *prefix = (const char *)cb_data;
> > +	return starts_with(item->string, prefix);
> > +}
> > +
> > +static void t_string_list_filter(struct string_list *list,
> > +				 string_list_each_func_t want, void *cb_data, ...)
> > +{
> > +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> > +	va_list ap;
> > +
> > +	va_start(ap, cb_data);
> > +	t_vcreate_string_list_dup(&expected_strings, 0, ap);
> > +	va_end(ap);
> > +
> > +	filter_string_list(list, 0, want, cb_data);
> > +	t_string_list_equal(list, &expected_strings);
> > +
> > +	string_list_clear(&expected_strings, 0);
> > +}
> > +
> > +void test_string_list__filter(void)
> > +{
> > +	struct string_list list = STRING_LIST_INIT_DUP;
> > +	const char *prefix = "y";
> > +
> > +	t_create_string_list_dup(&list, 0, NULL);
> 
> Okay, here we have to manually create a list because you cannot pass two
> vararg lists to `t_string_list_filter()`. It's not the prettiest and
> feels a bit repetitive, but the alternatives I can think of aren't a lot
> nicer, either.
> 

Yes, I am not very satisfied with this either. In the original shell
script test, it uses "string_list_split" to create a new "string-list".
However, this way is worse than the current, too hacky.

> > +	t_string_list_filter(&list, prefix_cb, (void*)prefix, NULL);
> 
> Both the `prefix_cb` and `prefix` are the same across all function
> calls, so I wondered whether we might want to move them into the
> wrapper function directly.
> 

What if we want to use the different "prefix_cb" and "prefix"? I somehow
think we should make "t_string_list_filter" more flexible.

> The `void *` casts are also all unnecessary.
> 

Right, I will improve this in the next version.

> Patrick
