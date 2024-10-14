Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555791D0B9B
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940463; cv=none; b=EiOZJKyPR7d+sl0AZOuczCTcM7rxjbqSoRFEyBdKWxZX7hZz3CumTmdRJb1q/VrIhgRBUzmZM2V9W/iGxFGX5pLzg8G50PV7VbLILPl+Ix5nhw5bymxWNliQazrCJjxUrcTxKKSKX8B32RBwmhvTf3z/68o9/3kI74SfgrNHvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940463; c=relaxed/simple;
	bh=k1KheMtXpSLndC0+UTD5W7w5GH5qyqHxJh2uNU109pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR4AuLpIMVvmGcsLxsE/38sv1sEjClG0zCRLtfelRm2DAl0qTOWJqZlyJx9KkhVyepn8pzFSwIbEGv2Qx1xnJGbrsfvvQaoM0aFrmI4H2sCmksGjh13ZYUlI6KGnW25SCrm5vporrEofrAwvSEDMqQ6IHEzhfAdTHGmpudqpSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=q4BPro3h; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="q4BPro3h"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e292926104bso2549940276.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728940461; x=1729545261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZULkQJeENkh24tMn442cgXmsZxFMXeUppuKbrZhZWiw=;
        b=q4BPro3h2R7XyxgHbMORjjkGqLYhbvj2Nv3ImUm6PLP5X1YkXlaUAwDZq+PzXNtZVA
         QK6PmVePYarbRzA6ENUTnMreOi4ta7EN/bXSGZmYTxmWEfyAbcV8h9qtgs8dSPWjaknK
         NAtSB7JGJpWZ5JeyNj7ZqKirk881z1JSb05reQ4cBoLfOoTUBpUOo7YykwiqJsJIUBsR
         WE0svadiFg4+U7s7Cl4wOTif8XDslpK2e7DOX72I2RptUa6jpCDie1/8VbY8JKjgDRHJ
         slk4Vr3nHQ2Qt71hHK8vp8ar5eyNTJdyK1KZ2w0LitwNVaHmxDzuGkKP6p5ylUo5cjO/
         1vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940461; x=1729545261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZULkQJeENkh24tMn442cgXmsZxFMXeUppuKbrZhZWiw=;
        b=aand7c/YzJOiypwDdz5Wc/5x1xjf0Upi2sWVF+5NBl98oycMdwQGXUsAx35HTIci0Z
         QdedFOw7jLQ9Us6mItFBc1U5e3mv5lOenTo9xGEEJeCzgOc++yorgIOo0aNvk544tKti
         EMP6XAP4UjGehEc7QCbcvzfSO3+ffhuOwM6fHfHu/f/zSVG1xwoQqVjl4BFPF3Hsz5Pl
         tKsxr448cCYuYV84lsqFbgPMgp92leMKZUQdYhKX4inbQvAdBlKjBJ4KOcLxKQaoX5Ff
         bgGES3LcTgcWqUbtD6d+YPO6n47Xr4eGgCbU99rtYTdWyDSovFHcoHmyBAp6/uIEvZIm
         fJkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzN5fBah4Mpih0wAK9OP9d94Rd7SJhn14YEr8HqVdRlzIkJduVVxSamxmxam+HiVfnahI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2g9Hh9CA2pRbklCcM38uWp1oCcP95g1e8VGg9607MpBfbPeu
	jwLYXTpAYhMvziqwBNbV21hGvqEcG0VqSjwa3NujCzzyrzcszyjjnkwibJQdtWU=
X-Google-Smtp-Source: AGHT+IF5LR2WlNDMXDGpVyDQ81zbYhb8uS5EfKKwWTDKAIXSph6kirUk5B3Yn15McpZtX+uRKAFRBg==
X-Received: by 2002:a05:6902:1611:b0:e26:1422:4006 with SMTP id 3f1490d57ef6-e2919fefd0fmr10164873276.54.1728940461195;
        Mon, 14 Oct 2024 14:14:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2940b543dasm1443904276.32.2024.10.14.14.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:14:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:14:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, jltobler@gmail.com, johannes.schindelin@gmx.de,
	spectral@google.com
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
Message-ID: <Zw2Jq0cGPrRn6GAO@nand.local>
References: <cover.1728697428.git.karthik.188@gmail.com>
 <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
 <871q0jrr02.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871q0jrr02.fsf@iotcl.com>

On Mon, Oct 14, 2024 at 11:08:29AM +0200, Toon Claes wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> [snip]
>
> > This avoids weird formatting like:
> >
> >    static const struct strbuf *
> >           a_really_really_large_function_name(struct strbuf resolved,
> >           const char *path, int flags)
> >
> > or
> >
> >    static const struct strbuf *a_really_really_large_function_name(
> >    	    struct strbuf resolved, const char *path, int flags)
> >
> > to instead have something more readable like:
> >
> >    static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
> >           const char *path, int flags)
> >
> > This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
> > and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
> > few characters above the 80 column limit to make code more readable.
>
> I'm really liking the idea of penalties, but I feel we're relying too
> much on guestimation of these values. What do you think about adding
> example files to our codebase? Having concrete examples at hand will
> allow us to tweak the values in the future, while preserving behavior
> for existing cases. Or when we decide to change them, we understand
> what and when.

I am not sure I see it the same way.

I might just be ill-informed or not experienced with these clang-format
rules, but having these penalties be defined as such makes it difficult
to reason about what lines will and won't be re-wrapped as a result of
running the formatter.

What is the purpose of these penalties?

Thanks,
Taylor
