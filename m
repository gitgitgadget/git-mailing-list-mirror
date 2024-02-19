Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AC2E416
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364477; cv=none; b=m8LRv+uyHJ33uwmrOauKEN5JXvZdrmwqFEEG7245Aj1rGuwn+kO/rrCV/ICs76f3pdWFNgyoLQqjBYd3iqb5afjbplW6pzoD+NIWP5xTgHPr6msB+jAAQ8DTigHi508dFQx4bfbFkR7sMIT3N8dh4UmIKnw7AML9KPStzYPYpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364477; c=relaxed/simple;
	bh=0CTKTecjttVL6Z2D6HlkvceEreGWhqMp+LHd41ZZ4eg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lqmlvf7AYFMZtMD09GSBDTSugt4FcyzglicUMNL9cIM74SgfXxeu0Qegzu778MCgJ2AGAeNbOE2NAwbkAZo4I9Y9PDAYNbvodf8teITekrHMgl7h/Z6N6XLm9iYkeS35h94zDWdcuMjDt7Vf/en7oB0Z3CSsZTsvDrLBFuWaHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvGVEPbO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvGVEPbO"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f51ba7043so15137966d6.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708364475; x=1708969275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42wFvrX2QuYu/vnLYHEprBydt7WmxnS+eF+2CPifYso=;
        b=JvGVEPbO6KGWutDSKv0wK9IoKExN85Ygox+BRD+0bkV8wK8RML9o8Za8VJcrNGfuLw
         4GLSNb/SSghWDJ2hvbJn0U+Mo4CCCPV2EVn6l9VptdOTfoJKlF0pNUjK+YqdrIkFmq74
         vej3J80oNm+ZQSBwhEkizODv3j7wOYCK91aczdY1LvEa9/CtDRQFYVOvLVOGPkSBvjJf
         moXQgfXm5FYj0wZyCaMmUqtR/CjaUCP2szji2uM7ZN8/oNB8YmMVSfBMnS/HtHd3VdkK
         98kERrTlj3XBpuISuZqFqNZYS9mL0Po6m5Mrn8Oeo2QIFf9wmIfOfkw338V4RQ8rqetv
         lfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708364475; x=1708969275;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42wFvrX2QuYu/vnLYHEprBydt7WmxnS+eF+2CPifYso=;
        b=mftva6cs8VW+dkKUhdl3DU3oBXPMZvTmcLeWkSnKk4XjLtXburVcIPxxr5Jg7SzgPG
         blHrnteDamrueU0puwuuOBs+sNxWmfiUDxyUQaB7VwNbd0w05ZLluSdLMHgdhg28Jlhf
         qrUkmQ9O4BjtWccIb9Hl/8NhfMB+tUaVOFbCZBIRmnU8KkI9RhbrOxMKgjCjc8GMCTJd
         2vvASCThXmiC2Y4kT1yV93ku6TndL1rl5V21Shr9vANwxTpLXtCBXJD3ykLjDF94+52a
         XzHkenGtT9hID5zvXjRsGQznwqtOufIhiQ2TLVfhzpGxNtsJqJCuko/OAeytEp07CsWk
         Umtg==
X-Forwarded-Encrypted: i=1; AJvYcCVmKcFsmyIPelNBkhGWM+RmRMh+HBeYINw00zxc/kDOp/HY6HEd8LS1XaRWHne1eOaYhdEYlXnwmPB7rR76BekCaglE
X-Gm-Message-State: AOJu0YwS8zhVxwrZ0ugBptrGbvN27cy24pSpEFaiaq5Fz/1LjnX1H2Oe
	vV8oKdKlncHoEVFKglqujU+jXTTlTYw/5YYWLsllYyP72rSQ0TuTp9gld3fP
X-Google-Smtp-Source: AGHT+IGjGU5SmzPtlpPJKuvAb54FimbN9t1d+zpsNELgfEcTTjomyxuQfh8/waEEAnrK0beSnQZt9g==
X-Received: by 2002:a05:6214:27cf:b0:68f:3c24:4744 with SMTP id ge15-20020a05621427cf00b0068f3c244744mr11929293qvb.5.1708364475026;
        Mon, 19 Feb 2024 09:41:15 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:3855:68d3:c5aa:248b:c146? ([2606:6d00:17:3855:68d3:c5aa:248b:c146])
        by smtp.gmail.com with ESMTPSA id h5-20020a37de05000000b00787314ec98esm2644791qkj.135.2024.02.19.09.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 09:41:14 -0800 (PST)
Subject: Re: [BUG] git commit --trailer --verbose puts trailer below scissors
 line
To: Jeff King <peff@peff.net>
Cc: Linus Arver <linusa@google.com>, Git mailing list <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
 <20240217060434.GE539459@coredump.intra.peff.net>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <ca6a73d3-58b4-e65c-4a8f-e6ddb3e86902@gmail.com>
Date: Mon, 19 Feb 2024 12:41:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240217060434.GE539459@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Peff,

Le 2024-02-17 à 01:04, Jeff King a écrit :
> On Fri, Feb 16, 2024 at 04:04:18PM -0500, Philippe Blain wrote:
> 
>> Hello,
>>
>> I've just found a bug in the current master: running
>>
>> 	git commit --trailer="key: value" --verbose
>>
>> puts the trailer below the diff, and thus below the scissors
>> line (and so it is discarded).
>>
>> I checked that it works OK in 2.42.1 but not in 2.43.2 so it is not
>> a new regression in the 2.44 cycle, but I thought I'd write now in case
>> someone spots the culprit commit faster than me.
>>
>> I'll start a bisection now.
> 
> Looks like it bisects to 97e9d0b78a (trailer: find the end of the log
> message, 2023-10-20). Here's a test that demonstrates it (signed-off-by:
> me in case anyone wants to incorporate it into a fix):


Yes, this is also what I found - not without fighting a bit with 'git bisect' though, 
but I'll start a new thread for that. 

So, it is indeed a regression in the 2.44 cycle.

> 
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index b5bf7de7cd..d8e216613f 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -485,6 +485,24 @@ test_expect_success 'commit --trailer not confused by --- separator' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'commit --trailer with --verbose' '
> +	cat >msg <<-\EOF &&
> +	subject
> +
> +	body
> +	EOF
> +	GIT_EDITOR=: git commit --edit -F msg --allow-empty \
> +		--trailer="my-trailer: value" --verbose &&
> +	{
> +		cat msg &&
> +		echo &&
> +		echo "my-trailer: value"
> +	} >expected &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -e "1,/^\$/d" commit.msg >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'multiple -m' '
>  
>  	>negative &&

Thanks for the test case!

Philippe.
