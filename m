Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2288B1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeKNEuD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:50:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNEuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:50:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3249703pfd.12
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSlKYOmqRS0oP7MYk9siJp3IVo2XafodtfwUhIyEePE=;
        b=qpnaMrvWIJsEEwhyc5RivD/LsBaD0rYoPG78kE1rN414wl4Db5hDUnRIkn2ONGYLuv
         tnJRxZv0GdiXG8Y5IpVdsnH6hURrE+k956uQVMT+ZDV7yX9QnoQxs2g+VdVWDl8UBBn5
         anO35bJ145G3K8eJVpisvWFnONsijGdGkQWxBQjy3fMHZce0WJDWi9sr0mS/cM4oCJ6R
         vwtJ+A8EbqjeHE3QWrKz5llH9NLd84v9gVcmNO+O8cdMOOezJ0XOqYZaTflGruVvSaUm
         oMuwnLmYvy2He0ZU9P91Owa+c7gqB3RZZqRj8ogf3vjBFSv3DcTdsnz22SLqyQuUTctl
         I0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rSlKYOmqRS0oP7MYk9siJp3IVo2XafodtfwUhIyEePE=;
        b=JJwzQqISi4p3boIPyK78kWxy9DNRS87PXlbjW/ijJMSLLnsh+s4shuGO2kF85Q71+P
         7+OJgu3SCGjQWIqFcOykug3IOKA9HGAtpoD2aCVZKqzZRdsyYvrcopFAtEHf7DyFN3Hw
         98dnbUv8/lndC+XuNHcrYVB5icZeVqzguGpW4aClY8B/80D3ufUJ7DCciLTDgd5FQRxD
         UOoYpO1+YZrhyiAnO1l7yUyLvJBIRQGAeBJPScoTsg5n4b2I/RQbqqvOVfvxQSRbUDOB
         qP5x9mo/MldjH5IRGWB9rxZ2YmakKTZZKpIvBzraeYlBVDKPqmxAPCCYN5WUm6s6hwO5
         WMvg==
X-Gm-Message-State: AGRZ1gJPguFLTUv1HKtLiE5fiso7zwBTkKWFmDJOTCmGU6Lr+8D/GnQN
        2E9ZtIsHqmBdCMVibv9/9fJLyQ==
X-Google-Smtp-Source: AJdET5ePMv7XDqgNEFvGAmYCRA6bwJQbsa0VFsU0Zx9YT7ZzhIyEK27+C8froME1huqkU6jVFbnxdA==
X-Received: by 2002:a63:8043:: with SMTP id j64mr5881563pgd.405.1542135039518;
        Tue, 13 Nov 2018 10:50:39 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id b69-v6sm23161541pfc.150.2018.11.13.10.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 10:50:38 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:50:32 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: use CXXFLAGS for linking fuzzers
Message-ID: <20181113185032.GC126896@google.com>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
 <xmqq36s5y8l2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36s5y8l2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.13 12:12, Junio C Hamano wrote:
> steadmon@google.com writes:
> 
> > OSS-Fuzz requires C++-specific flags to link fuzzers. Passing these in
> > CFLAGS causes lots of build warnings. Using separate CXXFLAGS avoids
> > this.
> 
> We are not a C++ shop, so allow me to show ignorance about how
> projects that are OSS-Fuzz-enabled work.  Do they use one set of
> CXXFLAGS when compiling the "real thing" and a separate set (perhaps
> one is subset of the other, or perhaps these two just have overlap)
> of CXXFLAGS when building to link with the fuzzer?
> 
> What I am trying to get at is if this should be CXXFLAGS or
> CXX_FUZZER_FLAGS.  If the OSS-Fuzz-enabled C++ projects use one set
> of flags for the "main" part of the project (to produce binaries to
> be run by the end users) and then link with extra flags to work with
> fuzzers, I would imagine that they won't call the latter CXXFLAGS
> but call it something else, and we probably should follow suit if
> that is the case.
> 
> Not that we plan to (re)write the maint part of Git in C++ ever, so
> I am personally OK with sacrificing the most generic CXXFLAGS macro
> for the sole use of OSS-Fuzz linkage, but I'd prefer to leave the
> door open so that other things like OSS-Fuzz that require C++ can be
> added like your work does to the project.
> 
> Thanks.

OSS-Fuzz only provides one set of CXXFLAGS for use on both compiling
project C++ project files as well linking the fuzzers themselves. So in
the event that Git ever added any C++ sources, they would need to use
the same set of CXXFLAGS.

Given that, do you agree with Stefan that it is more intuitive to define
CXXFLAGS next to the fuzzer build rules, since that's the only place
it's used for now?
