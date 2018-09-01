Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26941F404
	for <e@80x24.org>; Sat,  1 Sep 2018 09:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIANMA (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 09:12:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44491 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeIANMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 09:12:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so10641536edb.11
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gPoklMPf6B7XABBCzu49zEZNNo9n0t4WLWGQj/kXMQg=;
        b=Tda98205iYFpqXs7jKh0y3+IEyROJTVzFVKcpWKSUK3AJlNjZj6n15ebgAbh5OrH87
         C27xe4Us6fxfIqFWFzO0vEzClWdGD7YgmbSITI5t97jFQFjOnw7mGAeqUZGaHNrfJ5ft
         jcIVOteuA9IIInlxI8KufMLtingDBpUD9vgcYp04gpcrRxdr4qDQDQaNU4QgKfUhT+xA
         269KRMcpEpa/qxGaKLOnH2+hzqaMdJQwe7LE0nd3xnkZ9oD5T3OwCzBKXT7tAgjjjeTF
         9wRgmT1/XMTKcmTB6cHh+Po/2QX+3Z7xOnbr9S/xLPW/RVUFEQ3x/lrSiGUD80X4ditE
         +JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPoklMPf6B7XABBCzu49zEZNNo9n0t4WLWGQj/kXMQg=;
        b=ZMkuFseq3Q7fy+D53pcuNeEqjB2jr6PMxOvie8zFeQv2RlGpYg9vvgBhcgly8XACwW
         TtMCgqBcgSF8jXhkdhzle4XXvBKaEg9RI8gWDpBz8QVdkzLjWSjubUcps5LWFZBND6u8
         Q6/820y7SPgxSYxUg7j4eafdJNpx9F+eOSBTcEX7EGcwlpZPCWoa5eBsqyl44mVW0ZBp
         FLKr4KbQIbv9WQE1OqTXL3iVp6++wYMmQ6DfNsvjbR4cp59ea/USaBE4+pAYV7FIfd1u
         JPPEi823e7M2CRX+/YwIlajXSmFbYSv0tbFVejk8UojOo6xaNCyDxFgX0YrQND6pHeB3
         KviA==
X-Gm-Message-State: APzg51D/wfBNpXkRdY3jkG1/y4zg4wXerGBr245C7hAqRH1SD6SDz/2U
        cieQl/GlDwU8A8tHdfDVkO4=
X-Google-Smtp-Source: ANB0VdZAjdNeJ5Gofwtxc5Ri4Z2tO/PWRald2h4awmnZ4CgYntoluknaMSOcj2annIngqPgoRJXr2w==
X-Received: by 2002:a50:90c5:: with SMTP id d5-v6mr21355204eda.76.1535792441350;
        Sat, 01 Sep 2018 02:00:41 -0700 (PDT)
Received: from localhost ([2a05:e201:0:1224:5987:3e14:73d4:caf3])
        by smtp.gmail.com with ESMTPSA id b39-v6sm5428438edb.82.2018.09.01.02.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 02:00:40 -0700 (PDT)
Date:   Sat, 1 Sep 2018 10:00:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] rerere: mention caveat about unmatched conflict
 markers
Message-ID: <20180901090039.GA6147@hank.intra.tgummerer.com>
References: <20180824221005.5983-1-t.gummerer@gmail.com>
 <20180828212744.18714-1-t.gummerer@gmail.com>
 <xmqq5zzsajg1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zzsajg1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Yeah that makes sense.  Maybe something like this?
> >
> > (replying to <xmqq4lffk3ez.fsf@gitster-ct.c.googlers.com> here to keep
> > the patches in one thread)
> >
> >  Documentation/technical/rerere.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
> > index e65ba9b0c6..8fefe51b00 100644
> > --- a/Documentation/technical/rerere.txt
> > +++ b/Documentation/technical/rerere.txt
> > @@ -149,7 +149,10 @@ version, and the sorting the conflict hunks, both for the outer and the
> >  inner conflict.  This is done recursively, so any number of nested
> >  conflicts can be handled.
> >  
> > +Note that this only works for conflict markers that "cleanly nest".  If
> > +there are any unmatched conflict markers, rerere will fail to handle
> > +the conflict and record a conflict resolution.
> > +
> >  The only difference is in how the conflict ID is calculated.  For the
> >  inner conflict, the conflict markers themselves are not stripped out
> >  before calculating the sha1.
> 
> Looks good to me except for the line count on the @@ line.  The
> preimage ought to have 6 (not 7) lines and adding 4 new lines makes
> it a 10 line postimage.  I wonder who miscounted the hunk---it is
> immediately followed by the signature cut mark "-- \n" and some
> tools (including Emacs's patch editing mode) are known to
> misinterpret it as a preimage line that was removed.

Sorry about that.  Yeah Emacs's patch editing mode doing that would
explain it.  I did a round of proof-reading in my editor, and spotted
a typo.  Since it was trivial to fix I just edited the patch
directly, and Emacs changed the line count.  Sorry about that, I'll be
more careful about this in the future.

> What is curious is that your 2/2 counts the preimage lines
> correctly.

I only added some text after the '---' line in 2/2, but did not edit
the patch directly.  Emacs's patch editing mode only seems to change
the line numbers of the patch that's being edited, not if anything
surrounding that is changed, so the line count stayed the same as what
format-patch put in the file in the first place.

> In any case, both patches look good.  Will apply.

Thanks!

> Thanks.
