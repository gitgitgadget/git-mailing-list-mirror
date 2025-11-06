Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AFB30ACFB
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467063; cv=none; b=X3GPZC1fEya8kuTe8gJf5Lyzyhnb16QGXPRhWOB4VGvYcuR54n9Wtsgo1T5d4FvSDId8YnnQFFZGRPerC/KqvzXyC35rsRKKYBHHbpxP0aYrnR8d746nXY57Afe/E12rP+xNov1+oeupKTckZ1Icm/atg5qC4DkIK2ferHkJ0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467063; c=relaxed/simple;
	bh=ppbv6xnUpQMkmUbM5A8YteU0HcbidL4uxC/J7y2dXNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na/pHyOXq7JM72TX9zGZGWWG0T7fCdEKapJ123hhOU0AkWaPjM4mRz6iIOFaHsR9dQvq95Q9I5fVHvp3H2PegeQIkUktPBksKHjimSfDKoN8NnVw+3ln76IouFoK5rodHt1eGntt0RNbYwdcW+UhdFNA9aTWrNiiJS2jgrQacR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTd9UlfY; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTd9UlfY"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c284d4867eso32007a34.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762467061; x=1763071861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YZc8dBE8ESAwP3ihgRUpRYix0pIswBMJlqzFmLB/NI=;
        b=OTd9UlfYRQBgwMyASJXxkJSYXdx1gm9nsvRzjyE5FFxbkGq8Jm20TXykhkMhydNlYs
         zsnMt9WiHcexipeSn6yynNbJg+2GeQ/axtjSDm4sUoRRWREyMaug6zVuP05TJzYWGpMS
         EJDdAddhO6ZUmHEfu4bnjvGFYhKjHLxDu3ALu+aWZJfY1s2vfVn0RWl5eTgrQ73taQVa
         r4pyFmUxW1APq+SIkiwihi/Gqsbsi9sAvc/wA7QFMuEUl7kRdcgscxqGQQeLeb1YOVEZ
         k7FHfHMvU55J1OaGeKanhAtOsJolZkcLu3sAVWwKT47T27pY7sS5wy4WAl71hz5YlH3v
         FZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467061; x=1763071861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YZc8dBE8ESAwP3ihgRUpRYix0pIswBMJlqzFmLB/NI=;
        b=IRVPGaHNo1nu4L7jyeqPNynw3WOM4RpvjC7ZjFkMEvopvyq1lqXgDr1Z/NdXKH6TCy
         dm62WMTD1ATpkfFqR1Cw2uaQdhyZlm2oACWfD7JhpB1FwcYErZfU45SwaNURuLjZ0fie
         1DEohGtnCknsrIaJFVo/AiOTBw/fYVnmXQMTV/1EhN7cR82FNgsxsBg+5Z/wtlZFqEBG
         tRvbEpkqdiwZ2uYzxIVYfrdUwMwe0O74oJ5oDgrxqBYmL2R0K318I8AyWJTWHziFBtLv
         0vW4mtQfTI/PLzad2jB3nWgIH2vz4Xvmq/sayrGdC+/3nCvaqjVL559aqdMyk/UryZsY
         NyAg==
X-Gm-Message-State: AOJu0Yy0CCIajqa7bK7saiPW7gbB87UOcD9w7rkvQyPKM6sFWMqZhfmR
	g+Ml6DsC1mO8PMkN1Rfzup+JsuzN3icFwQAvDavgpAyps6OHS0sXFn/c
X-Gm-Gg: ASbGnctbBtatEeqLdVsAioszc+Y+78C83LyI09u+kL5uJbn+O+EazF+9cMGi/iTkCrY
	TmB07xBws/MTZbMwS73EBD9yyDoerZ2rgiZyBDaPI0CGh6uIoeAGdN8WX9ssZA62vOGwIjfQ33Q
	0yGkgK5yDK8H2dtjoJNSMgU41nY51V1F5NizgDrr/HzyrERBJs29w6sL9LYYWv52TbPDXw4yVua
	7KI+g2SmHZSwKERI+aAqNqiNj2qwfDFDY5d7vElNyJvO78Q31xAUC9erNYJjPqTQ416sFT3gYE3
	ZbqLHijsbGn3J4xHmLRsPYRJLqA9ka6qqC+mfBS8G3rKp+QTegJzSm1jsVZp1QHcg1FufRsg/KT
	JFlZplFswhf7eWiyjl5hQ6TDLTDFo4kQ8+rAXcD+6X9Eo45VewNaNw7BrR3XKN/fjNT4LCTSugu
	JmBNid
X-Google-Smtp-Source: AGHT+IHDXPGeYbXpcb5hu8XwHmHhLNzgHeoY/unuiSrAhNLTLwlMGuvMNk0NyRqqS+j+o5/o4H1Mnw==
X-Received: by 2002:a05:6830:25c5:b0:7c6:a628:22e8 with SMTP id 46e09a7af769-7c6efc9d2fcmr1148326a34.5.1762467061380;
        Thu, 06 Nov 2025 14:11:01 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f583a9sm380797a34.9.2025.11.06.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:11:00 -0800 (PST)
Date: Thu, 6 Nov 2025 16:10:58 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, 
	David Bohman <debohman@gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
Message-ID: <cwayobvml63evuasdcamvkx5rpwectmwrwxr3cwxqrkxtketqa@lzm62c2xe75v>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
 <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>

On 25/11/06 09:39AM, Karthik Nayak wrote:
> @@ -1858,33 +1902,8 @@ static int do_fetch(struct transport *transport,
>  	if (retcode)
>  		goto cleanup;
>  
> -	retcode = ref_transaction_commit(transaction, &err);
> -	if (retcode) {
> -		/*
> -		 * Explicitly handle transaction cleanup to avoid
> -		 * aborting an already closed transaction.
> -		 */
> -		ref_transaction_free(transaction);
> -		transaction = NULL;
> -		goto cleanup;
> -	}
> -
> -	if (!atomic_fetch) {
> -		struct ref_rejection_data data = {
> -			.retcode = &retcode,
> -			.conflict_msg_shown = 0,
> -			.remote_name = transport->remote->name,
> -		};
> -
> -		ref_transaction_for_each_rejected_update(transaction,
> -							 ref_transaction_rejection_handler,
> -							 &data);
> -		if (retcode) {
> -			ref_transaction_free(transaction);
> -			transaction = NULL;
> -			goto cleanup;
> -		}
> -	}
> +	retcode = commit_ref_transaction(&transaction, atomic_fetch,
> +					 transport->remote->name, &err);

It looks like previously, whenever `ref_transaction_commit()` or
`ref_transaction_rejection_handler()` returned a non-zero value, we
would "goto cleanup". Now that these operations are handled via
`commit_ref_transaction()` though, it looks like we no longer handle the
"retcode" return value and just continue. I think we still need to check
the return value here.

-Justin
