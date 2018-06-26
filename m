Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 880721F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeFZVZq (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:25:46 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38607 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeFZVZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:25:46 -0400
Received: by mail-yw0-f194.google.com with SMTP id w13-v6so6611460ywa.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49fdep3yD9gspFuwm++ms2gDr8qGl3YgcwX1oCZE3Fs=;
        b=UFrVW0O+FOEIWi1FNnfXvS8Qeu9z52Uye77WfrWM2wR05NuNZRW5TPdMSmxqbpqJ+b
         a38l836BinBfIwoLx9eKbgSZ0P0+MkwCu8UjXF3HxyDJghvgfXlG6IlGeWVPgT9VpWFz
         6hc4nVffqaQ4gSjxaw397SIlycegQvn9xYHvIGsG7e4Op0oui3dyawCaHz8YqiIJJYw8
         Om1uG5C9NLvRlo6POrnbUkWUfsYgUD1ilxVHdvZo4d4xvE1Au5/bp//SGWp0PM/CSzxa
         X+rS7KzKZcqoQ6Zh8EPb2icUfrl10UoAs4+RMW2m7TzwcPWz5zaJa80QsuaVoIzbZ4Ob
         5dAQ==
X-Gm-Message-State: APt69E3syHzd/Pg7/x3qvMSuQRlvAfl2IZFEC/s08hLpb8aO091S9Ag3
        Rw59BngBexFLRCMk25M9FmjjStE1sr8raF2qm10=
X-Google-Smtp-Source: AAOMgpf0aPVdwbGP0HfNxyBbiGXhszV9XsjKxPTIHwlUp55O056GrHUArEiLf5+3bp5RhqFQJP/4QhOY5+ZSFn24SXg=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr1648353ywq.120.1530048345481;
 Tue, 26 Jun 2018 14:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com> <xmqqo9fxjq39.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9fxjq39.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 17:25:34 -0400
Message-ID: <CAPig+cSW6jP3FtYpwf5bB4SM=qw6A3K9H3JPranJ_KMqH-AwZw@mail.gmail.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 3:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> I first looked at 29/29 and got heavily inclined to reject that
> step, and then continued reading from 1/29 to around 15/29.
>
> I like these earlier changes that fix existing breakage, of course.
> I also like many of the changes that simplify and/or modernise the
> test scripts very much, but they are unusable as-is as long as their
> justification is "chain-lint will start barfing on these constructs".

Sorry, I'm having difficulty understanding.

Are you saying that you don't want patches which exist merely to
pacify --chain-lint? (For instance, 2/29 "t0001: use "{...}" block
around "||" expression rather than subshell".)

Or are you saying that you don't like how the commit messages are
worded, and that they should instead emphasize that the change is good
for its own sake, without mentioning --chain-lint?
