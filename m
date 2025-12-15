Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B62C2363
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815901; cv=none; b=mB8+oTlB7SjQ9Dtx8z1SjpLZcnX63GZA8rjpblkd8VcvvZYKXivqzqrbp+17s7vMfWjka5lCMD+IlW/JBMIRL1NpEnRFcvKd/WaBvdNHcxUQ4O2JqEGc5WE+guEo3COylZM+cNRWshbjhPqaIV9pe05njT9rPlcZv99PbVFczc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815901; c=relaxed/simple;
	bh=2mno61NMWd0we2DHE0ZTgXCR3rC0PIATXTOfXYVvFSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kizlWI1R4RJQKl57tRZxOlq3yDpTUTpAPMqERni+Vsscjc9RwnonEcdk1LC3JZMGW38wV/VeKzx3uPJhsslhDY2YWTjaPKzDxVeCjd14zp3aSve8ZlH4KffTi+3ZR9acOEMnKe9Il+ArA0bibevTmn4VEgpzjL4YLxVMFLY0J18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayrYi82c; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayrYi82c"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-450b2715b6cso2153950b6e.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765815899; x=1766420699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psPOXZfOD+D8HFHBJUmXpQ+1SRZTRp0tmMwETh7iGYA=;
        b=ayrYi82cEz0ZjDTrvYRTaTVkbHwvfgM1lJPK1NX6p6DYSQR68XvWs5vY0YNBS8elqf
         F9GkSasJ8AXBeFXzab4A0qwp/LA7Ia7ikmY5xiqmV7PJeHDR/rswDfMk2X9M6wWxotrQ
         MVCQzk76GnJg/JK4P7Q2T8eFb5WdkdkRKOS5YtdONNNswXY7H0PGIYOkGByYHmnMOAJM
         aIrhYY+BuJKsmYBQeOtAyZlmDs16ZK+QaYoaiKg90SqE/fy939Ogd093w1Jq8UXZNV46
         YWvPpkbf+U71XNEAXH/qtjlpMAOQ41YtXbRGWuhIlZAU1/OMdi3E/+u0zJtnJAmAs+Ta
         kyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815899; x=1766420699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psPOXZfOD+D8HFHBJUmXpQ+1SRZTRp0tmMwETh7iGYA=;
        b=TA04qglgYiTKJpQhlWKcqChYqTXbwWIgFMQyAVn9qm7yXNh9w5UG/YPvuYkMw7GKUN
         4+6/pHuXv3vQ1K5Gx21Ec+lGx5h5uFdspZRY+pUwZcF8V8B2UBhahAkuHzKVcK1aUrnk
         Zoaiy1bWkNnO4KLF91lT+gLdp0o8bU+7BvGdAuBeImvU6A4owGMrFQIemcU7QvEzPq5B
         HiEAjsbHEtvyuaz0hXvX7I3bHwcfIVLBZ2VHMnhw5YphIq3KDsrcza0o5OKfDQxuI//U
         7gUM0SXiVhH0E5bvzMXUBrLjQQC9mwjeMVKBnTwuZUAQg7tPWJy86AagAn2Tcx1dL5OA
         D4Rg==
X-Gm-Message-State: AOJu0Yxj7xwRFvv+JPhqnMTAvhcXWsf97HTHE/Qpa9sc9JNWouGPZ8f8
	ZodawcDSFod8x7aOKkNjailWWfb/h90yUMms7RZbg5r3pf7QnCDKNGrkTyUEwQ==
X-Gm-Gg: AY/fxX6eGuOtVaFhJW/9JrlJlBMELls3/jrfeh4dxNUMsGdHVevvrGxfHhSTVIbYGa9
	dlVV508NN2Jnxswrc3jsn5I1shbJwkBtArnq+3YtDOGETQzVaRkzqvKRPLdRJ3h4d9uIjUnsMo4
	Upape8KeUvN1iraT79F045KtGuvAm7nVR8DVpk9SvmuGGSs3wSdK74bsC1qjmG+YVzcxsUmNJMC
	oHTIShAwuP+6UI+J7Zi/6sQKTmApEBZ8l3q46OxX44c5wkrd6G2rk8ljLiqZztVw08puYoaWB2s
	05f20Y2lPbj9tJ8MyLCXiVwjSgp8W+bw66l/fkJOAmfyvvFmjbiCYd8VFDeMefr0PmsCAj4bp/h
	g2LLVV3ExTVr8kwmnBcuYfVeevmdRBOY6RDDp29WlN0eLB4MuhgIBUIQ9QVUP0ooDHbHfMyDW2L
	AnssZj
X-Google-Smtp-Source: AGHT+IFxgsYb8yfGmM+psKZG18UiBeUtzdl0fN8sX2EOpq/Z5fLurpK/iXMKrFCj2ScCsQB7VS3NpA==
X-Received: by 2002:a05:6808:d49:b0:43f:6d5a:9cfa with SMTP id 5614622812f47-455ac8696dfmr5137671b6e.23.1765815898863;
        Mon, 15 Dec 2025 08:24:58 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614be6c05sm4839184fac.6.2025.12.15.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:24:58 -0800 (PST)
Date: Mon, 15 Dec 2025 10:24:55 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <3uphps6olbz4qphxmivd7iwiwnfvj6mv7su4i4dhaujixf733i@eqybxhvjsznp>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com>
 <aTkTCplQuSX_Y3oG@pks.im>
 <54kuvik2ecbkygjp57osmqjxiy7xtyjeffbzavuxbhuvta2oc5@mkqufah7cb3z>
 <aT-djS-TrQJxxV8i@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT-djS-TrQJxxV8i@pks.im>

On 25/12/15 06:33AM, Patrick Steinhardt wrote:
> On Fri, Dec 12, 2025 at 02:40:24PM -0600, Justin Tobler wrote:
> > So, I'm not sure we can use git-rev-list(1) in the manner suggested
> > above. It looks like user-specified objects are always included in the
> > output. When using "HEAD" this means the referenced object will always
> > be included regardless of the filter used. In practice, this means
> > reported disk-usage when filtering by trees or blobs will likely be
> > inflated by objects not specified by the filter. As far as I am aware,
> > there is not a way to suppress user-specified objects in git-rev-list(1)
> > output.
> 
> There is, you can use "--filter-provided-objects".

Perfect! I don't know how I missed that option. XD

> > I am somewhat curious if always including user-specified objects in
> > git-rev-list(1) output regardless of the specified filter is
> > intentional. Looking at git-rev-list(1) --filter documentation:
> > 
> >   The form --filter=object:type=(tag|commit|tree|blob) omits all objects
> >   which are not of the requested type.
> > 
> > doesn't indicate this limitation. From looking at the code in
> > list-objects-filter.c:list_objects_filter__filter_object() though, it
> > does somewhat seem like this behavior is intentional.
> 
> It is intentional, but I've been bitten by it in the past. Hence I
> introduced the above option in 9cf68b27d5 (rev-list: allow filtering of
> provided items, 2021-04-19).

Good to know. I think I'll submit a small patch today to try to clarify
the documentation here a little bit. It might be nice to point out this
behavior a bit more explictly in the --filter section. :)

-Justin
