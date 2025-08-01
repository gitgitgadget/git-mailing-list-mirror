Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA12E3709
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754015611; cv=none; b=GcSnkooPB7NARD7UMIFMDEKCprD/LXZMH/GdB7XPijG8cZF+MEFvg4hLmGLnn9+sxyTPRG09lauqsEUlwGbE/+po07y7zKql2MAW3Alqbn1OfwyLssvi38rIB0/96ovISS/we+Ii0kfEHLio8gEmXk1BVCnvnJhag3Uz+9O0kVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754015611; c=relaxed/simple;
	bh=45KB2iCGvf16rhzUkaowjmsnSvYDCN3gJeUKrDwFoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuFkrK5dwHFoPURSAA1gfCIPc37PnP9ZbtlkhHxBofdWTQpbW4sArUYdi4QopvHASLisU9Hvydhr6AH24AnOPp9be6ZjO6EasD9acWW56ZHNre/Evwuw/aBN5gvy8CSJHZWz3gdMAkE/Er0H2jhTa4IjSgr7ETkQMLSW8AhpysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTGQt7wv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTGQt7wv"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bdc73f363so257109b3a.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754015610; x=1754620410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5KJMUOZBuvxl0f33pNUAHJjlRMx1VQxh9mYPF9F77A=;
        b=BTGQt7wvVR55TF+P2AodAK1EIlPaCV9udjg1Ffft2ScZDZGlHhR/f5q0fbH3vhnh8v
         QMH24GNJLDdFFNz2sYhahcsbsrkOM+fx3j0jS7xwmyjIXrnYU22wPXqSe12mqyH4KPs/
         mX0W4Wkvp0cea/Tyxcc7l8LXoULfF/yvuGMxUQGE6Ck7ql7B2OVonZLHd5uycU2KCSdc
         nUhpLvzvrbLtIXqAdBIs2DnnPAF49yQCkIttrVqxOVugQKWmERdGseu0o1BpcW1qp6cz
         uHgSL2UqnBk2usWp6hwCxsUDnqnUg/Koq2dB3nn+RSdEwCN+FhWiEbY+TwUchRzHFW/n
         jZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754015610; x=1754620410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5KJMUOZBuvxl0f33pNUAHJjlRMx1VQxh9mYPF9F77A=;
        b=cPLXpYcqfFucrxKftk7th1Q1ZJvu61CqxKWrA3ggOBhDtqQREJ5w0fsT379ESHMSxh
         EWdCDFYJ5eLWPrQPPJjYGJfKLy9xPgX6vwUyhoh0l6gfZFPNCoJoF1Um3Kmj+JZ1lXzB
         bumfkh+MQXO5G4DEOCIHrJqL2fvjNIEnPJul5enFWmWC5Cg80LL5qyCLbD+949Dyx7Dz
         VpKjCEyvLz1kVknSl9cVWk3Nu3MhVK8A4g9NlQrW708TM+laBUDBiHzzhCy6+hHNjsPQ
         Q895jmaE0h0p7l4dK5m6mcMHhHr8iPp2DgaPEY1q8LsRfsMGkfOJoZwK1nuJ3YpTdztw
         nIZA==
X-Gm-Message-State: AOJu0YyFU2SH52Y6XXfBK8HthojOyusSVaq0uzFNMKK8W7PDJwqUyhYI
	7q1ZpBukYH4OTW3S3eyixCtzWfvGHbirrZ0KLH6lYIls7+a4U1PUptlw
X-Gm-Gg: ASbGncuCL6zqdyEsOS0LPeaI0zA2yWlx5f3M0MBw1YuwIaWAs5TyexRXufMnK0j8kaR
	xiEsGjKlIaWhnMpYxIVzLsm433pq1idJZ/8yN+A+zYudT7cc9Tm1QD93juCf/c6URfl2qECnuTR
	fnU7nFLhiGp+5RfSKv0QdA0vF0Xr4lLtIB0QiWPvIelOD2zHYF5g/FI7kvRPUqQtIURIPh1IVNz
	f7/C6qiqO9i9ly1uzHCh5g5qBOsWwF59yXxMpAkFpa6rMMfGpVXPBPJODswL/tTFXVGKGMDOzvW
	wcBkFadwHblAXiHhpoMv7M1aEYPybma+vjlFxASY4k6gS0aAszt8E0szEnds0SdqLRKk+BvE6aG
	4R5W3ggHotvnoTz57NQ==
X-Google-Smtp-Source: AGHT+IHkmlRBhVZg/aIm5sZrSKNLwJyl+2OKSYXz5fZnBsjea5i3QJdbgXgbXYKflGkeCsXwIu80Sw==
X-Received: by 2002:a05:6a21:7e07:b0:23d:d892:1b65 with SMTP id adf61e73a8af0-23dd892634emr7191672637.31.1754015609556;
        Thu, 31 Jul 2025 19:33:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4237390859sm991463a12.60.2025.07.31.19.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 19:33:28 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:33:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
Message-ID: <aIwndQtEoKNXRG5z@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-3-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:01PM -0700, Junio C Hamano wrote:
> diff --git a/setup.c b/setup.c
> index 6f52dab64c..b9f5eb8b51 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1460,8 +1460,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  
>  	if (env_ceiling_dirs) {
>  		int empty_entry_found = 0;
> +		static const char path_sep[] = { PATH_SEP, '\0' };
>  

I am a little confused why we need to use `static`? Would this function
be called many times?

And I have a design question: by using "PATH_SEP", we need to convert
this character to be string. Should we create a new variable named
"PATH_SEP_STR" or whatever to do that?

> -		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
> +		string_list_split(&ceiling_dirs, env_ceiling_dirs, path_sep, -1);
>  		filter_string_list(&ceiling_dirs, 0,
>  				   canonicalize_ceiling_entry, &empty_entry_found);
>  		ceil_offset = longest_ancestor_length(dir->buf, &ceiling_dirs);

Thanks,
Jialuo
