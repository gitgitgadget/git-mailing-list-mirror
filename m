Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23889381AF8
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561302; cv=none; b=Oc84rZstOhtOUjB9DJZ8FbehzWpW6Ir9W4Pc94iDfEfSQh51LREhBR9XwKpAJWphZ8Nl3hUzX9RubhOysqNQr0Qt7+5zcMn4KSvunqTYdWNpx4Gx7lU1f0ilxRQmUEzdd4NZSbuDrP0SJ5+tIO84dsSk4fs2SmPcm1UNzlBPapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561302; c=relaxed/simple;
	bh=HL67nfVkhGondvD0eiQQQ8mu/2SbXkv+DcUga+tJl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoNXbyQj2asZS6t1LjpyxB4d0vZXR1CXAR1YPFZs8RuYS3/xtZKxO6Pl5TQucogPu5xLtSxBlzz36faGDGDKcCCncS5Q+UlWCorciy3E19VSnXb6DLZT0miz3W24JESYSfgZoYj32C82HVrNuvu5wPuEW0vc+YfDr/Yj5BQrmkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFlMw/B6; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFlMw/B6"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4645dde00a7so6989908b6e.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561300; x=1773166100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91RwVqwGYpui5zJAbXqbIkVBAeexmyK1DmjrKc04+Qs=;
        b=hFlMw/B6i12/FMWQsSaZpyIwB8SycD6LFu/C+aj0G6on335kuF6/z8nRi2gv0NZEYe
         45tERjJwLsWq2gO2d2vvl4S35HHsB0iGPXHu0kO4b6FDJzYkwW1/xXXyukWWoX5RJivP
         eoIuo5G5v5XVbNhcEWzSWa808ZV/KcT7u0Q88NcP/Vv84C33uQ3TSJDg3p3vY9JSN4YJ
         tnMQ93dRhWTngb+H/RJRVYGObANc1BsDeQcCdM1tW6lP5Wru66YhAzSwus3mXCDFdtcO
         8zjeCmNxulgYWxOfv7PWw0VzMI9y8JiIiYHydkKO0g2yOgJCASPs8r2pyEDMPa+PfLeh
         DdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561300; x=1773166100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91RwVqwGYpui5zJAbXqbIkVBAeexmyK1DmjrKc04+Qs=;
        b=n9Sv+IHbCYW3Wu4wiv92fi7c+e0bGekaHEodN2VJ3GM1OTBljnd8FBi9+bVd5qBcgz
         d7D/ZMqMP81aEcbpHxxlm9EL2d2gVqqEhVhRZ0DngQlqL/9nJQWDsi1rg3XdWrxoqH6e
         ag2YQ7N1eooH9VliTVJPSaHSrvz3tI8mZ1SUDQg1ozrsbFft+nJ4144LoOAtR1ATKK+Q
         CtVknWcu1+Xrx+aWiQA6LJHv9SxWLlKDLQpJCn9Sf5dGaQIMGHEv7dVoJNYrwC8dVYD0
         Ii71kyM4FQMkPkST3xAGpRRl7jhAEV398WttEv7ysBWND8udxMPQBYWzJv7iRDmvRpzI
         D6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwH2dg4mw23VxQMjGJwx0NqsOoYA30ggPXBwS8X+TKOR1yV1dUF5SBuKgIdwcoBOvthQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGQl0uHdytC5VSQ+v+EaVwDAkArouWXH1eY5+7nft5X6P1qdD
	WvHedNqbvFmloJZ9qHqZSJiZw+nxj7M2O/n/WzMqK6fWVgh3lfSgUNE+
X-Gm-Gg: ATEYQzzpku+8tXPa4hivxnNkriH/gLhioo3maRG1OvYJkjy8q7VfJ6gzaiEOqnymImA
	novgapF0VwE9SUFi3Ib+bjVUmEpwn+X7u7v1eyl7EnUYh1WfneO4LzuR8JIBjXlvu5SZANY9Wqs
	AkiK4tp0ztDuSy6YhbBpVUTYZGqTBWNbdEDXT3zt1GYOgbK72aUQqYrf2p+KrYhxCSjc7QiBuS8
	0M6Qz5YF230o8NT6/EUxU5pqrtUBK4LUZX75LRnqKm3tDrx5j/2tvBe0GDH/L9/wZ6fMtXwx1y+
	5pRAIpubIp5MVJOvfixKmC98PTlURzNN8iuHBeSHqa3tIxWg9HrXbJMz47VcCePdWwGnHS1Y/7B
	z61YSsmxCEz6A1khYUi3wSOY0Bb+XfVN4VaqxHe3NilL69U85tpxpy0eqCzh2/iITvl6qB4M54B
	LNmKeThEOU3GmJwWwo
X-Received: by 2002:a05:6808:13cc:b0:451:4d80:5ab1 with SMTP id 5614622812f47-4650c847c3dmr1439174b6e.33.1772561299998;
        Tue, 03 Mar 2026 10:08:19 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm13752209a34.2.2026.03.03.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:08:19 -0800 (PST)
Date: Tue, 3 Mar 2026 12:08:19 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	kristofferhaugsbakk@fastmail.com, lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 2/6] builtin/repo: add helper for printing keyvalue
 output
Message-ID: <aachrznSGC_gcElv@denethor>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
 <20260302214526.2034279-3-jltobler@gmail.com>
 <aabhtfWZG90YyhQ5@pks.im>
 <xmqq7brserq7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7brserq7.fsf@gitster.g>

On 26/03/03 09:40AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> +	print_keyvalue("references.branches.count", key_delim,
> >> +		       stats->refs.branches, value_delim);
> >> ...
> >
> > It's still easy to miss any mismatch here, but I guess the result is
> > definitely easier to read regardless of that.
> 
> Sure, we could further do something silly like
> 
> #define P(name, source) print_keyvalue(name, key_delim, source, value_delim)
> 
> and reduce the above to
> 
> 	P("references.branches.count", stats->refs.branches);

This does indeed cut down on some of the boilerplate, which maybe would
make it a little bit easier to catch any mismatches.

> if we wanted to.

Ultimately, I don't feel strongly either way though. I've amended
locally, but will hold off on sending another version for now unless
there is additional feedback.

Thanks,
-Justin
