Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334181F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJMIe0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:34:26 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:46601 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeJMIe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:34:26 -0400
Received: by mail-pl1-f176.google.com with SMTP id v5-v6so6643912plz.13
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TstEenVcD9dtm0gKpxBLxgiUK+JtbO5wqAf6oc/UT/w=;
        b=vUij+8r57SHOcn1534j4Do+M1oeK6Qmtuepvqbsy6XkffLegklfEnZ8tJmEUj2Qjzg
         SFNczMh0+nJwVmLnHSYFgxEVH4KRxim6DeYxCQDHV8UeYFvlmHDIFTQKc4B+VTRSqdzx
         s6NdnoBENvtTd8cz1nX7o20/psEf+prPmPhgsQRbdLJWWqJPBKkD2JsOAjE0grBLz9Eh
         jO8gKL4W2cgcp+Uu558WqmDrOz79Bod+BMUGB5r/D2k8ZN0G2xFy0/UlU3RhQNcTjAIs
         fpuuOu/z4hTT//uHIERiTK/sZKRm2lW64hCtv5sUU/Mx//PuevBhsdeFg1jLJY2HjO3C
         fsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TstEenVcD9dtm0gKpxBLxgiUK+JtbO5wqAf6oc/UT/w=;
        b=tnoheLAgjdhOVdhBbjwgt8eGvJ95/r6e81/pB8pDXi3pVs3LgNe1v9WRBrU8RjHAR3
         rK42on3exINsxdAq3MW8eDBeGxkq0p87WdNqIzJ14dTGza1QABmeITYeYbOpS8cLFykA
         AJlxkRzZ+41w9nBX+w8rkJAz4c9RLGZ/WSR23yVXz+dkFNSJXZdDeSKo1U5J/0vTTWz1
         IRqudgwCuguiFS30D0lLLknT3ExwrpsRPJvrDbOatxcOubmkK8Lvrx2ZVZpzkTTgeFWq
         JPnP7g4okufR0mgkq+5OEKN390UzSiPu8ERmdRPW4VSBnYPYoAmSS61nzMtyrImdgyY3
         +OBQ==
X-Gm-Message-State: ABuFfogJe3zzLAZrAdTyhnyZCNBGDXbSZmbUiK/uC6t+xswRva7L9vg0
        MOlKydyrhZQgGklRjbfO28ccM0ejW1rxdw==
X-Google-Smtp-Source: ACcGV62PRtTeD7wkD+9BxpC85l+DWYaVgkD4evLM+42AqDRnbjj/AJ7+5Z8yk2pxnFUItyvahEGGzg==
X-Received: by 2002:a17:902:654e:: with SMTP id d14-v6mr7934018pln.292.1539392363978;
        Fri, 12 Oct 2018 17:59:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id y185-v6sm3669235pgd.8.2018.10.12.17.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 17:59:23 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:59:18 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fuzz: Add basic fuzz testing target.
Message-ID: <20181013005918.GD12177@google.com>
References: <cover.1538693039.git.steadmon@google.com>
 <bfe4f2f965528ca2a45864857051b9835970ff07.1538693039.git.steadmon@google.com>
 <xmqqva6amtt7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqva6amtt7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.10 11:14, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +FUZZ_OBJS += fuzz-pack-headers.o
> > +
> > +FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
> > +
> > ...
> > +### Fuzz testing
> > +#
> > +.PHONY: fuzz-clean fuzz-objs fuzz-compile
> 
> I take it that you anticipate the fuzz programs in the future all
> be named fuzz-$(blah), whose source is fuzz-$(blah).o (even though
> we may grow some common code that may be linked with them, which can
> be done by tweaking the rule for the $(FUZZ_PROGRAMS) target).  Am I
> reading you correctly?  Would fuzz-{clean,objs,compile} risk squatting
> on nicer names we may want to use for $(blah) down the line?

Yes, that's correct. I've reworked the rules to be more compatible with
how OSS-Fuzz expects to build these targets, and now "fuzz-all" is
the only remaining special target.

> > + ...
> > +$(FUZZ_PROGRAMS): fuzz-compile
> > +	clang++ $(FUZZ_LDFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) $(XDIFF_OBJS) \
> > +		$(EXTLIBS) git.o $@.o /usr/lib/llvm-4.0/lib/libFuzzer.a -o $@
> 
> Is the expected usage pattern to know a single fuzz-* program the
> builder wants to build, to run "make fuzz-pack-headers"?  If not, it
> also would be a good idea to have something like
> 
>     fuzz-build-all:: $(FUZZ_PROGRAMS)
>     .PHONY: fuzz-build-all
> 
> perhaps?
> 
> Also, in the final version we unleash to general developer audience,
> we'd want to support "make V=1" (and "make" that is "$(QUIET)").

Done and done.
