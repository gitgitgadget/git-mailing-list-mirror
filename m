Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0A21F404
	for <e@80x24.org>; Wed, 20 Dec 2017 17:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755852AbdLTRlw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 12:41:52 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34142 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755732AbdLTRlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 12:41:51 -0500
Received: by mail-qt0-f194.google.com with SMTP id 33so29301419qtv.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 09:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LthRFVP6hz9V4JGQJo/BMVgXNStDFvczl5bC34Cfmrc=;
        b=HUC308+FIeY3VHOqidv4EgG+rpRG9O0H88CcX2dYrSKB/gy6b1e8v1yBVJgSAG3/sx
         CWlsKGgr/nyhi3+VSXCTpvHvAbVcF8OEeipmoL0qhJ14XYmWdsVMJ/dHGMQ8QzXP/6PN
         BIeNzq2N8U3dZaTmp1yI08j4ysY9rcMePT/LyOO9LAfzPw6stN0QV7v4DbL5b2r3ahvC
         sHStniPm6nPc55d6RZmy7WyJR2itqdNJBTTrKnjjA9Dw7tM/h/TA3/DWVT0QLrHNnwyk
         qj/+ZxtDWXPg+KpqwU2MJT3Z0cC0YHyPIZAdg3H3+9PE5FpzCka4eRR6cwpXRHniD4PK
         dOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LthRFVP6hz9V4JGQJo/BMVgXNStDFvczl5bC34Cfmrc=;
        b=ugdHq6tjaO4WnhXnQJGFTolaDSBcggKqP1Mqp5PyawaIQ0KKTktNcrGXtNGoVwHbTM
         cp04N0Z51v48KYW/NlI/pLY34o13EKj9ZDbIUK7HHV1MAqLEgB9nKnIdi/DzSxXb43Iz
         Bgt6JchLKHUNZTz+zaSa8cDxekXCUda4sG25CaDm2Rms7nhr8gvUuJT77sDqI9EXl3XR
         yf+WBjq3D5ywD0+H5eq69987sagED2xRLNjn3a6qgN4F71MxdbVClqJmsKzN0kPuaMzu
         7aOZqpS6THQpdO/KYEdxZH1ySdL2lNzNwVXKVECzI1q85LQsuCslkEuPsFS/ATLiAqt7
         NZLQ==
X-Gm-Message-State: AKGB3mK5aH2o6FI/6fwkZTPuN+ZPQn59GzJKuKi0+1QG3KI37RdBaQpl
        uvGrtF+dMSl2eWIGPMg3CLw=
X-Google-Smtp-Source: ACJfBosJDDH7Q6Q5zOfqsS8+M284rOnZoAHZlf/Rdcy1KNW/AQTNoo/dki2IfiA1kvZPA+J/TLx8PQ==
X-Received: by 10.200.53.201 with SMTP id l9mr4152709qtb.155.1513791710627;
        Wed, 20 Dec 2017 09:41:50 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id h32sm11485488qtk.8.2017.12.20.09.41.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 09:41:49 -0800 (PST)
Date:   Wed, 20 Dec 2017 12:41:47 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v5] Makefile: replace perl/Makefile.PL with simple make
 rules
Message-ID: <20171220174147.GG3693@zaya.teonanacatl.net>
References: <20171220061545.GF3693@zaya.teonanacatl.net>
 <20171220115240.19510-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171220115240.19510-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> [Sorry for not CC-ing you on the last version. Forgot to update the
> giant send-email line I'm juggling for this series].

No worries.  It is a rather large CC list at this point. :)

> This *.pmc thing is just me being overly clever. Here's a v5 that gets
> rid of it. Diff with v4:

Ahh, thanks for the additional details on this.

>         -+PMFILES := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
>         -+PMCFILES := $(patsubst perl/%.pm,perl/build/lib/%.pmc,$(PMFILES))
>         ++LIB_PERL := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
>         ++LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
>          +
>          +ifndef NO_PERL
>         -+all:: $(PMCFILES)
>         ++all:: $(LIB_PERL_GEN)
>          +endif
>          +
>         -+perl/build/lib/%.pmc: perl/%.pm
>         ++perl/build/lib/%.pm: perl/%.pm
>          +  $(QUIET_GEN)mkdir -p $(dir $@) && \
>          +  sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
>          +

