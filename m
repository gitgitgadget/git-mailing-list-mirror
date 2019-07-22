Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58681F461
	for <e@80x24.org>; Mon, 22 Jul 2019 17:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGVRbH (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 13:31:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41330 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGVRbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 13:31:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so22373256lfa.8
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWvdY+Dcg4kB1rMmvENDz7qgFOI4rT2H9R2puZIV4rw=;
        b=kcWSxxSlxnLWI+Mo3XIYMVfR01kGZ/QlPQ4Bq7uUkqe23byxf9BdMH1/EEycyq9+Y7
         kGTwjBiy4I1bU/nwqpQAy2/KumIk63hq++VoDqzp7GMaF1Lwbce0lIFUjr51q2OYLRAb
         MfPTzs4VET4+XzxDyHRRUVIMZqMCuMqRIeUv3P/Y/4m20KjC/s+Ljz4ItfIzG74DtwS3
         HGCP0JyEePiMAZRVLrZ33gs1RmcCsNm47Iz7Z1Tlw5LB+krGic+9vSVGqV45nk3AL1W/
         gHeJpA1shqhsRXZUlclgcFfnNMISdCAdtsyXthQbLgFRuN6pJ9rFutosoymuwYbq640E
         DPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWvdY+Dcg4kB1rMmvENDz7qgFOI4rT2H9R2puZIV4rw=;
        b=f3fNZ6vkPqMvSpMQWKOrQvUhwwtUKnRLYZudVfHXAEVElsCaQ/ARy+fdY2N5/7A9zM
         JnAkGpEXt+xguSrdkaagt2CIcWnimQiOuRJGsq2R15cT6a8Kdn4ARjl4Bd2XQu2RmLY7
         hwXBQ6iyzN0BUQbhIC3JznVzCAgYuHLOwNbwn13Ll9pnUtBMZPXbDuMoUsW3VJnLI8+K
         xElN520mUMMxtg8mn8I9xE/j8EN9qyUxQLirD/nAoOCqPX3xJBi3aj2XbIXZmvDPXBrl
         HHe/DWoTXs6vPZ7sgDeVTm5T7GEVnl5SEj/8Pt1Sz44D+4tH285rAAroUBBWmuf0VQ94
         DANQ==
X-Gm-Message-State: APjAAAUMRhIXulfk8FX059n0ktKrEHDrrGYAPY7GyfzfenYWdjeip4hT
        oxFc9TvzLRKHIv+8iFmRYvxiThyLyVu+mUUWX/GU7g==
X-Google-Smtp-Source: APXvYqzsDUdisx4W8iJnTXlfs8gxsaIagPtxzwNRkvezkd3aG6iSTaFFQJ4rewFxWKEGgzhb2S8zQTlspfRJmyEPueM=
X-Received: by 2002:ac2:455a:: with SMTP id j26mr31994405lfm.18.1563816664624;
 Mon, 22 Jul 2019 10:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190707055132.103736-1-masayasuzuki@google.com> <20190709125620.GA18175@sigill.intra.peff.net>
In-Reply-To: <20190709125620.GA18175@sigill.intra.peff.net>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Mon, 22 Jul 2019 10:30:52 -0700
Message-ID: <CAJB1erXRg4S-vzRZwA-Q5cXAPayRE0dAjFjjkNQ9CoKiXF=7EQ@mail.gmail.com>
Subject: Re: [PATCH] credential: add nocache option to the credentials API
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 9, 2019 at 5:56 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jul 06, 2019 at 10:51:32PM -0700, Masaya Suzuki wrote:
>
> > The credentials API calls credentials helpers in order. If a
> > username/password pair is returned the helpers and if it's used for
> > authentication successfully, it's announced to the helpers and they can
> > store it for later use.
> >
> > Some credentials are valid only for the limited time and should not be
> > cached. In this case, because the credential is announced to all helpers
> > and they can independently decide whether they will cache it or not,
> > those short-lived credentials can be cached.
> >
> > This change adds an option that a credential helper can specify that the
> > credential returned by the helper should not be cached. If this is
> > specified, even after the credential is used successfully, it won't be
> > announced to other helpers for store.
>
> I think this makes sense to do, though note that there's an old
> discussion which covers some alternatives:
>
>   https://public-inbox.org/git/20120407033417.GA13914@sigill.intra.peff.net/
>
> In that patch, I essentially proposed making all gathered credentials as
> nocache. That's a more secure default (though in some cases less
> convenient).
>
> It did break a case Shawn had of caching the result of another helper. I
> showed some options there for providing a mechanism to chain helpers
> together explicitly.

I think that it's better to make it nocache by default. Having one
helper produce a credential and having another cache it looks storage.
But since this is the current behavior, I'm OK with just keeping
nocache an option. It's backward compatible.

> We also discussed helpers passing out an explicit ttl. That's a more
> general case of your nocache flag (i.e., ttl=0 covers that case, but we
> could additionally pass "ttl" to the cache helper to let it be smarter).

TTL sounds like it's a generalized version. It might be a bit awkward
because the existing credential helpers that don't support TTL would
anyway cache the credentials. I think in practice the password saving
feature is mainly used by those password management software (like
git-credential-osxkeychain), and they wouldn't support a short-lived
credential. Just having nocache seems fine to me. As you said, if
needed, "ttl" can be added and "nocache" can be just a shorthand of
"ttl=0".

> Given the age of that discussion and the fact that nobody has really
> complained much in the interim, I'm OK to go with your much simpler
> approach. But I think it's worth at least thinking for a few minutes on
> whether there's anything to pull from that discussion. :)
>
> (As a side note, I've had all those patches on my "to revisit and send
> upstream" queue for 7 years; if we take yours, maybe I can finally let
> them go. ;) ).
>
> >  Documentation/technical/api-credentials.txt | 4 +++-
> >  credential.c                                | 4 +++-
> >  credential.h                                | 3 ++-
> >  t/t0300-credentials.sh                      | 9 +++++++++
> >  4 files changed, 17 insertions(+), 3 deletions(-)
>
> The patch itself looks good; two minor comments:
>
> > @@ -296,7 +298,7 @@ void credential_approve(struct credential *c)
> >  {
> >       int i;
> >
> > -     if (c->approved)
> > +     if (c->approved || c->no_cache)
> >               return;
> >       if (!c->username || !c->password)
> >               return;
>
> Here we're disallowing a "nocache" credential from being passed to _any_
> helper, whether it's caching or not. It could be storing permanently,
> though perhaps that's semantic nitpicking (if it's not to be cached, it
> probably shouldn't be stored permanently either). Other helpers could in
> theory be doing something else with the data, though in practice I doubt
> here are any uses beyond debugging.

I cannot think of a usage either. If there's a good usage, I would
change this, but if it's for debugging, it's better to be done with
those debugging features (like GIT_TRACE_CURL). Note that this is
called only when the credential is successfully used. We probably want
to use such debugging feature for the credentials that are not
successfully used.
