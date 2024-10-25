Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411C206505
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867505; cv=none; b=ldm8OROch9ikTOTndu+wkwt5+TeZA7chUrLxoHWK7C6Vt88dMDSPEnmFec9CtuX9jVmOiZ9/MTV8CzvPpNu4GaWN2IiolF9ECsQmgGbyppqP2cjyOItx9smdEc6TQgNl5k8D+KGP/lLaCSDMZxh64YzqpfisjkloDQFZIQkgEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867505; c=relaxed/simple;
	bh=mepmk86B3fYar/Nmwlp3dcbVzWUJiJpZBmYu+hYGCuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbZCO1KcRWHYnJTMyAIFXYxb22JtZ61d7MYU855Z9W8m6zrd1RTFCCEFoRrmjHrFPhBn42RNzVvvVRWEuVHuvenM5ys6I34kB5p20GLl76l7zz89uEitbkMzw7oBsHMmP7AgQJUGUEkCGDEBgvDpRomxpfjfrwqAqCv073AC+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LO96y5ES; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LO96y5ES"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e7e1232648so21446587b3.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729867502; x=1730472302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UuAC7KA7xmrnaKyQpjXgEXBc+B+Rz6bbjYQ4fHImZug=;
        b=LO96y5ESEgcye+2ZcHkUTee3JHk6L0j6CxfizOIsnQ+F6BgcP812HeUb8socHYlEwv
         yBj7qZT6nVjx41SpyDrLVyKmxoHx+akPNs0rSrw8qQHGx8V7Tf7Gkd+w0xWN7qcP5y59
         J1V9faj5gKVdmhsnsQbwyAWpP+VERw39GdJf9ceHyP022P6BnOF4wjkU1xW1+xWWeGQ9
         DMyrB1kDs+LyvYQ9Lvb9MkKo1bJ4vWUkLr5hm5oEsTtRbdpMMAPEHPdMOo3yRTVqAMCi
         bKUY/WPyvkMUbL6w6pnaZuOZsLLRAyB98pCc0v2AICfhS2Iwpp0lkWBixJWJqobuPZYo
         3AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867502; x=1730472302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuAC7KA7xmrnaKyQpjXgEXBc+B+Rz6bbjYQ4fHImZug=;
        b=INVveoQxAGUKL5sbNesRikb8h80YwBhKQ1s15GBVq2u8nW1WqHM1OPRJqMIPAVZgQw
         ONmhNgVG2fZ1JFysCG9ApUw4EYasEl6IeJ8Ea1poP1K6rQY2iH2w/z5VNf0rLBz8z1Cu
         gYHZeRFqsyhh0Yq11WNhaBbb8zkmxEkxnKFYcomaJLQt2CPtO6T76rPIq3GiGdw3mQut
         uQAM3riR+xLVaJ/gK3I7nRE100OX/CbjL4HiYX/QmTwzEI844KMlZ0vmgvWI6cLtRVnt
         ilEy83SOXg/dQTCwHcUurAQl4C1wSZINSz4ktEjJyks0SoRwoij8S1UviMaYIthtlRkc
         JYng==
X-Forwarded-Encrypted: i=1; AJvYcCWmYoaBTp4rgDCUBGf8HjM3HOZrssgO3JzbBLPy3Vgf9fCsrp0MRUw//2/LnYwjSxHSHkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CAkEd5wtKv7ERw+fUt0Fpe/bq5lvYHXWX/meLy2XYeHUF35M
	P2hjABSEGE2H5LDK8KaG2u8vWqesu+LsPsmon6o1Bhzkj4PHDZIwb8T45jIfQpQ=
X-Google-Smtp-Source: AGHT+IHrSUsySHxJwgBPVdG0rHrGqFm3/DFmDGMvaANalZt+8EIjC7NTET7CmlI+cJkYXkbAvlsjoQ==
X-Received: by 2002:a05:690c:4a07:b0:6e3:1903:5608 with SMTP id 00721157ae682-6e7f0e30e53mr114880527b3.21.1729867502369;
        Fri, 25 Oct 2024 07:45:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c980dcsm2993917b3.128.2024.10.25.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:45:01 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:44:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v6 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <Zxuu4U+5eBsrtv7A@nand.local>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
 <ZxqL4MId4ah+OmTW@nand.local>
 <Zxsncryo3cdbgxu7@pks.im>
 <CAPSxiM-jFOjiX2QpJjLM-LD9ci0JMV_vvD0Y0QiPNkwS1GPfLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-jFOjiX2QpJjLM-LD9ci0JMV_vvD0Y0QiPNkwS1GPfLg@mail.gmail.com>

On Fri, Oct 25, 2024 at 06:11:05AM +0000, Usman Akinyemi wrote:
> On Fri, Oct 25, 2024 at 5:07 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Thu, Oct 24, 2024 at 02:03:12PM -0400, Taylor Blau wrote:
> > > On Thu, Oct 24, 2024 at 12:24:55AM +0000, Usman Akinyemi via GitGitGadget wrote:
> > > > Usman Akinyemi (3):
> > > >   daemon: replace atoi() with strtoul_ui() and strtol_i()
> > > >   merge: replace atoi() with strtol_i() for marker size validation
> > > >   imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
> > > >     parsing
> > >
> > > Thanks, this new round looks quite good to me. Do others have thoughts
> > > on this, or are we ready to start merging it down?
> >
> > I'm happy with this version.
> >
> > Patrick
>
> Thanks to Patrick and Taylor, I really appreciate your time and mentorship.

Thanks, both, for working on and reviewing this topic.

Thanks,
Taylor
