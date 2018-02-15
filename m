Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3EF81F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbeBOUmD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:42:03 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55695 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeBOUmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:42:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id h74so3173885wme.5
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ti7d4s6xrgAXma4HaQ6/LH/XreMlzhsn7oHNhNPnCMY=;
        b=ESbL6AiZEF33SXWDCMRAFS+ofF4D2JTvUFXb7BLWqcHfw8hZim6NWOd/DFslcDWhqH
         3IhHfwwmwfnYpugWKpUADsugjL8CXPF09jtigL5XNWPj47s6NC+jY58QTKj9mDuCDjtP
         uzlDwfC+wplwYn4Z6D79Dw+tgQz4KjMezMDC5xQ+iv5NQDrteOTB1umW4/aPcAQTpVgI
         I4hpV7EHCVKJghl2esP+A4Xu73VWGCsyxQu5JSClGXQaK7lbQzvtUNOU2TQcoN8YCBGV
         afOWlGfdJ1JWIelJ/EaylzEo2pXPuvdgDlXrVSl8J5sIKy/s4rw9NSsnukxozXSoXBT8
         dXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Ti7d4s6xrgAXma4HaQ6/LH/XreMlzhsn7oHNhNPnCMY=;
        b=UHl0ahcR4Bn0TstXlsEPFhs9oCqVRzsSrjEdT663Ec0VCTH/d61ZGYAgCKqvgOq++T
         SwQ+Ox7TzVIliV41atAkc/M3MDCAwf8CGDIYx3anf9Kh4ECWXGERC6A/eEzfBSNuHwyV
         GQG//vkYOg++LU5Jj+ihZD2PMVDkZQ6T0Czt/AMZhf/snLNR/BfvG4rkE+gp3yDsSKyy
         Bz6662Oc0h+mjgbSxHmAhmhHuIicUcuRDNyxMd+eghq8e81cx4gvjqHjnQZBWK39eTri
         fqQf8d8UUuNGBE8dUoY8+74zixrOyPJGx6QAwMvhV8r2cg4a6CA/RbAXgjZWjSdIUjZu
         37pg==
X-Gm-Message-State: APf1xPCepKyloUwM5LiD1y9GC3HQIGoZgdJBTBtnGQfrNHaxxijYDSug
        J0fUcuqeuzn0UfovOFBa1GNwN367
X-Google-Smtp-Source: AH8x225crcCq+KKgpVpYrq/PwdWhqe6h49TfMGqsFAyX8yMAxWeK5nLmReuUVoP0PoSU3nEIO4F5vA==
X-Received: by 10.28.130.72 with SMTP id e69mr3367469wmd.50.1518727318430;
        Thu, 15 Feb 2018 12:41:58 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id q14sm13141428wre.66.2018.02.15.12.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:41:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-4-avarab@gmail.com> <20180215045301.GC27038@zaya.teonanacatl.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180215045301.GC27038@zaya.teonanacatl.net>
Date:   Thu, 15 Feb 2018 21:41:54 +0100
Message-ID: <87sha2f0j1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 15 2018, Todd Zullinger jotted:

