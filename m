Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A231F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbeGSSpC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:45:02 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41331 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbeGSSpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:45:01 -0400
Received: by mail-yb0-f194.google.com with SMTP id s8-v6so3607490ybe.8
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB8y02+cwxHYmAzlO4qxHYeasmVoBIsDUBZrnUhZ5Xk=;
        b=mjpOaSi1lEGC1yLZiWAMeNngoH0T4iE30SAxH2Ij0uCLX0JJNtrOh9VTxX/22z9nvl
         DyyPnd9TxYtQevxsI1V2Mwdlcmrj+9QMPOAmmQY1V5zmwKY16stgC1tHBJ0WJJCf+Pix
         XHPktFaavFET7N3ncap59bLyO12exNfOXaC2wJSIFjhfClEmnooleNQGjWQE03wsLOld
         7fRJ+MRnMXPrC7QUScueVdth5FhNq5Nun1qxw5/n/v78aVkTDs4vH4OJXm/H+UKrovDW
         C/nZJW+3DTnrD5TPCBNjZQD+nDqGZ+t/8CqSMebBi7nkWn+5zsAzHxYya23ZeBH82ZVZ
         93Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB8y02+cwxHYmAzlO4qxHYeasmVoBIsDUBZrnUhZ5Xk=;
        b=ApJLKdKEUH0sLosMciwVrAaLswQcMNjy/pZSdBYFzpCSmo/ykhaeX4PY1LleyHx1ZZ
         W20nDbBmUBVgCq+XruaHW/3VgtrOvvFLj8DqNwqJVXHIOxZD372+rv3dvHfLfscGrW1g
         SFrw/5W0Kx5W3togv+BioaGtYmcZVN3kZMMSmIQYucn8G/QF6r64PCW5XIJ/yeqzD5tr
         ZX/NoE/C+BHxz0G37jmAfTGOKo8i0OwQ02LYgv9hUTHK8MJwd425pkGFMKE5RGEGcJL7
         sesSw9CqzC92GkD2AwSj7KpbS4mNcHbDPrb3O6iqdVfy2jJFPQp1Ak6eYYMQMHvW/0a4
         h7Ww==
X-Gm-Message-State: AOUpUlGCYJyRZJmf9dtHnFWb0ivNT+G7APhr2POwyop7ByK7G+lpABwz
        Yrf/+8MZHBTf/ne66ubDsRD1VXHogPXR+cnlvZOJaHMqdcReIA==
X-Google-Smtp-Source: AAOMgpeWI2i4THgfMN0QIkSgSH6INMvUDRuHWsePQzSS6eaI1YUNXrr5YBmvC9gbw/Tk47bES1QBkOR86vxTsRJlF/8=
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr5940430ybj.167.1532023245095;
 Thu, 19 Jul 2018 11:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180718005311.136329-1-sbeller@google.com> <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbOxD-GomEYGkOPe9bPT8sgik77hLaTHK1xN9Hk=g+BvA@mail.gmail.com>
 <xmqqtvovgped.fsf@gitster-ct.c.googlers.com> <CAGZ79kZvHvMy6Lf-_Dtzbfaz2BFY2WonOfw-dDQVCOnS-a0=sA@mail.gmail.com>
 <xmqq601bgmh3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq601bgmh3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jul 2018 11:00:34 -0700
Message-ID: <CAGZ79kYo_zFfvX1LHod47BND=GbmzeaBfxhLbX_nmCPx0UATZQ@mail.gmail.com>
Subject: Re: [PATCH] diff.c: offer config option to control ws handling in
 move detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 10:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > "git format-patch HEAD^ --color" produces red/green output
> > (like git log would), so I do not see why --color-moved should impact
> > format-patch differently. (i.e. if the user requests format-patch with
> > color-moved we can do it, otherwise, when colors are off, we do not
> > spend cycles to compute the moves)
> >
> > Maybe I did not understand the gist of your question, still?
>
> "format-patch --color" done by end-user, especially when combined
> with "--stdout", would be useful to show coloured output.  That is
> what you are talking about in the above, but that is not what I was
> asking about.
>
> The question was specifically about configuration.  You may say
> "diff.colorwhatever = on", but "git format-patch" with no command
> line override wouldn't want to be affected by that and produce a
> patch that won't apply, I would think.

The options introduced here (even the command line arguments)
do *nothing* if no color is on, i.e.

    git diff --no-color --color-moved=blocks \
        --color-moved-ws=allow-indentation-change

is the same as

    git diff --no-color

and as format-patch doesn't use colors by default giving
color-moved settings (even via config) is a no-op, too?

Stefan
