Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6FE20248
	for <e@80x24.org>; Mon,  1 Apr 2019 06:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfDAGkj (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 02:40:39 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40151 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAGki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 02:40:38 -0400
Received: by mail-vs1-f65.google.com with SMTP id f22so4816077vso.7
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9BAHy0dTmqZr7UI+vwhWMd6H1ofxYBV6m3ox/VRj2c=;
        b=ifX2gXxmjkEVTQmOc2jFxRIcQqe2x/dKY7uwINoB8kJAGSgmFzgGTmsD7L/ICSjNyL
         107e98xffzTcIyCfbX/hFIBaeyy81ZqbXzFXvcf4YNp7jDxH14GV/KQ6hpdyCVK9L99V
         tx/+BGc5fRJKJgssVeYBBExEpDuvjJBhlHIR1bev1R5khAns1aryprUvOplLCXmKXJEw
         Xzz/WHkzs5C4yG6LWGgtDIjFkxE7DL/DnlT5bej4tuyOWxG2HPOaR7O/ZfuZEr7OzxDm
         8oQrgJndKlEQlLJkWsWgIfWCPxAzllpvQXHtxgAE4/HBduRCePnWTku6hZRHVbUlcr5H
         lLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9BAHy0dTmqZr7UI+vwhWMd6H1ofxYBV6m3ox/VRj2c=;
        b=TH6QOkdZM2yM7hgDQrWHj0+FwUmW21Vx/wiEYUZq/4wu4hXv11h6TsKZ3EcWfTuOk3
         tWO21uV8ret200awDaQwKZ8D/yd7GLsrj+gfr2DRMUf2rTgLI2WeOa6afnYasJpFmr8M
         7KxRZib4lr6gRu2NHCciWnkTqHNA1J2jG6q8hTdNONQxP5nPj6R+MDxIaWlIUj0e9gMC
         WNxuVyvTS6+rxwBNs+y6T1jK9y2nnxBqfi7BM5OWWbOWFYMiSIIK0N6w/nn75Dc/VIpx
         +AlEPXVTDSmjpdNsXEP96hu1Z+0zlX9YsERFLfkbakv5kqFFcpZFh8Dy0YB4xLEr9b4j
         2GLQ==
X-Gm-Message-State: APjAAAX+DaZNqvUeUcdnKeSHAejTht7pv/TiJedd51yZh5vc1C60VHII
        bDlmaTHpZMFonI/dF8ZdaPGfFsf9moND+WGQcFA=
X-Google-Smtp-Source: APXvYqye0lYRV1OJG/p9CgsFcmFxbRroqNoMPBc9KQEAyZrzzf3qO/edg4+l7rxuDSeeOZS4iMU0xkvhuNEduS8d5iQ=
X-Received: by 2002:a67:ea08:: with SMTP id g8mr4949224vso.31.1554100837182;
 Sun, 31 Mar 2019 23:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0qcwZm=2YnGm+rccDT2e5yZU3pyYGUGTwr9izod+e0s0A@mail.gmail.com>
 <CAKPyHN2Unp7Cou86fefYo9nD_ApokMxRMih=d27=rp634bYKwQ@mail.gmail.com> <CAODFU0p4FxZP34L=LAZX=25EFn6NK8vD7p47bsUu8yd+TpCb_Q@mail.gmail.com>
In-Reply-To: <CAODFU0p4FxZP34L=LAZX=25EFn6NK8vD7p47bsUu8yd+TpCb_Q@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 1 Apr 2019 08:40:19 +0200
Message-ID: <CAKPyHN1ekK8o8vnBEhvjLtz0G0=FFVkpAH6Qq92TC3E=dXQGfg@mail.gmail.com>
Subject: Re: git-gui: unstaged changes windowpane resets after unstaging a line
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 31, 2019 at 9:48 PM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
>
> On Sun, 31 Mar 2019 at 21:15, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> >
> > Hi Jan,
> >
> > On Sun, Mar 31, 2019 at 8:45 PM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
> > >
> > > Hello
> > >
> > > After performing "Unstage Line From Commit" action, the "Unstaged
> > > Changes" windowpane is reset. The reset does not happen with "Unstage
> > > Hunk From Commit" action.
> >
> > because its not necessary when staging a hunk. Though when staging a
> > line it is better to run the diff algorithm again.
>
> Yes. I was thinking comparing the old state of "Unstaged Changes" to
> the new state and preserving (or approximating) the selected filename
> and scroller position if possible.
>
> When unstaging a line (or a hunk) there is internally no possibility
> for the currently selected filename to disappear from the "Unstaged
> Changes" list.
>
> > Anyway, which problem do you observe in particular?
>
> The problem is that the selected filename and scroller position are
> reinitialized. It is uncomfortable when "Unstaged Changes" contains a
> lot of filenames.

I can't confirm this behavior. Neither when staging lines from the
"Unstaged Changes" file list, nor when unstaging lines from the
"Stages Changes (Will Commit)" file list.

Could you try to come up with a recipe from an empty repository?

Best,
Bert

>
> Sincerely
> Jan
>
>
