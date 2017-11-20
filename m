Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E170202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbdKTVuQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:50:16 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:42678 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbdKTVuP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:50:15 -0500
Received: by mail-wm0-f45.google.com with SMTP id 5so20510812wmk.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ausz7EtiSzMymnUUY6iD5rg7l4DXP5vC65dPwAVtyc0=;
        b=DWqvrieeqIHk3Xjmb3f4EqsNH41GYnU0e2gdStR82dxwu+7mcummXSNP3RiX2xgRDx
         Nh+zE2rHup32yRCePgC8tYlwtggcD/671cAu7+RE6wrxcvjqE5eSVAsrU8sgjeu6aXVu
         0CTPkGAiMnlwEy6lr1zelN3tijkLPHsaqJng5B+EaWypJdRV43YdO6Xijm4q6cKla5hW
         POjFr/6iV4ol8cYonPKqX+gCAG9n7JeoNEI5SWwMveBswnUWakRloqohqDvyzRWtXhFD
         oC1xIAZlVdr0tQS+NpCz4e3iBw+fpZKgIHAly9eu/aAWZfJPGlOAX5c/2QrOMx5eWTFw
         Dfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ausz7EtiSzMymnUUY6iD5rg7l4DXP5vC65dPwAVtyc0=;
        b=mWt82llPlqt9noGGrY2D/Ge8ZZQdMnlUWCl4UJF2LEvC2G7yF8dYSxzf14V6TwrJUK
         F2ix1cfNVdYZpQdU1BWZ0WXFwHv5it3xfQBwvmFYo1KxFwvFLZ8OgNnisTDvUf/o4hWd
         wU3tsi36A7PNjo1YmlYPHDKHxQWdTBl8nCiYkxHTfa4K/2f1I2s+jzafgIJmyM+YKqh2
         IPQxjsl5/Bz8D35cMDAwnOsON7nFamo0oVAYGKaNXwT1sDY65ZSW6wx8+gXEioRFmJhp
         hczWcX043p+xjezzBvjGsxtwb7nGjTapZGRNthyehsUNKjMgUMgYH3jLJ4FKZd326hwH
         JNNg==
X-Gm-Message-State: AJaThX5wiPhj7A+cWos8M4QWblkajL/jXmIrzdtadfIZvWiq6Pcp+/l6
        3CKds6+iNMGjERsVKI6pSLgDMSGq
X-Google-Smtp-Source: AGs4zMa8LsLIyd4Oshi6zMK5h4fwRtnn6XTNbFZIClWUa1rwVk9rQBuhuhBJ+ivvMjUI3VjkKZXSHw==
X-Received: by 10.80.164.87 with SMTP id v23mr11887077edb.99.1511214614431;
        Mon, 20 Nov 2017 13:50:14 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z23sm8781725edm.62.2017.11.20.13.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:50:13 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eGtxE-0004yY-Lk; Mon, 20 Nov 2017 22:50:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <20171119173141.4896-1-dnj@google.com> <20171119173141.4896-2-dnj@google.com> <87lgj0wtr9.fsf@evledraar.booking.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <87lgj0wtr9.fsf@evledraar.booking.com>
Date:   Mon, 20 Nov 2017 22:50:12 +0100
Message-ID: <87k1ykwrfv.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 20 2017, Ævar Arnfjörð Bjarmason jotted:

