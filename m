Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C1E1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 02:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeDXC5E (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 22:57:04 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:33847 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932861AbeDXC4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 22:56:55 -0400
Received: by mail-ot0-f178.google.com with SMTP id i5-v6so19643035oth.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emQqrfjOKPA6yHpWyPeVNSE4CfADaRJvy6HuM3XLEnM=;
        b=OnG71e5isuuDul5Kp5wirVnTvFzQOPEKRScIGpNcNaitORZg1PM6RS+F0Gh3/L+vrx
         K5jFQQ8YXKDw3MxO5tp796fdJ5smX44h+FH6UHFYuYD+HNRwkBp/0biXQCP00Si+7tuJ
         I+l67zXyCyGbrG4HbeCtHxEqZY03v+P+1yMqgzs0uC+5Dv9wosomZUDMwRaA4nRCNCV/
         gHuOHBAfD54TNE4DaZ/AIByxKQAkJNcuqYKWszsRBtNfz67S3F0tie407ZIv2IOQSv35
         3bQrZfT9ULT2Y8F9qI2z3rm4MS/I4eu/iDHQ2sdseD+1rtXHjxuHfO4drWQajrf/98Yd
         /kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emQqrfjOKPA6yHpWyPeVNSE4CfADaRJvy6HuM3XLEnM=;
        b=ZyvEJMdGCEHiaIIMZYHpltPWDxH8ismdeX2ULrffNvhdZ228/fEdwF0YoNR32lWBBh
         N4BQMfk9R9ZLF1KQ6CRSj63hYyA3w3AY4TGLFbVP9PfPn+gMjLRWnjNUYAzx95ylIisw
         clECrQO5ag5KgB/UMaBp1oWk0dnXsykjMwxMSqqNW7Z+XXKLM/iEdKUzWOh+6huVGXNX
         Gk/MzTNvpEUzefehxmnF3PUH3CR1XEs276IGQIdNVu0cDwBsl5/joQ/hece9oYDWUtgp
         m+uCKNprGGim384dTGvWL/PW6ps9WPWNg8K6Rcpj/hULJHRUIcoEvM7EvHH+w1jIWFlp
         mdzg==
X-Gm-Message-State: ALQs6tAobet0DUP4Z2pCLxEJu/Y7c8a8kzlNOC4SczunScsgmikKgZDN
        hgiGBmfF/EjNcPfOLampkuI+W8GNNwWzOV064YXbpA==
X-Google-Smtp-Source: AB8JxZoj1/IJZGN9ZAjMoFKnz0wD+f8iY8dul/9+uRRa364G6vnEcVimtNWqVqb09ZG2uNJW+2nv5qdIKloHYu3QAEI=
X-Received: by 2002:a9d:1f49:: with SMTP id x9-v6mr1756194otx.300.1524538614337;
 Mon, 23 Apr 2018 19:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com> <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org> <20180423232326.GB25128@aiede.svl.corp.google.com>
 <20180423232535.GD25128@aiede.svl.corp.google.com> <xmqqin8h8lx7.fsf@gitster-ct.c.googlers.com>
 <20180424021834.GE25128@aiede.svl.corp.google.com>
In-Reply-To: <20180424021834.GE25128@aiede.svl.corp.google.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Tue, 24 Apr 2018 02:56:43 +0000
Message-ID: <CAD1RUU_W_Caa7pbM6Nvxe4yAYeXZB3vvRYEURvvmAgHzxM=sPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] Makefile: quote $INSTLIBDIR when passing it to sed
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good catch, thanks for doing this!
-Dan
On Mon, Apr 23, 2018 at 10:18 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

> f6a0ad4b (Makefile: generate Perl header from template file,
> 2018-04-10) moved some code for generating the 'use lib' lines at the
> top of perl scripts from the $(SCRIPT_PERL_GEN) rule to a separate
> GIT-PERL-HEADER rule.

> This rule first populates INSTLIBDIR and then substitutes it into the
> GIT-PERL-HEADER using sed:

>          INSTLIBDIR=... something ...
>          sed -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' $< > $@

> Because $INSTLIBDIR is not surrounded by double quotes, the shell
> splits it at each space, causing errors if INSTLIBDIR contains a
> space:

>   sed: 1: "s=@@INSTLIBDIR@@=/usr/l ...": unescaped newline inside
substitute pattern

> Add back the missing double-quotes to make it work again.

> Improved-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,

> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:

> >> +++ b/Makefile
> >> @@ -2108,7 +2108,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE)
GIT-PERL-DEFINES Makefile
> >>      INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
> >>
  INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
> >>      sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> >> -        -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> >> +        -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
> >
> > Good find.  FWIW, I'd find it a lot easier to read if the whole
> > thing were enclosed inside a single pair of dq.

> Thanks. I agree, so here's an updated version doing that.

>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/Makefile b/Makefile
> index 2327ccb906..5e25441861 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2116,7 +2116,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE)
GIT-PERL-DEFINES Makefile
>          INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \

INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>          sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> -           -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> +           -e "s=@@INSTLIBDIR@@=$$INSTLIBDIR=g" \
>              -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
>              -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
>              -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
> --
> 2.17.0.441.gb46fe60e1d
