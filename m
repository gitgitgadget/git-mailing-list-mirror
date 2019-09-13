Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4511F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfIMUPT (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:15:19 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39886 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388982AbfIMUPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:15:19 -0400
Received: by mail-ua1-f68.google.com with SMTP id s15so9588372uaq.6
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYLlyIZgOlEjbrgIV9K9RXebCAXVZG0sEN6z/MM/zZM=;
        b=hCJhSbFzi+LUU8/vNztYd5PCLqJBuEFL2QCiHztlFFgAXlTjCsfFIqYiHdfripPmjt
         jZ6RnFmT7C8H+u0nZ6mcCfZ2/y10jl0Qm7FTPh6hnQ3NDne0ZjlS1fa/rWX5d9OF/e8h
         s0rRF/TUe5J3j1MRaejHH9NXEXs18JVTfx69ERvCkUb8GR8osRQGsAPrW0K3Q76Qzpln
         nGmeeT2WhdYonEyEjfpwEm/UF07luXmo/jPlmUQo5yhu5dgWSrhcB6nauLnjh8ybSFSG
         2Gemnkq3kLkCTornwPGzLYhQSB148rqPcWlgXh2+SFf5psUSEjhw959SCkn571isoPjA
         RuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYLlyIZgOlEjbrgIV9K9RXebCAXVZG0sEN6z/MM/zZM=;
        b=ka/yMip2Yx+j+KWbLC+Kha8I0XGNos0NjjZrQWk8J3VNihl7IUjdDUAOjCWWVZMnPU
         /RGrwW+++X0/tLfum7NrIa5+Mx6hMHaIgTvibVuOYHhqDpQNQwr1/kfnBjFey4dcIezX
         Ed1Ma0w2xnR2j94AdHB/yEoDRTb1y7utfh6jrfjRWJCCIBs9rpHQFBciZjn4n5B24l/b
         St5VAdJR1wdFgP4q+rTHELwAG3W3mo7ZNZjD9rsEVfVQSR2h6wKD+gfXrmmZ3zCni15z
         UJeBz3X6KmPhRwxewzU9iN1JRWtq+esV0zaWXzCpUIQk4q62++nhALduTeY/qBE1Coxu
         sM5w==
X-Gm-Message-State: APjAAAUBdvEJ47s8AbraYJJBIVof2VupqqRpaIXjS/XbjoVsjficargm
        HKBnF4VttZf9PzZz5oWc7moA2gWM7mmY1nopSZdku3SAqek=
X-Google-Smtp-Source: APXvYqwXiL5lmlyQPSAKwWzjcA+NwAMarAychb0Xzt7bcFhqYGAE/W4Vua0S8xGVseQwVLlqCv6rH1O5TZLVNVfEZdE=
X-Received: by 2002:ab0:758a:: with SMTP id q10mr2785894uap.76.1568405718142;
 Fri, 13 Sep 2019 13:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <f9bf70bfae825228a7afee705babc1915b579072.1568315704.git.bert.wesarg@googlemail.com>
 <20190913185309.m766nxjo6wby47hf@yadavpratyush.com>
In-Reply-To: <20190913185309.m766nxjo6wby47hf@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 13 Sep 2019 22:15:06 +0200
Message-ID: <CAKPyHN37WPrc9vFXKWJNhW_4GG0r8VPcUnxJALfpNTWirx821w@mail.gmail.com>
Subject: Re: [PATCH] git-gui: add horizontal scrollbar to commit buffer
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 8:53 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Can you please add a version number when you send re-rolls the next time
> around. Something like "[PATCH v2] subject...". Makes it easier for me
> to keep track of things when there are multiple re-rolls of multiple
> patches.
>
> You can do this by passing "-v2" (or "-v3", "-v4", etc) to
> git-send-email or git-format-patch.
>
> You missed two quick questions I had in the last version. I'll ask them
> again below. Other than those two, LGTM. Thanks.

I removed both of then, but they still made it into the patch, sorry.
Will re-roll with v4 now.

Bert

>
> On 12/09/19 09:20PM, Bert Wesarg wrote:
> > While the commit message widget has a configurable fixed width, it
> > nevertheless allowed to write commit messages which exceeded this limit.
> > Though there is no visual clue, that there is scrolling going on. Now
> > there is a horizontal scrollbar.
>
> Looks much better!
>
> > There seems to be a bug in at least Tcl/Tk up to version 8.6.8, which
> > does not update the horizontal scrollbar if one removes the whole
> > content at once.
> >
> > Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> >  git-gui.sh | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index 5bc21b8..032ebd6 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -3363,14 +3363,20 @@ ttext $ui_comm -background white -foreground black \
> >       -relief sunken \
> >       -width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
> >       -font font_diff \
> > +     -xscrollcommand {.vpane.lower.commarea.buffer.frame.sbx set} \
> >       -yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
> > +${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sbx \
> > +     -orient horizontal \
> > +     -command [list $ui_comm xview]
> >  ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
> > +     -orient vertical \
> >       -command [list $ui_comm yview]
> >
> > +pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
> >  pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
> > -pack $ui_comm -side left -fill y
> > +pack $ui_comm -side left -fill both -expand 1
>
> If I remove this change, the behavior does not seem to change, and the
> commit message buffer still expands. So what exactly does this change
> do?
>
> >  pack .vpane.lower.commarea.buffer.header -side top -fill x
> > -pack .vpane.lower.commarea.buffer.frame -side left -fill y
> > +pack .vpane.lower.commarea.buffer.frame -side bottom -fill both -expand 1
>
> I'm not too familiar with pack, but why change the side from left to
> bottom? I tested by changing it back to left and it doesn't seem to make
> a difference.
>
> >  pack .vpane.lower.commarea.buffer -side left -fill y
> >
> >  # -- Commit Message Buffer Context Menu
> > --
> > 2.21.0.789.ga095d9d866
> >
>
> --
> Regards,
> Pratyush Yadav
