Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0481E20A36
	for <e@80x24.org>; Tue,  7 Nov 2017 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdKGWGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 17:06:31 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:50345 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdKGWGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 17:06:30 -0500
Received: by mail-wr0-f195.google.com with SMTP id p96so632983wrb.7
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 14:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HJk50Bya+ldP8TlOYfw54cjz/6ZLe3CuUaag+prPe1U=;
        b=er90pjj7jbzljYTRms2ONcM3q0B4z5lYqsjCLnUoBS7HWw9NMTYl34LCBNbQ2v1P7/
         Lba0SzkOsGjkdfc1mx6hteSAbV1utD0yzKx6ps4P9zfRbNl11cWD82ojZvP+X25oQs0m
         oqKzNQUNHn9m7fc3gd3CQTWuad9MmZHx0CfG/hXRdte+A2Zqho3v9UbA4eWG0ofYm/9I
         SJHlWtE579/KFWFvlA6o4BiV+f1zvv6aZRHDvpx80f3elFtoO1Cm/oya7ltlylXSL0Ns
         JERsNlyN0lIlnwxupQyDFyZj7wMIn1MzCKbxCZ9E3/ZEjHE7rpFJimlgZSCT5sq9W/Al
         Zb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HJk50Bya+ldP8TlOYfw54cjz/6ZLe3CuUaag+prPe1U=;
        b=cvmpXOLSW6MCXRusdr1RwQpxCqJcd08YNTJwnrG8gugtmIZpJQqEWXW+7KZAwFg85h
         PPKHy2npOM1ePBaxtH1cuRLMBVNgwNrW8vYHxSs2D43H0UhsV4CGqAjIrNtsA75wwByU
         /HMUzT9L7e4ZyEnymFir+hu4gi2kIGBR7eAoAH2KnhmxXtqwr2RLWJOFsBUoG6/rkKfL
         GRm7ozPElAlwQ0J0h5kYVkwQkfnoN54P/7gpn090KXnm2+y7HjKKHodEH/rkFXGzYssr
         SjgPxHt7UVKkZl2/81k7kew5QcHIxsBBBkuC4ZQMZ8/uonnc/PHyEggSkqsRb6gXZqvh
         OL6g==
X-Gm-Message-State: AJaThX7DtzLTXPsaxjK2AVJO7TgAcKNsU+9sKVhRl/XtJjq4jCX++Lav
        3Gy5brqgwhcrlUuPPMZVQFY=
X-Google-Smtp-Source: ABhQp+RZ5O1QGUXvLkTLEXET5QARj8ncFZHl1sSZiSE6i6Bcuit6cVInid7vJTskvKvVqF2DmDzZqg==
X-Received: by 10.223.157.141 with SMTP id p13mr171913wre.92.1510092389158;
        Tue, 07 Nov 2017 14:06:29 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id r63sm2159552wmg.13.2017.11.07.14.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Nov 2017 14:06:27 -0800 (PST)
Date:   Tue, 7 Nov 2017 22:07:48 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] ref_transaction_update(): die on disallowed flags
Message-ID: <20171107220748.GA19775@hank>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
 <10901328af1e6e04e8c7c7b39977ec85f6c58142.1509870243.git.mhagger@alum.mit.edu>
 <CAN0heSpOpfCmf8k8kZz1L-1qb-5mDHMLbQYaLPKE=twOhgyi8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpOpfCmf8k8kZz1L-1qb-5mDHMLbQYaLPKE=twOhgyi8A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07, Martin Ågren wrote:
> On 5 November 2017 at 09:42, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > Callers shouldn't be passing disallowed flags into
> > `ref_transaction_update()`. So instead of masking them off, treat it
> > as a bug if any are set.
> >
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> >  refs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 62a7621025..7c1e206e08 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -940,7 +940,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
> >                 return -1;
> >         }
> >
> > -       flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
> > +       if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
> > +               BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
> >
> >         flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
> 
> The masking out is for sanity, but also partly to squelch a
> compiler-warning. Thomas reported [1] that dieing does not make the
> warning go away, but that masking out does. Of course, avoiding warnings
> is not the ultimate goal, and -Wnonnull is not part of DEVELOPER_CFLAGS.
> Thomas reluctantly suggested that one could do your check and then do
> the masking...

Thanks for doing the digging and cc'ing me here.

Interestingly enough  my compiler no longer complains about this.
Looking at what changed, gcc got upgraded to 7.2.0 (from 7.1.1) in
between then and now, but I can still reproduce this if I base this
patch on top of the old commit.

So bisecting leads me to 89f3bbdd3b ("refs: update ref transactions to
use struct object_id", 2017-10-15).  It's too late for me to dig in to
what in this made the compiler warning go away, but it seems
reasonable enough.

With that said I think the patch we have here is definitely an
improvement, I would have prefered to do it this way in the first
place, but the compiler was standing in my way :)

Thanks Michael for cleaning this up!

> Maybe it would be worth a note in the commit message. But blaming these
> lines quickly leads to c788c54cd (refs: strip out not allowed flags from
> ref_transaction_update, 2017-09-12), which describes this already. OTOH,
> since the warning does not hit these lines, but a bit below, maybe it's
> even worth a comment in the code.
> 
> I'm not saying we should sprinkle comments for each warning we hit...
> Anyway, those were the thoughts than ran through my mind.
> 
> [1] https://public-inbox.org/git/20170924204541.GA2853@hank/
