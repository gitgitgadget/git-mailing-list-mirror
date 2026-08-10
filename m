Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296643745E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389023; cv=none; b=dVnvRn6O97DchvGNzFSyLKurKqUl8OwIYklvKZuUyuy8S5f9zPaDdPl8uJK3jz6xNiMV3axRTUgzsG9u8X1l/g2u26mlS7+/MeQk0DLkLGpjHWNXy2XHrWjdzFzT3iGeGhWj9ksdoMvab2CC72P7kIVWQ0EkXt/MzJ/ILM5nioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389023; c=relaxed/simple;
	bh=EwmIYftjzyU9BpBxl37RLJBTSw0+EWLAfplUJVNjQFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuxxzmkjKl4VZ+btRCXKUM8Ovo83i8vDpTkFGFRmtb5x70xSwEozNFhyDwvy3M3Tl9aXBcZUG2Dvbq0iGKGrT70bukzIIaVj07nlHV88EGzaS6HmxLqg5Pvk5xnqh8D61fOXhshCk9phbcb+BiLakoWdr0/WERMhNkVuD0jcP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7EElhbz; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7EElhbz"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acc15016f1so1299273eaf.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786389016; x=1786993816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Klu8tNdOgplhvhIlopYeIScf3PHOFOK6AY161afHvrw=;
        b=a7EElhbzA5XcnXRq5tFJlXubnf0lJ3iFPeezexh6Yhyh3nTpWDMsC8wudu7mNufIkJ
         lzVfRKT5KSRPHTgBMTcuqzvaOo9YwA0a42Dm2AW3IqUKymQbUgQ6fkcc9V//N4oSXN8X
         pJilX/z4rMiyvvhKgYRQ5SzR8+/CJ2hsz0LbLkkUgwxJ/MlA9d2VnnD496AAmR52hJrm
         tmboXoC49yOhMaDWYjfr5GFej8M4das0qi0AUwhH5DqzOqae+gM7e36mBwX08P6Xu0g9
         Fhce1Lrc2PTZoLdXHDXK54UgqA3IoAZEAhcwNsjpZCnWU3Yyz0W/2gO9dmhLRbblOJsD
         javg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389016; x=1786993816;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Klu8tNdOgplhvhIlopYeIScf3PHOFOK6AY161afHvrw=;
        b=OxL74J1wWrO8DGqBgIGdAWsXoiy0kQvUi/XOGjCHSLjN2V4zS+AGeKDP54PBT13nGq
         2txvOnUBCEEHoTdPd7yNgnt5aTH50af24xSLw5EViahLSRs9m5jXHxBEcUI5qZtkwJre
         R5pegeekvg1W9cwD8S+ZdR99mmQzL3TtFbL4mFpecU19zgBt/nIv+GhwFhXsshzLoXYR
         VasHYG3cFYxkYASWOCQCxPC1CXMDsDV5dlCNR7H5KymLPSMdXncoDWR5ZG9LlOJ965GN
         Z0IxG7Hfcxd7AIbXrC3W7MZkQnYmaYNNvRu9I2rt+sQ7Y+51GQcMYRPuPeSLu5dIfyEr
         MwgA==
X-Gm-Message-State: AOJu0Yyx72fdmvWehZ8DnO39GirhOm1/7Wj5vYvK3KpQGVyVaH3GVzOL
	qkqeICEJyuuY3u7NfNmRLrOYDowUE/69gwTQY/JyoH2qDYrMx/S0+OcnO6nN9w==
X-Gm-Gg: AR+sD13zxPRxBgX2RXVsf1ppyZVaT7JG9E0FVLhmn2oIsTYYLU/F6g0UyIbUvr4ESl0
	cCx9U8YdP3fWlKnq15AKbwT9StEDX9ALWiu/lJ/U0CZP9ZvWArBVPYOV2smwFtGrZT+XRs7Zqf5
	q5H34du+Dwtaj7HBFQHUMhQgoXlk+6K8Yk4mO088nu5kl2nhfD16HCplli5GkbEiMzEp50hkYx5
	DSTJz7WqqpK1GDo56RXOtJhULxy72AYnwdLZx526sJtmcKEZHlgqK/PXej/sLOoummpxm6kcr9R
	cjxBE8dV8Pk0UxUxBsHwE1ywaq8Mp71MrL+oxkZVfjVaAPFpq/uW6vnC/OKvqj0q36idtQgJWRG
	c8i5eVIssi+MCFzYSUo8ckfOFAdSs+xR2QFQYMfdn0itA/L8ne52be411fXEpdzq540cPHSD1wU
	yHreeeT00Ls5CozMcXCRMzWZcHgzkWYptWhYzu1jRBBeKeIbJyrA2q8xaZUhkAptzo
