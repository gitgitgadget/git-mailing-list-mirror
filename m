Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45D2F9984
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167569; cv=none; b=p+EXL+XjZ/jPzWf9hVs2CrpxgWg2V+y0IDyrkzfRIA5BXOOjFZAvFcR63oWVlw/YBiopZHGhbINbrcm6T1AHlZ9FGmEPPLnKviko6pHwpRD+0I8Rw/9o3cJI8D+Phr6cgb8OpW3dLcM7YYqFLHrLfyoyAuNBdcoK703CEsc7OOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167569; c=relaxed/simple;
	bh=B3/2BEWBryZSAPl7Rxc+ghit5/4mBTKGf7yHVfjZR/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTIuuFDofE52Hc2NDEziA8dG3yZejWSARPOorbldb6HLV0QbrblOpDKss1F2bbWnHAMuZqWFlu9lKIIr0ynR9nmLzxtLGCzeXlbuwFWJE7gsmZm3QnwI7g5RvK4Y9KQEA7+KUrVNDup5+C8glaCJbzM9LS6/d73bmX1xJt6qOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4lEpMcf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4lEpMcf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso30979845e9.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773167567; x=1773772367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngxlf8uqJz77PKNcjGgML5EwEbOmvI/NPi5YcmePNcs=;
        b=Q4lEpMcfr8/FD2+UAMKbtqVOt3cygkdwRp5zCgDE8uERjKxl40H+4P/CQCWA3463n2
         1Z0sHWvTsBhzmMRz6S4mQEvOYa8rZ6nJDgy3qbCG68oH0oWegyyq+yxfeVHRpe8rl5Z7
         GQMgAb+NquiYnr5tewK8hnx88llHia8D9aPSWZRCFg1QwMz9dRdUy85Q6A5hUBpbzVxo
         MLUHZbkRTCGmtZe0BHRWw9Xvm94UJAIEJjdwx8JslMv6q+D4FD9LpZIU++VgOWFNnMbB
         VNRlPVa51rMajDgk29QMiuNsfMv+uDP2utF4WfTXyx5MYvPP2Wz5jHRbBDj6NdN2d0Rk
         05Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167567; x=1773772367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngxlf8uqJz77PKNcjGgML5EwEbOmvI/NPi5YcmePNcs=;
        b=ioncMe1Da0HMmR3+KDJ4g+uBEaNf81Z0vjmPWdUr1aifR6MV3aUAunSXU00OspYPAd
         bm8974DqslxBHXbvlK4vh8muQDKRiOGswPwEM80G5gq/H0xhnsfoCApJT4J/6xfae/4Z
         ZyUlft5iTKX7OEWlBLhSCAMW3e6ceRb6Y2Fgcir+5RXQoNJUYr4U9nml1jFzTuVc94qA
         stv3ekKcOQHVA1Sbwl0AAJTzcuGT7AM+NkAzsyW9d6eWo4rwBU9NUlaQehP3zN/XnftK
         f/C2URoYkiwLAkbwf7ojsjcGeIDnzBcQXpt5/9IU1Mx0/WboUH6LkdoawR0sC5mwhIeZ
         8BOg==
X-Gm-Message-State: AOJu0YwaIRSoO6VMUYEImwYw8x8xFdL2iHpkCXEgwd9g3GNgb+JXDLaU
	t1nf6cUDCKnRTBIbJ5NwuMf5duevqZPpKgEZ2S7f1+ODXOictjCp0mm9bsv2Sg==
