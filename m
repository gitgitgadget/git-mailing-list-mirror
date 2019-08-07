Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90681F731
	for <e@80x24.org>; Wed,  7 Aug 2019 16:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfHGQye (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 12:54:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39650 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfHGQye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 12:54:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so88983955qtu.6
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/pl6xfnV1EjECea2UR5WxRaX5PbMkPiHKPGnN6P6BU=;
        b=yxyrsow+M25N0lKTzyaVZzchImUhxxI7MZj5TPeP7PqPshyShBqQVuS2RhOqkqZPAP
         AMw6Ky+2Xd+/wsAOqSbsTul2gfNXl9J8IOewMWObWwV4z/CChoh6ld8GREW1xT4SOw6p
         CUwzbZMPRrgG+j0dcbx5nM/6pdpTegCElc8qYbGU7YHg+Lc4MUNkTv4OEhexJYZuevoa
         f52JmPTtrMjvhiR/1iBJVIeqE8WF9yIsRILeZJxYE+M+xkEFj2vdQgowxliEXwXORems
         ylr5jYHIh9uV+WHn1Hv8JSlzblo8FjNMjrBl4dLvLf2Y0mTymz0L0aDD9plpObFIdnOz
         QFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/pl6xfnV1EjECea2UR5WxRaX5PbMkPiHKPGnN6P6BU=;
        b=nO92cF8lxVZ/tMr+jZQXKj2m4+0i8/Xtxwi+YPjU+rGZz9IL+yEAh9H5ADfvuAfHxh
         ZBGY1NC10fWvn+IkWDL5lKNZN3E8+Lrpu8tec98F5z8nb+wAdF1FXeXF0LquXA/OT7w3
         sc2rs4xLnHQWsjStiQPjaNw2zPnAz0drCbDlQR3Lm/fALNJUmQ3KgjIw6NFvuQ/etmAT
         SVY7QS9zuNxUXV4P9wJ8rya2LZHF+zD1XXlQII4JeZUAOaAwbnFmZIqtIsuY3mkqq0Wv
         8DYtZ0HjgnleA5YqhhU9/ajQTTlj0HkvkiqtkN9rJ+hawT9xjxNojAVM4Pr2NaLDJVcl
         SFPA==
X-Gm-Message-State: APjAAAVMnirNeBb5FVQwWkgUuy7PjiKKg02bGaE8Dr5/bbFBMtif0OGg
        8kNHv3PyDi80QVJEam8UbXEGlA==
X-Google-Smtp-Source: APXvYqyfc9exqp3lzrhC4DmW15V1b5QhdM0iryE6e6rr4lJnYm6FyBzXciWQPeMSsW7NY84uj0qfOQ==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr9161233qvd.101.1565196873370;
        Wed, 07 Aug 2019 09:54:33 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id j6sm39019226qkf.119.2019.08.07.09.54.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 09:54:32 -0700 (PDT)
Date:   Wed, 7 Aug 2019 12:54:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190807165431.GA60876@syl.local>
References: <20190806143829.GA515@sigill.intra.peff.net>
 <20190806225853.GH118825@genre.crustytoothpaste.net>
 <20190806234319.GA19178@sigill.intra.peff.net>
 <20190807041749.GI118825@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807041749.GI118825@genre.crustytoothpaste.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 04:17:49AM +0000, brian m. carlson wrote:
> On 2019-08-06 at 23:43:20, Jeff King wrote:
> > On Tue, Aug 06, 2019 at 10:58:53PM +0000, brian m. carlson wrote:
> > > Sorry, I hadn't had a chance to look at this series in depth, but I was
> > > wondering: could we not just accept two separate "--" arguments, and if
> > > there are two of them, interpret the first with the traditional meaning
> > > and the second with the Git-specific meaning? That would be much more
> > > intuitive for folks, although I suspect it would take a little more work
> > > in the options parser.
> >
> > That also crossed my mind, but I think it opens up some complicated
> > corner cases.  For instance, if I'm parsing left-to-right and see "--",
> > how do I know which separator it is meant to be? I think the only rule
> > that makes sense is that you must have two "--", like:
> >
> >   git rev-list [options] -- [revs] -- [paths]
>
> I was assuming that we wouldn't have a huge number of command-line
> arguments and we'd check ahead, although that could of course cause some
> pain when used with xargs, I suppose, especially on Linux with its huge
> ARG_MAX.
>
> > but that means parsing the whole thing before we can interpret any of
> > it. What kinds of tricks can an attacker play by putting "--" in the
> > revs or paths areas? E.g., what does this mean:
> >
> >   # expanded from "git rev-list -- $revs -- $paths"
> >   git rev-list -- --foo -- -- --bar --
> >
> > I think if we at least choose the left-most "--" as the official
> > end-of-options then they can't inject an option (they can only inject a
> > rev as a path). I guess that's the same as with --end-of-options. But it
> > somehow feels less clear to me than a separate marker.

This is definitely the secure option among the two, but I'm not sure
that it makes me feel better about this alternative direction. I dislike
the ambiguity in having two '--'s, and I don't think that this is
something we ought to concern callers with.

'--end-of-options' is on the one hand, cumbersome to write, but it is
clear. I think that this is an acceptable trade-off, because we don't
expect users at the command line to ever type this. So, some extra
clarity in favor of a drop in convenience for a supposedly smaller
number of use cases seems like a favorable trade-off to me.

> I suppose if there's more than two, then interpret the first one as the
> end-of-options marker, the second one in the traditional way, and any
> subsequent ones as pathspecs matching the file "--". Writing such a
> command line would be silly, but we'd fail secure.
>
> > It also doesn't allow this:
> >
> >   # allow paths and revs, with optional separator, but no more options
> >   git rev-list --end-of-options "$@"
> >
> > though I'm not sure whether anybody cares.
>
> That's a good point. I don't have a strong view either way, but I
> thought I'd ask about alternatives.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204

Thanks,
Taylor
