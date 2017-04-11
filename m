Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEFC420970
	for <e@80x24.org>; Tue, 11 Apr 2017 16:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdDKQvc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 12:51:32 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36539 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdDKQva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 12:51:30 -0400
Received: by mail-pf0-f178.google.com with SMTP id o126so1200036pfb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DI1hJrKRIMdU8OYTWa9Z2ETODGssyqLh14M6LQk4XM4=;
        b=PlaXLpInzndVGOAwlplbu6fOKRczmW/KrT31/OLE+Pedhncb3AXGj4KKAH5/9R00IP
         fXf4Ue/FOij6BLNdDxI0S95ph2tEmxvkvtCQCwsITb+IeWvAAzGkkIl9V555zn/8fQMJ
         ivNMQLJlbDyYWsmMsdmrNC++KQ/lgH7TjNsIPLouJhEWaNGTw4T/yVFqT8w58sKICQ+P
         FLPrJhy6WBNKtSjN9GDiWeyZ4Z48xa58wP/h910mopFCncMShAXR4TdM7XiVBe4gESkI
         gjfPGoWmH1fhhsoBraLn22Y/0RoAXyUzcfIffUbbhOK/Z9H2aGzNlo+9ojGLWoQwaD6M
         3rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DI1hJrKRIMdU8OYTWa9Z2ETODGssyqLh14M6LQk4XM4=;
        b=rnZWGm1BoZU4nFyWlgr8Ap+zR/TwmcSZkvP0BQfmrs13ryXuk8UFEIZo8Rkc9Bpbcz
         7nEpv8RM+yP8EMJOWQHBAJBbhBDF2YBUSxZzFo2Kt6pALQ3dImbEEG85n2pBtSaNCdVb
         OaE1bosm4J/dcTbPibUwxZG85ll5lb0KrfTsW2uBEKQrVhmJZ5AY+zfgsLJ9dfpRNXiT
         1K4N5E0Rgs1eFWaXCpHBs+3xqQ9sDVYHT+3Vp0ztc+Kg4fqfvVmIjSvc3iilIpNwMWY9
         sR8AjTb1nGlp009zJ3r6NWPmdyS7C7cgDJHQDSNPRu4CcieCSoOuPkxf3oQBsNDZgX07
         3jxw==
X-Gm-Message-State: AFeK/H29l4S5hk/TwqK/bjeoWhqXMGHd7j5wFsS/iGwEJVZ+26GheixXOQqZ1FMqlrN2XPhy
X-Received: by 10.84.248.74 with SMTP id e10mr38727968pln.76.1491929489535;
        Tue, 11 Apr 2017 09:51:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id n85sm31606861pfi.101.2017.04.11.09.51.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 09:51:28 -0700 (PDT)
Date:   Tue, 11 Apr 2017 09:51:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/12] grep: change the internal PCRE code & header names
 to be PCRE1
Message-ID: <20170411165127.GC36152@google.com>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-12-avarab@gmail.com>
 <20170411103746.bth3rof753gbjtjf@sigill.intra.peff.net>
 <CACBZZX5V96Vv5NAYpkQSBWpn-4rgHOatAnL51o4-4DADAF+pEg@mail.gmail.com>
 <20170411104828.skkujde3qrvn4jrt@sigill.intra.peff.net>
 <CACBZZX6A8tcXy-hCcQqqDsGNDtXWmZMdTY=RxeAOn8QFYDypyg@mail.gmail.com>
 <20170411125741.7b7hlmuucid37b3r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170411125741.7b7hlmuucid37b3r@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Jeff King wrote:
> On Tue, Apr 11, 2017 at 01:02:56PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > >> Yes, this is a bug. I'll need to add a git_options along with
> > >> submodule_options and pass -c grep.patternType=....
> > >
> > > Maybe that's an indication we should have --pcre1-regexp and
> > > --pcre2-regexp, so we don't have to resort to config tweaking.
> > 
> > I'd rather not. To reply to both your
> > <20170411103018.dkq5gangx3vcxhp4@sigill.intra.peff.net> & this, one
> > thing I was trying to do in this series (and I don't think I went far
> > enough in "grep & rev-list doc: stop promising libpcre for
> > --perl-regexp") was to stop promising some specific version of PCRE.
> 
> We don't necessarily have to document them. This is just in the general
> rule of "if there's config, there should be command-line to override
> it". Because without that, you get this exact situation where you have
> to bolt on "-c" options to another part of the command line, which gets
> awkward.
> 
> I'm also not sure it would be strictly correct, if the sub-program runs
> other sub-programs. Providing "-c" affects all child processes, whereas
> command-line options are propagated manually. So imagine you have a
> process tree like:
> 
>   grep
>    \-grep
>       \-textconv
> 
> I.e., grep recurses to a submodule which then has to kick off a textconv
> filter for one of the files. If you use "-c" to pass options to the
> second grep, then those options will continue to have an effect inside
> the textconv filter. Which _probably_ doesn't run git commands that
> would care, but technically it could do anything.
> 
> > I.e. as far as the user is concerned they just want perl-y regexes,
> > but they most likely don't care about the 1% featureset of those
> > regexes where the various implementations of "perl-y regex" actually
> > differ, because those cases tend to be really obscure syntax.
> 
> Yeah, that's what led me to the "why are we even worrying about run-time
> switching" direction. I'd think a build-time switch would be enough for
> people to test, and it makes all of this type of complexity go away.

Yeah I agree with Jeff that we should probably avoid needing to pass a
config option down in addition to a command line switch to do perl
regex's.  I didn't take too hard of a look at how that would be done in
the grep code, but it might be slightly more involved than just changing
the enum name.

From [12/12] it looks like the main purpose of this series is to use a
more preferment version of PCRE, if all else is equal it doesn't really
make much sense to have both versions to be select-able at runtime.  Is
there any benefit of being able to do that, that I'm missing?

-- 
Brandon Williams
