Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABBE1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 19:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfBDTid (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 14:38:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34842 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBDTic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 14:38:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so1240784wmt.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Ti9akn6JgIGeUepKzmlin3kxQq8Fq460nAxiXLZqaQ=;
        b=kuzbWJVtsO5gGYD9ifI8WPiJwqzqNNyWbpLu9ycy4SE+Jt0JM2h8xR4VDxc6/1Ff92
         2GA1FRdowEn1i7bo8FN7aI8RSIysnohB1gSfqxsC+2Vfojqo1ciAeGGNk2nEuH5jmjfh
         3pABOipRs2Uju9P7v0tVKCnF7Fyk6LW4DOKoQdI6jqay69WJ8hk95MlIRY2fbXje0enO
         QzUfvOiZKyyOeqRjEO/s1Gke3jQl+1wyq7YTgMtgsdp1uUmkTmoKhKmQu/Dzi1w41CZr
         p0BQNPkUMclFDLPP0RKshff6V3DbEA1uPB1l9VRLCTw3shv5RzPmUhkdAM1GhuP3xze+
         6Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Ti9akn6JgIGeUepKzmlin3kxQq8Fq460nAxiXLZqaQ=;
        b=NjxpFkbF4z/ON9oo7mC63/R/2U2Kw27EcxzwV7ZvApCDjye5jGiF2stx+t2VwQD6gB
         eyS7ub2zZPPF4vMOPKEJ/Bgp0liGe52cTD10Ehb6jIMsNj4kyu2iIFfxPbUlPOcMTJlI
         I9O9+zZ/atKq0JpJM0zcHrsVb30b5JJxRauiNZ0IYfNHAp4KedJamukOpLayT05LhGWI
         oxLCqXu54xIpm03WLmvHUCO5E1I0soL4hDlb+Mcs2m4Wovt/LndmkSGxTd+uNyiwIxup
         B1O7yHAKs7pwjsh2WdIhxb3Cs3mmNkx0jiOm7Gl4TF1q3o2Vaq6vctIuFUIrxvta+cUx
         6kMA==
X-Gm-Message-State: AHQUAua85xQLXHdMDl41DHXCSltWWSEEKNyjEZ4yCvsXNzOUfi/n0cCG
        0NUhXCdIgWgB6RRHY4TObCQ=
X-Google-Smtp-Source: AHgI3IYYdoMSW3ivuRYD0WZCMk6nOCnrn65kA92+pjs6VpjyqALsu2T9tUcuHZx1RfSmYSUNzTl0mg==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr732360wme.69.1549309109718;
        Mon, 04 Feb 2019 11:38:29 -0800 (PST)
Received: from szeder.dev (x4db609fa.dyn.telefonica.de. [77.182.9.250])
        by smtp.gmail.com with ESMTPSA id o4sm6650957wrm.12.2019.02.04.11.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 11:38:28 -0800 (PST)
Date:   Mon, 4 Feb 2019 20:38:26 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more
 quiet
Message-ID: <20190204193826.GH10587@szeder.dev>
References: <20190202163421.19686-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1902041045280.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1902041045280.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 04, 2019 at 10:49:05AM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Sat, 2 Feb 2019, SZEDER Gábor wrote:
> 
> > Before installing the necessary dependencies, our OSX build jobs run
> > 'brew update --quiet'.  This is problematic for two reasons:
> > 
> >   - This '--quiet' flag apparently broke overnight, resulting in
> >     errored builds:
> > 
> >       +brew update --quiet
> >       ==> Downloading https://homebrew.bintray.com/bottles-portable-ruby/portable-ruby-2.3.7.mavericks.bottle.tar.gz
> >       ######################################################################## 100.0%
> >       ==> Pouring portable-ruby-2.3.7.mavericks.bottle.tar.gz
> >       Usage: brew update_report [--preinstall]
> >       The Ruby implementation of brew update. Never called manually.
> >               --preinstall                 Run in 'auto-update' mode (faster, less
> >                                            output).
> >           -f, --force                      Override warnings and enable potentially
> >                                            unsafe operations.
> >           -d, --debug                      Display any debugging information.
> >           -v, --verbose                    Make some output more verbose.
> >           -h, --help                       Show this message.
> >       Error: invalid option: --quiet
> >       The command "ci/install-dependencies.sh" failed and exited with 1 during .
> > 
> >     I belive that this breakage will be noticed and fixed soon-ish, so
> >     we could probably just wait a bit for this issue to solve itself,
> >     but:
> > 
> >   - 'brew update --quiet' wasn't really quiet in the first place, as
> >     it listed over about 2000 lines worth of available packages that
> >     we absolutely don't care about, see e.g. one of the latest
> >     'master' builds:
> > 
> >       https://travis-ci.org/git/git/jobs/486134962#L113
> > 
> > So drop this '--quiet' option and redirect 'brew update's standard
> > output to /dev/null to make it really quiet, thereby making the OSX
> > builds work again despite the above mentioned breakage.
> > 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> > 
> > Notes:
> >     There is no conflict with Dscho's Azure Pipelines patch series; the
> >     patch contexts overlap a bit, but the auto-merging results look good
> >     to me.
> 
> And this indeed also affects Azure Pipelines.
> 
> Since Junio's workflow is very different from GitHub Flow (where this
> issue would be worked around with a simple, single Pull Request),

I doubt that a single PR could be sufficient, because it won't help
contributors who want to run CI builds in their own forks; they would
have to rebase their branches on top of the fix, or cherry-pick it, or
whatnot.

> we have
> no prayer at a workaround on our side, though: pretty much *all* of the
> next builds of Junio's branches will be broken, unless he chooses to
> backport your patch to all of the base commits he chose for those
> branches.
> 
> So our best bet at not getting overwhelmed with failed builds ...

Oh, in my long-time for-fun semi-automated CI experiment [1] all
integration branches and cooking topics are still just fine :) they
all have been including this patch (among many others) for quite some
time now (since when the list of available Homebrew packages was
"only" about 1700 lines... about a year ago).

Unfortunately, I never upstreamed it, because that long list of
packages is folded up anyway when viewing the logs, so why bother...
In hindsight, I should have.  Oh, well.

[1] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/branches

> is to help
> Homebrew get `brew update --quiet` to work again. I just opened a ticket
> to that end:
> 
> 	https://github.com/Homebrew/brew/issues/5666
> 
> I do like your patch, though, and am very much in favor of fast-tracking
> it all the way down to `maint`.
> 
> Ciao,
> Dscho
> 
> >  ci/install-dependencies.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 06c3546e1e..5968efdbbe 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -34,7 +34,7 @@ linux-clang|linux-gcc)
> >  	popd
> >  	;;
> >  osx-clang|osx-gcc)
> > -	brew update --quiet
> > +	brew update >/dev/null
> >  	# Uncomment this if you want to run perf tests:
> >  	# brew install gnu-time
> >  	brew install git-lfs gettext
> > -- 
> > 2.20.1.642.gc55a771460