X-Received: by 2002:a05:6820:1628:b0:6ac:aa4c:5d93 with SMTP id 006d021491bc7-6b0909f1041mr1761181eaf.36.1786389016477;
        Mon, 10 Aug 2026 12:10:16 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc2631esm10382779eaf.4.2026.08.10.12.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:10:16 -0700 (PDT)
Date: Mon, 10 Aug 2026 14:10:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 1/7] odb/transaction: add transaction finalize
 interface
Message-ID: <ann3abcyJD0KwuHx@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
 <20260809190106.1565882-2-jltobler@gmail.com>
 <xmqq33wm8x20.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33wm8x20.fsf@gitster.g>

On 26/08/09 08:38PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > diff --git a/builtin/add.c b/builtin/add.c
> > index 60ffbede2b..501e114ed5 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -393,7 +393,7 @@ int cmd_add(int argc,
> >  	char *seen = NULL;
> >  	char *ps_matched = NULL;
> >  	struct lock_file lock_file = LOCK_INIT;
> > -	struct odb_transaction *transaction;
> > +	struct odb_transaction *transaction = NULL;
> >  
> >  	repo_config(repo, add_config, NULL);
> >  
> > @@ -610,5 +610,6 @@ int cmd_add(int argc,
> >  	free(ps_matched);
> >  	dir_clear(&dir);
> >  	clear_pathspec(&pathspec);
> > +	odb_transaction_finalize(transaction);
> >  	return exit_status;
> >  }
> 
> There is only one non-local exit between transation-begin and
> transaction-finalize, which is a call ot report_path_error()
> followed by exit(128).  Will _finalize() stay to be just freeing
> memory and nothing else?  It may be conceptually cleaner to jump to
> the bottom to make sure the clean-up sequence will always happen.

In practice, only call sites that invoke `odb_transaction_write_pack()`
(only git-receive-pack(1) for now) actually need to be concerned about
any deferred clean up outside of just freeing some memory. Conceptually
this is a bit messy though and callers shouldn't ideally have to be
aware of such specifics.

It may make sense to align the clean-up as you suggested above. I will
explore in the next version.

> The same comment applies to other codepaths to which this patch adds
> _finalize() calls.
> 
> > diff --git a/odb/transaction.c b/odb/transaction.c
> > index dab7da6a9a..9e9a982778 100644
> > --- a/odb/transaction.c
> > +++ b/odb/transaction.c
> > @@ -33,6 +33,20 @@ int odb_transaction_commit(struct odb_transaction *transaction)
> >  
> >  	ret = transaction->commit(transaction);
> >  	transaction->source->odb->transaction = NULL;
> > +
> > +	return ret;
> > +}
> > +
> > +int odb_transaction_finalize(struct odb_transaction *transaction)
> > +{
> 
> Curiously no callers added by this patch checks the return value
> of this function.  Intended or just sloppy?  If the former, perhaps
> this wants to return void instead?

In version 1 I did keep `odb_transaction_finalize()` void, but decided
to at least provide the option for callers to check for errors if they
wished. The existing callers don't, but there isn't a reason most of the
couldn't be more strict here. In the next version, similar to
`odb_transaction_begin_or_die()`, I may add an
`odb_transaction_finalize_or_die()` helper and adapt some of the
existing callers.

> The same can be said for _commit(), by the way.

There is one `odb_transaction_commit()` caller in
"builtin/receive-pack.c" that does check for errors, but ya all other
callers simply ignore them. For the same reasons mentioned above, I
opted to follow the existing behavior of ignoring temporary directory
related errors, but include error reporting as part of the interface in
case callers wanted to check. I could also add an
`odb_transaction_commit_or_die()` helper here too and adapt callers
where it is reasonable to be more strict.

-Justin
