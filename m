Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797A254AE1
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578981; cv=none; b=Vkrd2vPTvYH9kokXfrCcQo9PDDrQI8GQseEs2/2e+NAcN+6SzSuj7XkjOL90GqK9DobcwE1sK96OdC60q0aBquO7SWwjacOEIE3BvauaOeKE/wwuK6PX/DdoerkiuDXgw6fl/p3PgXX2T97n1dQT9TM7G5Iu31CcmSHlRpoVG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578981; c=relaxed/simple;
	bh=N0ZgAFv215heWPpR+ZuquQMD9k8fThoFGPUEcuwj7ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW6kjUgmzdyf6Fo9Waz1jjerZEAmYQWA8WRODztariQVjo07qspTf242be+AJj6gZ54FpvYZ8mvbKvtyrcrjzuscaJF8uYfzIgf5MaE9tcA9CVOx0iUWYHzscmP2OZw02jBoEA6kcEN+M4luL1f/Znig7uUHQshrpwGJ12VlREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+iWFPRj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+iWFPRj"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cac8243bcdso1123712a34.3
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765578979; x=1766183779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DFcrFzwq3sGbb5MF5NzQBhY/U3anS7O5XjezDZgjzPM=;
        b=e+iWFPRjfhecv5u74sUpq11RdFI22sxibFvAVMWK5Ua/1/hJzWvWlclTivz7C8p2TB
         NdirpDj/mCJSv7VMb10W84tkncU/xcACyuOQFpAfeVgwYSsD7Bkhn/mp4kpIbeZsXunb
         9A/gTSPPyxZTvuB0l1b+RsVevsddES6fVanpFHPXgd1G3Z1ZqAOJyPNbfWPONw/AgWuX
         jIMUyhI/xtuKvvyg/7dc/bz2Wt9x0zw+rGfM1w8HKLxBUfy0S5h5xCKJWAbFPBVL+sf2
         eh4Nhd14gDyfTv0Ov7o03/Hx0u9vMd10byB0U2FCTIkEJs3++IDhbWMsVkTC3KBavmOO
         orbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765578979; x=1766183779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFcrFzwq3sGbb5MF5NzQBhY/U3anS7O5XjezDZgjzPM=;
        b=bHHdlpuJ5oKO0PBgjwFYz9aLr0EbM/ChkCsxMmlDXbIOE7pI3G4qyRXmCovQpHvobC
         8Z6f3GxDA0yI6jsVwJcI4ALhgQ8wF5BQj9e7lPFmq+vurUZ1TfHEyKewhiAc2UrAIkyE
         idsn4CWqHcUcj4S5z5EzaqBUKdGoczVjSAP+IDyaODqw0T9hIMi3y1NYfZl7+JVOqwr1
         ikJLxko4QY5MB3A9Qe55+6Dd88n6whA450WL5mtxOhcsVMR2he9I6Egr3/Nn/gZPCJsq
         AvQtDQFgiWfAIKYxjvfIVzXAGFCOjqdRKG3Iaet3xJWgcHdWtGwMQwin7K552PBzeymK
         Xazg==
X-Forwarded-Encrypted: i=1; AJvYcCWbvng+zMUE9M7usCccR+2gIUw+K4/EvBrm/LP4s01Q8ni/oqW3BMw+yBBF6WLuI9lCwMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkXv6H2T9raqaCDQ9aGBGzcpFq4nu/BxSEN2n77dOJl9ijE2I
	m+HacPeqB6u28cv407BpSPurXx3bcvC9uzUbmlW1uSC/7ZXW6/ECWjFZJlsV8w==
X-Gm-Gg: AY/fxX6AbNdOXjuJFUnWN+e5Th8eVOz0ze0oBW6OWAlKLVD/NShYxj+3StRRe3SXcqh
	BeU25ZP8y2vSi/hhtbS/f6/TVBmEzItPUNhxZo0mzYC6Hievht9A5YAFu4AbIRb56nuKxwRnul9
	JJkKpypcCxamN1hzlGBuhrJYyE3UM7trVHjvNFvAb9RxRM6y+f37a4UdtRXVA3RqOerjL1N8Ij3
	5o2rNqpv6q+Krbzn/ecgDiYsVBaWQGKow3wmlhcT0wGSVfVVw5sksDacpwgcYGInUHY3ajLzPDn
	Sf5BbsKJSdyVZ9PaErBUrgSLMT3+CnAAx0snhPGPBtkKv3OyXfI4s58vztwGAxyiIoDpjC8PAvF
	BO9ZtbES8Y+iFP3C9lRXv47opgBAUyu5/pn7PDbv/95hS8Ece+sWZACc5FptXt+yx5pJklOYZNW
	xOv6lrrMbYur2WkQU=
X-Google-Smtp-Source: AGHT+IHkwIxA86rUkjlcFJON+cC48tDqP0mYfLwOtKuZPwVZ9nDmiqDoodJ2qB9azJ7UaQEMET4cTg==
X-Received: by 2002:a05:6808:3505:b0:450:d1ba:151b with SMTP id 5614622812f47-455ac87b97emr1618702b6e.29.1765578979339;
        Fri, 12 Dec 2025 14:36:19 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1d0facsm4338586a34.3.2025.12.12.14.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:18 -0800 (PST)
Date: Fri, 12 Dec 2025 16:36:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	ps@pks.im
Subject: Re: [PATCH 5/6] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <e5hsuevw5t37yt3zgp4hhtunusdyeg2lkph52pj4valpmlyrdt@7teicd67atbj>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-6-jltobler@gmail.com>
 <xmqqikeegz8q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikeegz8q.fsf@gitster.g>

On 25/12/10 11:58PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > -test_expect_success SHA1 'keyvalue and nul format' '
> > +test_expect_success SHA1 'keyvalue format' '
> >  	test_when_finished "rm -rf repo" &&
> >  	git init repo &&
> >  	(
> > @@ -106,16 +137,12 @@ test_expect_success SHA1 'keyvalue and nul format' '
> >  		objects.tags.inflated=132
> >  		EOF
> >  
> > -		git repo structure --format=keyvalue >out 2>err &&
> > +		git repo structure --format=keyvalue >out.raw 2>err &&
> >  
> > -		test_cmp expect out &&
> > -		test_line_count = 0 err &&
> > +		# Strip object disk usage from output due to platform variance.
> > +		grep -v "objects\..*\.disk=" out.raw >out &&
> >  
> > -		# Replace key and value delimiters for nul format.
> > -		tr "\n=" "\0\n" <expect >expect_nul &&
> > -		git repo structure --format=nul >out 2>err &&
> > -
> > -		test_cmp expect_nul out &&
> > +		test_cmp expect out &&
> >  		test_line_count = 0 err
> >  	)
> >  '
> 
> This part has both textual and semantic conflicts with Lucas's "-z
> is a synonym for --format=nul" topic.  I think I resolved it
> correctly while improving the "munge expected output into expected
> NUL-terminated output" approach to "munge -z output into textual
> output and compare with textual expected output".  Please sanity
> check the result after I push it out, merged at 32f8d84b (Merge
> branch 'jt/repo-struct-more-objinfo' into seen, 2025-12-10)

Thanks, this looks correct.

Just FYI, some of the test changes I made here are reverted in the next
version since Patrick suggested a better way to test disk usage output.
This should allow Lucas's changes to apply a bit more cleanly to this
file.

Thanks,
-Justin
