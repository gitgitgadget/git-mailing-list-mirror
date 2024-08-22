Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB241C93BC
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330480; cv=none; b=txZ/uT1oh5zDznWBu4eTSKMev3RoZLKPyQLf+HO+9bruKBFpjX0vapXIm4h/j3hSKtbXX5p/s2ZZrkIrY8LIJRcJBn5TNT9v0EFQ23LFyA5zWlqz01T2t1mf8Op2SCrnlhpKjCDsJ569gETgGrcEPjHPMdj6k3i2RLqyM7SYitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330480; c=relaxed/simple;
	bh=LerSK8QEBhIabVdwfaHY6Bm0seezM7HkloUUDb2vfQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+tQbLw1FsRi69UkstWzS5t5ZVx8C4HcCNY+g0NYTHJqRuKJ5VPcTsinriSFVcSdvp50F0+Lszd2qZ5VKHgzCXrQ8sus9XNntzGt6zEXNrGkpcyqKCOf37+OdfYQeA9w4zZjwY06s2qldJBSwVXiKcjfHydyePVIPShPLf+Nyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLIYpILh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLIYpILh"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-713eeb4e4a9so626051b3a.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724330478; x=1724935278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnGbOkjMpBN6pXsw013niDTvMwIt0wat/UDLff/78vI=;
        b=fLIYpILhVESTQx6B1c/KnJGZEulgeZdn8Y340FlB39sQR1QePHRY7YlAk79D5tlXFV
         j6hrhgL5w9druu8A7KP3l6dqP2x5dDGZROX+WBuRKXtB9aeO4fqLn2r1EGYukzhRz8G+
         C6psh/wmbM3576o6AJ/5rTUR8Fx6j5y2U6rqqCnACMnmoux764yot+j2C1as0y+37pog
         4+8EDcpp7OtDUwf7JGVcUZQHogd2UpVOyhgiLc4LskwJAKzLRCdM6m6xkhG+fjvs7Hrv
         cXogJMkZcLhTuaFE59TpjsMCiubinZdPAmfrMyVDcDpI/pWf2Y7nt+BaD/QCaqhk+LQ3
         FH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330478; x=1724935278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnGbOkjMpBN6pXsw013niDTvMwIt0wat/UDLff/78vI=;
        b=uZaAm7upouZsrImf6UgFEsSTByC4G0BSooDm6aJoOLzJavIEjo00ztuL9c4ZEgCyWi
         fgRAcnGmg81rhLePQ8slZjj1o2GUan5fvgu6lbNzm/eHdFJ1KKzYFrNKxdo1wpRvaazz
         GyHktBl8hzW+UZjiE5DngJPxxHsrWnif8o5Q3sWJUyO88uded2X3TEEIm0otervncGUL
         xF76hIzs//TA2DYHnsLbuy3A2brX75xmNdhwADablKZF3xS4VZUURQ6OdMher01SsRgV
         vGTKC6MPlqbs028Q8+NZ0kxc9qmpUw65kiOi5wvkMA+rWG8nVEzPz0XCaAqGO9EDoBsP
         YjnA==
X-Gm-Message-State: AOJu0Yw3qaH5Y1YmrwPsAL2vC+m6KY3X65IW+R2rnu9nHS1dlaM0BRXR
	4zlz0Y67uB0Yy0tAELyFIooihW43c0bZ1HEImn95xG40TccByW2+
X-Google-Smtp-Source: AGHT+IFF7gs0ZlnLozjiAEvN/dmzSroLKWBmGAByEXwfGT3tfFg+L8JdKOmyK1n2UThilY2Wnk4tHg==
X-Received: by 2002:a05:6a21:3a86:b0:1c2:88ad:b26d with SMTP id adf61e73a8af0-1cad81814efmr6484061637.48.1724330477849;
        Thu, 22 Aug 2024 05:41:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434250a9csm1289647b3a.74.2024.08.22.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:41:17 -0700 (PDT)
Date: Thu, 22 Aug 2024 20:42:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <ZscyGg8M8TbJVKNS@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM4OZWfylcP5Ix@ArchLinux>
 <Zsb8oDA-vyLxNY0U@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsb8oDA-vyLxNY0U@tanuki>

On Thu, Aug 22, 2024 at 10:53:57AM +0200, Patrick Steinhardt wrote:


> > +		if ((space_num || newline_num) && !isspace(*p)) {
> > +			ret = fsck_report_ref(o, report,
> > +					      FSCK_MSG_BAD_REF_CONTENT,
> > +					      "contains non-null garbage");
> > +			goto out;
> > +		}
> > +
> > +		if (*p == '\n') {
> > +			newline_num++;
> > +		} else if (*p == ' ') {
> > +			space_num++;
> > +		}
> > +		p++;
> > +	}
> 
> Can't we replace this with a single `strchr('\n')` call to check for the
> newline and then verify that the next character is a `\0`? The check for
> spaces would then be handled by `check_refname_format()`.
> 

We cannot. Think about this situation.

  "ref: refs/heads/master  \n   "

We find that the next character of '\n' is not '\0'. Then we leave it to
"check_refname_format". But "check_refname_format" will report an error
here, but this is an allowed symref.

But I think using `strchr` is a nice way. I will try to find an elegant
way here to handle this logic here.

> > +	/*
> > +	 * Missing target should not be treated as any error worthy event and
> > +	 * not even warn. It is a common case that a symbolic ref points to a
> > +	 * ref that does not exist yet. If the target ref does not exist, just
> > +	 * skip the check for the file type.
> > +	 */
> > +	if (lstat(pointee_path->buf, &st) < 0)
> > +		goto out;
> > +
> > +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
> > +		ret = fsck_report_ref(o, report,
> > +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> > +				      "points to an invalid file type");
> > +		goto out;
> > +	}
> 
> What exactly are we guarding against here? Don't we already verify that
> files in `refs/` have the correct type? Or are we checking that it does
> not point to a directory?
> 

When scanning the "refs" directory, we will check the file in the ref
database, but we ignore the directory. So we are checking to know
whether it does not point to a directory. If the ref points to a bad
file type for example "ref/heads/bad-file"

If it is a block type file. We will first report that "refs/heads/bad-file"
is a bad file and then report ref points to bad file
"refs/heads/bad-file".

Actually, I think this is a little redundant here, but we can be
tolerant about this because we need to guard against directory. We need
to consider this situation.

So we could let this be.

> Patrick
