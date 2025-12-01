Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFDA3385A7
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611892; cv=none; b=eKNtWvv8XlDftMtzx2xXFfeplIMQFVq69uNF9T6v9guamKb4Yfb88IRS9cBtGKI+O+bDREUEiOYPxJz5SgPE9vmDajW/DLpFadkI1ZDZYp5YwRqGpElvcjhQuuj3wlRax++CMPUyR1pPCA9Wk9303EJzc0YfXP+DAl42syENFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611892; c=relaxed/simple;
	bh=ipMRNP8dIaImuzaCbBFCWwWFiSoVGtYRh5NO3geEQBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlui1EIFfDI/yTfxx3TcWC3z9RHiBS4VT2s40VoF0N8sBsiN/t02CtiBNTjx28Q45MNwzpALpP82QoVwGiO45h4WuTa5Fi05KKsuUjSnNeKRPsBlT7sC19wGOnGGhr5IWZQBzZzQMcISBVT/q/r9pZkO3vE1E6vAJpwLHXbybU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRfLTpuO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRfLTpuO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779f9696e7so2092045e9.2
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764611889; x=1765216689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zSG5AKh4MtYHXNCd6I6BiYaBhnBZDYFMXi06nRPSWc=;
        b=jRfLTpuO6n/eMd9/q8tcCaPw+N2ZbvqevQMZejKcmY3BxQJAtyiMXT7O4dXM74hhTX
         FTpTdDDfqmVvIqUv+gf6Xdzyh/LXkSWeKOhq8YGfrhvYWZBW4vW68xMv7LAOsav6U3KT
         k5ZUDLdHLsc74/wr7/jP4dfCSKrMjL1WANJ+tEKvZsKS07K3IYhwfpUMhncRdoRyB7js
         Z6cdBeI2Q61YKibO5mMVEN/+qYJrMRbov21H9Ic+U342WotPRquFGdIcBsw10qCPQMcz
         WjS9bbYhDEhaFuSMbAUJXal735Nc6wxGMaNMz4aHdkIXEbK9cE014c8pSVNgIfxo/1u0
         edWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611889; x=1765216689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zSG5AKh4MtYHXNCd6I6BiYaBhnBZDYFMXi06nRPSWc=;
        b=VgC18AhH1iPI6ToHqAdWN4cQdes0iMg9AUxNs2IgJKl9kfD7WmRX5hkAHThjy1Rajz
         IZ0vd9Ht2ufpyh1NXeuKKZRoYBcAm0pkBW9xsL9VuKWIan8X6oidxrWdIVXZq6l4jopm
         9vUFz+3baICiQDdP6PJ/f7PJBgiudbPdHSSb+a62zn6k+GBo2V8pGVcD5dz35OsALbQi
         lczZLJG2kb5atF+v7dALeTD7RN1EfsqCE1+sm9XCJHq9g/pW63FH2GU0idY2y3uh1/pO
         6yy0m2vqQCfQf94vTgXwWZOXNPwiiiYWTLzMzpSrKRQX70sv3Y/iaSb4D0G8p0icZORi
         uNJw==
X-Forwarded-Encrypted: i=1; AJvYcCXfg8F+QrxTPecrwbcTCRoExG0ItrdzSr7E8g+xdnheHeFsYHAsMQW4URlXY93xvp8BCV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlA/j6OLFXScM22jpvIj645o8ybVUXstuVLd1OhrnDL1qeomQB
	2yuG1Nzu6r3XLQ8ACUpPWDH0dPrx7sZTTeofXbgcGA5iHIv7lIqhJicD
X-Gm-Gg: ASbGncvft8rVJi6SmjpxILlFif/zSWPsjBupY7zl5kppWge3zhTAtO1Bpk1zONZ08a7
	BaHSq47+475AefkcZzOrjz5v4jWRnGVTRe1vjV47CodId3kzYo2jbW5e4O1qTyEv8Au1Dqmsf7k
	A687ceK8a+6xE0SB13KsYffHnlEhC1kPd+iZJgT3HDGxLAqLjoBzKP3y83YDFwHvpo+2FUJ3Iti
	rgTEwo3mcWWf0MaSo+HjXjGIawjGmTzNK1i15ZkSYsWDT94UyPXVo52gUD4jJX56oZ9ZuMYxMJ9
	TqA68ncGhDSGB+FBNWYrkQEYP8effwhUBYQcR6Fr7/TQ61NyNo9cxCnXrPuxZFFoNK5DwtfWYTH
	KeR4UYfCe49Kyccj6qcx2cxC3nE7WPCPCBJgmVkZZrkjUMJykpzYx3JTuCBiPFjFMp+07wifyWf
	XIYt+7kFnx6qGXMg==
X-Google-Smtp-Source: AGHT+IFb1rbm1DCRDIDS1F+RdxHWXKA+aqK1yA2yODqHQldEEseFuKfFDwlu/g6b+9rPzM7tHbWoHw==
X-Received: by 2002:a05:600c:a03:b0:477:7a1c:9cb5 with SMTP id 5b1f17b1804b1-477c317d347mr229403765e9.7.1764611888983;
        Mon, 01 Dec 2025 09:58:08 -0800 (PST)
Received: from desktop ([194.127.199.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc186sm309111115e9.13.2025.12.01.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:58:08 -0800 (PST)
Date: Mon, 1 Dec 2025 17:58:06 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, matthewhughes934@gmail.com, 
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 5/5] scalar: document config settings
Message-ID: <wqvecbwieexjpp2pgxn66mlvq5foiw6as4doxgyiehzjuo7hv7@jrskhegeuqvg>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1627dbd94e3330117fbaeac2e2373104aef531.1764607847.git.gitgitgadget@gmail.com>

On Mon, Dec 01, 2025 at 04:50:47PM +0000, Derrick Stolee via GitGitGadget wrote:
> Add user-facing documentation that justifies the values being set by
> 'scalar clone', 'scalar register', and 'scalar reconfigure'.

Thanks! This is exactly what I was hoping for.

> +REQUIRED AND RECOMMENDED CONFIG
> +-------------------------------

Would it be worth noting in scalar.c that the config options listed there are
documented here, So that a dev changing the list in the source will know to
also update this? I assume there's an understanding that if e.g. you update a
flag you should know to also update relevant docs, but perhaps this is a bit
more niche.

> +gc.auto=0::
> +	This disables automatic garbage collection, since Scalar uses background
> +	maintenance to keep the repository data in good shape.

Checking my understanding: this means there will be _no_ automatic GC in a
scalar repo? Since scalar calls 'maintenance register' which means
maintenance.strategy will be set to 'incremental' which won't schedule any gc
runs
