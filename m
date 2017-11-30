Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6EFB20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 22:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdK3Wal (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 17:30:41 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:43544 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK3Wak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 17:30:40 -0500
Received: by mail-wm0-f51.google.com with SMTP id n138so438188wmg.2
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f32ewlPne02ZnVQugyaBdRqmFcMk6N/4zSZc5aoVnaA=;
        b=X7M0v/XmzySYuCkrctU6xAT59EOwTjeuaF9ZgFw96sFnIQK0oJTJc5kZIDKkcN1BOJ
         km0k2Qv+NsY637S3XKDrm400KW0a58KF2+7rMQ9aPTI59ii0IJBpW1y/lBl0px2TugDt
         Es0QvSMfSBtVIxob30bHcBzDXisBKLLLcJ3JtIRxDEog0fDu8XLSZK9xpgKIyu1M3RHS
         NwWSYjHCitzdHwrkOl0PaMwDhD6EiIR9h62bUrizOLSKc13gwCpb+x9mJTGTJ2zlxtDI
         hOGZVQeAuMOKTsrYr9n1/M5yv6SHhesHMm22aaUjl9VvY5zq2X/B5AhxJpvBIQ0VHB8O
         V3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=f32ewlPne02ZnVQugyaBdRqmFcMk6N/4zSZc5aoVnaA=;
        b=O65kdkRsT+C80j1kGZbihN6MyuctjUeOG8V6IW2r4TdFUxlFIu0Ib3qhjmr5qnPJxQ
         cHVnn3+6SBWSMDQ6H8CzjbF54EHnuhpX0hCn+9HqmGhP+XGabvxCRDL5bUOasbf1uRQ0
         EU99bl9fBWi+gpXutWY44NNoQzS1xGRhoHaGnVaFHmmi3DWf0jUaurQUJ+VD988dnwR4
         vu366LdvUz4dq03lkMXV1tEi8TzOCyykLRrtZpsEZY0Y+WxUZRXwmoec6Hsu7tUSgjuq
         vvGLp3Ls6M5ynC+Qb+GcE4NYUk8Io5cqg1yC5Vii2UvSSGNixJfboja/UYpamJ/R4kbB
         oa6g==
X-Gm-Message-State: AJaThX6l0oyh+uye+JUsSxO0n46DfIeU9KWvAWgYm/GE1752fGXmCEhf
        mhFgZgv5S0BxP9V6lT7zLhZ06kAe
X-Google-Smtp-Source: AGs4zMatB3IZNH3bViNzjwDG7z0wF6Emenpnmcblr2MUlf7e9EgjrlQVRZypsKvH9kBI7LNEY4Vs8A==
X-Received: by 10.80.170.136 with SMTP id q8mr14572977edc.134.1512081039457;
        Thu, 30 Nov 2017 14:30:39 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id g3sm3106757edi.66.2017.11.30.14.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:30:37 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eKXLp-0006dd-2A; Thu, 30 Nov 2017 23:30:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129153436.24471-1-avarab@gmail.com> <20171129195430.10069-1-avarab@gmail.com> <20171130213105.GA8861@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171130213105.GA8861@sigill.intra.peff.net>
Date:   Thu, 30 Nov 2017 23:30:37 +0100
Message-ID: <87bmjjv1pu.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 30 2017, Jeff King jotted:

> On Wed, Nov 29, 2017 at 07:54:30PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> Replace the perl/Makefile.PL and the fallback perl/Makefile used under
>> NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily
>> inspired by how the i18n infrastructure's build process works[1].
>
> I'm very happy to see the recursive make invocation go away. The perl
> makefile generation was one of the few places where parallel make could
> racily get confused (though I haven't seen that for a while, so maybe it
> was fixed alongside some of the other .stamp work you did).
>
>> The reason for having the Makefile.PL in the first place is that it
>> was initially[2] building a perl C binding to interface with libgit,
>> this functionality, that was removed[3] before Git.pm ever made it to
>> the master branch.
>
> Thanks for doing all this history digging. I agree that it doesn't seem
> like there's really any reason to carry the complexity. Of your
> functional changes, the only one that gives me pause is:
>
>>  * This will not always install into perl's idea of its global
>>    "installsitelib". This only potentially matters for packagers that
>>    need to expose Git.pm for non-git use, and as explained in the
>>    INSTALL file there's a trivial workaround.
>
> This could be a minor hiccup for people using Git.pm from other scripts.
> But maybe only in funny setups? It seems like $prefix/share/perl5 would
> be in most people's @INC unless they are doing something exotic.

I think so, but I'm not 100% sure. I'm hoping downstream maintainers
will catch this one if it's an issue, but in many cases it'll just work,
e.g. I have /usr/share/perl5 in /usr/bin/perl's @INC on Debian even
though that's not the target install dir EU::MM would have picked.

Whether there's perl configurations that don't have $prefix/share/perl5
in @INC at all I don't know.

>>  * We don't build the Git(3) Git::I18N(3) etc. man pages from the
>>    embedded perldoc. I suspect nobody really cares, these are mostly
>>    internal APIs, and if someone's developing against them they likely
>>    know enough to issue a "perldoc" against the installed file to get
>>    the same result.
>
> I don't have a real opinion on this, but it sounds from the rest of the
> thread like we should maybe build these to be on the safe side.

Indeed, we'll need to ship at least the Git.3pm manpage.

I tried coming up with something that worked like the current
Makefile.PL but couldn't figure out how I'd generate
a::file::like::this.3pm from a/file/like/this.pm

So I hacked up the following minimal patch to just build Git.3pm:

	diff --git a/Makefile b/Makefile
	index 48f1b868d1..ba6607b7e7 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -1709,6 +1709,7 @@ ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
	 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
	 bindir_SQ = $(subst ','\'',$(bindir))
	 bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
	+mandir_SQ = $(subst ','\'',$(mandir))
	 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
	 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
	 perllibdir_SQ = $(subst ','\'',$(perllibdir))
	@@ -2284,6 +2285,10 @@ perl/build/lib/%.pmc: perl/%.pm
	 	$(QUIET_GEN)mkdir -p $(dir $@) && \
	 	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@

	+perl/build/man/man3/Git.3pm: perl/Git.pm
	+	$(QUIET_GEN)mkdir -p $(dir $@) && \
	+	pod2man $< $@
	+
	 FIND_SOURCE_FILES = ( \
	 	git ls-files \
	 		'*.[hcS]' \
	@@ -2595,12 +2600,17 @@ endif
	 install-gitweb:
	 	$(MAKE) -C gitweb install

	-install-doc:
	+install-doc: install-man-perl
	 	$(MAKE) -C Documentation install

	-install-man:
	+install-man: install-man-perl
	 	$(MAKE) -C Documentation install-man

	+install-man-perl: perl/build/man/man3/Git.3pm
	+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
	+	(cd perl/build/man/man3 && $(TAR) cf - .) | \
	+	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
	+
	 install-html:
	 	$(MAKE) -C Documentation install-html

Maybe this approach is bad, I don't know. This might be a better fit for
Documentation/Makefile since it has some "man" logic already, but do we
want it to be depending on stuff in ../perl?

On my Debian install I have these from existing Git:

    /usr/share/man/man3/Git.3pm.gz
    /usr/share/man/man3/Git::I18N.3pm.gz
    /usr/share/man/man3/private-Error.3pm.gz

We definitely don't want the 2nd two ones to have manpages, that was
always an accident. git-svn has a few more:

    /usr/share/man/man3/Git::SVN::Editor.3pm.gz
    /usr/share/man/man3/Git::SVN::Fetcher.3pm.gz
    /usr/share/man/man3/Git::SVN::Memoize::YAML.3pm.gz
    /usr/share/man/man3/Git::SVN::Prompt.3pm.gz
    /usr/share/man/man3/Git::SVN::Ra.3pm.gz
    /usr/share/man/man3/Git::SVN::Utils.3pm.gz

But those all say that they're internal API only. So maybe this hack of
mine is fine. What do others think?

In any case, a solution that tries to build all the manpages with a glob
is going to suck currently since some of them have POD, and others
don't, which gets us into the headache of trying to distinguish whether
something has POD v.s. whether we just had pod2man fail.

So it seems better just to whitelist the man3 pages that get build,
which to me seems like just one currently.



>> @@ -2291,6 +2273,17 @@ endif
>>  po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
>>  	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
>>
>> +PMFILES := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
>
> Yuck. :) I don't think there's a better wildcard solution within make,
> though. And I'd rather see this than doing a $(shell) to "find" or
> similar.
>
> The other option is to actually list the files, as we do for .o files.
> That's a minor pain to update, but it would allow things like
> differentiating which ones get their documentation built.
>
>> +PMCFILES := $(patsubst perl/%.pm,perl/build/%.pmc,$(PMFILES))
>
> TIL about pmc files. It sounds like they've had a storied history, but
> should be supported everywhere.
>
>> [...]
>
> The rest of the patch all looked good to me. Thanks for working on this.
>
> -Peff
