Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75531F600
	for <e@80x24.org>; Sun, 23 Jul 2017 20:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbdGWUcf (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 16:32:35 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37780 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdGWUcc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 16:32:32 -0400
Received: by mail-it0-f52.google.com with SMTP id v127so26535221itd.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+3Q+WKCVsee7TBoe8S+5b6OjKbIyL2qke+8HewBx7fM=;
        b=j416z5FcSht35Y/C+nZWylHgmVQxYpDQ+tmiLuUY7qvyZTR9h6x6UczWZyPEF5/QIs
         HvyMYn8lYo/y+qWwuZbTzqs5AdHqQyEq49RptgDDvg9pk+fwfz1V5gN7NNfBvv+7rT+o
         NpifMelz1Q382sggbgTNxh+9s4E/XPnP723vAfkT1x0flmnGvWYAWheSy8W2Dug6ZhwH
         U1Hor3C/ototYckyEB4pESKl6anh6Jt+iMo4Uyaw2nPladgeji9moRTNWCM+BotJrChd
         OFDkY1Z79ku0AeNaq17sJnx4Vm8YrPesmgWi8LEYE+qKvHZOjpoosTwsi3JiXdfaGn8w
         gV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+3Q+WKCVsee7TBoe8S+5b6OjKbIyL2qke+8HewBx7fM=;
        b=g2gUm80tLdlxyfplmG/An8263t6mOj0AbJJ7n6OYKSR4xEqwvwI43fKMAvASwWBo0R
         xjNc6SV/XGSct/bfWTTLS/8l84tMQUvT4jYHcSTNMfC4cdn5j0esxVdPe2E3tCJLtJmn
         pl5uMyD3sVYiAbb+hX5deUTPZ9T43S22XZpBDuRzPYRjSMwnfJ+lwFpSYhX+WOCXI6Mt
         l8zD6nOpFmqECKwkSRCbOcq+qqFs7vFjVBSDTLsNaEOOYPWyvdRjonU4DR28IY5sBxsq
         C+E89h6JzBbvCnWe4u/iGtnIQbLzaQIuPZY/StB8XOHb+mfyFlP2GeJnx+Ub5x64Le0A
         uH+Q==
X-Gm-Message-State: AIVw113zvKr2y5X5qRMagDwFRpoo5thr9uTzrtgLdPUNyN87I91ILXzF
        YU8sQaom7ZGD8X0lQdiX5Px9ARRGCQ==
X-Received: by 10.36.16.137 with SMTP id 131mr5023837ity.11.1500841951657;
 Sun, 23 Jul 2017 13:32:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.155.195 with HTTP; Sun, 23 Jul 2017 13:32:11 -0700 (PDT)
In-Reply-To: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 23 Jul 2017 22:32:11 +0200
Message-ID: <CACBZZX4RwAmdQFeLCNG4oYLrQjafw2g2PBy6-Jn_LLp4t6hXsA@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 22, 2017 at 8:29 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 3rd iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Significant changes from v2:
> - efficient lookup by SHA-1 for allow-tip-sha1-in-want.
> - type 0x4 for FETCH_HEAD, MERGE_HEAD.
> - file size up (27.7 M in v1, 34.4 M in v3)

I had some feedback on v2 here which still applies:
https://public-inbox.org/git/87k234tti7.fsf@gmail.com/

It would be good to either get a reply to that, or if you don't think
it's sensible for whatever reason and left it out of v3 have a
"feedback received but discarded for <reason>" in these summaries as
you're sending new versions.

Aside from the mail I sent I think that would be very useful in
general if there's been any other such feedback (I honestly don't know
if there has, I haven't been following this actively).
