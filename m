Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3719220193
	for <e@80x24.org>; Tue,  9 Aug 2016 18:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbcHISuz (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:50:55 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36099 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbcHISuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:50:54 -0400
Received: by mail-it0-f51.google.com with SMTP id x130so20210992ite.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:50:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KJ2MlM5Lwk/RjagmCjiGY6Fbo5kTwFXcwugX9vJOeMk=;
        b=IRicNcOtRRGDxQWQQhEu/zfAytWTtZTzgvxskgjr93EUhkTQYEJp+cMWHKdpN+3bpo
         0XJavcLArbzTvWUXJbUmSvRJFG7WI9oYVjRBFq7R3sYYd9BjuEAQbBLxkULh41lPivGu
         HOxhzyGeBZwsQ4+30/7WpckPHOua8mYqRKpUyYmKBMQq+zBHOIM+n0tFbTOBKTdvVpQg
         KB2jVUv83VtpLgz8eCbJj2ZydD8VnUDrDnMjOswIjdPt0QcviF9WkAAkMrIuGvqJC7nz
         DPg93vS50wrs/E8rDGGEQCM60IjD113SJE0OjWmvgKEUwZDCzwd0L66DZTlplXM9+Gy2
         YIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KJ2MlM5Lwk/RjagmCjiGY6Fbo5kTwFXcwugX9vJOeMk=;
        b=aanNa3xnfkSiaxnBHLkjwHgs3EI5fUPbkXdymsrGJkEucJ9W8+mZeAiNlCl2qi//mG
         FfEs5d4czehPPPgV1NoZQUkV7YdgC/njtAClw2xIEig3ljmhp0i8JulhBian0eglrkj9
         eCPLMJt3PFsyXEjxK8B8nzUi+93K4pheatqE+CIUFlpFJ1cM83j7aJWE976sAhuTV+bn
         DNlhJDvVEZ/2nHO1k3q/JlJ4gQeC+57GgAQeKQiZS22oaQlgUFSUGBbXF+fxiGBPnptO
         xQko6CUTiO7ue0D5wg+Y+PRoQ5oRpbvhge5fpL0z5C3LCdtypwBx5kI5S7Kd4qgLsh7E
         3vjA==
X-Gm-Message-State: AEkooutd8Lc89DIvR02z0UCHhBXUwCkKotzyCTXBzs8xXrRdy/cqypX/q+hA2L7X05IVlhrHyiVkKYdVrWcz7wsG
X-Received: by 10.36.217.9 with SMTP id p9mr713204itg.46.1470768653223; Tue,
 09 Aug 2016 11:50:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 11:50:51 -0700 (PDT)
In-Reply-To: <CACsJy8ARtg5KUceogNaeB+Fgh-u-TxfkAWdOk68_sEA-c0y6vg@mail.gmail.com>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com> <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net> <CACsJy8ARtg5KUceogNaeB+Fgh-u-TxfkAWdOk68_sEA-c0y6vg@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 11:50:51 -0700
Message-ID: <CAGZ79kZ=kNCq3uM5WGdmZRfPGaT1ZUqa2WkQdq5C2inF154sew@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 11:43 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Aug 9, 2016 at 1:37 PM, Jeff King <peff@peff.net> wrote:
>>    That's (relatively) easy for me to script via mutt (grab
>>    these patches, apply them).
>
> Could you share your mutt set up pleaaase? I've been wanting this for
> a long time, but never used mutt long enough to bother with a proper
> setup like this (I blame gmail).


That is my complaint^H^H^H^H position, too.
I always wanted to switch to a more powerful
setup than git-send-email for sending /gmail for reading,
but I could not convince myself the steep learning/setup curve
is worth it eventually as it is "not broken enough" to do the change
right now.

My experiments with mutts, have left these lines in my
~/.muttrc

> # use shift + A to apply a patch in the working dir
> # macro index A ":unset pipe_decode\n|git am -3\n:set pipe_decode\n"
> # macro pager A ":unset pipe_decode\n|git am -3\n:set pipe_decode\n"
>
> macro index A ":set folder='.'\n:copy-message\n"

(IIRC they were broken for many patches, but I got applying
one patch to work. Which sucks for long email series.)
