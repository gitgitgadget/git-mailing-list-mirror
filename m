Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44B2E2DF2
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939420; cv=none; b=rUoOL8nCs7zqAI5g5LM4CtdYwAyVmgJFoEaL8Bh0Qkt9s+YuuUYIX1GYBWcN8d1R4UX2+DUCEYEvfn43h4Dp3K0n4YK7aodCvdCPmv+AzYcygTlvFhlUdzAfEs6h3D4MQ4qz+zpkYH0/rIfrsCmcaTy0E8hHZdHhW7RKSnRTGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939420; c=relaxed/simple;
	bh=nuRYJtmBMX/8Q9bCiUkTxQDC1sreC7lOVJ9BcNoGi4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opxpzJt4KYJKdFntkoRZxbNvm1F747RScQXZ/laQc7rwG/Zwo6FawxuUtmXSQwTRTqXENeJnI5Is8a1BAewV57UyDzWni3LPjdS1vLBagPnI8ozvfym/sxrzX0r9cNqxJ81JL/Lzzr1gby1NO6zHzxDECT8dTJ1vIDO0wqsWgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxsJA44W; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxsJA44W"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6199e7dea32so2181945eaf.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939418; x=1755544218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydNmCJN+L4GTRIqvxFnhgUB8IvDpNqkuQU/yNdxN4RE=;
        b=AxsJA44WZMrodjv3XZY+JUxDekX2OXdJLlWEmrl6XEk7jr4R0AtZ3ROKEAmfFA9pAQ
         LAJXIkJcjZ23SNFT3AOaRITQQpC5+UWE0wcQKc/1K7fwYfpHmivlRjvhgm4p7d0dcxih
         JhlGrSlex1LNyuQ6DyGq2zmkaCTmdTLgbhuJdmdAilV8s6BmHt7k502hMwgQfzdnBZVN
         HlB9F83QZQEcTW0Se0qB2GZXiXOIc/ltACXr2Ru7+gM3LrwJs1VJlP9f6aVHqjg/3M/i
         tCVFQ+LObRyBHxCc250qWsQaFiNYpIJ9LQk1WFwh4dWTunU8RxP2S+vcL4nNUIy0xWWK
         yxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939418; x=1755544218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydNmCJN+L4GTRIqvxFnhgUB8IvDpNqkuQU/yNdxN4RE=;
        b=uwmY0/8csYauz2nSBvCj14yKR28Sh/Bm1UFztNnsL9+VU8FlnkJ0PM9ZEBoRCMz7iA
         urQCofPE0j7WVHmVpd1f66IidRZ2VxnvwnDgk39myHEV+8nci5kvI/bwmDn7j4tDcumM
         i4LcgivCJrhFMNplsHJvitr0gzRKAoOSlVRbTTaOfZxVVDk11qWlfFcJ9apMaYU3d4XW
         fY5zMW3UipFwzsfFKQpBoX3qhGoRjcUGmx3hiM3NwC9FpCzS15WbhyrR1mIRb1oJLMvw
         SuTOS5ad0CWG5hzK0S3vb2DdOQ/9aIYoHRepQVCUeHTnR1TmmTFlPe70MUfCbq2CN3Qu
         vrBw==
X-Gm-Message-State: AOJu0YwqFVM8OcuxlkYrzJokxZ6J7NV8Mzp3Dk1Ij2xEPKfCXZ5CDAk7
	XkcxCP0cvWjzw4DCuHOcxqsdBTwrfNWC4BhDnMgD57gaLiWuMEYRpsFutsHAFGid
X-Gm-Gg: ASbGnctAypINdkrdYzorbuRxVOFmBN/nA5RmWb42entiakgmDDwlf9LC6Dmkq2VSgXU
	8wexI8FWrX5boYCyis1uDxjNqU/Lh6ESDA3qy5ONV44qGtk7kYWHv98zPy3RAmWr8lmqi3+m87f
	VLVfu7heDC8HuuNVxtMh8DytHBI/i5W6WOhYxtuQzk6/zNmIQ2zvbQe8+noff9kR7X4aMJ0MJSv
	/Q2R5srQMVx0IsM4TXF5zfLA7kWQh2h0JbFC60XcCTemFLDDyz/jYKcuzcxUHVYTYOUyN2V2Lja
	Wdw0qhs9Lz4fLNWr0cwC6sTVa7vnIHFgOhAEa+R7w9AwSRiS45WIS7kWTDUC4R0P712hrWfbkWM
	eVNX/mBbUqhlq0KA=
X-Google-Smtp-Source: AGHT+IE2H4Z15FcdGYFOLBlppk6SKUvekNBCLQ2RSbCIknAJuWsOV+OE1I1aOBx2tVgmgKQ72r+eVg==
X-Received: by 2002:a05:6820:822:b0:619:6fea:2fb8 with SMTP id 006d021491bc7-61bb5bc72f0mr554419eaf.5.1754939418175;
        Mon, 11 Aug 2025 12:10:18 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-61b7c86474asm1025980eaf.6.2025.08.11.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:10:17 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:10:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/6] reftable/stack: reorder code to avoid forward
 declarations
Message-ID: <gisipxu5fdge3762fddx4qyiccwdtg34a42uiv4lpevuwgmsbz@lcj7fcifogvk>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
 <20250804-pks-reftable-fixes-for-libgit2-v2-4-fef06209a984@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-4-fef06209a984@pks.im>

On 25/08/04 11:40AM, Patrick Steinhardt wrote:
> We have a couple of forward declarations in the stack-related code of
> the reftable library. These declarations aren't really required, but are
> simply caused by unfortunate ordering.
> 
> Reorder the code and remove the forward declarations.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 364 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 176 insertions(+), 188 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 3480ad21c3..d6e4ea93a3 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -17,18 +17,6 @@
>  #include "table.h"
>  #include "writer.h"
>  
> -static int stack_try_add(struct reftable_stack *st,
> -			 int (*write_table)(struct reftable_writer *wr,
> -					    void *arg),
> -			 void *arg);
> -static int stack_write_compact(struct reftable_stack *st,
> -			       struct reftable_writer *wr,
> -			       size_t first, size_t last,
> -			       struct reftable_log_expiry_config *config);
> -static void reftable_addition_close(struct reftable_addition *add);
> -static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
> -					     int reuse_open);
> -

Nice cleanup :)
