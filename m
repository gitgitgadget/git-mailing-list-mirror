Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35CD3FE7
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431361; cv=none; b=cEero9wBfDI6maxDTyE33vbJv72oOP3F2hRkmO3Fi0Rq0IBHau/ae49gmEIjRZOu+gl/xpk20i+AfqfoJREZbhJphFCqGvrEQoiRQHYklBy8fhyF0Ox2IpKL969i4VwxLOYLBAq9RLN01SxrVbxUL9MHtuUR6Hb675ArB83T2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431361; c=relaxed/simple;
	bh=bM9Dq2KYcYPXpcsA61CcXcGWMQ0Qc0uMONgE671hHmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7j5CJHhGVCanXmsf7k30Q1rj+qfrGqzQABb+9RVyguWfIYhlJgprvhugSuKV9Pv9rspX4eMEoJchis4+Y6SL/fboUnmO6MmSh6XtwbFQ+PBoKaQL+yXe7UzvQopeSubnPOYv8a0wuZIRo4YwHQowptiaSGeUu3otXjrdxDYnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hsXt3vpf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hsXt3vpf"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ef39d96a32so9531085ab.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756431359; x=1757036159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bM9Dq2KYcYPXpcsA61CcXcGWMQ0Qc0uMONgE671hHmQ=;
        b=hsXt3vpfWdlhbFPqG1V/WOg9CtI+FXil08oQlUmPYM2TMCO9nwzzB5DiN+d+MA5O3J
         l37YoPuiDHTo22BvqhaMHAY3+eXt9uyuIWtUbQJkr3finwWyNuxclbAzhFSJFW+puMhr
         AHBT3b4O744U2I8139V5YSX8Rt+3YqN3Yh1FnB4RTnO/FZH3fupq090NyKEdx+5gsKFd
         N6VesBo1sphseZUsnV7BO1s8vlljEwN/5vpPOdZ7f6B2jJ2mRn5V0zQ1b1RNEvEJDOSV
         uHXxDz/WAEGaa+9Wts7CRWoEL73Lh+A5sPu2y+RQF78ApZJY0ppWDhX31nsKBkh/oqcH
         eN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431359; x=1757036159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM9Dq2KYcYPXpcsA61CcXcGWMQ0Qc0uMONgE671hHmQ=;
        b=hn5CRRiGIvo+XfV3MiTsj9NZ5fJZCqwkqcT4Uj36GV8jrSRyr14/Aa1OAV9DryXc9y
         9M3FdAkDSAm3KVgta9qEfevgUizaSnfHt5dXiwI1ktYTQ5A+753BQKTPIH+kUt/v503a
         guo/jnaPU51B2GGedM/NPhxEF08XAxVZJOyI3mxTQhJG+1LLXc8k2byZiUwFUBAo71K4
         IaQaIoyMhKPpaVT2CfqI6Sw1wT47JEQl8ucvW1jdNoiohVyZxEt1HHQgDn5aNajWoB1Z
         bsF5BzPCyBHTkLAhVKjKrCRldhvEojF7CbjRBbN/w3J1BIbjLmYa9deLgEdHbZg8FAbo
         ABXA==
X-Forwarded-Encrypted: i=1; AJvYcCVwL/6+Q1tG98fl7bpxNcNa33CF9B9u7w5VNl1tRXG0tKSzKjG8TNNmwAS9cetwLtjd0gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwlOxpy8d3M1eUyuwZ9W9j+juD+QXUsj8YrScivGFUsfDCxli
	K/7Ui9oYDcVfPIzYgXh03+3wZb9ReUrfT7MvQIgtCKk3QOLLXPg5C67GxnmBZ+etmes=
X-Gm-Gg: ASbGncvNAWiEXYeJsNYcS5Zz3sCsGjRJ9z3IKWLzL/Gl0dH/l3YGrQkqncOYgh4y2Ov
	DXmXXi8uBSpb79/BhA22dis8/uUEDFtmJVDLwHtG/QJqZWI6k3wziiV+HKt1O13rQB3dqPwepWV
	oRe5vl7rjAQbnaj9eBw2wxaeepUu8g+C1tFkscW+BIVDpbRKKboXGCFalREcrbwLJhAN9G6hiXc
	VkawfRLv1AJXKeWuJFnQW9dgbkxwSzxIXOBqPzg5fM7+tM0cZvhUIHYRaVyNsRfgy6uw8wTTZKv
	Mb6ET7xOANdCom4peI8QoSCOyt644wbi6K3twLhTs/FM/tKjYsUdkZvmkGfFIdWHEZhMqnuNFMi
	FRbiDYogfzdExt04OMxyy1kFbI6ldDbwYhrmKKS7GcpL1XyJAV5gODM6kdZIKi2tfZdgibUS1me
	N1fdZUvmnFii18lbfUy+D4bGzZXV0soMfnJrbucCiFaenpPNE=
X-Google-Smtp-Source: AGHT+IEhb+VyL6QH3nR9JOeHeT8B3yEGF73bn4Z3E4+X3zuLbhp/bWG85I+D6zky3Hv4sVXI+95tYw==
X-Received: by 2002:a05:6e02:188d:b0:3ef:969c:c91 with SMTP id e9e14a558f8ab-3ef969c0caamr169146345ab.6.1756431358983;
        Thu, 28 Aug 2025 18:35:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3f2a17914c8sm2403225ab.35.2025.08.28.18.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:35:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:35:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] midx-write: reenable signed comparison errors
Message-ID: <aLED/YDNy9dZvkHO@nand.local>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <eb1abdca32c64cdabbc92008bf318c7ed67b2c1f.1756402795.git.gitgitgadget@gmail.com>
 <xmqqo6rztb2h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6rztb2h.fsf@gitster.g>

On Thu, Aug 28, 2025 at 02:01:42PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The strategy here involves defining the variable within the for loop
> > syntax to make sure we use the appropriate bitness for the loop
> > sentinel. This matters in at least one method where the variable was
> > compared to uint32_t in some loops and size_t in others.
>
> Sounds like a fine way to avoid accidentally breaking these loops.

Yup, all looks good to me.

Thanks,
Taylor
