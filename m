Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58A11F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH3XcT (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:32:19 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33873 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeH3XcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:32:19 -0400
Received: by mail-ed1-f53.google.com with SMTP id u1-v6so7196137eds.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jx1D2aV1Ghfu7ymIUdpm9at5XSt1ub25GvZIbWLSX5o=;
        b=UVa7bhakXSGapFz9zpETuuxBSXheiwJaT1RpEPaJkzq5KqSiWMYy7GHYmiYALSOS3+
         /PT5fPdu//5pk5J+HcFP2v6UhDAl0kx1hY3f2jS77EJTm9MdtKwPBshSoat+TnEH/pg2
         BmGjpV4x4X1/Nsv0bjB5zX5MiEjT8IzphhIQ7J5KWBDIkYuTqTKtw1WYuldktydGXX9L
         KLR0ckeQ7nC7DoDAQacuJH4SoTF9yZlOWejRiSBS7HmPZwsCn/zf5MAsYtJBVvXUSqVU
         4V40s3WZH24xeOv0xYyDG8ZkbdB+VG8pHPnXSkjsX77+Xv7Do6KZVhdzFzmI6X72fzUk
         PPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jx1D2aV1Ghfu7ymIUdpm9at5XSt1ub25GvZIbWLSX5o=;
        b=U9vYC8XeFVLgEewk3TTb4XqIWpGJVhXUnMdC4a3aKH5mLqyFuPNcCDorFbghmz6E6W
         JMb4hH90S9+5Ti0Mk8e8kV1Xlc5XcGBAFjcqgVthOJ64KXAjny1Ycxio8CbWseELNTPk
         Ft/ZYbLZL4J6hM1O45QJI22ybzvlelhlFHwmkC3U6FI/9u0MhxQ4+7oPupsBLu/P0n50
         AYMqFo54Uoz1JZd7M8c/65xmyGhMrGJQaMBiEoKrbUhuF/yCKyUAKdadKFRf1IuhyRwm
         dO7oqKQiH/crvr1cQz3xsV5Tm5kJD+I7Wdd2prjEkh+f2LfEn3bwjqJFK+YEdCmpiqTc
         9J3g==
X-Gm-Message-State: APzg51D9JwwKv7gv060CraLeXJrhRzBED3zfQ+yHlKWF7PrnKnrpIm+B
        +zsoMK2Pq6JdksNLrztL5e0eLA3OFyOzVaOYi8KWNw==
X-Google-Smtp-Source: ANB0VdaeHyjWBNqcpfeKQ/Xf4q1So4L/qTfK7ejTr2I5rlizVsayhs6W+ERUgpMCPOKkePga391f6UtJR1ZGnmWKCUQ=
X-Received: by 2002:a50:cc0a:: with SMTP id m10-v6mr14152100edi.81.1535657315234;
 Thu, 30 Aug 2018 12:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
 <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
 <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com>
 <20180830025457.GA665@sigill.intra.peff.net> <CAGZ79kZNVw4-q9KYAi9G3axb7-Ggpc2EAK8ZxAZoPEnZvEL-DQ@mail.gmail.com>
 <20180830192019.GB19685@sigill.intra.peff.net>
In-Reply-To: <20180830192019.GB19685@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 30 Aug 2018 12:28:24 -0700
Message-ID: <CAGZ79kYVLNM4fMwXAw9FbKFNJ1tTR7e04nBqKdnYPX3wYveUfg@mail.gmail.com>
Subject: Re: Possible bug: identical lines added/removed in git diff
To:     Jeff King <peff@peff.net>
Cc:     Gabriel Holodak <gthepiper@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 12:20 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 30, 2018 at 12:16:22PM -0700, Stefan Beller wrote:
>
> > On Wed, Aug 29, 2018 at 7:54 PM Jeff King <peff@peff.net> wrote:
> > >
> > > On Wed, Aug 29, 2018 at 10:10:25PM -0400, Gabriel Holodak wrote:
> > >
> > > > > Could you cut down to a real minimal reproduction, i.e. just these 20
> > > > > lines or so?
> > > >
> > > > I'm working on getting down to a minimal reproduction, a few lines at
> > > > a time. One thing that seems strange: as I've removed lines, there are
> > > > a bunch of lines that don't matter. Then I'll find some lines that, if
> > > > removed, completely fix the issue. But the ordering for these
> > > > apparently important lines doesn't matter. They just have to be
> > > > somewhere in the file to cause the duplicated diffs.
> > > >
> > > > I'll upload again when I've figured out all the unimportant lines to remove.
> > >
> > > Yeah, I reproduced based on your initial post, but noticed that when I
> > > cut it down the problem went away.
> >
> > Oh, I had to look further down than I did initially. Now I can reproduce it
> > from the initial data as well.
> >
> > Note that it goes away with --minimal.
>
> That's interesting. I did wonder if this was in fact a bug, or simply
> that Myers does not promise to find the absolute minimal diff. I'm
> _still_ not sure, especially because the minimization is so obvious in
> this case (literally the first "-" and the first "+" line of a
> contiguous hunk are identical).

The `Myers` (our default) diff algorithm is really the Myers algorithm +
a heuristic that cuts off the long tail when it is very costly to compute
the minimal diff.

The `minimal` diff is the true Myers algorithm and I'd vouch for its
correctness and being the minimal number of lines in the diff output.

The Myers is implemented before
https://github.com/git/git/blob/master/xdiff/xdiffi.c#L135
and the heuristics is after that line.

> > I have a patch cooking (which was sent out as
> > https://public-inbox.org/git/20180810221857.87399-1-sbeller@google.com/)
> >
> > and one of the weaknesses in that patch is the lack of explanation on
> > when the heuristic is applied as I have not fully understood it yet.
>
> I'm not sure I understand it either. But at least knowing that --minimal
> changes the output gives a lead for investigation (I don't really have
> time to dig into it in the next few days, though).

An interesting (to me) approach for digging into that would include
finding these examples at scale, which I presented in
https://public-inbox.org/git/20180810001010.58870-1-sbeller@google.com/
but I guess reading the code would work just as fine.

Thanks,
Stefan
