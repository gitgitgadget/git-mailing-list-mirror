Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828B41F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfIDUn5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:43:57 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40400 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfIDUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:43:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id i128so14756820vsc.7
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASF7YXjwTLGHOoFPct/7p+koTkRQonNLwokQybth1Jg=;
        b=PgRH/jP47wywdX/75+Mh4p0KpXicskHLZWj6c+N23Vya4NhkO46u46qdv49afC4Pyr
         hIXe9/X9UYFhS1PCLRECWrxJyBvjNk2Upp6gX19xSSdPg/5cMLPaOt4sesRK9qnt5++d
         GJP+7Z0PQIDigPEiMNwLqTUe1nzXN09jNrJCW4GnQIfcx3SOEkR8TtF6idhgy3UqL6wp
         mSdpSnW4quoRiBjLVXUfqVKs7Pqzp9Vj+q89RtZGIRMvvo/s/NzN3AkTYGCII0bc3UUv
         cc8oXVWypsdAo0pDWFDHqUPOErnsteuXIoRnrWspFIg94ypqq7hw7XCUnZST0bZaM1OR
         McPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASF7YXjwTLGHOoFPct/7p+koTkRQonNLwokQybth1Jg=;
        b=UXGpGpg9L+3opLhPHfWtQFSQkfhqfxhBNSS7huGryKZ83pC43wkiXx4CRbaEtQdbbB
         XYgofeDYnuohOjaQKpM6U0hJdDGuxW8v+9TVWjV15EItcpP/EwEjGzUgT2LK5eCemLf4
         tuy9yxnsq+llXoIFwZhhmclTFIuZ1XUqubNbJLFR9xWgOJXbe4OVJxSxrUKh4ff9FwfR
         T7kWNpvekKtHFDmL+JpZyelCte+GuuRIHRgdLiunskzPx756Xzm/DG85J52s4usMz5Qo
         6pWd3aTWfVJZnBazWXx2i97V4XYlRe4/jsLSnRiZc0edjzn5aahI73XRoEjmKAgEU2Ph
         IEuw==
X-Gm-Message-State: APjAAAWI5EmSsMGo0agswN5XG0d+hYUjqvMh5KCu5YX3qZAwUB+bNzMM
        dKavSFpW9UpVWOzJcB/xoNc8VDokkpNedH1nAlY=
X-Google-Smtp-Source: APXvYqxLK200LQ+NblzW5oWEIKx26kOtzUs2RzVT7KGzWbTSBvNHGU+g48ShhCrp/Oy4aUHVpUYV1zmSsZNAEmLT6/0=
X-Received: by 2002:a67:fd11:: with SMTP id f17mr9774581vsr.31.1567629836254;
 Wed, 04 Sep 2019 13:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
In-Reply-To: <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 4 Sep 2019 22:43:45 +0200
Message-ID: <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 10:30 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Sep 4, 2019 at 4:10 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > The commit message widget does not wrap the next and has a configurable
>
> s/next/text/

fixed

>
> > fixed width to avoid creating too wide commit messages. Though this was
> > only enforced in the GUI. Now we also check the commit message at commit
> > time for long lines and ask the author for confirmation if it exceeds the
> > configured line length.
>
> Hmm, more confirmation dialogs tend to mean more annoyance for users,
> especially considering that the line length limit is a
> project-specific _policy_ (so this has the potential to annoy a lot of
> people), and also because there often are legitimate reasons for
> exceeding the limit (such as pasting in URLs).

these people did not saw the entered text anyway. they would have
needed to change the option (default to 75 characters) to see what
they have typed. which could have been garbage to begin with.

>
> As an alternative to a confirmation dialog, how about instead adding a
> _warning_ message (perhaps with red text) on the window itself
> alongside to the commit message field (below or above it or
> something)? Is that something that could be triggered by a text widget
> callback?

How about a horizontal scrollbar? This indicates pretty conveniently
and in a standard visual way, that there is more text to the side ;-)


>
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> > ---
> > diff --git a/lib/commit.tcl b/lib/commit.tcl
> > @@ -215,6 +215,16 @@ A good commit message has the following format:
> > +       if {[tcl::mathfunc::max {*}[lmap x [split $msg "\n"] {string length $x}]] >= $repo_config(gui.commitmsgwidth) \
>
> Does this take TABs into account?

probably not. Does git expands tabs if it wrap lines (git shortlog's -w option)?