X-Gm-Gg: ATEYQzxsKkxNBl4UEb6bTJxdZT7anoxuE4eq6TNNSZQ3nziPJlF4Kg0vI8DiAusW8ss
	d12ADTE2/ipAG8ZQVcGVXnzKUT+EE71t+Pe+b+MW/e79WisTnLEBDBZ3+ObWkiZXJQR1EgUXb6o
	QYhIUuS3rQkqXs59/VFVE1627U+6F5b1Uh09oaGyD9mDLil2223hLu5RFhHrHBCVAD9o9zPLjAB
	M88PhUMFT5Z4Wb+TfbJopsb2GqmElG7szD/scMUqh+l0J1XoJvtzKMhQoYixD9ajy25chP5SWLX
	taa1fl/Ih7e4s0VXWHaA34+Sq1oL9OTARNNCwC2S1kMCfQsixtVGAJLkCAJdUUk8WZNAfSCGQ9x
	HJJJRRgM7rUOsigT1KHHmK4WqsuNwItIuea1pkwytXQ0VQMRM0KceUmHD5IPUOuZqPeqoZoD/IX
	yVREz1RC+g+0Dw1ry0NtyZlBvmyPxTtll0
X-Received: by 2002:a05:600c:a418:b0:485:3d00:f0a with SMTP id 5b1f17b1804b1-4853d001809mr105957405e9.8.1773167566691;
        Tue, 10 Mar 2026 11:32:46 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm230940625e9.2.2026.03.10.11.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:32:46 -0700 (PDT)
Date: Tue, 10 Mar 2026 19:32:44 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] extensions.partialClone and promisor remote fetch order
Message-ID: <abBjzBFDReUnIvdK@lorenzo-VM>
References: <aavvwfZllMWUwIl3@lorenzo-VM>
 <CAP8UFD1cQHUzxu0cWjVWBfBWh8qOy2+oOb0rwo5CmgJ2qKRFDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1cQHUzxu0cWjVWBfBWh8qOy2+oOb0rwo5CmgJ2qKRFDA@mail.gmail.com>

On Mon, Mar 09, 2026 at 02:40:42PM +0100, Christian Couder wrote:
> Hi Lorenzo,
> 
> On Sat, Mar 7, 2026 at 10:28 AM Lorenzo Pegorari
> <lorenzo.pegorari2002@gmail.com> wrote:
> >
> > Hi everyone. In the past weeks I deeply studied the documentation
> > regarding the GSoC'26 idea "Implement promisor remote fetch ordering". I
> > am preparing a proposal that is as detailed as possible, and that tries
> > to answer to as many questions as possible. I am also experimenting a
> > lot with multiple promisor remotes configurations, and creating some
> > examples that I will showcase in my proposal.
> 
> Thanks for your interest in Git and this project.
> 
> > I have a question regarding the interaction between the config
> > "extensions.partialClone" and a possible fetch ordering mechanism:
> >  * from my understanding, and from my personal tests, it looks like
> >    "extensions.partialClone" is not essential when working with multiple
> >    promisor remotes. Having these promisor remotes setted up with
> >    "remote.<name>.promisor" and "remote.<name>.partialCloneFilter" seems
> >    sufficient. In this case, the promisor remotes will be tried one
> >    after the other, in the order in which they appear in the config.
> >  * if "extensions.partialClone" is present, then the promisor remote
> >    configured using the "extensions.partialClone" config var will be the
> >    last one tried when fetching an object.
> >
> > 1. is what I explained correct?
> 
> Yes, I think so. The "Using many promisor remotes" section of
> "Documentation/technical/partial-clone.adoc" seems to agree with what
> you say.
> 
> > 2. when the fetch ordering mechanism will be added, this config var will
> >    not be useful anymore. How should it be handled? It probably can't
> >    just be removed, so the fetch ordering mechanism should be flexible
> >    enough to handle a situation where "extensions.partialClone" is
> >    present, correct?
> 
> Yes, for backward compatibility, it's better to have things work as
> they used to when the new ordering mechanism is not used.

Exactly what I thought. Thanks for the clarifications Christian!

I just sent my GSoC'26 proposal, where I took into consideration this
discussion:
https://lore.kernel.org/git/abBh__zmlWXY-yjI@lorenzo-VM/


Lorenzo
