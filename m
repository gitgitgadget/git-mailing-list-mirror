Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95821211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 21:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfAOV7z (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 16:59:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38051 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbfAOV7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 16:59:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so1819457pgc.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+fpfVCVNXgLajrQzXI4LC+LNHFJ3OWMgEq1nRXQ7UQ=;
        b=TJx+cNdMnZIr5ScDl0JUmZnh257UK/hPa0olmssBArBq/2KmrrTASf4Ug4jcsKuL39
         nLgZkoe3SsDYt00wteYvP1vi2kWM8VvH/BGAmbFwF4agcnbF8kf9j6kSfVAxfOxWMMn8
         e0WldYzsvHxA8lso/A9ifrG2Jck+e8IOpTPMJh3DO3am59rljuTcxWH/83ZYbNhgKRAM
         4sflaz4Iu49/87ez2QD+l/BB0rbbHcWrnKRPBUyeFUL6VvT7xejwIZdb32Ft7Gs94lm8
         SBuMW/5VG+nLG32SfYQki6SmTus5nPE/6wTi/DendVnbzyGP0d8q620nMBJCqJdQx+hK
         JuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=D+fpfVCVNXgLajrQzXI4LC+LNHFJ3OWMgEq1nRXQ7UQ=;
        b=d8QHzTJTORvuAaSSQqmoYrf1s9y7cBMSlfk36z2rKbXZa3LQ99/J2DEXpMo+gTKEYk
         MlWHXMKmTPaMXmz/I4xQRdOYiIxAdoU4V3Psvom1znHQNDUvwcjo569kRogYvzEXEI/Q
         jR08TZY6mb753ypa2m5G6tZD5Uf5jmtus2gLXsEX5/+uwe2ozCltL40Pk7usCKsHbEMP
         Xsvlnjzw+z6GaZld8Auoj6UpPZAxOCBWq515jevXauxrX6cA9vcSHq3demxENW3vglx5
         gDlKrYIPWfIzjKTPxYyEG4iMMHBmJMF2MZfrB36QVfySLuZZet6/Mn9wKujzKpAcU8aZ
         9Xkg==
X-Gm-Message-State: AJcUukc9XW0wvKVEHpC6TyW7+yr26q5EBZz7yQoh32ns5iVSiMlOMh86
        RljetEjArS0aSRv3ukdnCNH7hQ==
X-Google-Smtp-Source: ALg8bN5+BEVAMccfVOHCOftFCd9pwvM4rB79FgLNJtnLjc7Vyhywtqnk2X7CiXaDgtyDGurnNjG5ng==
X-Received: by 2002:a63:7044:: with SMTP id a4mr5607528pgn.359.1547589593117;
        Tue, 15 Jan 2019 13:59:53 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id s37sm4454087pgm.19.2019.01.15.13.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:59:51 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:59:45 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v5 3/3] Makefile: correct example fuzz build
Message-ID: <20190115215945.GB35794@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, peff@peff.net,
        szeder.dev@gmail.com
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1547582104.git.steadmon@google.com>
 <350ea5f7c97aa4166eea56aa57b66ddc9c53de4a.1547582104.git.steadmon@google.com>
 <xmqqimypr6yx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimypr6yx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.15 12:39, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 6b72f37c29..bbcfc2bc9f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -3104,7 +3104,7 @@ cover_db_html: cover_db
> >  # An example command to build against libFuzzer from LLVM 4.0.0:
> >  #
> >  # make CC=clang CXX=clang++ \
> > -#      FUZZ_CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> > +#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> >  #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
> >  #      fuzz-all
> >  #
> 
> I know this appeared in v2 of the series, but I cannot quite read
> the reasoning/justification behind this change.  After this hunk
> there is
> 
>     FUZZ_CXXFLAGS ?= $(CFLAGS)
> 
> so if you do not give CFLAGS but give FUZZ_CXXFLAGS, like the
> sample, shouldn't it have worked just fine?  IOW "correct" in the
> title is a bit too terse as an explanation for this change.

Sorry for being too vague. The problem with only including FUZZ_CXXFLAGS
is that all the .c files need to be compiled with coverage tracking
enabled, not just the fuzzer itself.

The motivation for splitting CFLAGS and FUZZ_CXXFLAGS in the first place
was to enable OSS-Fuzz (and others) to include C++-specific flags
without causing a ton of compiler warnings when those are applied to the
.c files. So OSS-Fuzz sets both CFLAGS and FUZZ_CXXFLAGS when building.

We could fix the comment by setting both CFLAGS and FUZZ_CXXFLAGS, but
since we're not including any C++-specific flags there's no reason to
set both.

I'll fix the commit message in v6.
