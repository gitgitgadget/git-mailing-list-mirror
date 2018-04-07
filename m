Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7A51F404
	for <e@80x24.org>; Sat,  7 Apr 2018 00:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeDGAjR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 20:39:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37347 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeDGAjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 20:39:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id v5-v6so1603668plo.4
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZeDRc8oR4MAk270a342x2NHTcYYFfo6H4rMQfvzZzXw=;
        b=ImBh9lkrZNxlEWGC9SzypJqoQ6WIVte+fQxPEaGqW0CBlHHFDzJ1y9lqD2gI8maxnL
         GAc0ynckgrde3ryn9bJ35QbtEpWuX49nUa4RLtsf6xSroEPS83ANNBASjlKTMwlSPYh9
         OzgUd3IEo2nf86XNRVnjpiGcrcM56rc34Nz03IaWTFKxkwFSWjiISFgTEScT5DTAJ3Kl
         HD8IvB0rqVvGcVH+901HXGpmEPrBmoVzu+Hy6HNc21/CPmgla6ESGXd4D/XhAb5NiTst
         vKjyKZIODiHSRydMsHKwzZgCdMAFENkWhN85dPfUrgbjezttN6hKSkwpwB4cbMrXMNSA
         DU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZeDRc8oR4MAk270a342x2NHTcYYFfo6H4rMQfvzZzXw=;
        b=KvfCN2bJIlDKuk5HDOGlJXqPpSFab1KO6PtvGutSvmA9LEddVV0YE7gRGUId7Z8tRR
         SGz7heZbRmylsNU8e1GqIQyF1vv9V1wuE0orQHC+TZ0cOoHZCUHbZsrflIv9zgj/RfYZ
         7xGyClRApEcEWF+/rjmAi8I5rP2clEfoxim6nUNxc2fPwkhunu2IkG+KBhWKHmoDGHyZ
         4WTX3yhM+f3jzf9se/IRpprGbd2WzTnDdowMarwmKEiFOQB8X/Uq12BAVSkb/qJ3kykv
         jqsp39gOlmuozmHYFQYY5V+U6aJgtud8i8xQD6zD1EapRywax7mLjei62aYZbDOn8upN
         +Nlg==
X-Gm-Message-State: AElRT7FgQ+UiWzmN6bA3aATjJ4HKuIqPS56lkkPOfs5ev1/nOvvRd8fX
        YlBZgyAib3VBF5KA+RL8rSmCJoL2OcI=
X-Google-Smtp-Source: AIpwx48cCAw7niLQrvFWaSQa7izWFOfbqsjt2HrefoOuLQmo+KaIRrYRSw1NGxBqTusqoQQcn+PE4A==
X-Received: by 2002:a17:902:b095:: with SMTP id p21-v6mr29034435plr.31.1523061555438;
        Fri, 06 Apr 2018 17:39:15 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec81:e7e6:a4ca:eef6])
        by smtp.gmail.com with ESMTPSA id p89sm22190879pfk.63.2018.04.06.17.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 17:39:13 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 6 Apr 2018 17:39:12 -0700
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180407003912.GA78042@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522996619.git.me@ttaylorr.com>
 <20180406063915.GC2908@syl.local>
 <CAPig+cQPB+74T3YenoZ_oVFGh2c38AbcFdc+yjw6f32Ojestwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQPB+74T3YenoZ_oVFGh2c38AbcFdc+yjw6f32Ojestwg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 03:04:53AM -0400, Eric Sunshine wrote:
> On Fri, Apr 6, 2018 at 2:39 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > In this patch, we support `--type=<int|bool|bool-or-int|...>` in
> > addition to `--int`, `--bool`, and etc. This allows the aforementioned
> > upcoming patch to support querying a color value with a default via
> > `--type=color --default=...`, without squandering `--color`.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -38,12 +38,12 @@ existing values that match the regexp are updated or unset.  If
> > +The `--type` option requests 'git config' to ensure that the configured values
> > +associated with the given variable(s) are of the given type. When given
> > +`--type`, 'git config' will ensure that the variable(s) are of the given type
> > +and convert the value to the canonical form. If no type specifier is passed, no
> > +checks or transformations are performed on the value. Callers may unset any
> > +pre-existing type specifiers with `--no-type`.
>
> Sorry for being such a stickler, but this is still too mushy. The
> first two sentences are saying effectively the same thing. One or the
> other should be dropped or they should somehow be combined in a way
> that says everything that needs to be said without repetition.

I agree, and please do not apologize for being a stickler. I think that
it's important we reach consensus before landing this, since other
humans will read this.

How do you feel about?

  The `--type=<type>` option instructs 'git config' to ensure that
  incoming and outgoing values are canonicalize-able under the given
  <type>.  If no `--type=<type>` is given, no canonicalization will be
  performed. Callers may unset the existing `--type` specifier with
  `--no-type`.

I think documenting that `--no-type` unsets any pre-existing `--type`
specifier is worthwhile. That said, I also think that there's a way to
combine the last two sentences, but it might be clearer as two smaller
pieces rather than one big one.

If this is still off base, could you provide some pointers on how you
would word it?

> If necessary, iterate over updates of this paragraph here in the email
> thread until a polished version is reached rather than re-rolling the
> entire series every few minutes.

Thanks, and will do :-). I am quite new to this and was unaware of the
situations when re-rolling is and isn't desirable. I am going to wait to
re-roll this series until it has gathered more feedback, or at least
consensus, after which I think it will be ready for queueing as-is.

Thanks for your patience and guidance.


Thanks,
Taylor
