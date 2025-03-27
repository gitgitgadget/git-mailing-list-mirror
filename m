Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAC216E30
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085395; cv=none; b=Q3lefEi9K2iFH9cA5QnqNqCUAuGnpPXhf2603GHQTuOPdVK7KWeoXb2kZ5u3//G9t+6IsxowP9t7pJFGxUrCLeDOlTt6znUnrY3bCylpg6+cY9qCc3FNMb1m9dKs34Q7NnomN8d2TOfE+DMjrwe8EujVBtJCFWrCHw8CMbWscb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085395; c=relaxed/simple;
	bh=HoU/CEQIwlS5QgO4T4uIpJginBk2Bpvk26lUszoUjHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQjDLNNxJx82zirvWxxGuuBc2PpDAm93gtZZg/YzyEQeP+F2msMefx8ArQailp4mapE1hAUFhOPEIjz10pZdeXAHPnQIqklL5G3tmhf6oTvQwHXUaY/7Wa6WJB1ExAi0KDwCGXXWUpSezSezo6L6eUYVCAXgA8UREmHj/KwlU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tN2FuaHE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tN2FuaHE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-477282401b3so11212621cf.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743085391; x=1743690191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=of/3txpYhIRycN5dzOjk5ugyZKqgmqOrVvyk3CKzhiE=;
        b=tN2FuaHEIKUPz6bbKqaQR626V1cSAX2mmNrNyKgpKHeI3sHcQFnYDB7UyWrkA8ZSPg
         Inho0KWu0FTbVzSnrvFxUBQtm51buDToGfjP46NpzVLw//RkZoE5IdRMMyx7xjVaDs52
         ubv6wYozW9riARhRhRNB+MjFDuGd/FDyRVinf77w2j1YjATr05dtaeenqTfKB95z3qBX
         cxMGq2SnxlkEnsjQR4ype46c7butGUiWMAVIgEt6HTBcTLFBD8ZhLcSH/mvS4F/5lgx+
         r3MdsaCjXJv1RYf9t8AOR0knGbEorHJ9SIt/NCUGgDtsm6lgCWxG8rtIsNMTfiTYhbYa
         kmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743085391; x=1743690191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of/3txpYhIRycN5dzOjk5ugyZKqgmqOrVvyk3CKzhiE=;
        b=CAPbdX/0T3WWAY4CbGOyDJ1ZVEfCv7V5l/AlcwMdIsKJhoOV5AhgGMLEKsjrr/z3n8
         3FUqcAUf8D+GlXJ0Qnf2GmS+yEDDe5ULxetGDn3H5TP+aPy7qha7boLikRKRktEHvpl6
         Pe6zbiq6x0qgP8pE5bjHeG2qGo2WZlU09I0g4mkSze5kt+J2xIygfdbD2mWfo3lJR3id
         cpklJmSGKQ062ktvtuXQ7s4R40S9bz9L1nDQTM9ZvJjNGydwwe4sdfzvaOm+UTuuA5VV
         pU6OB3AT+TTZT59CJOLxM535q8cuOeR64IimbFfMOFuSluKSjok8eOG5wVpJK/APLk7z
         1llQ==
X-Gm-Message-State: AOJu0YwUfW9+z6p0QXg1hUnEue8GrBFRu71pSki+fC1br5VKI0HMWDt+
	tudLjgQwVaApGdeSUxjraSQAIyFzDNsruUDMo3UyHDl9UBwymEGv+LSUXmWxh1s=
X-Gm-Gg: ASbGncsWIghJvibl34eMLqCuMROqv0O6qpaBFiPR36h2v+mHcSXsiHQ1Zc1sSKYkRtK
	y2Jp1/7XGLM0LLHW2exrYn2s6IeKhV58XcJUKGjuEi09G2GIpoWcRWdDWiE9N3U4iruhc2I3esG
	PPLBVa1kJ64+HZUpw4bQRxa2AofoDrFi2c/0VI/jL/Co+SQjDoPg62LaQc+PR+UpEMTfkxf1GUQ
	NDVREAjnDL30YqkFB05F1zac5eUz6IH52GSr+APalM/sM+bvTthOtWPRUhl6k1ar+bwidLPpc4l
	RF44R+smL4afqmn43DWaGa7+lGIuowfX2fbv50HkAQscIW+iQ8Dxy4xUMfgNngb68dJs0mxhJXG
	vziGVD9mD9F/5Tf6R
X-Google-Smtp-Source: AGHT+IEKrbmQa2B2mirjHBnrVvFySAHPWBzcLcQGhxernGUNGRoWQG/tWuZ5WylQMwrkVwfO0udULQ==
X-Received: by 2002:a05:622a:4106:b0:476:77a5:3104 with SMTP id d75a77b69052e-4776e07ad57mr59639671cf.11.1743085390822;
        Thu, 27 Mar 2025 07:23:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d1760e0sm85286181cf.23.2025.03.27.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:23:10 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:23:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] load_revindex_from_disk(): avoid accessing
 uninitialized data
Message-ID: <Z+VfTUrQe1x8DO+h@nand.local>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
 <b9901920de20ae29bd55bd68dab37a737867593b.1743079429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9901920de20ae29bd55bd68dab37a737867593b.1743079429.git.gitgitgadget@gmail.com>

On Thu, Mar 27, 2025 at 12:43:48PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `revindex_size` value is uninitialized in case the function is
> erroring out, but we want to assign its value. Let's just initialize it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  pack-revindex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-revindex.c b/pack-revindex.c
> index d3832478d99..3b007d771b3 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -208,7 +208,7 @@ static int load_revindex_from_disk(char *revindex_name,
>  	int fd, ret = 0;
>  	struct stat st;
>  	void *data = NULL;
> -	size_t revindex_size;
> +	size_t revindex_size = 0;

I'm certainly not opposed to initializing variables proactively, but in
this particular case I don't think it's necessary.

We assign 'revindex_size' out to 'len_p' when we enter the cleanup
routine label if 'ret' is zero. We'll use 'revindex_size' in the same
label to munmap() when 'ret' is non-zero, but only if 'data' is also
initialized.

So there are two conditions where we'll enter the cleanup label before
assigning 'revindex_size', when git_open() returns a negative value, or
fstat()ing the descriptor that git_open() gave us returns a non-zero
value. In both of those cases, ret is non-zero (it is assigned to 1 and
the return value of error_errno() in those cases, respectively). Since
'data' is also NULL here, this function will terminate without using
the uninitialized 'revindex_size'.

If both of those work (i.e., we opened the file and fstat()ed it
successfully), then we'll have revindex_size initialized to st.st_size
(really the result of calling xsize_t() on it). There are two sanity
checks on the size, both of which happen before we have mmap()ed the
file, and both sanity checks set 'ret' to a non-zero value upon failure.

So by the time we '*len_p = revindex_size' it is guaranteed to be
initialized and just junk bytes on the stack.

Did this trigger a warning from a static analyzer or something? If so,
I'm happy to take this patch to appease it. Perhaps that it what's going
on since I recall you mentioning that you were working on enabling
CodeQL in Microsoft's fork of Git.

But if not I might suggest dropping this patch for the reasons above.

Thanks,
Taylor