Without the .pmc extensions, rpm picks up the perl
dependencies, which is good.  But an additional build/lib
dir is created, which ends up in $perllibdir after install.

Here's an extract from a local build:

mkdir -p perl/build/lib/build/lib/ && \
sed -e 's|@@LOCALEDIR@@|/usr/share/locale|g' < perl/build/lib/Git.pm > perl/build/lib/build/lib/Git.pm
mkdir -p perl/build/lib/build/lib/Git/ && \
sed -e 's|@@LOCALEDIR@@|/usr/share/locale|g' < perl/build/lib/Git/IndexInfo.pm > perl/build/lib/build/lib/Git/IndexInfo.pm
mkdir -p perl/build/lib/build/lib/Git/ && \
sed -e 's|@@LOCALEDIR@@|/usr/share/locale|g' < perl/build/lib/Git/SVN.pm > perl/build/lib/build/lib/Git/SVN.pm
mkdir -p perl/build/lib/build/lib/Git/ && \
sed -e 's|@@LOCALEDIR@@|/usr/share/locale|g' < perl/build/lib/Git/Error.pm > perl/build/lib/build/lib/Git/Error.pm
mkdir -p perl/build/lib/build/lib/Git/ && \
sed -e 's|@@LOCALEDIR@@|/usr/share/locale|g' < perl/build/lib/Git/I18N.pm > perl/build/lib/build/lib/Git/I18N.pm

When PMFILES and PMCFILES matched .pm and .pmc respectively,
the glob didn't match duplicated files under build/lib, so
this wasn't an issue.  I'm not sure where this is best
fixed.  The build/lib dir could be moved outside of perl or
it could be made .build/lib to avoid the wildcard match,
perhaps.

Building with perllibdir=/usr/share/perl5/vendor_perl
results in:

/usr/share/perl5/vendor_perl/Git
/usr/share/perl5/vendor_perl/Git.pm
/usr/share/perl5/vendor_perl/Git/Error.pm
/usr/share/perl5/vendor_perl/Git/FromCPAN
/usr/share/perl5/vendor_perl/Git/FromCPAN/Error.pm
/usr/share/perl5/vendor_perl/Git/I18N.pm
/usr/share/perl5/vendor_perl/Git/IndexInfo.pm
/usr/share/perl5/vendor_perl/Git/SVN
/usr/share/perl5/vendor_perl/Git/SVN.pm
/usr/share/perl5/vendor_perl/Git/SVN/Editor.pm
/usr/share/perl5/vendor_perl/Git/SVN/Fetcher.pm
/usr/share/perl5/vendor_perl/Git/SVN/GlobSpec.pm
/usr/share/perl5/vendor_perl/Git/SVN/Log.pm
/usr/share/perl5/vendor_perl/Git/SVN/Memoize
/usr/share/perl5/vendor_perl/Git/SVN/Memoize/YAML.pm
/usr/share/perl5/vendor_perl/Git/SVN/Migration.pm
/usr/share/perl5/vendor_perl/Git/SVN/Prompt.pm
/usr/share/perl5/vendor_perl/Git/SVN/Ra.pm
/usr/share/perl5/vendor_perl/Git/SVN/Utils.pm
/usr/share/perl5/vendor_perl/build
/usr/share/perl5/vendor_perl/build/lib
/usr/share/perl5/vendor_perl/build/lib/Git
/usr/share/perl5/vendor_perl/build/lib/Git.pm
/usr/share/perl5/vendor_perl/build/lib/Git/Error.pm
/usr/share/perl5/vendor_perl/build/lib/Git/I18N.pm
/usr/share/perl5/vendor_perl/build/lib/Git/IndexInfo.pm
/usr/share/perl5/vendor_perl/build/lib/Git/SVN.pm

Note that not all of the .pm files are matched, which I
believe is due to the glob matches only going 4 levels deep
under the perl dir.

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Never do today that which will become someone else's responsibility
tomorrow.

