Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA324A33
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760806; cv=none; b=DTye8E/bM0yUxK0D6HVL6C9vPskIadLOk04HwoBsbgXK+I3fzGuVIkZCdYJ01O8TiLhQPG4GNU9gFe43imPzlGn6CparFaBvx0HuzEIUehO0bkyhiplWM0VOYfs4mIokEJuhkDbs5XE0voiGc1tWooHEk+i88/krpi8HUPna3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760806; c=relaxed/simple;
	bh=hquW2u3f/M1mKTprHY1IAFGZ+ejWCTl86n0WwCcJtmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD+9M9JDaX6Eu89T5Y7ersYUpqXxxbt3VkxIuOWwaO7TZ1pPNQqArLQu0zDUbZ3PpK0QbrMf8vKmBJR8HMqzqP+di/FAl5N+jdXRt1DUHjcnKQgOy6pJODqZ+0YLk4szKf+SB3tDPJGsLQUOrYKUGcKNmulUzlw8FDieTyctCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOpHYRBD; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOpHYRBD"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9c7e8eb21so1494577a34.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760804; x=1783365604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6Yekzi0baGCcsbQX2BVLol4EfH3lUldNSr5pAgjHwo=;
        b=UOpHYRBDCaBLTED1+spTpm7p+Q3rx2l/Ez0PO/56T6TELDKvzd2Q/R+EVMS+g/ji2A
         tFgcSDx2Ck9l2cYR3Km7PGodO02s+KkoZZMKCLlaFYZ/gpriAtD+sGzJTvKBd5TsfB1g
         4LPHQ0fKcbPyEn0QjksIaGi4dfQEOlYUgeN8amWXvzaz4CFr4Vb+2I/oeo4zoWmddqMe
         rhhF0oHm9j8CPtaRweCkYduYTbnXgf4I4U1PzwNSp1vJzQKumOHSNA3HgKXYfwpNZTbz
         p4oq+/oQgrFg4b9EpVw35UOY4G/bwGktZNsZy9cmejnd6yUbTTY0652dX3XPRg6c4hqD
         B3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760804; x=1783365604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6Yekzi0baGCcsbQX2BVLol4EfH3lUldNSr5pAgjHwo=;
        b=VawYxCwIGbpISyaTM9k+loBOL1vB4ChLJQEETJ+t9ZkhKo4t6JfBGUz2D/HU79A2Rg
         haHkFzl4ZqfNhKzWSl98ssviXDJ4Xxcv3OIAToEaSUhwyClStldEUuie4YhS1P0PzjiU
         YvqbZfOd/Q0q5adNVydwgW+eUvrMRKGHSwj5OZsY05PiBC/SEP14+LYp+Zy4PnaEcvll
         j1jHpSVAxJF9IREM8yoa18kv9UDa0Qtct+rs+jqerVUujVXwFaC3SheNZ3ofQykTLMEb
         A9iYifzW4zaiW/G9Q6i31ml8AGcHcL0Lvz8959ZW9g3jSNyAXctanQ1nldtEnzcAfJgN
         3yeg==
X-Gm-Message-State: AOJu0YzvDwkFgBpUCYS6Y14Xt3R9jR7cDveScXK2xm17Pag7cw2W8MZT
	Gw7bO1IUAxZcOR4FanZIfjQD4tJ7EQR8t9NMyjOrUP6Z/awqFzAsu1TSJpaEEA==
X-Gm-Gg: AfdE7cnFFgRgbOOIVzBf6LIsr1dm2n9PiRFnRttz7XnUeP5RSnVKMzBeVJhWO/XoQKk
	oMBsdmu6JiZBxG2cjRbaSalm2NahWTV6sTejuBVdnI3VVNDn4yumlxCcJQHGjxsMYBdIiK92YC7
	3HbBgfjgTmPWktZMqZi32t4nFv3aET6CYaZqTSspv6X2SWJm+kQi7K5YFosmGk+gh+16Mh/BJ6O
	71tv3NVwXxsakWJ6UMLVxdX4H2MafdwsU3xmQ43OtK3nA78TrgVRryz+Yem/E9BmPCVh1sgLBBS
	eZ2jikUWrQlNfUSDhWk5witt2Da1THI4CVUssCQWCIr9/Xta/egQLJ8g9ObYhtUjSyyDPXpCfYV
	CP1Wc9VTKVGKDX47pZOhLwrqi9U4+O/KcjlIt3whWCd12FyF567PQHGg0Y+MA655GsY55ovqSJ7
	2y82NFaw==
X-Received: by 2002:a05:6820:1384:b0:6a0:b54b:a1ef with SMTP id 006d021491bc7-6a189058db2mr660585eaf.11.1782760804082;
        Mon, 29 Jun 2026 12:20:04 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a189428fcasm425886eaf.11.2026.06.29.12.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:20:03 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:20:03 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] odb/transaction: add transaction env interface
Message-ID: <akLE1DhWGaOWhvQ4@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-6-jltobler@gmail.com>
 <aju-_Nf3kmoIidue@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju-_Nf3kmoIidue@pks.im>

On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> On Tue, Jun 23, 2026 at 11:19:19PM -0500, Justin Tobler wrote:
> > The ODB transaction backend is responsible for creating/managing its own
> > staging area for writing objects. Other child processes spawned by Git
> > may need to access to uncommitted objects or write new objects in the
> 
> s/may need to access to/may need access to/

Will fix.

> > staging area though.
> > 
> > Introduce `odb_transaction_env()` which is expected to provide the set
> > of environment variables needed by a child process to access the
> > transaction staging area.
> 
> Possessive s is missing, I think.

Yes. :)

[snip]
> > +
> > +	/*
> > +	 * This callback is expected to return a NULL-terminated array of
> > +	 * environment variables that a child process should inherit so
> > +	 * that its object writes participate in the transaction. The
> > +	 * returned array is owned by the backend and remains valid until
> > +	 * the transaction ends. May return NULL when the backend does not
> > +	 * need to expose any state to child processes.
> > +	 */
> > +	const char **(*env)(struct odb_transaction *transaction);
> 
> Would it make more sense to adapt this function so that:
> 
>   - It receives a `struct strvec` as input that the environment
>     variables are to be amended to.
> 
>   - It returns a normal error code to indicate errors?

Ya, that is probably a more sensible interface as it would be nice to be
able to signal an error. Will do in the next version.

Thanks,
-Justin
