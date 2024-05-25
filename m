Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C242391
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716599738; cv=none; b=ces51TSQJ3RAD4/Xy0THQtVMm3MGiiznnrVJjW0qqfK2bc4kIRam0Mzdw0C9jIT6zlRkOawqD8EBPrB1tEAH0p/YKt4TowJFVOkW8ktA3OxS73cZvQuH2dz7OTvTg7h5syI/PW5K4aPr/7CQ4hTWg7PrgJPji/+DYKy5c1tB+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716599738; c=relaxed/simple;
	bh=l9xUXJ6e/bXYyPbIU/FgpgNTeUx1JR//3lk6Bxw8iMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU95eiwXyu5HUnnT9maUHpoRlvM7U40IPgmw5amaw9HRVDrSPKrYn22reCzlelV+uNL576pvZxc9yZXc6kSguj0Jyh6Q1QWTgn6A7wDZTWBqgZQFK2ylUBuTypceKlvuxmLOZc3+woOo0IlaAse6u7x5/oBH2rfeZYMOYmsIaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsILA5iw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsILA5iw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f34b5f1964so18198035ad.2
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716599737; x=1717204537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDjY/0dk3xTzDXtB48WZDnt278korC/bJW4CxgVFZGI=;
        b=RsILA5iwnW2YVuCTpsKh7Q/c+uYgrRetVvRCegXCl3QrGywnJO4NE2u1rRik0kykET
         p5kbHTQvnzcRU7yXP7JuAjfV2h1xeJIR1JXUk9u2f73Wg9p7xB/EFVk1TMTiRqFYoO4l
         gIZHFDFHFH9yoSXuHv5HrNcCrWgRxxx252ERxNfe4Lr7zbnLZFpQ+rc7pFezsuqqRgNO
         yvVaazwdvI1S74FEAvHjE/eK65wWPJGn+H6X5t+Z1dQ2aPPAzIDH4ngXXkSbxmxLtB+L
         lw7qSwtVsegx8M8laQHgn7hTp0Oug9Ahh5z1DZwSAL74eOaUq200WOeb7vGcE9Y73F7F
         TkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716599737; x=1717204537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDjY/0dk3xTzDXtB48WZDnt278korC/bJW4CxgVFZGI=;
        b=oLpW497phkHJjc+nQ7DYK94ri7gpEYE6VMvK7SLxu4qwy0LvVH67De5JigaJBuy39N
         MxVFUQ6KfyoY5KKgcjgGbw2EyB33SwHmtuwW1uoMbiVNoI+TqmCjaBYGfDTSp97xYGe8
         yI0dVSmM7xCncy53iFVIlCdBd/5V6VNdqRdZuUHfUi8tMajx5JYk6JJISag5HyeVugDn
         4mEOvAc02W9qvXqr3tYBu+TBjvPEhXgPSSljTgo8DXycRBOKp3w7ffIpZsVh90kt4pZa
         x1OnJNa4XPhKZ6wAhr0MbUJe6CDXZ9KO4mEjCPDuBRXIpNKr3SElkC9S1brpZ3FY0Ho5
         Jr7w==
X-Forwarded-Encrypted: i=1; AJvYcCX/boNigTDekL1PDGHyAuRAUariOyQIDoDzojquzY5tQPaF8bvku/i65Gbas20Qu8VZZIYHlxHHU2xCdFNrfx4IfCx+
X-Gm-Message-State: AOJu0YwNxmnUmEjkwCw6ucyAWpufL2M6xnh5iqW7AezoMRBC6x04LUAM
	Iy0CrS8qqxhp0sy9+y7Ny1TshlcHSKcalhzNxJYaQPy/wQYQNpn0
X-Google-Smtp-Source: AGHT+IHI0IyS+GSye+2kaBvXe0WRWCXYMAIfzhUWRVCDjX9xD5qcMmaxhohrjNpuPngb0CVTpJIZEQ==
X-Received: by 2002:a17:902:f549:b0:1f4:58ed:a5f2 with SMTP id d9443c01a7336-1f458eda9bamr25509445ad.31.1716599736450;
        Fri, 24 May 2024 18:15:36 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9940e8sm19866425ad.193.2024.05.24.18.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:15:36 -0700 (PDT)
Date: Sat, 25 May 2024 06:45:32 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: ach.lumap@gmail.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 3/3] t/: port helper/test-sha256.c to
 unit-tests/t-hash.c
Message-ID: <d2tnjzx6vdz2egh7qv6vff2x74dzzvvjlamjs7qodkpbpqj4pj@ur2e2fcfoa62>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-4-shyamthakkar001@gmail.com>
 <ZlCWeCJq6qxWrJvI@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlCWeCJq6qxWrJvI@tanuki>

On Fri, 24 May 2024, Patrick Steinhardt <ps@pks.im> wrote:
> On Fri, May 24, 2024 at 05:29:45AM +0530, Ghanshyam Thakkar wrote:
> > t/helper/test-sha256 and t/t0015-hash test the hash implementation of
> > SHA-256 in Git with basic SHA-256 hash values. Port them to the new
> > unit testing framework for better debugging, simplicity and faster
> > runtime. The necessary building blocks are already implemented in
> > t-hash in the previous commit which ported test-sha1.
> > 
> > The 'sha256' subcommand of test-tool is still not removed, because it
> > is used by pack_trailer() in lib-pack.sh, which is used in many tests
> > of the t53** series.
> 
> Similar question here, are there replacements we can use for it? I also
> couldn't see it being used in any test other than t0015 when searing for
> "test-tool sha256". Maybe I'm looking for the wrong thing?

It is used indirectly and not explicitly like 'test-tool sha256'. e.g.
in t/lib-pack.sh when GIT_TEST_DEFUALT_HASH=sha256, ...

  # Compute and append pack trailer to "$1"
  pack_trailer () {
	  test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
	  cat trailer.tmp >>"$1" &&
	  rm -f trailer.tmp
  }

...it will use 'test-tool sha256' on the first line of pack_trailer().
And the pack_trailer() is used in t7450, t5308, t5309, t5321.

And I will consult with Christian and Kaartic on the replacements but as
Christian and Junio said, doing it in another series would be a good
idea.

> [snip]
> > -test_done
> > diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
> > index 89dfea9cc1..0f86cd3730 100644
> > --- a/t/unit-tests/t-hash.c
> > +++ b/t/unit-tests/t-hash.c
> > @@ -32,11 +32,24 @@ static void check_hash_data(const void *data, size_t data_length,
> >  	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA1), \
> >  	     "SHA1 (%s) works", #literal)
> >  
> > +
> > +/* Works with a NUL terminated string. Doesn't work if it should contain a NUL  character. */
> > +#define TEST_SHA256_STR(data, expected) \
> > +	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA256), \
> > +	     "SHA256 (%s) works", #data)
> > +
> > +/* Only works with a literal string, useful when it contains a NUL character. */
> > +#define TEST_SHA256_LITERAL(literal, expected) \
> > +	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH_SHA256), \
> > +	     "SHA256 (%s) works", #literal)
> > +
> 
> Same question here regarding the macros and whether we can merge them.
> 
> Also, we do have the same test data for both hashes, and if we ever grow
> another hash it's likely that we'll also want to check for the same
> inputs there. Would it make sense to have a generic `TAST_HASHES()`
> macro where you give the input and then both the expected SHA1 and
> SHA256 to avoid some duplication?

Yeah, that can be done as the inputs are same for both hashes minus one
extra for sha256 (though I think it can be easily obtained). It looks
like a good idea to me for v4.

Thank you for the review!

