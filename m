Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89071F0E5F
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355028; cv=none; b=b39BOMapxFgIyOXxlg+qWxUyCaqvM0KKyx8KuWRbgGIlAEsrPF6bgBsaBrE139g0kQ6Yhga8bkgeifOISHGAncIlcQKBoO0WHnEaLa0i/0IzQmc/Y56uyR9fLbEuQ6vgAUf9maRnUboxQzgokPv25CDbmGCPjjo9IbXfWQiid8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355028; c=relaxed/simple;
	bh=HX65QdcTEoClrmnh3ipUbQ8X26zbR/EYTYvGXRSqaP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX7T4xRYiinV5pJ7E8/2BrgZjD3bdPjEY+NBg7ec8Cle4aolCfL0mYosNCub2rI2QA0Av0xhpuBuB0bkdU+SobN4tUN2eieIsY6ql8+dZUGvXXQcz3FP3sv+y/g65459oi4ZF6IX6kgh7y+N8Ji8v6BvZA9kWRZmsZlQ/DFsbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8GcLkc8; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8GcLkc8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47191bcb2afso23576531cf.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 02:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355026; x=1739959826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvhJ8XWJE2gYi+WKMwlYr6B3jWKy/wekfNN06HMyup0=;
        b=H8GcLkc8k6AJKXtzr2nBwzqV6QSjftA0uAYyLbLLkYNMUL6Ab+Xz4fOi4ciOJiFVmS
         WKoW28lxj0lvdrcPYzAwMy1oOmulK0KfSjFTJaRlEY8aMI1ksiYklQAjlrA+6w54LVzM
         f8UYfw9sTLW7hqZzYq+4pmvI20nhaP4BoHuXTebiZpHzPlnJi6iUklAsYj7nJo4vg+Gr
         ZSiqWs6IbpQJ5qEAN4DZ4VCKNR9v38xN9BT1f/3bdENoqORn7RUQsM9y9TNoGvkI5W7f
         jfqNUtWZmHI6d32zmUhIiahYKexN8R0ydqTsYZqYpOY4by/q/EFFhXUThQzouMIbWW6+
         il0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355026; x=1739959826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvhJ8XWJE2gYi+WKMwlYr6B3jWKy/wekfNN06HMyup0=;
        b=AWlLqtK/ZVsXo2+GsiMlzEEsXY49r6QPi23nicYwTI4QiGRuwnhWFIJ/Ti7JBCM84q
         ycDfGzEtgTfnrdpe1oXfbt+JCue6Gm5nohQIf0Q8+F4L8dDX0CGSLzFRMxIeoKXwu+5C
         hsU4v2hGfsMtcMU+I37Ym4NYWQfzP/c1zDnMy/4WIgYV3JFaSps2Swscjc2pgEA81/Um
         aSSsbIgUPhTgAnENuOCAiYVzzMxwv/M1yMsme+QVT0CFRFZjQyVWMOtk6nfnwRZx+5Ku
         gAaCON/Wxvk9JsYraufRcWn5/qN92vUZqERjdYKFOom0bEV4saUzQxXnQBF68SaCVGoZ
         ePxA==
X-Gm-Message-State: AOJu0Ywu3ZpxN66O0yJcJqiaKBHFzl74Zcw8mhCXdJI0hfG/zckmYBV8
	j6cp/+GZlc+z6H+Hx7mPAiglYEZYse+wJ6tOjkd50FCaS8WYNIm4
X-Gm-Gg: ASbGnctcsVd8eh9uxzXXLJCYlZPLbwe57xiir8Jr7/opOr7mHPoGCYvnSGftm1N6z/f
	ehe0pyd8yk1AwnZlyCRcz8NlaxW8nibzGGfdqf5AQGkA0czuTf83WDMVKnszD6IzTzsT/ijII6D
	IjWvyxE2ElF9pHTQDj1pm0Glxh/tdmrnzfmTAV7E/pYaFLcKGhefzdargNCXP6H74XToZgFdSQe
	JewJxpogv7E/Vxwv7kj+wx+nG1ToWimPcMVLlmEgCLMUSsEIPlltSg/acBkVn+6O8aAOA==
X-Google-Smtp-Source: AGHT+IEz7CDR7xp22n4kaxWDeGh2JVJTAbs6jYOFUAKEVKv9N1XKYacqG+MuuolYRG+onvnTuoLT+w==
X-Received: by 2002:a05:622a:393:b0:467:84df:92ee with SMTP id d75a77b69052e-471afedf42emr34731381cf.40.1739355025775;
        Wed, 12 Feb 2025 02:10:25 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471a61eccfbsm20322671cf.62.2025.02.12.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:10:25 -0800 (PST)
Date: Wed, 12 Feb 2025 18:12:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z6x0AtbmCY4XJsGj@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RPqE64ScsjzUg7@ArchLinux>
 <Z6xwW0N7GG4NhCzZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xwW0N7GG4NhCzZ@pks.im>

On Wed, Feb 12, 2025 at 10:56:43AM +0100, Patrick Steinhardt wrote:

[snip]

> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index 42c8d4ca1e..da321f16c6 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -639,4 +639,29 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> >  	)
> >  '
> >  
> > +test_expect_success 'packed-refs header should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit default &&
> > +
> > +		git refs verify 2>err &&
> > +		test_must_be_empty err &&
> > +
> > +		for bad_header in "# pack-refs wit: peeled fully-peeled sorted " \
> > +				  "# pack-refs with traits: peeled fully-peeled sorted " \
> > +				  "# pack-refs with a: peeled fully-peeled"
> 
> Instead of verifying thrice that we complain about bad header prefixes,
> should we maybe replace two of these with instances where we check a
> packed-refs file _without_ a header and one with capabilities that we
> don't understand?
> 

I think we could add some tests to verify that we won't complain about
above two cases where packed-refs file without a header and one with
capabilities that we don't understand.

> Patrick
