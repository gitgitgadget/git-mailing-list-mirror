Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE66B1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeH3XUO (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:20:14 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38029 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:20:14 -0400
Received: by mail-ed1-f42.google.com with SMTP id h33-v6so7345215edb.5
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bejBAXziIJSs6ll4tSxSwlShjuupnO+F+vLP3MG8Pdg=;
        b=Og11UpJ4edkw2VvdCavOuX4ID0iasMWBpmO8sICuWYyB2an3f/jHtxDalmVjNxLYXG
         eqD/jsPyyVAWzERWckAiBneN8JrdLxnwp4heJXeOEuTleFZaHMhwJ7JNgeJs9dOMcbJE
         vGuvtC74h4S7NW+BHSHMjJ5gAKrQyjYVYDgZ6xKapttcTZBJPvP6Dm9R6cO2t0AfMZlP
         T+OX5e6n8JXcUtzo7942nlQyoKrUljLr11Yx1j1zxjof0dmMt1W8vrn893te8LMYPyrb
         9bnYriPYsdKH/+Fc0o6zZ7sB7WLsDENw2poneq9qduUAq6vXsYjEa51292q1ztURiVse
         XATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bejBAXziIJSs6ll4tSxSwlShjuupnO+F+vLP3MG8Pdg=;
        b=U18xcWSyAM4jf2evdYNxfNi4NeIyQetT8N0beY4ZpQeFEmxYmC5hID8AT5NNHuv9AC
         UM2IBIQ6GAmlT2zkS6Bboz4kPfjmuGRDzsI0GEN1VkKFXv4h85VlwxVhURWa1b+aqnbH
         GLj2NmJTZH3/9OApuSOh9mAbPktFzerp63e1k0EspwwKas/Nc9keXzyrHd3Fm1dfToV3
         FS409MTdGi0CBuK6gzLCOdufFg5g6HY1VZG6ueyuOrc8xEd5As57GEpuZ2rc/5THtTtG
         aSVCcXBVCVCLO1fKpIjXynHfz23Yt2wawkwzugCwgqSDpMlldquUHSXRqwprF6uZB5Gw
         wERA==
X-Gm-Message-State: APzg51D06AcwL7OEI8enx5N22ARv5vtPmkQIjIX8ssGNy1PiwF44TYPG
        Xopyn7EHUKuf5dfQYARzD8NcP+eMNi4JXqjfRENa7A==
X-Google-Smtp-Source: ANB0VdZ3jgcgIblGUI4szIw1d/zQOLPiuPo8s9qty9yD4uKFSKaLdJz1yEx5ZOQJhBs2s+qW2e/0i9xPBTa+OpczqYk=
X-Received: by 2002:a50:9943:: with SMTP id l3-v6mr14783559edb.198.1535656593504;
 Thu, 30 Aug 2018 12:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
 <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
 <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com> <20180830025457.GA665@sigill.intra.peff.net>
In-Reply-To: <20180830025457.GA665@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 30 Aug 2018 12:16:22 -0700
Message-ID: <CAGZ79kZNVw4-q9KYAi9G3axb7-Ggpc2EAK8ZxAZoPEnZvEL-DQ@mail.gmail.com>
Subject: Re: Possible bug: identical lines added/removed in git diff
To:     Jeff King <peff@peff.net>
Cc:     Gabriel Holodak <gthepiper@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 7:54 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 29, 2018 at 10:10:25PM -0400, Gabriel Holodak wrote:
>
> > > Could you cut down to a real minimal reproduction, i.e. just these 20
> > > lines or so?
> >
> > I'm working on getting down to a minimal reproduction, a few lines at
> > a time. One thing that seems strange: as I've removed lines, there are
> > a bunch of lines that don't matter. Then I'll find some lines that, if
> > removed, completely fix the issue. But the ordering for these
> > apparently important lines doesn't matter. They just have to be
> > somewhere in the file to cause the duplicated diffs.
> >
> > I'll upload again when I've figured out all the unimportant lines to remove.
>
> Yeah, I reproduced based on your initial post, but noticed that when I
> cut it down the problem went away.

Oh, I had to look further down than I did initially. Now I can reproduce it
from the initial data as well.

Note that it goes away with --minimal.

I have a patch cooking (which was sent out as
https://public-inbox.org/git/20180810221857.87399-1-sbeller@google.com/)

and one of the weaknesses in that patch is the lack of explanation on
when the heuristic is applied as I have not fully understood it yet.
