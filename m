Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F343BB9F1
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167155; cv=none; b=D5JKrjThKEsgnFwfhQqvqDkQEiRfPN8FUzsp7SFZsH12cyrfp3VjK1ELJSduM3g7u6muQnBme+FcGP/dTLG8GKdt+X9hiGU3uS1S5TRF3nRkwg4FD8qMlikzm5ebwphWNv6tpvuW3lJmUlUQkwYQdWkDKDJGpd7F3tOtXNfU1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167155; c=relaxed/simple;
	bh=Sowlz2ZFm0cp1p2lo3j7ZOioBz2xb8r1Hva3Bu+/dCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSdFAsED03bmX0uME7KxEzSC7sGk2gVFbt9UTw41Hb3Y8+dXw9r5qPRfpWJdWU3a2Iv91a7HSyZWkwHDpqGTY/OP0gQMvdt6+nlzNjjzGliENcsecjG+9yqXax1vB0OnPcSXp6hF0aUmzn7KS39EfNnG0EhtvjQa8y189+Xyjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxACHE+V; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxACHE+V"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6b554044fso2434033a34.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785167149; x=1785771949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8nfZUbnTr5I/UN0RfYFusyLsYdPzpNsJD35p/I++BX8=;
        b=CxACHE+V2TJTLAmDezhY3e5LyWLaNhXOABroA2e+X4k9V+K9P/Ftc6pzfAdJfzOp7Z
         n1+C3P3McGZR5/kkb6jZrWRirpebF4suw3qIVVayj97mmbBqdgsjFe4RVv6YXzhzDt5E
         dU6m9kYMBz9Gshs16PIXBasklGRQIEdS1aKxWW19Lnh7P2gLST4PGXksizH6KUOPVcWL
         cs1RAwl+30zuG+/KjX3ILGA+Kn029HLT07Ve/d6vgRERnagkLvW6aVJQpPyobL4TL1Iz
         WoZ4y1AaKnxADsYTGHccojc8rRo+HFkc/p1E5d5VKv0Qu1HK8VifUiJdozO3iZlSXsmN
         5AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167149; x=1785771949;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nfZUbnTr5I/UN0RfYFusyLsYdPzpNsJD35p/I++BX8=;
        b=swGAtM3Eoz4LhtZlcpPFVsQDHt6F0brkM+8DEpL20YOigfxVnm7w7UmxBmVZo4pPpZ
         VlZ9h8w626Xm2LjowsbRK8x0uhCQzvlmnG3m4SM02UMaoPaiUSzZeW+doJv93Xd1l2Uk
         iKYIOsoH9ogkhpwMftn7oxZNg+NKYDGsvv6unQGUwN8YeGuUy7r2a3evZ0jmQent3t42
         BX9vu5n+jRmQ8W9TQxNU6O8pKg8vrZAIMLioQgLm0sgJfv6+oV23b15YzC9BGrCQ42+5
         HohqT6th8izujYaAlBtbh4w7MDaFyelkTpSuKoBg6SAAB4n31hd/CTLB3Cisu2AKQa98
         oNrA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4DTML7v5iid/KP33NdSNTj54zSg0oejMJXhL6Gv0m/3GkW2piVMUDesSpT8IFLi8umR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqW1xJgCr/YvwrC6MQF9v3ajh5GI9bGUWThUx3Inv7SdDXJAnP
	tSFqrL+tthI5YS5jGUplZ6/UhyhrN+Ju8Atz/SmLS7wV6fGiVxPPZL3KmbDUJA==
X-Gm-Gg: AR+sD10GbH1Op0UtoRo0I+ArAqctYe8HX77394CQBgdZ2kuyBJWp1vuviqvGhyAtMpZ
	RlichqsD7A8FBp8+ccIHaNempa7IW6XHDDIJL9829yO5Ml3qPdRA5p+4KGNyQVmrNRJB2AAHpNQ
	re2JKMnpg/VOga8Z0x8pzV0+13fNbR7SUljRVHR9OoDYKRzmNZYLx/XXmZ+fedsznnUoMKdDnar
	UxbGA3/fjHpvr1TREB3pifP7bhDYRVONnOl09sN6XsxLUPBBqhiF22hIf67k7v+2dJe0tOcXOSE
	hipCUuYu+tfXN6QX85+1qdWOgs/cEomx02Gqe8uxfDRP9j52ODpk8uW7+amdr9RpzPCvyZARvXv
	crLuiyCxP4KIUm4rF2+st63nJCBIomoaS9+K1/EqvzbDFwPzMSVJ1RCCLRRJ+xbzEyJj6HFQ=
X-Received: by 2002:a05:6830:6d13:b0:7e9:b4d0:df75 with SMTP id 46e09a7af769-7ee78dd9884mr8500172a34.29.1785167149558;
        Mon, 27 Jul 2026 08:45:49 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e13a4csm12722806a34.12.2026.07.27.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:45:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:45:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>, git@vger.kernel.org
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <amd4yR3EEn_fVZcm@denethor>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
 <amCuLpT6vYzo1GF8@pks.im>
 <xmqqh5lrrplt.fsf@gitster.g>
 <20260723104943.GC604358@coredump.intra.peff.net>
 <amLgMqkqxR8mKIbT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amLgMqkqxR8mKIbT@pks.im>

On 26/07/24 05:46AM, Patrick Steinhardt wrote:
> This would solve a bunch of smaller issues that we're currently
> grappling with where some of the concepts in Git really want to operate
> across all of the alternates:
> 
>   - The OBJECT_INFO_SECOND_READ flag can be dropped as it becomes an
>     implementation detail.
> 
>   - We can fix the performance regression because we can now easily
>     reorder access to read via packfiles first across all sub-sources.

Letting the backend control the ordering would be a nice property.

>   - Commit graphs and bitmap really are a singleton, so loading them via
>     multiple sources is awkward.

I completely agree. Having the ODB source be more self-contained with
the alternates better fits the shape of commits graphs and alternates
IMO.

>   - The object storage extension that I've written got quite a bit ugly
>     as it wasn't quite clear where exactly to draw the line. Especially
>     hadnling the environment variables mentioned above into the "files"
>     backend removes one point of friction I encountered.
> 
>   - Object database maintenance needs to be aware of the other non-local
>     sources.
> 
> Also, doing that change isn't as bad as it may sound at first. We'd
> still retain the whole `struct odb_source` list because we want to have
> them for submodule sources. Furthermore, alternates aren't required for
> isolation either as we currently use them via the temporary object
> directory. An alternative implementation may use a completely separate
> mechanism to achieve write isolation, which is also why we have made the
> environment variables pluggable that the `struct odb_transaction` ends
> up passing to the child process.

Once all temporary object directory users are updated to use ODB
transactions, we could stop reording source list when starting/ending a
transaction. Instead the transaction could be tracked separately
internally and during ODB read/writes the transaction could be directly
used as needed. This is something I plan to tackle in a future series
soon.

> I think overall this could simplify some of the design, and it makes a
> bunch of issues that I have been struggling with go away. The devil may
> be in the details of course, but I think transitioning towards this
> should be doable.

I am certainly a fan of this direction. We do lose some flexibility in
terms of supporting alternates more generically, but I'm not sure
supporting alternates of different source types in the same repo would
be something we want anyways in practice due to the additional
complexity.

-Justin
