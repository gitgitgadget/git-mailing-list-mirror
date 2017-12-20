Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C66A71F404
	for <e@80x24.org>; Wed, 20 Dec 2017 20:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbdLTURS (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 15:17:18 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46897 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbdLTURJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 15:17:09 -0500
Received: by mail-qt0-f196.google.com with SMTP id r39so29794117qtr.13
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 12:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w+rAZLGT1keqxvn+eu3yyzdGoVrojUo+Z2XdxG39kTA=;
        b=JHA+gMiXbPrjAYV8CYQnWIIb7oLaYtURSUGqY3k2Gz7SKP8c2NBx3ABtRybMiYaH6t
         u7HXJIc+c5qW/8CwJhoihZmnWZzwW623I45kFqjH3BH99/Q9X16jqMjy1XmQCggLYlNq
         8G8/gDw2ogiAbbsJLVSEpNj5+kOa7s1J8a1xksohYzxnSJESNV1uaVuAGXSH26ampQmw
         FFa4LnSxJHNgMFcwGvxGx8ZGnSnaZEJ4qUvU/nwp2s31+x0HnCI6TuyDhAH8Bh6HVXoi
         5dfHEqct7bVa7w3JbdQpzCJ/1GcXiJJUEEs6g2MVIEqA0e1+ZmryougaAoR/1Itnw9VO
         Mbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w+rAZLGT1keqxvn+eu3yyzdGoVrojUo+Z2XdxG39kTA=;
        b=q6j7sW+JqiiMQGKPWFIlF3/KYBIdKhmaXBP7pWKLsNgdet+0YAtSYaO07CRogW2NcE
         mPMOzqtU18Gbr34/s35E+/HdGYl0646N6HNingoStLKjp4ydghNKUpSu/+7cyhzyEI6r
         Gho8ZDA69AJS+X3IZHSTtvQiZ95zZFe9dLF+ZbYk6LlFSX3n3DHTkXAOU4wWBxONRFFu
         Ug05mXKvVEeDXcjTMDmlOdIzjvzj82spD1WRXF6slErH5GH1w4mMX6hqx0U8PRCTxYv8
         09uuztS19eEoYEulmhjiUhrTvh6F5cQQH6XLPXXnKsGFk+RiISLpcLRI8BKkRPgHlH84
         pWLw==
X-Gm-Message-State: AKGB3mJmBlfMuU+D6qskeWwwVTONCRPRNb3IpwsoKA6Iq1l+H5CwpeZo
        HFvfQXFKJDtpPIfJydaK2h8=
X-Google-Smtp-Source: ACJfBos5YK1nJxQRuPtjIGfyN3/JYo6jnH3EfJXymraz3M96CvnYMRPQIfcayAyGaLf63ANIq5MgAQ==
X-Received: by 10.200.3.194 with SMTP id z2mr12023505qtg.309.1513801028181;
        Wed, 20 Dec 2017 12:17:08 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id x10sm11368884qkl.47.2017.12.20.12.17.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 12:17:06 -0800 (PST)
Date:   Wed, 20 Dec 2017 15:17:04 -0500
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
Subject: Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make
 rules
Message-ID: <20171220201703.GI3693@zaya.teonanacatl.net>
References: <20171220174147.GG3693@zaya.teonanacatl.net>
 <20171220182419.16865-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171220182419.16865-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Dec 20, 2017 at 6:41 PM, Todd Zullinger <tmz@pobox.com> wrote:
>> /usr/share/perl5/vendor_perl/Git
>> /usr/share/perl5/vendor_perl/Git.pm
>> /usr/share/perl5/vendor_perl/Git/Error.pm
>> [...]
>> /usr/share/perl5/vendor_perl/build
>> /usr/share/perl5/vendor_perl/build/lib
>> /usr/share/perl5/vendor_perl/build/lib/Git
>> /usr/share/perl5/vendor_perl/build/lib/Git.pm
>> /usr/share/perl5/vendor_perl/build/lib/Git/Error.pm
>> [...]
>> Note that not all of the .pm files are matched, which I
>> believe is due to the glob matches only going 4 levels deep
>> under the perl dir.
> 
> Ouch, that's a stupid mistake of mine. Didn't consider that changing
> it from *.pm to *.pmc would of course impact that glob match.
> 
> This fixes it, changes against v5:
> 
>     @@ -224,7 +224,7 @@
>       po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
>         $(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
>       
>     -+LIB_PERL := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
>     ++LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
>      +LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
>      +
>      +ifndef NO_PERL
> 
> I.e. let's keep calling it "build" for consistency with other stuff
> and so "ls" will show it, but just alter the glob so we'll only match
> modules like Git{,::*}. I don't think we'll ever add anything outside
> that namespace, so this seems like the best solution.

Sounds good.  While it might not have been too bad to have a
hidden dir for build artifacts, using the more explicit glob
pattern is much nicer.

I'll use this locally and let you know if I notice any
issues.  Thanks for working on this.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some people never go crazy. What truly horrible lives they must
live.
    -- Charles Bukowski

