Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95ED4A0C
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112379; cv=none; b=cF+oUNZexfWdDOAVzTs7sg1Fx7jYiuMhJ2bIIBXol/Z/h/vEsEYLa+1XZU+hJyZw0YpbXYglBZ1HmQ7lSNLQT9pfW0q6cG+GRLttWSMlKtwAuoNXr7IL5zGjCDoWcSRKxk1VgjYwMGwzkdvI2BZ9tcNnscxZLw/rHeHEZWtX93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112379; c=relaxed/simple;
	bh=sXf/POKeqB1DJEzZgTp1rNQ/PXmjaRKw0I268FHcn3U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MVeVdCBUZ+x8dU4amt+pVWfMgS8JZxxfDsbgQmJb4yPFw9J639x5R/eoThryylKM61nBbRwlKHli32re2TatVXtSX/MxrumSeWk3UHq/9VLZ9ypRvtUY8PZaMAwwurhktU69lha8/2f6nLmVAtJWMnJR0su9Xb1ixYzLUMCWZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0bcnPRe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0bcnPRe"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3934128b3a.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750112377; x=1750717177; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/Oe/mZsRXALHkfzgaKoifQP51U/v8BY9U7xNs3mYPY=;
        b=d0bcnPReCfctgIfpJ2MI4nUH1wBVQTgiMY8sj+i9zXy2Na2klCJWg6VlUaxoGWZ8XO
         +wnVT1l0KvkV/xYAEFrPSCGglUEPXyZv6AjTNIJ7MP8LC7MIHv+Z9EqlfM+wAR2oqO/F
         W5U5OrjWepPLU5oMk/PBonYLf+M68JV31xrNdHrp+yqfdakwCagU9zEQSFYCnAmFFdnE
         EjtHVa1ApuNJBHyxR82LAvxWjmwJlCjqb535RjTgOkvL6kFPzU5fM7y7Wo9lgd31eYP1
         RMNunpsncmc9wWj8rPIcW1wjVHPdnTXnXUEsZZjgceTXoo17aUcjq2V8hZTaq6IG9cvL
         ImKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750112377; x=1750717177;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/Oe/mZsRXALHkfzgaKoifQP51U/v8BY9U7xNs3mYPY=;
        b=sKvBauZG/z7i2rWfN/sfsIWDLs3MfiJueDy6VS2GVDYJiMCBAX9t4Xv6FKRQC+I+HZ
         KicO939H6xOeB0/qkoCeGorWdmPxc2r5bFnr+oZrb7cbWjEQ6fUUhulP4sypgpY/qsos
         KV8abW/eZ14cOz6KnJtat+H+8kDvf7fEJLP1oY/iq+fvfPHDEZ4QIRG2Ak6CuSscTsCJ
         Jfaoc1+mT6YoPUsN3jsMRuTlbx5u56/Y/rMGQbaTRupKGDFvRIe6Xr1XZVDNW5f5NCHJ
         NIqGiUh7LJFtYFt4HkffSppVHDS00+m8YQtpY0usW5kdi/j0hxc3+Rsg9T/8wu85STBP
         u2Eg==
X-Gm-Message-State: AOJu0YyM3yqhVzlu/pG7zwvb8qH1nFITUmUjkdWGIB/e6W/TC9v2/Y4W
	F9+vemvkPoFjECm4eOFN2YbY0lrn0kANiU9jfxRNt1cEayOqR+PQ+lg/
X-Gm-Gg: ASbGncsr1FMda3k1bxIbdQABbsk8T+Wuh1EgWWjoz5mhi/slMVYgysqAYnMHEM5ZDad
	mbXd7Iz3RivOj4bQjEyBvExq9CmQ0mYy2iiTLgxekxKMyUK83Wl50haqxE/lCxe1gK41B4/jaUf
	q8gNiNejam043QY5j9gXH43VT3+QtoQPJi005xnu4VVYogNg8wEnBxlhnWDKO4HViZ/ihv1GhIE
	A+OJ+4IuqluHRHBoffd6dkhEofO5tTNDcBarfnnacYC6jPp2+3TkiDrXfqELnKHMrhZrjpEsuq/
	otd2lPA45OWLCkoTiZY2/wfNsKFZ7uhP1EhCbCLkpI3R0Dlre1BF/w3G6Ri8NcPL6sqDyCJgF8g
	arxijSB9EwRYp
X-Google-Smtp-Source: AGHT+IH/ugxLJAFCuoDhmahMibVal0uwxPDTOMf8uQa3+cDEtb+S7pokac39T/ydl1wmUURz1hdvuQ==
X-Received: by 2002:a05:6a20:7343:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-21fbd4c7e63mr15420108637.10.1750112377078;
        Mon, 16 Jun 2025 15:19:37 -0700 (PDT)
Received: from smtpclient.apple ([177.76.102.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489000531esm7378347b3a.41.2025.06.16.15.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jun 2025 15:19:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq4iwkd68p.fsf@gitster.g>
Date: Mon, 16 Jun 2025 19:19:23 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <C339DA52-F88A-4BC6-98DD-1586A1B4A175@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <xmqqikl3mtx2.fsf@gitster.g> <2EB72983-BA77-47C3-9331-B08760B092C4@gmail.com>
 <xmqq4iwkd68p.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Let's learn from our earlier mistakes and do it right in the
> new incarnation.

Ok, fair!

> 1. In text mode, the values are shown one-item-per-line, even if
>    the value has embedded LF in it.  At least we assume that the
>    values do not contain a NUL byte.
> 
> 2. If a value does not have LF or double-quote in it, it is output
>    literally.
> 
> 3. Otherwise, the value is shown with quote_c_style().

Hmmm, ok. So, I if I understood it correctly, is your idea to keep
the same functionality but using quote_c_style to keep one field
per line?

> The implication of which is that a loosely written program that does
> not grok funny values (namely, a string that contains a double-quote
> or a line-feed) can be written loosely without having to worry about
> quoting and assume one-line-per-item.  They may show a wrong value,
> but at least because one-line-per-item assumption holds, their
> input/request and value they receive from the program will not go
> out of sync.  And a more carefully written program can of course
> check the first byte to see if it is a double-quote, in which case
> they have to unquote the whole line (which may yield a multi-line
> value if the quoted string had embedded "\n"s).

Thanks again, Junio! 
