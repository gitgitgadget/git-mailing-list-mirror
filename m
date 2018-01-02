Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E271F428
	for <e@80x24.org>; Tue,  2 Jan 2018 19:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeABTR0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 14:17:26 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:44713 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeABTRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 14:17:24 -0500
Received: by mail-it0-f66.google.com with SMTP id b5so39750003itc.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4XFl2q694V7xojPm3lMVXrnXJpgOH74mmcjHOQ3RKDY=;
        b=SqPmHDnmE8rUqFSu1/U1qZQ0ZmXt1mgb9cnXmj7E/vwl8OAA4vvsXeKKHSiEeQgmJJ
         V8FMfV5KUDzImaDhFPTU42gzFjY+c0CWCBvJfkWRfkBtWxY7iI3/adMChGdEmM8OS5HP
         LYWvsNWlwmSRZUec/XV6NdMADnsEXBoKcmVqY6aF6JT3ET6hSTKjxFD+TEPTnG0fZ6EA
         +SHrIBqjced936HOrhEjUPfMoJ2BklKcTq1Lty9w0qrd0QXkzPa3oSOdmUQGEtEttcee
         Y+OONkWRlIHt1y9+ttdMb0CBubsFMnrV9C9AR5TN9oxO6ximLckRBNPl3Dkn7E1EVpug
         VBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4XFl2q694V7xojPm3lMVXrnXJpgOH74mmcjHOQ3RKDY=;
        b=lsFFMW0Hu5CjvDaNBDzj9atnONqRyXOVtezRr306fKgAEKPLms6JfPu45ex08EjU2Z
         GQXdpTYQ9g4ioUXYtQLx35MCfmHGQWPhCAXqobIkvI1ea5rwmor71hZWum0S6HUspW08
         n89RhT5R4UJL83//me1P1BiOrW5T5fqXtlL8mWMa8tlu/sP6rDz3T7GsbC8TGp6CK9gP
         rNjWXHU0C2+0dRCho6YrcqmYffYVequ4bLHXLnvX8aXxmGOhM3KZsm8Bny/7RYP9Y8hV
         k7aR6eM3Jq+olzhwPymThEnq2peXQWMVZ67M/Yk2/Wr2EQFlon0v7/zjCxxpB0oCeB4L
         ZWWQ==
X-Gm-Message-State: AKGB3mIqAIGP/qK4cMJkkqQsU2hpuHg5zgfAhegnOwhdu5/5JXhtKXtd
        JokyI8837OEY0Nf/RAGpBAc=
X-Google-Smtp-Source: ACJfBosq/qih4/e2SGXgu/QnAE2mpc4VaSitwshXrNaGDbb7iYSRB7J93/r6EUgd1pb8xCdvcCjrEw==
X-Received: by 10.36.207.132 with SMTP id y126mr25953173itf.132.1514920643365;
        Tue, 02 Jan 2018 11:17:23 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g187sm16999916itb.29.2018.01.02.11.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 11:17:22 -0800 (PST)
Date:   Tue, 2 Jan 2018 11:17:20 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>,
        Todd Zullinger <tmz@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make
 rules
Message-ID: <20180102191720.GB131371@aiede.mtv.corp.google.com>
References: <20171220174147.GG3693@zaya.teonanacatl.net>
 <20171220182419.16865-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171220182419.16865-1-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> +++ b/Makefile
[...]
> -PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
> -$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
> +PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
> +$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> -	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>  	sed -e '1{' \
>  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>  	    -e '	h' \
> -	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
> +	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$(perllibdir_SQ)"'"));=' \

This appears to have broken a build with INSTLIBDIR set.

 $ head -2 /usr/local/git/current/libexec/git-core/git-add--interactive
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB} || ":/Applications/Xcode.app/Contents/Developer/Library/Perl/5.@{[sub{use Config; $Config{api_version}}->()]}/darwin-thread-multi-2level" || "/usr/local/git/current/share/perl5"));

(forgive the hackiness there).

Is there a reason we don't do

	INSTLIBDIR='$(perllibdir_SQ)' && \
	INSTLIBDIR_EXTRA=... &&
	INSTLIBDIR=...

and

	use lib ... || "'"$$INSTLIBDIR"'"));=' \

?

Thanks,
Jonathan
