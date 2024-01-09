Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A43C068
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oM9ENcmR"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-680b12e5d42so23014576d6.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 10:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704824455; x=1705429255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/urNvC13oOYnotGTrdvrCLFnrnsiI7xKhuBgy+omHI=;
        b=oM9ENcmRn7NQIgBIjX7l2akFBacLqHPGxdOuJPiC9+MtAQrekBaum2pd/lK1rL6cuV
         EzXLtdxK2XAeqjCm2SP585SPh8o3KjN2g68pt49AH8Bkmfi+gNhBcz4QSIHncWEg6EOC
         iA4XEOyiAMKo1rYvbcqLeLUvyN/au1Evx5/vRNmU7J3MLnd8ozgDrz/TXFNPG3vR6F2C
         CPetgJtSHRhkIc0xN4nYD3dy/ufD/xptZR1m7Z8XQ9l9O6+Q793hbaqrTAa34+j/OpCG
         +hvFm5tHMgXBfKGjB3k51Tnq1vOXKqhZU2Dme1mqfm7Ef8h34A09Qwuad+ZutPHd33Hm
         QaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824455; x=1705429255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/urNvC13oOYnotGTrdvrCLFnrnsiI7xKhuBgy+omHI=;
        b=gCJ9io6+Em/g7ObG0mxDC+gfm8L+4S/ci90vSltSL7FeAnkMwKQjVRpVC3lEQgkIg1
         KlVLu0u4C0S/rlEWdf0UuLcOGJ++24wlTLUfbXg88PczqDzG+wOqZrSikGwQlByZmvdJ
         zuCkMaBG/zlbuW9d5WZjDkUr2jk982SxrWoUAv+iu7GXjdJ2vUIezqn+AYb8ShpI8VMB
         e61GhZT5vR7eF7lFu5GQ40Ph8UpYF3TuCJ3DbGe9XeoU6v+eNFIz/fyXdLCh6P7GoyR2
         pc5lptba8ojRNEjRwHQ8fOol2fpBpACtSGw9uAewKBqjxEq9+6xyAG+05GiUufNrDu/w
         IyuQ==
X-Gm-Message-State: AOJu0YxO3eBA/DbKzJ7ssyWNNTkH+0pChk4Ujbr5UlOV7+0WRtg0qVUQ
	x/J4J0f5eqtyxLiFVXO1GrWJBgHiomQpvKxSsTv8VHVOGViI8g==
X-Google-Smtp-Source: AGHT+IGcvez3PXuEn97dHa22STawaOAfsYBkjrYHYp5tgIKnz+fU2uee47EqtwPMlqXVYWtbCCqs2g==
X-Received: by 2002:ad4:5bea:0:b0:67f:99ae:75b3 with SMTP id k10-20020ad45bea000000b0067f99ae75b3mr6275218qvc.113.1704824455478;
        Tue, 09 Jan 2024 10:20:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a20d500b00781df19c062sm982402qka.59.2024.01.09.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:20:55 -0800 (PST)
Date: Tue, 9 Jan 2024 13:20:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] t/test-tool: handle -c <name>=<value> arguments
Message-ID: <ZZ2OhkDhq1yOp+q3@nand.local>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <6a4d6a56-ab6f-4557-a5a3-1713f57cbfc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a4d6a56-ab6f-4557-a5a3-1713f57cbfc9@gmail.com>

On Tue, Jan 09, 2024 at 04:29:57PM +0100, Rubén Justo wrote:
> Soon we're going to need to pass configuration values to a command in
> test-tool.
>
> Let's teach test-tool to take config values via command line arguments.

I wasn't expecting a step like this to appear in this series. I don't
have strong feelings about it, especially since test-tool helpers
already understand $GIT_DIR/config when they rely on library code which
implicitly reads configuration.

But it does seem odd to have test-tool invocations that intimately
depend on a particular set of configuration values. At the very least,
this step seems to encourage passing finely tuned configuration values
to test-tool helpers, which I am not sure is a good idea.

Your patch message suggests that this will be useful in the following
patch, which makes sense. But I wonder if it would be easier to avoid
the test-tool entirely and call some Git command in a state that we
expect to generate advice. Then we can test its output with various
values of advice.adviceOff.

> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  t/helper/test-tool.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

The patch itself looks reasonable, though.

Thanks,
Taylor