> Hi Ævar,
>
> Ævar Arnfjörð Bjarmason wrote:
>> +Git::LoadCPAN - Wrapper for loading modules from the CPAN (OS) or Git's own copy
>> +
>> +=head1 DESCRIPTION
>> +
>> +The Perl code in Git depends on some modules from the CPAN, but we
>> +don't want to make those a hard requirement for anyone building from
>> +source.
>> +
>> +Therefore the L<Git::LoadCPAN> namespace shipped with Git contains
>> +wrapper modules like C<Git::LoadCPAN::Module::Name> that will first
>> +attempt to load C<Module::Name> from the OS, and if that doesn't work
>> +will fall back on C<Git::FromCPAN::Module::Name> shipped with Git
>> +itself.
>> +
>> +Usually OS's will not ship with Git's Git::FromCPAN tree at all,
>> +preferring to use their own packaging of CPAN modules instead.
>
> This is something I wondered about.  What's the recommended
> method to ensure git packaged for an OS/distribution doesn't
> ever use the fallbacks?  Remove $perllibdir/Git/FromCPAN
> after make install?
>
> If so, would it be useful to add a Makefile knob to not
> install the FromCPAN bits, which may be generally useful to
> packagers?
>
> Something like the following, perhaps?
>
> (I'd feel bad suggesting this without a patch, after all the
> work you've already done to simplify and improve the perl
> bits.)
>
> ---- 8< ----
> From: Todd Zullinger <tmz@pobox.com>
> Date: Wed, 14 Feb 2018 23:00:30 -0500
> Subject: [PATCH] Makefile: add NO_PERL_CPAN to disable fallback module install
>
> As noted in perl/Git/LoadCPAN.pm, operating system packages often don't
> want to ship Git::FromCPAN tree at all, preferring to use their own
> packaging of CPAN modules instead.  Allow such packagers to set
> NO_PERL_CPAN to easily avoid installing these fallback perl CPAN
> modules.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 5bcd83ddf3..c4e035e5bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -296,6 +296,9 @@ all::
>  #
>  # Define NO_PERL if you do not want Perl scripts or libraries at all.
>  #
> +# Define NO_PERL_CPAN if you do not want to install fallbacks for perl CPAN
> +# modules.
> +#
>  # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/python
>  # but /usr/bin/python2.7 on some platforms).
>  #
> @@ -2572,6 +2575,7 @@ ifndef NO_GETTEXT
>  endif
>  ifndef NO_PERL
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
> +	test -z "$(NO_PERL_CPAN)" || rm -rf perl/build/lib/Git/FromCPAN
>  	(cd perl/build/lib && $(TAR) cf - .) | \
>  	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
>  	$(MAKE) -C gitweb install
> --
> 2.16.1
>
> I don't particularly like NO_PERL_CPAN, but I'm confident
> someone else will suggest an obviously better name.
>
> I thought about moving the 'rm -rf Git/FromCPAN' after the
> tar/untar, to keep the files in place for the tests.  No
> tests seem to rely on those local files, so I stuck with
> removing them before.  That diff was:
>
> --- a/Makefile
> +++ b/Makefile
> @@ -2574,6 +2574,7 @@
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
>  	(cd perl/build/lib && $(TAR) cf - .) | \
>  	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
> +	test -n "$(NO_PERL_CPAN)" && rm -rf '$(DESTDIR_SQ)$(perllibdir_SQ)'/Git/FromCPAN
>  	$(MAKE) -C gitweb install
>  endif
>  ifndef NO_TCLTK

That makes sense, I'll incorporate that in a re-roll. I like
NO_PERL_CPAN_FALLBACKS or just NO_CPAN_FALLBACKS better.

I'd really like to find some solution that works differently though,
because with this approach we'll run the full test suite against a
system where our fallbacks will be in place (although if the OS
distributor has done as promised we won't use them), and then just
remove this at 'make install' time, also meaning we'll re-gen it before
running 'make install' again, only to rm it again.

The former issue we could deal with by munging the Git::LoadCPAN file so
it knows about NO_PERL_CPAN_FALLBACKS, and will always refuse to use the
fallbacks if that's set. That's a good idea anyway, because right now if
you e.g. uninstall Error.pm on Debian (which strips the CPAN fallbacks)
you get a cryptic "BUG: ..." message, it should instead say "we couldn't
get this module the OS promised we'd have" or something to that effect.

The latter is trickier, I don't see an easy way to coerce the Makefile
into not copying the FromCPAN directory without going back to a
hardcoded list again, the easiest thing is probably to turn that:

    $(TAR) cf - .)

Into:

    $(TAR) cf - $(find ... -not ....)

Or something like that to get all the stuff that isn't the Git/FromCPAN
directory.

Other suggestions most welcome.
