Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83AB1F42B
	for <e@80x24.org>; Tue,  2 Jan 2018 20:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbeABUjg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 15:39:36 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40370 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeABUjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 15:39:35 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so62674950wmf.5
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 12:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JprJuuduipCJ2N0ujK8wAdj335XGO76956c82WSnrxA=;
        b=RqjCO0PSagI5v2lZn5zI2jV5piA/24EFcHc1pF0U0dolzSeA/D8jmJ/bVO5Bi35Z5/
         KuAsnG1i98fZbltlR5u3XuhrDA8uhkJbLKkVbf7q5HEM0aZ10H4F6AImuboongHAp22z
         0u4V6VGHqH1k0Z7xIuQ13RiHSNRku7BcS15UaizwAxiGtwyro18rnmpT8wkbBwE6Ycdn
         94MXGPEbrk5ypn8kN4Vv5c+aBitq+On95IT+KW+lq8spJiELnkWE2J3o8UMbDRx/PdNu
         3YTcF81uw/brALD+4CjcEUwJaP9RDm8igZX9Yp3nWNywucyA2MhmOKNr12Pt+n2qxobP
         y6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JprJuuduipCJ2N0ujK8wAdj335XGO76956c82WSnrxA=;
        b=W9afcyGbhQrW/uLvigoKZKXuI+Zfo233CS+EqjWg/zirzYnoi8+p1HQxiAo2rn6uIe
         Soe7FsJai4Duj6StR67UYuIq6IT454cGiINkBHh0fpHzoKUDTcJkIMO4Nt+CAIqjMtRj
         tBSAzfHEpOB0D24MCPMxBtmN7BFMBnxOMyd0JA9zQrTR+/5NQbDiRaS0Ju4K0MVQbo1T
         x7CehHk9YpDmXgVv4uWdbErO0XitLMnF5orYunW0Z5UvGH9y5I390uwrsxrsy9DEw7KR
         v9ndRTJMuH15IKdLgO2UyJV8iMzZz/Tf3pMeA/IexowxG0UIGRjOq9IA5IY8UFPmPX4x
         qPDQ==
X-Gm-Message-State: AKGB3mKVeo777sgqDMgXspIhR0SYktB3UZ+5bG90mJuRg09zLd8SBslX
        DTDQS0wuZBMfYO+YIkeFKyGKDat2
X-Google-Smtp-Source: ACJfBoslWEN2zNpMnoYLQVKyjqqHZD9vvqtxcizc8VqSHoOhL+o1u9UxIa2o118gsr6o2eRp7k5atQ==
X-Received: by 10.28.0.193 with SMTP id 184mr39252736wma.58.1514925573480;
        Tue, 02 Jan 2018 12:39:33 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c53sm64633064wrg.10.2018.01.02.12.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 12:39:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
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
Subject: Re: [PATCH ab/simplify-perl-makefile] perl: treat PERLLIB_EXTRA as an extra path again (Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make rules)
References: <20171220174147.GG3693@zaya.teonanacatl.net> <20171220182419.16865-1-avarab@gmail.com> <20180102191720.GB131371@aiede.mtv.corp.google.com> <20180102200140.GC131371@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20180102200140.GC131371@aiede.mtv.corp.google.com>
Date:   Tue, 02 Jan 2018 21:39:28 +0100
Message-ID: <87lghgc7wf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 02 2018, Jonathan Nieder jotted:

> Subject: perl: treat PERLLIB_EXTRA as an extra path again
>
> PERLLIB_EXTRA was introduced in v1.9-rc0~88^2 (2013-11-15) as a way
> for packagers to add additional directories such as the location of
> Subversion's perl bindings to Git's perl path.  Since 20d2a30f
> (Makefile: replace perl/Makefile.PL with simple make rules,
> 2012-12-10) setting that variable breaks perl-based commands instead:
>
>  $ PATH=$HOME/opt/git/bin:$PATH
>  $ make install prefix=$HOME/opt/git PERLLIB_EXTRA=anextralibdir
> [...]
>  $ head -2 $HOME/opt/git/libexec/git-core/git-add--interactive
>  #!/usr/bin/perl
>  use lib (split(/:/, $ENV{GITPERLLIB} || ":helloiamanextrainstlibdir" || "/usr/local/google/home/jrn/opt/git/share/perl5"));
>  $ git add -p
>  Empty compile time value given to use lib at /home/jrn/opt/git/libexec/git-core/git-add--interactive line 2.
>
> Removing the spurious ":" at the beginning of ":$PERLLIB_EXTRA" avoids
> the "Empty compile time value" error but with that tweak the problem
> still remains: PERLLIB_EXTRA ends up replacing instead of
> supplementing the perllibdir that would be passed to 'use lib' if
> PERLLIB_EXTRA were not set.
>
> The intent was to simplify, as the commit message to 20d2a30f
> explains:
>
> | The scripts themselves will 'use lib' the target directory, but if
> | INSTLIBDIR is set it overrides it. It doesn't have to be this way,
> | it could be set in addition to INSTLIBDIR, but my reading of
> | [v1.9-rc0~88^2] is that this is the desired behavior.
>
> Restore the previous code structure to make PERLLIB_EXTRA work again.
>
> Reproducing this problem requires an invocation of "make install"
> instead of running bin-wrappers/git in place, since the latter sets
> the GITPERLLIB environment variable, avoiding trouble.
>
> Reported-by: Jonathan Koren <jdkoren@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Jonathan Nieder wrote:
>> Hi,
>>
>> Ævar Arnfjörð Bjarmason wrote:
>>
>> > +++ b/Makefile
>> [...]
>> > -PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
>> > -$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
>> > +PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
>> > +$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
>> >  	$(QUIET_GEN)$(RM) $@ $@+ && \
>> > -	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>> >  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>> >  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>> >  	sed -e '1{' \
>> >  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>> >  	    -e '	h' \
>> > -	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
>> > +	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$(perllibdir_SQ)"'"));=' \
>>
>> This appears to have broken a build with INSTLIBDIR set.
>
> Here it is in patch form.
>
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 5c73cd208a..409e8f6ec9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1951,12 +1951,13 @@ $(SCRIPT_PERL_GEN):
>  PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
>  $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> +	INSTLIBDIR='$(perllibdir_SQ)' && \
>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>  	sed -e '1{' \
>  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>  	    -e '	h' \
> -	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$(perllibdir_SQ)"'"));=' \
> +	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
>  	    -e '	H' \
>  	    -e '	x' \
>  	    -e '}' \

This obviously makes perfect sense if the intent is to add this lib dir
instead of it being a replacement (as is clear from this being an issue
you're noting).

With the benefit of hindsight in re-reading the commit + this report I
can see that it *should* be that way, but I assumed it was the other way
around when I wrote this up.

Thanks!
