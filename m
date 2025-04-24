Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6942701AA
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499188; cv=none; b=iy7AEry1HvJ3h/P/dEYJ9phnhd7jqg5ru/wc/lyv0xdjpXzOmNZ5epfm2fmmqmAy+3tygf8zCg7/foKs3j94v1zKXRMBLaTUUfK3X2J4cAaoutOiaXawfnaG4hHjz2UdozF3915bhcXm8QgNqZDsAxURme8YYMcSvfE+PLdAp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499188; c=relaxed/simple;
	bh=1CITxONkHtew0a6Wfv9u5l5HYfpBh0yfPZkoHjmh+x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjEUNO/MEkSzt8xjc1LHqMvxoLI9lxZC7mw84hgEa/Pxe0NoJgzxZcbym4Rvr1CfrDHmXYkRPFfWqxXl8vyXSLdylflbB7OxXOb/ePn3EmjG28AJjjmTuvOqeqM0Qi1JV87DAHwmSHvEDFe6X5yZE6ihaq6ClsQ0pYrQVG9pTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifBBMJH3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifBBMJH3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224100e9a5cso11575465ad.2
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499186; x=1746103986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0FtDJ8pcqzEo+2AogsF5NUW5n85q4K+iEZTpB0Rla8=;
        b=ifBBMJH3MAeSCc2ZD1Ucrmy7upY0ffx5FrelcrBfr1162dW5p2HZSyNJXWcmp8PoAx
         vkEzMKqy9GP9cagGJVk+xHDcDAhsw9VW8OVKEoGqDyYRIsHbbPpwrluJARN8BODEqfAm
         tj3sOYZIobuuPiv2uEtkoW5bV9y5x0EEtijQ/jdGmEfpPof+9y+s59rfD54+XhR0Z7aU
         qPJBR/+XK17NT84zrWEKyj8qZW+QFi67tMBAVK73uqyRX42I8HshlT100+9erIubVmev
         aMeHMqd3m4Wasamm3tTYL2+DbmG5sHBkIxg1Ox7wGAL5zyQz78OagER+z4Q8LSs8DRM4
         nQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499186; x=1746103986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0FtDJ8pcqzEo+2AogsF5NUW5n85q4K+iEZTpB0Rla8=;
        b=B3gYuzFUCPlLeP7WrX1+CzYGwdxpe7pR+1T32E+E/YyesS4kRYq63WKGRKI/1KU2hj
         M/gEDvg1wDO2qzcHrcxShhQsk8eYIGQ6ssmhyhoc0p9LQ0yCBm9o0qhJol+6cq2FNqS2
         9CnzWP1xpHP0T3+kKl4j3q8kZPPhJsHHEdr82GkSbF9jg3S/8Av6m+0jHUTewBXpR4bg
         eF0eDwj6G0MUGeZxa1c6uTeT+RgqwqyK3Up0b0hUGnX48IvA9rcpudaxNX3IehGdFybK
         P/rnWfYFUHQEI39QZVHpooWdmAIL2miWn7DPfVF8jjA/ypKZn8xKy9aMUYqHAVkmAdLe
         ijGA==
X-Gm-Message-State: AOJu0YzUzWV6egUz+zruUgttk1BVMMI9Fgj6tHw71frvFOmSc60o8I+l
	csXNXYXFVZbpPPTSOgwEbuJNWWEqq/OuCuQ7aFQtvM4P509uSsZUnEF3oCdf
X-Gm-Gg: ASbGncvOSeJMx+09qEVd6GWGruIsafsjgv8uJLCRvdbMhqmJgq9p3CvZsS6ko459MkS
	FeplTkXYcJrLkJeqy8tMZX568RBKjyxyZbD+HuF4543Y3RcrpM8MluFv8c6lGuf5/aRJRcMb8iX
	7IPP0UwEeV7FaBYWfKOQQeyhnDA9XuiwQGkVYKU8sqoWGMvQeULa9AkuHTehH6t/ccdyY6HgAT2
	4nm5NnLOSgsRC9cT8S7vXxuUKRYbkAPC2lnVAvT9lbTI/A7sz5+oxeKctCPtVjU132f7o5keQVL
	jDuqWGCJrzAl/1x0JY+94CKag1iKhQHdeGu6
X-Google-Smtp-Source: AGHT+IFSY2PvoD/jIEvk91jKnaUQ9XigAykz8249LrbPIt7vyeIdFUiET3b+A92TFhrkHkjT9Fkt1A==
X-Received: by 2002:a17:902:cecb:b0:223:2361:e855 with SMTP id d9443c01a7336-22db3d7af11mr36215695ad.39.1745499186501;
        Thu, 24 Apr 2025 05:53:06 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db50e766bsm12244645ad.149.2025.04.24.05.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:53:05 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:53:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] u-string-list: move "test_split" into
 "u-string-list.c"
Message-ID: <aAo0PKaIrmqkuzeG@ArchLinux>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAetv8l8jrxvEywB@ArchLinux>
 <aAjUmi4ccemvO7XT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAjUmi4ccemvO7XT@pks.im>

On Wed, Apr 23, 2025 at 01:52:58PM +0200, Patrick Steinhardt wrote:
> On Tue, Apr 22, 2025 at 10:54:55PM +0800, shejialuo wrote:
> > diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> > new file mode 100644
> > index 0000000000..0c148684ea
> > --- /dev/null
> > +++ b/t/unit-tests/u-string-list.c
> > @@ -0,0 +1,86 @@
> > +static void t_string_list_split(const char *data, int delim, int maxsplit,
> > +				struct string_list *expected_strings)
> > +{
> > +	struct string_list list = STRING_LIST_INIT_DUP;
> > +	int len;
> > +
> > +	len = string_list_split(&list, data, delim, maxsplit);
> > +	cl_assert_equal_i(len, expected_strings->nr);
> > +	t_check_string_list(&list, expected_strings);
> > +
> > +	t_string_list_clear(&list, 0);
> > +}
> > +
> > +void test_string_list__split(void)
> > +{
> > +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> > +
> > +	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "baz", NULL);
> > +	t_string_list_split("foo:bar:baz", ':', -1, &expected_strings);
> 
> Could we adapt `t_string_list_split()` so that it accepts the expected
> strings as varargs? If so we could simplify the logic in this function
> here.
> 

That's a good suggestion. I will update in the next version.

> Patrick
