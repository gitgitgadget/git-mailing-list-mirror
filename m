Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927EE1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 17:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeH3VZr (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 17:25:47 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38826 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH3VZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 17:25:47 -0400
Received: by mail-ed1-f54.google.com with SMTP id h33-v6so7109849edb.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7hiY6tdwDIhXSFFMSVqXylnghd4eQKZ36HRMnBeNHg=;
        b=NayeXSWgpOHzPg4KV0ZmdOgu91TipLdHu+1BxPI2hlprsl2u05z7TRzykhKBGhQaxr
         LkfbyHweWhrb639CpMprxmWMzI3/3HxT0ZmEoDSvT0BFtUuypfOGnVDERDOGA1a5Yp0W
         U+ueawPnlMTCrGdkY7moGUp60GOKvraylM16h0IwHP8bFq+hp5nZBktCXNXCjoX4CwF8
         xbNIELxjzXk3PN8rNIFNktdGAqWEav7lVyGegO5s5BJyJwcA6rK5vxQIOC0u2TDVl53D
         mpnxdsBNWohZ9z6GNibL2v32s5U0+/n7vCZnRD36LfB4OZv0st05a7Jw46mMvwL3y8IK
         p1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7hiY6tdwDIhXSFFMSVqXylnghd4eQKZ36HRMnBeNHg=;
        b=gz1mE7j0HSCmNbrYlsQvENOQAbItkp1iA1uLZ6d/yLP1Y2T8COBZPK0hI1n3DtA006
         Xxh16FSSG30+4WP8G1woqZ0ZCuSbhU0qrrgxsoVEVfqYUtoTcy/pk4V7fDUBw2ucrQni
         AFOmA7wsRWLmGo4ERSw+xXrNXqLhd2Tg0amIqCukFJlFoJFkoOBzF3oGzpLL4VHsBpxo
         mpQu+tEbDyaA0BVgWBcGnkIG+8j03LawftBYSICjcB7ze2rdUIjLRoe7PlqNx6zS4y6d
         TP9XhQRnwWfyWD0pVKS8e0Qfmy8Qb1pv0krRVKRxtJ9A3/sgUCh+p2aJiBKmgNYdgewd
         jOFA==
X-Gm-Message-State: APzg51BDac5GZY+MFRnSh2tkoS9pHBCqeGRDblSJkQ8PFADXQ3ArG5mJ
        cSGw+cujWj50xwH88GhPxxuXYOarSWUw+at1G1IXZg==
X-Google-Smtp-Source: ANB0Vdah8fTFuNaDde2lJEudLp6g0+eKQu3/P/3smg8FYAXpIEVkoWwomHOk4zqf7syQtZnsGfOT0J9CBBBODebWkr0=
X-Received: by 2002:a50:9e46:: with SMTP id z64-v6mr10473182ede.204.1535649756556;
 Thu, 30 Aug 2018 10:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmvCd1BwPNgZM+g7c6An-EESMHDOSGQe7RjkAAz36eNY3fvGA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808301324120.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808301324120.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 30 Aug 2018 10:22:25 -0700
Message-ID: <CAGZ79kbN7CGiQFoCF-3zkJH3h0kxbfM4xigpYc7XNuF-1bcONg@mail.gmail.com>
Subject: Re: improved diff tool
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     pierstitus@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 4:33 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Piers,
>
> On Thu, 30 Aug 2018, Piers Titus van der Torren wrote:
>
> > I've created a diff algorithm that focuses on creating readable diffs,
> > see https://github.com/pierstitus/klondiff
>
> Looks intriguing.

Yes it does.

The diff of c07c0923 looks quite interesting as it shows what was
intended to happen (indented a lot of code as it was wrapped).

Playing around with that commit and some recently added switches
  --color-moved --color-moved-ws=allow-indentation-change which is
supposed to solve a similar problem did not yield as good results.

> > The git integration as an external diff command works quite well,
> > though it would be nice to integrate it deeper in git, and also in
> > git-gui and gitk. Any way to use ext-diff from the gui tools?
>
> Git GUI and gitk are both Tcl/Tk programs, and will need quite a bit of
> work to accommodate for your diff mode.

It would be awesome to have gitk/git gui working with more diff options.

>
> To put things into perspective: the `--color-words` mode is not integrated
> into Git GUI nor gitk, and it has been around for a while...

How is it different from the "Color words" mode that sits in the drop down
menu that defaults to "Line diff" ?
https://imgur.com/a/qvo4oOC

(Oh, I realize I had to draw the window wide to see it as it hides easily :/)

> > Is there interest to incorporate this algorithm in the main git
> > codebase? And if so, any hints on how to proceed?

It depends on the the layering,
look at xdiff/xdiffi.c xdl_do_diff() which has

  if (XDF_DIFF_ALG(xpp->flags) == XDF_PATIENCE_DIFF)
    return xdl_do_patience_diff(mf1, mf2, xpp, xe);

  if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
    return xdl_do_histogram_diff(mf1, mf2, xpp, xe);

as that produces the xdiff/ is for producing the diffs.

All the coloring is at a later step, see diff.c (it's a big file),
builtin_diff(), which uses fn_out_consume() as a callback from
the xdiff/ stuff and assembles a git diff around the raw diff.

diff.c is responsible for everything after the raw diff, including
coloring, or getting the format of patches right (such as file names
before a diff, matching up (renamed) files for diffing and such)

> The best advice I have is to look at the `--color-words` mode. It comes
> with its own "consume" function that accumulates lines from the diff, then
> outputs them in a different way than the regular colored diff. Your mode
> would want to do it very similarly.
>
> This is the accumulating part:
>
>         https://github.com/git/git/blob/v2.19.0-rc1/diff.c#L1886
>
> and this is the display part:
>
>         https://github.com/git/git/blob/v2.19.0-rc1/diff.c#L2013
>
> Basically, I would suggest to do a `git grep color.words` to find the
> places where the `--color-words` mode is special-cased, and add new
> special-casing for your mode. Which, BTW, I would suggest to find a
> catchier name for ;-)

AFAICT this is more than just a coloring scheme as it both produces
a different low level diff, which would need code in the xdiff parts
as well as colors, that is in diff.c.

Thanks,
Stefan
