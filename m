Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF991CA95
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UJ/toMfn"
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4325DF
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:24:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7afd45199so47009267b3.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698697482; x=1699302282; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BngUk8RFw1dbYziaFhAr1CJ6MF1+I7zJ3WUKcFeNQF8=;
        b=UJ/toMfnyx05okC53pA2LR2Zt2cWcjfldwGtUIcWpjwsMVRzPiOt6uxf7Nt8ZwiyxH
         E162EwY0Pyo69c/px/RJrEfLYxKFSiMa7v6IhKql0rx/J4HGRNXSvXyxSjsJNxqqicn1
         Rhq2YA3+I+Z2Cxo55orsTiZ+8OGCcrYUNWVQ2UNXjwIAz5XwU7Vkgh8kBkyM9GT6VDiD
         b+Xh04cvq8AHbEV9XKL1Vnslfac5+PJQRRIPIClPjaLE+4oAhU/ooQXAwW3j4iWQ7oAP
         8uwPJUw3cXEUlhmEwpShLLy60SFht6GxHFtuWtpOyKWlAvb/PmSVmwcgXmfrhO7JJSyA
         oAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697482; x=1699302282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BngUk8RFw1dbYziaFhAr1CJ6MF1+I7zJ3WUKcFeNQF8=;
        b=brS+5SxN/BVJ9vVDKFGKOOt92WpWrwFGz1vnYz9K+SLwaaxRoOa1TO1zKk4YtvabXh
         yujKxxWvmPtKIFq11EqVDatOnhVuFRvuINCQdVtRKUcCOPDP6vchsofZl1trZ6MXWaOn
         8/uBU1T2Npb7UWlL6KbH6t2ru5SInBHVBgnxNBhrJEPwPlrUq/WZo58rA4rJttKbVgam
         5xJXTvzxaQRv/j2ctXykgEYLQezazId8PYjJ1FrgT18G3E+pC4MZ4hMWpmj6xaZv8nzP
         /ZN4BVrwn598iqi9K9/Hl6/xv/KbayYSxkIj2TQrTRbY0Yo4NNPC/NX6rszHaXdXdPq/
         D1SA==
X-Gm-Message-State: AOJu0YxASBXaSb2QugNA96ZbNQKPN0NoCyQ0PnVeI7fxGHi6KjQuCKk5
	OAvI/A6UgWgdRpXXQJRSbvBTeIn5i9OOPhCVd0p9/w==
X-Google-Smtp-Source: AGHT+IH0br+/a0J25q3loT3OkaF7wEpcjpLd4NRqqP9WZ872ktNBJcHStxtRDnWSMxHCMm4XAf08jw==
X-Received: by 2002:a81:aa0b:0:b0:5ae:8539:5630 with SMTP id i11-20020a81aa0b000000b005ae85395630mr11338228ywh.4.1698697482013;
        Mon, 30 Oct 2023 13:24:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y14-20020ad457ce000000b0065d0d0c752csm3719738qvx.116.2023.10.30.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 13:24:41 -0700 (PDT)
Date: Mon, 30 Oct 2023 16:24:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/17] bloom: changed-path Bloom filters v2 (&
 sundries)
Message-ID: <ZUARCJ1MmqgXfS4i@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
 <xmqq34y71phj.fsf@gitster.g>
 <ZTK4ZKESDVghzSH8@nand.local>
 <20231023202212.GA5470@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023202212.GA5470@szeder.dev>

On Mon, Oct 23, 2023 at 10:22:12PM +0200, SZEDER Gábor wrote:
> On Fri, Oct 20, 2023 at 01:27:00PM -0400, Taylor Blau wrote:
> > I'm optimistic that with the amount of careful review that this topic
> > has already received, that this round should do the trick.
>
> Unfortunately, I can't share this optimism.  This series still lacks
> tests exercising the interaction of different versions of Bloom
> filters and split commit graphs, and the one such test that I sent a
> while ago demonstrates that it's still broken.  And it's getting
> worse: back then I didn't send the related test that merged
> commit-graph layers containing different Bloom filter versions,
> because happened to succeed even back then; but, alas, with this
> series even that test fails.

I am very confused here, the tests that you're referring to have been
added to (and pass in) this series. What am I missing here?

Thanks,
Taylor
