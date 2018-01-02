Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9131F428
	for <e@80x24.org>; Tue,  2 Jan 2018 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbeABUCR (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 15:02:17 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:41107 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeABUCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 15:02:16 -0500
Received: by mail-it0-f68.google.com with SMTP id x28so39896119ita.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2qZjDs3eLXiZcmvm2KLrpGk/6/ute9AF0mjOrZbkZ2M=;
        b=fw0M5PLR+BHkAldpc5n+uYb/9JK3leQ6SHdcx/EmKbjebMewqlPo2OVVuPFT6ePFWx
         aDhYBQBV5F0gNuvckzunw+sUSfaxsj0A3lmbd6Wg+4YJMMJmSaOtGZY+gt3Ef+iG/lLd
         TVl6YT/IC+eBaOTMTaz4xJdodiCul3waWlyl/4tqLs2vAXNWnJyIM2TqDq/BTa8NoXP1
         AyWx++mpgKBtZulb/7EQVQGzUhG2lXTfU/KXboZtp1NzicyPNDXncj1tWvfvmFYMHj3/
         bD4cc8Rme3dNMNyrFnAqIhwxJcMVfEmyA5rWLbX6qTBL0IauxssCA54OB4+SzxLyPaF0
         M9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2qZjDs3eLXiZcmvm2KLrpGk/6/ute9AF0mjOrZbkZ2M=;
        b=ZSNbvByPbeEQRUk0tDRcXg7eBgUdj45rqYhIpLoeO42+1wkvcLAzSS/PVDFBUdLJVk
         G5wwuQSJHrwDCT7v8jCH3iL1RvqU8y0SD0nHhCsFyTxJ0ZqK3QGdjNoWf+J7XfaXoLhM
         smQKF4ZxukRPx/L+LDOEbE212b91o7x6sXECnvhExxb/pPzUojtaZww2EV9oecwuhbHr
         ZfmQESVFEwdtYxh2uthVa7tiWJ8Z7yubRFp9RgqMfuKRkEphLFNBO/LDL2pKxcnkPKh1
         7BYqpzikQTJhRkrMQu/gLYDm2MXw0zcdp5bUZcEfFOyyts3jOHcY5eRa/n+fPG+PF90e
         H5sw==
X-Gm-Message-State: AKGB3mI4F7+MgsN43xRFv59y0krXBiDxWLhWxjxGx/ao2wCjktaufP5f
        fuw7+zWqC99dlYoKeY8oYVU=
X-Google-Smtp-Source: ACJfBoskE2F2MxEJmUvhiUAd3d76RNQXOkeOEqekWMhNiXFPASsXmipHIgMJl87bNEK9cHmyWFG64A==
X-Received: by 10.36.185.76 with SMTP id k12mr57653442iti.49.1514923304303;
        Tue, 02 Jan 2018 12:01:44 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j21sm24143832ioe.25.2018.01.02.12.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 12:01:43 -0800 (PST)
Date:   Tue, 2 Jan 2018 12:01:40 -0800
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
Subject: [PATCH ab/simplify-perl-makefile] perl: treat PERLLIB_EXTRA as an
 extra path again (Re: [PATCH v6] Makefile: replace perl/Makefile.PL with
 simple make rules)
Message-ID: <20180102200140.GC131371@aiede.mtv.corp.google.com>
References: <20171220174147.GG3693@zaya.teonanacatl.net>
 <20171220182419.16865-1-avarab@gmail.com>
 <20180102191720.GB131371@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180102191720.GB131371@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: perl: treat PERLLIB_EXTRA as an extra path again

PERLLIB_EXTRA was introduced in v1.9-rc0~88^2 (2013-11-15) as a way
for packagers to add additional directories such as the location of
Subversion's perl bindings to Git's perl path.  Since 20d2a30f
(Makefile: replace perl/Makefile.PL with simple make rules,
2012-12-10) setting that variable breaks perl-based commands instead:

 $ PATH=$HOME/opt/git/bin:$PATH
 $ make install prefix=$HOME/opt/git PERLLIB_EXTRA=anextralibdir
[...]
 $ head -2 $HOME/opt/git/libexec/git-core/git-add--interactive
 #!/usr/bin/perl
 use lib (split(/:/, $ENV{GITPERLLIB} || ":helloiamanextrainstlibdir" || "/usr/local/google/home/jrn/opt/git/share/perl5"));
 $ git add -p
 Empty compile time value given to use lib at /home/jrn/opt/git/libexec/git-core/git-add--interactive line 2.

Removing the spurious ":" at the beginning of ":$PERLLIB_EXTRA" avoids
the "Empty compile time value" error but with that tweak the problem
still remains: PERLLIB_EXTRA ends up replacing instead of
supplementing the perllibdir that would be passed to 'use lib' if
PERLLIB_EXTRA were not set.

The intent was to simplify, as the commit message to 20d2a30f
explains:

| The scripts themselves will 'use lib' the target directory, but if
| INSTLIBDIR is set it overrides it. It doesn't have to be this way,
| it could be set in addition to INSTLIBDIR, but my reading of
| [v1.9-rc0~88^2] is that this is the desired behavior.

Restore the previous code structure to make PERLLIB_EXTRA work again.

Reproducing this problem requires an invocation of "make install"
instead of running bin-wrappers/git in place, since the latter sets
the GITPERLLIB environment variable, avoiding trouble.

Reported-by: Jonathan Koren <jdkoren@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Hi,
> 
> Ævar Arnfjörð Bjarmason wrote:
> 
> > +++ b/Makefile
> [...]
> > -PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
> > -$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
> > +PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
> > +$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
> >  	$(QUIET_GEN)$(RM) $@ $@+ && \
> > -	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
> >  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
> >  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
> >  	sed -e '1{' \
> >  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> >  	    -e '	h' \
> > -	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
> > +	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$(perllibdir_SQ)"'"));=' \
> 
> This appears to have broken a build with INSTLIBDIR set.

Here it is in patch form.

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5c73cd208a..409e8f6ec9 100644
--- a/Makefile
+++ b/Makefile
@@ -1951,12 +1951,13 @@ $(SCRIPT_PERL_GEN):
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
+	INSTLIBDIR='$(perllibdir_SQ)' && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$(perllibdir_SQ)"'"));=' \
+	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
 	    -e '	H' \
 	    -e '	x' \
 	    -e '}' \
-- 
2.16.0.rc0.224.g99853183ba