> On Sun, Nov 19 2017, Dan Jacques jotted:
>
>> [...]
>
> Firstly the promise of this is very neat. I'm happy to offer any help I
> can give.
>
>> Enable Git to resolve its own binary location using a variety of
>> OS-specific and generic methods, including:
>>
>> - procfs via "/proc/self/exe" (Linux)
>> - _NSGetExecutablePath (Darwin)
>> - KERN_PROC_PATHNAME sysctl on BSDs.
>> - argv0, if absolute (all, including Windows).
>>
>> This is used to enable RUNTIME_PREFIX support for non-Windows systems,
>> notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
>> do a best-effort resolution of its executable path and automatically use
>> this as its "exec_path" for relative helper and data lookups, unless
>> explicitly overridden.
>>
>> Git's PERL tooling now responds to RUNTIME_PREFIX_PERL. When configured,
>> Git's generated PERL scripts resolve the Git library location relative to
>> their runtime paths instead of hard-coding them. Structural changes
>> were made to Makefile to support selective PERL header generation.
>>
>> Small incidental formatting cleanup of "exec_cmd.c".
>
>> +$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
>>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>>  	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>>  	sed -e '1{' \
>>  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>> -	    -e '	h' \
>> -	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
>> -	    -e '	H' \
>> -	    -e '	x' \
>> +	    -e '	rGIT-PERL-HEADER' \
>> +	    -e '	G' \
>>  	    -e '}' \
>>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>>  	    $< >$@+ && \
>> @@ -1986,6 +2028,29 @@ GIT-PERL-DEFINES: FORCE
>>  		echo "$$FLAGS" >$@; \
>>  	    fi
>>
>> +GIT-PERL-HEADER: perl/perl.mak GIT-PERL-DEFINES FORCE
>> +ifndef RUNTIME_PREFIX_PERL
>> +	# Hardcode the runtime path.
>> +	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>> +	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>> +	echo \
>> +	  'use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));' \
>> +	  >$@
>> +else
>> +	# Probe the runtime path relative to the PERL script. RUNTIME_PREFIX_PERL
>> +	# automatically sets NO_PERL_MAKEMAKER, causing PERL scripts to be installed
>> +	# to "$(prefix)/lib" (see "perl/Makefile"). This expectation is hard-coded
>> +	# into the generated code below.
>> +	GITEXECDIR='$(gitexecdir_SQ)' && \
>> +	echo \
>> +	  'sub _get_git_lib{'\
>> +	  'use FindBin;'\
>> +	  '(my $$p=$$FindBin::Bin)=~s=/'$${GITEXECDIR}'$$==;'\
>> +		'return File::Spec->catdir($$p,"'"lib"'");' \
>> +	  '};' \
>> +	  'use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB}||_get_git_lib()));'\
>> +	  >$@
>> +endif
>
> If you run run:
>
>     make -j8 prefix=/tmp/git RUNTIME_PREFIX=YesPlease RUNTIME_PREFIX_PERL= CFLAGS="-O0 -g" all install
>
> And then:
>
>     make -j8 prefix=/tmp/git RUNTIME_PREFIX=YesPlease RUNTIME_PREFIX_PERL=YesPlease CFLAGS="-O0 -g" all install
>
> You end up with this:
>
>     $ tree /tmp/git/{lib,share/perl}
>     /tmp/git/lib
>     └── x86_64-linux-gnu
>         └── perl
>             └── 5.26.1
>                 ├── auto
>                 │ └── Git
>                 └── perllocal.pod
>     /tmp/git/share/perl
>     └── 5.26.1
>         [...]
>         └── Git.pm
>
> You need to bust the perl/PM.stamp cache as a function of your
> RUNTIME_PREFIX_PERL variable (or NO_PERL_MAKEMAKER).
>
> Other than that, is this whole NO_PERL_MAKEMAKER workaround just because
> you couldn't figure out what the target RELPERLPATH is in
> $prefix/$RELPERLPATH, which in this case is share/perl/5.26.1 ?
>
> I don't remember offhand how to extract that, but htis is built into
> perl itself, see e.g.:
>
>     $ PERL5LIB= /usr/bin/perl -E 'say for grep { m[share|lib] } @INC'
>     /usr/local/lib/x86_64-linux-gnu/perl/5.26.1
>     /usr/local/share/perl/5.26.1
>     /usr/lib/x86_64-linux-gnu/perl5/5.26
>     /usr/share/perl5
>     /usr/lib/x86_64-linux-gnu/perl/5.26
>     /usr/share/perl/5.26
>     /usr/local/lib/site_perl
>     /usr/lib/x86_64-linux-gnu/perl-base
>
> So it's in Config.pm somewhere IIRC. But your patch doesn't discuss why
> you toggled NO_PERL_MAKEMAKER, is it purely to work around this issue,
> and if we had some aesy way to figure out the target $RELPERLPATH we
> wouldn't need to do that?
>
> Seems a bit of baby & bathwater there :)

So LeonT over at #p5p helped me with this. He believes this'll work
(unless MakeMaker INSTALL_BASE is set, but that should break the Git
install anyway):


    /usr/bin/perl -MConfig -wE 'my ($relsite) = $Config{installsitelib} =~ m[^\Q$Config{siteprefixexp}\E/(.+)]s; say $relsite'
    share/perl/5.26.1

I.e. aside from my spiel below injecting this should work, and would
eliminate the need to toggle NO_PERL_MAKEMAKER (untested):

    BEGIN {
        use lib split /:/,
        (
            $ENV{GITPERLLIB}
            ||
            do {
                require FindBin;
                require File::Spec;
                require Config;
                Config->import;

                my ($relsite) = $Config{installsitelib} =~ m[^\Q$Config{siteprefixexp}\E/(.+)]s
                    or die "PANIC: Ohes noes $Config{siteprefixexp} doesn't match a subset of $Config{installsitelib}";
                File::Spec->catdir($FindBin::Bin, '..', '..', $relsite);
            }
        );
    }


> Aside from that:
>
> 1. The regex match you're doing to munge the dir could be done as a
>    catdir($orig, '..', '..', 'lib'), that doesn't work as discussed
>    above, but *might* be more portable. I say might because I don't know
>    if the path string is always normalized to be unix-like, but if not
>    this won't work e.g on Windows where it'll have \ not /.
>
> 2. You are 'use'-ing FindBin there unconditionally (use is not function
>    local in perl), and implicitly assuming it loads File::Spec.
>
>    Ignoring the NO_PERL_MAKEMAKER caveats above I'd suggest something
>    like this:
>
>        #!/usr/bin/perl
>
>        # BEGIN RUNTIME_PREFIX_PERL=YesPlease generated code.
>        #
>        # This finds our Git::* libraries at relative locations.
>        BEGIN {
>            use lib split /:/,
>            (
>                $ENV{GITPERLLIB}
>                ||
>                do {
>                    require FindBin;
>                    require File::Spec;
>                    File::Spec->catdir($FindBin::Bin, '..', '..', 'lib');
>                }
>            );
>        }
>        # END RUNTIME_PREFIX_PERL=YesPlease generated code.
>
>        # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
>        # License: GPL v2 or later
>
>    It's also nice to have some whitespace / comments to note that this
>    is generated code.
>
>  3. I may be squinting at this wrong but it seems to me that between
>     your v1 and v2 reading GITPERLLIB here no longer makes any sense at
>     all. You used to set it in git itself, now it takes priority but
>     nothing sets it, presumably you'd have some external wrapper script
>     that'll set it?
>
>     Now if I compile with RUNTIME_PREFIX=YesPlease I get magic
>     auto-discovery of C program paths, right? But it'll still fallback
>     to the system perl libs (if any) unless
>     RUNTIME_PREFIX_PERL=YesPlease is set. Shouldn't we just make
>     RUNTIME_PREFIX=YesPlease Just Work for everything?
