Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEE275B15
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370355; cv=none; b=tOjK+mQ3uuaZmPa1ohlxx0h1eJPpugbVQH5wTS/H01SipQ7FA8+2hi1zLUHStUXQ6s6cqv7VxFQK04LuvOaBdh7P3j4x0Zsq2hw5EbtQkadDbnhOYP94DYwf9sJDXNUvZLTnndRR3kZAFvIKytIhDIW6HRw76dju/tlnS8jGKis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370355; c=relaxed/simple;
	bh=utScv6z/hXFqM8gYgYfHpwu0yU09fzOCBe8/Bh1FIx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fttU2zuDd24DkEkUKuhOQmPCcwQMiryHqJ70YcBii1/3jNP7q9SxBKI97vunyZPvAZAB/uCQBArnAAHwbgQyAiWEe9TNeiosNQ3tnLIESw4wLPc1BL2LL5062am+iCXvEk8pkfneu1ZYCqITcNI65GdeCYWfpBv83uZs+mbDEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptGD3F7M; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptGD3F7M"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so92304205e9.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370348; x=1776975148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6m0r6T2zFs+Hg7pp06d/BQD53Eq27CtNKJt1/jKNs5M=;
        b=ptGD3F7Mwaz6Uz5rWHCCBcfS6Bnmq9UvzQ98B1mQDUDVS50pUYpJK7RlOZHUIQNsXM
         38BpJXGt60Umk7QI7G0VnbToO/xiSYxuiOzgt6v/kw3G0XF8gK9+DAaoI2jFrOE1/etC
         b8ZUl+A/tJo5KiU+DR3Qxxd0P9c17UpA6swW63wFjc8s03X6edRMkj6T4lnwNGwB0Dxb
         agvp8K0ddwXZjnU0dZ9MiFvfHYv4OVEYlcNCfGiS2OIoP7zbBDLje9DimUS9NfeNEk8X
         DUZt1Voo5Ga2GTW2Ot/jdmjNVqF/OmPubPzZNayfm8qfkkf2QFExHJ4zVC+LJ+JvrcYQ
         aH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370348; x=1776975148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m0r6T2zFs+Hg7pp06d/BQD53Eq27CtNKJt1/jKNs5M=;
        b=VT7mbTFd1F93XlAm/7NJWEzsb73xr1Q22JTe9+3eCYSIoKTVVjaB5J9rJXhpWHDXMv
         VswwCHVKoYKip8mgD7ZKfPUDwI1iS9P3YDqYedrxKN21XJoXgo8Ozoldxsm0D8Q4ATeC
         qxr3WVEmEpsBJHs8S9dj+7mjLPpiOCn9ZNOE68BTXK1UnD7TrpQiYW8p7nhAV+pN/Myt
         mIvHZrmvMdTek2c4hidO3eg7O2WTamgCMoJcQLnPkrtVPtqFDfPD1ZzguiQuAa7xdiU8
         ebIDnDXIWwukDbXV12lEw/4LVqDEQ3d7gBiTxRUt5CkRd73YjUm1TX8qDW+HBF5jdfA9
         nh9A==
X-Gm-Message-State: AOJu0YwMSP3cv8oNQVSYwHmo2aUGCpMki0yxhDF6C93OinXF/xaxf/MZ
	e90zpobI0sVTouHos7fXHc01R4IGCamAhpQcslzQi3x7eJ+XtbcXZsL9
X-Gm-Gg: AeBDiesfZCq+EBdzz1vn3ZkPQIFE7ZYFqraMW+52iEyp4R8XsW25IT21zqA2hjJAFwu
	lBDMQJBmUcgrntTJiy5MPIF73KK6g19fCiFPgtdUZ6GMe1iBar1rYV7Oq0z3oFMeIEMF4M/s2G6
	KBgHggQcQ9d7UFuBu9LD7Yo7pL5DYWwWM6ZP0NMGxESVTa/2Aaf1RJghnTKxTNgQhS24w/9v3Zz
	LHcJKsxC/fAnDKnRTueB7RLCmkbfiUsYZ7jaoDO5IC7m6T8liG/tI2a6YpfmzOvZyXIBtqWnbqV
	2+yKBZlUtoXKF3/161KUJanolIP3f6vlZ1Y7PIPZlBE6j1LllT1RhCwY6vTJSPJu2/VV43rL1nC
	19yNI493QuDZG1gQk9DW9sMZ6u15VI/L4pgIUd42LxBy0xA0Ft9xyWIz1MW3nQ5Dm4VnVrtmzkp
	KNHagi/6qV2v2Th7gcnZFTpnw44a4GRYMBS3Ul96SMV9SePvFPx9tT95UP0XMzr5gbWbf2PYe4o
	GFhxS42zIDRJBlngzy/WIdBAbzXp+e5hg==
X-Received: by 2002:a05:600c:8582:b0:488:a82f:bbb0 with SMTP id 5b1f17b1804b1-488fb798fe0mr413305e9.27.1776370348228;
        Thu, 16 Apr 2026 13:12:28 -0700 (PDT)
Received: from localhost (20014C4D24C75900EBDDC50441E421E2.dsl.pool.telekom.hu. [2001:4c4d:24c7:5900:ebdd:c504:41e4:21e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm75323955e9.6.2026.04.16.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:12:27 -0700 (PDT)
Date: Thu, 16 Apr 2026 22:12:26 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 11/12] t9902: fix use of `read` with `set -e`
Message-ID: <aeFCqhGIWQgE9lq6@szeder.dev>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
 <20260416-b4-pks-tests-with-set-e-v3-11-7a90e5dccadd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-11-7a90e5dccadd@pks.im>

On Thu, Apr 16, 2026 at 01:19:28PM +0200, Patrick Steinhardt wrote:
> In t9902 we're using the `read` builtin to read some values into a
> variable. This is done by using `-d ""`, which cause us to read until
> the end of the heredoc. There is a gotcha though: when the delimiter
> isn't found at all, then the read builtin will return an error.

The absence of the delimiter doesn't make "read" return an error, EOF
does (that's why a "while read ..." loop works).

> This
> hasn't been an issue until now as we didn't run with `set -e`, but
> that'll change in a subsequent commit.
> 
> Prepare for this change by silencing the error.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t9902-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 2f9a597ec7..e3a7df7691 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -590,7 +590,7 @@ test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
>  	__gitcomp "$invalid_variable_name"
>  '
>  
> -read -r -d "" refs <<-\EOF
> +read -r -d "" refs <<-\EOF || :
>  main
>  maint
>  next

So AFAICT what this "read" does is equivalent to:

refs='main
maint
next
seen'

Isn't this much easier to read!?  OK, the first ref is not aligned
with the rest...  But I admit I had to look up the docs to see what
the empty string as delimiter actually does, and even after that I had
to add a printf '>%s<\n' "$refs" command to the test script to see
what's exactly going on.

