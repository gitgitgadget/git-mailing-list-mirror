Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B621F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 15:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408680AbfJRPAL (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 11:00:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43634 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392463AbfJRPAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 11:00:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so1376424wrr.10
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZHOLlT6ElbvKX3xOpuAZCZxRpvpJW3gqedm7MwJ36/A=;
        b=KXVJt5KMoSz97E6XQ+QpQtvR1v9qpfoQwGzKDWnait/9jcMSZfTNQGF25CJkNfnRp1
         9VeiDY5S5o8+yE//26ce2SJuH+EoY33No1HrbXxiKVwXS55WNd/MSvYt5YhbNUe6xO9T
         Nmd52/ZgWiEYTyFuDSQ36oWlnuIoEDS/m6+jHpLSU7TsxC/2SpIZuuoQlMMvIS250mUD
         J2SKG60+qyyOzJo6dqLyab9/V5QgEB76Die1FHcXXjVnZn7INQbHcRdKP6mjUPjtUhs5
         3eJKvGgjNgMMrq0PM9WCBvovdn/oRagCcAuep6Ne6k/7zwFT3n3COh0GNL70l+Mnr6YR
         Rjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZHOLlT6ElbvKX3xOpuAZCZxRpvpJW3gqedm7MwJ36/A=;
        b=e50on5KQT3Ra1DaQGvq95gaVsTuRLfes5B9OA/GksSENZ35AUwWfiBqG1KwCmqYgHH
         iOoGgXx8pbX4jxTJXhHn4tHygH/H35toG4aBKlzHQwf6Bawp3zb1K/O/4xLZyKaqgKzj
         txsZ09nIm1+ceNdZenNacgQVqEWCYYbs2ZToEELn0OuiODTSsl8Pc1GXTw1NpKf6hFlh
         QNYz30/Liuh9yab2qOIWImsKwr05HJdMrX5CA19hJlT+OGyAMUA/s3eYBTZ/7rfZ3/bc
         bNbkzmtkfnjGCpMlHiHlvNCpb6z6yYxiiTIksaKGfRmhRzlGFDkE2KTgOWkmI+4XDZsg
         pWMg==
X-Gm-Message-State: APjAAAXx/x5Kq0p/dZd6NtpyuWEyvL9JzSWzAoX+DQ2lAfK1NoUMC8Vp
        kINcRBWrCkb4yVkw1WtmJuw=
X-Google-Smtp-Source: APXvYqximH7T3jmR7LvtYpj9vujlVap0HwhPob7Y7xFjFVI4AwXEaBQGpznpUXqVGG+LnDGBRX4cKw==
X-Received: by 2002:adf:8526:: with SMTP id 35mr8898661wrh.266.1571410809543;
        Fri, 18 Oct 2019 08:00:09 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id o22sm7667760wra.96.2019.10.18.08.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:00:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:00:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] completion: list existing working trees for 'git
 worktree' subcommands
Message-ID: <20191018150006.GD29845@szeder.dev>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191017173501.3198-6-szeder.dev@gmail.com>
 <CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 02:08:12PM -0400, Eric Sunshine wrote:
> On Thu, Oct 17, 2019 at 1:35 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > Complete the paths of existing working trees for 'git worktree's
> > 'move', 'remove', 'lock', and 'unlock' subcommands.
> > [...]
> > Arguably 'git worktree unlock <TAB>' should only complete locked
> > working trees, but 'git worktree list --porcelain' doesn't indicate
> > which working trees are locked.  So for now it will complete the paths
> > of all existing working trees, including non-locked ones as well.
> 
> It is a long-standing To-Do[1] for "git worktree list [--porcelain]"
> to indicate whether a worktree is locked, prunable, etc. Looking at
> the implementation of builtin/worktree.c:show_worktree_porcelain(), it
> should be easy enough to add.

I didn't look at the implementation, but only at the docs, which says:

  --porcelain
      With list, output in an easy-to-parse format for scripts. This
      format will remain stable across Git versions and regardless of
      user configuration. See below for details.

I'm not sure whether introducing a new boolean attribute (i.e. a line
containing only "locked") would still be considered acceptable, or
would count as changing the format.  I can imagine that a too strict
parser would barf upon encountering the unrecognized "locked"
attribute; but yeah, no sensible parser should be that strict IMO.

Furthermore, I'm not sure what to do with the reason for locking.  In
general I would think that it makes sense to display the reason in an
easy-to-parse format as well.  However, doing so will inherently make
the format less easy to parse, because the reason could span multiple
lines, so without some sort of encoding/escaping it would violate the
"a line per attribute" format.

I would say that this is beyong the scope of this patch series :)

> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > @@ -2981,10 +2981,21 @@ _git_whatchanged ()
> > +__git_complete_worktree_paths ()
> > +{
> > +       local IFS=$'\n'
> > +       __gitcomp_nl "$(git worktree list --porcelain |
> > +               sed -n -e '2,$ s/^worktree //p')"
> > +}
> 
> I know that the commit message talks about it, but it might deserve an
> in-code comment

OK.
