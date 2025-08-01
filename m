Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F602156C40
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019237; cv=none; b=ZNQUjSs5T4+nelCIwjhv+D4KUPYE5m0pfHeW1nRbwN++DO8Y80/AsmWzVcC+4ecCEh6xI0bstXJIjL4IqllElpBc6h860tbEx6CtAYDvVgvmo7tFWxIcIhbFc/bWPZd7fJpxAnKN3XYNmnieJhmQydTzkKyB5lgYEtnJWyw09Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019237; c=relaxed/simple;
	bh=U8su84/krvxsM5evuEWiFLSNzXd0ZQSlIpG4T7GGV+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERAmFasI2PA1reEn1TRY2+YkbuW9ebRwsG3/K2bACUKzngfWgnmc7HNNxlE8+0B+lpp4+vZ4MrPXOjJOAT+FQqnREoDTkyLkGHgKREE0f2ZwVtnJjXkO8BxugNyKpc6V34406T3d1bUSqh88NV4dx+TxesTq2daTfMCX17PwJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T89fnwsL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T89fnwsL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24014cd385bso5272335ad.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754019235; x=1754624035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fl2cJAaDSq8Z2QLs5qtbRSUkGQvZZ2O8BAxu/1o+G04=;
        b=T89fnwsLxBDbe8WWA2nQG67NjBZXLUS616aAvM+zQrocrfZJn6lyGVjSZr9fGMDZEG
         J6f+FwOPWOzt5KdrPO35mq//zlCjeN3wfWJo8Pyp7Lm9QjD3rC9Ugzj1XV0b2sjYAWYF
         n2libu/89ZzzWk6qdQPm+nUzL+fxAnlEMn1RTpbG9032C0D9UtPGjINmHPeHKR3qq9kB
         MA1DkKexPZW0mqTNCTHFdVO8eQ2gFF1K0K0UD1ELcXMpiw9f/qf2oh125LhEtdYBYJSL
         gTYl87HYhp1qb4b3JuJKSgPkyjam/9Pfd1opZaI0eKVDPOW30Lx2zhSZoiqhaY2Q7GUR
         T04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754019235; x=1754624035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl2cJAaDSq8Z2QLs5qtbRSUkGQvZZ2O8BAxu/1o+G04=;
        b=Xyg+nrDrlKcqntAJbyPw5+wbldiNPhMU3LAlIR/j9ndW77tLb1G0wd3QWfIB1JTD18
         QCB6ppSIzpVn30OhYYPVaF36LzDOzUOzr8R3ABFD7FM33apXH4L3U1A3x0gjExSsKYtz
         yMnByNU118nB07Pf7jN2+luQSS+Xnr+DtNgsYmYlFTXdMUsVupG7OEhcCD/FLHwQbawR
         vZ/kFJjg3UuiOQOt8Vob1KLCmXmRvKwCseWv/3JoMWj0FYDyKLQ0itsIwmizPk+K7kqz
         nWMhpEz0Vxc+Ms6wqVIFJfyw8yxV4eO6XzXvHgvZlm5hK0F2aPEi/+41mVN+P8t0XUIT
         tIvQ==
X-Gm-Message-State: AOJu0YyGibkiaRkxChPNXmEi6+xz3aschZ1qKFfUvvb5JwVJNH5tcO++
	ftAAWXuVqoBLxxoTnR6WF+peuLMgOQKnUvimdEhDDHMM7SIrIkT3Fi//
X-Gm-Gg: ASbGncsphuE1KXeYJkwEtr7U40HTae6Xxty2bBsvgRybsDoyIRuHYpM6wvHfsp+mPq2
	qXTNYdveNsnTbPmlYSShMDbZ4K5FvLrj2TB3zADQWS5JciOglW14hFRurRzoSrDcJj5JxishHwr
	qqPko9BuYnv7Pidps3y7CfrcMf494gPeYq35qmbU8B6Nvbx3FllOl5f5hKwxqAK/2UK5sCj1IM7
	5sHK/FLEXKDJTnF2h3yas399nuYxQlF6ZGsQO5xl/oEq3mfy9Xm8Acv0qdRFV5PjbeLVx/ksfF8
	SP6j8IK4ZNXYSJaPBNdUFp8mC0zp9HZfp2m8Ns3tacqiB+cAg/RUZX3phPZhJMIJyDeexSxfCqf
	noE8q7eCFylUeQuo0Lg==
X-Google-Smtp-Source: AGHT+IG1PvRNb5sbjpLTQ2N6FOEwN47K1Bt0vp/GQLxK+4HTT2XW260RnHqw6EE0VJUjnv76KVCJNQ==
X-Received: by 2002:a17:903:2290:b0:224:23be:c569 with SMTP id d9443c01a7336-24096ad18c9mr154801245ad.22.1754019235308;
        Thu, 31 Jul 2025 20:33:55 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3207eca6ea6sm3304973a91.19.2025.07.31.20.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 20:33:54 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:33:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 6/7] string-list: optionally omit empty string pieces
 in string_list_split*()
Message-ID: <aIw1niPrhuvt8QoQ@mbp>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-7-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-7-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:05PM -0700, Junio C Hamano wrote:
> diff --git a/string-list.c b/string-list.c
> index 86a309f8fb..343cf1ca90 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -294,6 +294,9 @@ static int append_one(struct string_list *list,
>  				break;
>  	}
>  
> +	if ((flags & STRING_LIST_SPLIT_NONEMPTY) && (end <= p))
> +		return 0;
> +

I somehow think we should do this directly in `split_string` function.
And should we use `end == p`?

Thanks,
Jialuo
