Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D91110A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="JL3JCUKo"
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B7DA
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:07:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c87a85332bso29739105ad.2
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697339249; x=1697944049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7cHbrs2yRdMWtXxzr3LvxH9Lt/bYqj8/hvHj1kOLVU=;
        b=JL3JCUKokCd4Qn6i3e/QIY1uriycvwOwsv54oSEl1D+0zDWFnPyDzajq8yDgcFRRPn
         lsNXUOzMnAIck7I1vSfvLHAYmVoLV2eGRvARSsDzahADVukSNznscoRFew+aKSiMLKtD
         i2DyL39PJiKn4MMDA9N3iQZT9Jzk/MaWimTqLYujvR76u568zyh0+mHYMukI22mh+CVN
         5VI1H0NLA+SZWRBMiJ7/HeSvbc+IKqD14cFIkgJmwnqpV4iUth0U+uaitjFcjN+9bB2K
         HV/PTH+ea7+c0KVNJNDVxkYiUeYKPy+HZS3GQhGdeC1DxckKALLNQoKQZl7IoajBxWdr
         2G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697339249; x=1697944049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7cHbrs2yRdMWtXxzr3LvxH9Lt/bYqj8/hvHj1kOLVU=;
        b=eM0Am1MLaXKgQ3mkD7Ay8RZirVQdjDqWxcpM+FY4AIXT9tGBZ8r8OKNGeek1GVgCVW
         zDCLbuwTz7eQB92+b2lsRMw3hOlQGHq8f8LjVfNkwK/89BOOB72+5Ey/2DA0Q2RE8Dqy
         inAprSPEeIH5OhzM16Mzt8zzt3tmx96Oow3FBegtNz12L3znUp14dWcYMlHh9da8aCVC
         Zy4ldb6pxElDW3VUkIFEd7iBh26ddMK4x0N3qTaNseHwoF5sBKKUXwr0szGkpxjuK7bX
         vO7ktX4KmR4soeWnnDoJoPqoAj7WFtnwlVgpFWAqJCNd0Y/AHA+Xldua6q7JiGcIRd2o
         QPQg==
X-Gm-Message-State: AOJu0YzNXrZVAJAf1tazYw3fa0UA7S6POwE8jrwlQNsPjF28rMS1koqy
	dAKDjuNRQtzWJdqyiPNffxnTXOiUUgGR6S39YoI=
X-Google-Smtp-Source: AGHT+IFJWuxoiB5qDTF0CjY+rzCoRjKv9yTEmVm1dUx7+1xdDNvh0Wb0e2F4FuDhUcOvDjIqHXf9Ew==
X-Received: by 2002:a17:902:da88:b0:1c3:ed30:ce0a with SMTP id j8-20020a170902da8800b001c3ed30ce0amr41474521plx.19.1697339249169;
        Sat, 14 Oct 2023 20:07:29 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001b03f208323sm853525pld.64.2023.10.14.20.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 20:07:28 -0700 (PDT)
Date: Sat, 14 Oct 2023 20:07:26 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
Message-ID: <ZStXbjgFTlO11Pp7.jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <xmqq4jitw4nk.fsf@gitster.g>
 <833da2d05d4b1dfa8e561aa638a927b0@manjaro.org>
 <xmqqa5slt7wa.fsf@gitster.g>
 <438a5edf1a17ffac201436a950ce50fa@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438a5edf1a17ffac201436a950ce50fa@manjaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 07:52:32PM +0200, Dragan Simic wrote:
> 
> Speaking in general, I somehow find "20220712" a bit more readable than
> "2022-07-12" as part of a filename, but that's of course just my personal
> preference.

It's funny how we all have our own preferences for this kind of thing.
Mine happens to be separating the date part from the rest of the
filename with an underscore, but using a hyphen to separate individual
date components like:

filename_2022-07-12.ext
