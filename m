Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C040C1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755312AbdC1SFK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 14:05:10 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33151 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbdC1SFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 14:05:09 -0400
Received: by mail-pg0-f41.google.com with SMTP id n5so72036590pgh.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=92yy+E61aYuGVHpX4fIIFzhBtXvUsRSiN5JJmvlLT+I=;
        b=RY2LVTL3zS2+qh2VLMI9ST4qVWV+2er8JpZohygky8tzNdYfnlh/VlS8LkjyK2WeSn
         2ihj9bD4skSER3/dOylLzJpXlkrVCxrolTVwaAg0YuttnQLjnVDPtClkaIuBH/fSuHs+
         HH0bhmiAqUNfVqcY/qgSioTVw4KImxlHJgaUv4XopOBUtIpSskJkJmHJH9NZlVPDZiXj
         h27NNSNySnlF5SrQlMsurYGI0TQW/6Fs8YJmO2A3rNJGOnnj9helCuVvXG2RoxVwvxgs
         BobtJN2cGQMFpLEYOHMwMXmw4p4Alhk6K1sV2AC2u3WO8eyGTqBjcdKJ+ZpZp8wVGjsq
         DyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=92yy+E61aYuGVHpX4fIIFzhBtXvUsRSiN5JJmvlLT+I=;
        b=MSC9/ZEWGfuZQa9HITXiiFiRmg930FpUnheQ+EMJfuuhyYXBYgYKgaaRx2sTHVE8vF
         RjjD6QVsTXHcYrDHYGzzRUb1AXM8cEfMGYyzxGhy2iCmHN8d712HsuxX3Bl2CLBs84Kr
         NZwR0c1Q9liCUgQo7ogKBZ/iui/EY8CGOAp0Yf8d+437X2xsutKr6qflsunP7hiIoiHW
         SCKysdsenWYNm2M0/LqSCHBHvVNjThxavx9u9qxOKUUEBjI13N+Q5ppTdzifQjpYG9MY
         5LVQAf4G9cTHDeJHIEwz8CMGObLLMm3Ehy3dbv1fk1QanP+Nj9LLfxF74oVbK6TdWhWL
         rPlA==
X-Gm-Message-State: AFeK/H3G29meEgfKwc6+u+w+VzX9vBTOYDYsfFRvLut8nc5SmUpITEWgRFH1ciqs8wB+pLdElNU71QT+krDUMj4X
X-Received: by 10.99.119.140 with SMTP id s134mr31112629pgc.162.1490724307722;
 Tue, 28 Mar 2017 11:05:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 11:05:07 -0700 (PDT)
In-Reply-To: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com>
References: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 11:05:07 -0700
Message-ID: <CAGZ79kbyW79wToWqoL_F5n+jOFwFH=z2jY3Du2YTyv9tS9L=JA@mail.gmail.com>
Subject: Re: [GSoC] Proposal: turn git-add--interactive.perl into a builtin
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 8:15 PM, Daniel Ferreira (theiostream)
<bnmvco@gmail.com> wrote:

> SYNOPSIS
> There are many advantages to converting parts of git that are still
> scripts to C builtins, among which execution speed, improved
> compatibility and code deduplication.

agreed.

> git-add--interactive, one of the most useful features of Git.

knee jerk reaction: I never used it, so it cannot be that important ;)
(I use git-gui, which is essentially the same workflow. There are tons
of ways to accomplish a given goal using Git, so I guess we don't
want to get in an argument here).

>
> FEASIBILITY
>
> There was only one discussion regarding the feasibility of its porting
> (https://public-inbox.org/git/CAP8UFD2PcBsU6=3DFK4OHVrB7E98ycohS_0pYcbCBa=
r=3Dof1HLx+Q@mail.gmail.com/).
> It resulted in a consensus that doing it would be a task too large =E2=80=
=93
> although interesting =E2=80=93 for GSoC 2015 based on the amount of its l=
ines
> of code. It is, however, only a few lines larger than
> git-rebase--interactive, which has been considered an appropriate
> idea. As such, it looks like a possible project for three months of
> full-time work.

ok, it sounds a challenging project. (currently counting 1750 lines of
code). Scrolling over the source code, there are quite a couple of
functions, where the direct equivalent in C springs to mind.

run_cmd_pipe -> see run-command.h
unquote_path -> unquote_c_style ?
refresh -> update_index_if_able()
list_modified -> iterate over "const struct cache_entry *ce =3D active_cach=
e[i];"


> PROJECTED TIMELINE
> - Prior to May 4
> -- Refine my basic knowledge of Perl
> -- Craft one or two small patches to some of Git's Perl components
> (preferentially to git-add--interactive itself) to improve my
> understanding of the language and of how Git's Perl scripts actually
> work



>
> - May 4 - May 30
> -- Clarify implementation details with my mentor, and work on a more
> detailed roadmap for the project
> -- Investigate roughly how to replace command invocations from the
> script with actual builtin functions; which Git APIs in Perl already
> have functional equivalents in C; which parts will require a full
> rewrite.

There are different approaches for replacing functionality in another
language. Examples:
* Implement the functionality in C and then have a "flag-day" commit
  783d7e865e (builtin-am: remove redirection to git-am.sh, 2015-08-04)
  This only works when the whole functionality was replaced in prior commit=
s
* Implement partial functionality in C and call it via a helper function.
  3604242f08 (submodule: port init from shell to C, 2016-04-15)
  This works well for only partial conversions (the larger the thing to
  convert the more appealing this is, as it gets code shipped early.)
  When choosing this strategy, this part of the Project would be to
  identify parts that could be ported on its own without much
  additional glue-code.

> - May 30 - June 30 (start of coding period)
> -- Define the architecture of the builtin within git (which
> functions/interfaces will it have? where will its code reside?).
> -- Implement a small subset of the builtin (to be defined with my
> mentor) and glue it into the existing Perl script. Present this as a
> first patch to get feedback early regarding the implementation and
> avoid piling up mistakes early.
> -- Do necessary changes based on this initial review.
> -- Have roughly 1/3 of the script's functionality ported to C.
>
> - June 30 - July 28
> -- Port the remainder of the script to a builtin.
> -- Have a weekly roadmap, sending a part of the patch every 15 days to
> the mailing list for review and to avoid massive commits by the end of
> GSoC.

yeah; send early, send often. ;)

> -- Apply suggestions from community reviews when possible; if not,
> save them for doing toward the end of GSoC (see below).

Please do not underestimate the discussion by community, finding
consensus on list consumes a bit of time in some cases.

> (Note: due to a previous commitment, during a five-day period of July
> I will only be able to work part-time on GSoC. The actual week will be
> known over the next weeks.)

Maybe you want to shift the schedule up to here by one week then?
(e.g. the first period would be April 27  - May 23)

>
> - July 28 - August 29
> -- By the start of this period, send a patch with the builtin fully
> implemented to the mailing list.

/a patch/a patch series consisting of many patches/
Experience shows that smaller patches are easier to review as
it is more focused. Consider e.g. e86ab2c1cd (wt-status: convert
to struct object_id, 2017-02-21) and the parents leading up to this
commit. They work on the same big topic, but focus on very
regional areas to ease review.

> -- Fix bugs, test extensively, possibly extend test coverage for
> git-add--interactive.

AFAICT ('$ git grep "git add -i"') there is only t3701 testing the
interactive add. Maybe we need to add tests first to document
current behavior, before attempting a conversion?

This could go well into the period "May 4 - May 30", as writing
tests would count as "Clarify implementation details".

Hope this helps,
Stefan
