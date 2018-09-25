Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141EB1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 15:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeIYVoc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 17:44:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53204 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 17:44:32 -0400
Received: by mail-it1-f196.google.com with SMTP id h3-v6so15982173ita.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9PTh23sOCPZUURNhyGCvkXveGKrmywhkjnqkk90MUYo=;
        b=HxzFeqi066bdtv1o1jTOm/qwcX/DOxN2UBLAZmEY5uw73K5lcwCaZSLiec79CIOv81
         lHI6jZyGIpNHdxTp1ZFlYMy/DaMueD2FHiIZo7jOqpkjZbz2C6d5wdGQYA5KYm/72+vK
         RTlZPtrViXb/yVSH3uA/bav1aGMyMlp3lP84Mc7wYGF4wDrHLZ8MjbRORsSkXPEBnjeo
         t3Aynq9L+aDSLMjpI5Ne4RKqNGJV+Fk7Ej9cc37INXQCJLYZ1ZDjWV6ybskNQ5uc/UJj
         9y+L7pvzpWxYRCBFjUgYWQL9asiO1b39esYr6+cnnMRL71Q1L5buThd3Dp5t8XJ7fG4g
         vekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9PTh23sOCPZUURNhyGCvkXveGKrmywhkjnqkk90MUYo=;
        b=TvmjpmcjgfzBUBugl83rYM1LAKvKapzONkAqxvFwaum2TWTkz6UzQQZBpU5Vb2F0hn
         y2MikqCSqrO20uTSDRWeikbwfXOjEB5D5lMqaeh6mqnD4i7m1h1m5WLRqtq+LIXTWenj
         x+z6chycFG0/IBQImcWGMuZGetIaFLBw6J33rwuG/yuRhErP79VB88SSgbO9nQgM5d61
         VKy+1akZyc0kiIpJRFj26l7DOiffmb2MaKVqQWvb5r16ZiLa2YX5V7Ve1Ls5ML5xGftb
         jRMS/VWuthBRoZxTjeKbImoU+dDgy4Ct+XTDi0w1ffYptM8lS8b7pREuWM2BQDZmR0Mg
         hFbg==
X-Gm-Message-State: ABuFfogBTktn2AznINRfChVYbyNMrzskGhyoC0Bj+sVqx6CjV8AbIMC7
        e3qg1NYKI597F0HoxcuW8fPks0/+rUNcn2eoo+k=
X-Google-Smtp-Source: ACcGV600pDiuXoT6GtyQGxlnomRlsA31eOn8Xv2uXBYaScaMZccJksOlCqnj5kOniq6kvWQ/xefOQJwl8XPC2Dn6lEY=
X-Received: by 2002:a02:270f:: with SMTP id g15-v6mr1468807jaa.94.1537889788420;
 Tue, 25 Sep 2018 08:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-3-pclouds@gmail.com>
 <CAGZ79kZF1+0PTEgF_NwM_AwttJ0sedAP8CT834L5ZGJpxZ+G_Q@mail.gmail.com>
In-Reply-To: <CAGZ79kZF1+0PTEgF_NwM_AwttJ0sedAP8CT834L5ZGJpxZ+G_Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 17:36:02 +0200
Message-ID: <CACsJy8BKTkbc=ZgMnO7Yuk0eaqzZnifo80tnR872_T8b02biqg@mail.gmail.com>
Subject: Re: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 4:35 AM Stefan Beller <sbeller@google.com> wrote:
>
> On Sat, Sep 22, 2018 at 11:05 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
> >
> > When multiple worktrees are used, we need rules to determine if
> > something belongs to one worktree or all of them. Instead of keeping
> > adding rules when new stuff comes, have a generic rule:
> >
> > - Inside $GIT_DIR, which is per-worktree by default, add
> >   $GIT_DIR/common which is always shared. New features that want to
> >   share stuff should put stuff under this directory.
>
> So that /common is a directory and you have to use it specifically
> in new code? That would be easy to overlook when coming up
> with $GIT_DIR/foo for implementing the git-foo.

There's no easy way out. I have to do _something_ if you want to share
$GIT_DIR/foo to all worktrees. Either we have to update path.c and add
"foo" which is not even an option for external commands, or we put
"foo" in a common place, e.g. $GIT_DIR/common/foo.

> > - Inside refs/, which is shared by default except refs/bisect, add
> >   refs/local/ which is per-worktree. We may eventually move
> >   refs/bisect to this new location and remove the exception in refs
> >   code.
>
> That sounds dangerous to me. There is already a concept of
> local and remote-tracking branches. So I would think that local
> may soon become an overused word, (just like "index" today or
> "recursive" to a lesser extend).
>
> Could this special area be more explicit?
> (refs/worktree-local/ ? or after peeking at the docs below
> refs/un-common/ ?)

refs/un-common sounds really "uncommon" :D. If refs/local is bad, I
guess we could go with either refs/worktree-local, refs/worktree,
refs/private, refs/per-worktree... My vote is on refs/worktree. I
think as long as the word "worktree" is in there, people would notice
the difference.
--=20
Duy
