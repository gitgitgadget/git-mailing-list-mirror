Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BB9B1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfJ3Wnd (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:43:33 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43021 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfJ3Wnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:43:32 -0400
Received: by mail-pl1-f176.google.com with SMTP id a18so546450plm.10
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XE9iY0hJgdq2dV/1VmYo0ImfbAW4io/0Oep8pkMLk7I=;
        b=gTDulmcnzVl33Li+ou+EKSMl2i6nGcEQcGRhaOyjCUaKHSy3HUPlJjLNEegGXP18vr
         90iltmeNIH/vqx73AdkU5m4Jf1jGDCOfhB9m/TKNDqOpsDIoe1W5B31e119jWjMsnt5+
         C7VUgd1s0f0V2QEHpO8Zq44t0BaKH4+kd8K5lrV9V76y+I41Wt4Uj4ZDG6UHT3I6+RNx
         Ln6g3pLRU0NbgMMhjLN2HbAQ5cVWCEXNIGOwFNAgtnOJVSDagpi2wYqw6jOMfHfys3mJ
         VTDFPIRuk9cHwVvAEfIdSVzhQEO54Ou/id7t/Pet9BC+Uptpb5PCcZCLg8U6YiH3T0G1
         B3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XE9iY0hJgdq2dV/1VmYo0ImfbAW4io/0Oep8pkMLk7I=;
        b=YZk1DFFhhKs6DwvaKKXLlFgiX48uKyrVyZU0psWIoKp3nHboSbL1lL/4X8utyQYEas
         X76zZrVtUu0ScycsXOyvpo6guWjZCTrSxsscR6Hd9MDJsw5FvCBMZvjFSzp1jhPmZFe2
         VwjwxvS5g23T3LXEv/0dDyROrQ0SQaUYpfYmIFY9rsi6chLyL88oF7SrGtFv6rcTQ715
         yf9qNyzR9wupK5FBQ5+PjddtfJkZkTyF1B1ECKGwRcNngQkXLt4LoSsOj7OImEQNeGH9
         mlcQr9Q9rKFRZfSjqM7tasKa/Y79gUewONh/YYAypDsYt4EqsCsinFUv5MYY8dIln5ax
         6Pgw==
X-Gm-Message-State: APjAAAWlnaEztC3wFcdR88LnFDWFh0/dIsQwD8E/8i4eocdh18nWsQJU
        QouXw/OBR4A9Csyf4VZBfV8e/1vg
X-Google-Smtp-Source: APXvYqwFjOI8YA+T3CT/iT8SyNFToX1IioHaZEY1o3uakSPSsVu1WQo97ZEuEN/Yl8RUX1OXL1xCAw==
X-Received: by 2002:a17:902:5988:: with SMTP id p8mr2430747pli.131.1572475411083;
        Wed, 30 Oct 2019 15:43:31 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id v10sm871041pfg.11.2019.10.30.15.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 15:43:30 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:43:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191030224328.GB44961@generichostname>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030202835.GB29013@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
> On Wed, Oct 30, 2019 at 11:39:50AM -0700, Denton Liu wrote:
> 
> > It seems like everyone working on git.git has their own patch management
> > system. Currently, I keep all of my branch-specific configurations
> > (including CC lists) and patches in a worktree within the repo so that I
> > can keep my configs synced around on different computers.
> > 
> > One thing that's missing about this setup is that I would like to
> > version my branch descriptions as well since I use those to generate
> > cover letters. Unfortunately, `git branch --edit-description` only
> > operates on .git/config.

Dscho brought up in the GGG thread[1] that perhaps we want to treat
branch descriptions like notes and have them all under something like
`refs/notes/branches`. This would certainly solve my problem of
having versioned descriptions and it would probably do it in a much more
general way than having a versioned included config.

Anyone see any potential problems with this approach?

> > 
> > As a workaround, I rewrote `git branch --edit-description` as a
> > shell-script that can operate on any config file but I feel like a more
> > general solution should be warranted.
> > 
> > Would changing the option to `git branch --edit-description[=<config>]`
> > make sense, where the `<config>` is optional but if it's specified,
> > it'll operate on that file instead of the .git/config.
> 
> That makes sense to me (though I don't use branch descriptions myself).
> I actually wish a lot of auto-written config (like branch.*.merge) was
> written to a file besides .git/config, and then just included. It would
> make it easier to keep your actual config file cleaner (I usually take
> the opposite route and version-control my own config in a separate file
> that I include from .git/config).

Yeah, I've also wanted the same... I've thought about just symlinking
.git/config away but I think that causes other problems that I don't
want to deal with.

> 
> > Alternately, would it make sense to support a $GIT_CONFIG environment
> > variable globally? That is, when $GIT_CONFIG is specified, git will
> > read/write from $GIT_CONFIG instead of .git/config? It'd be a little
> > heavy-handed for me to make the change just for this one use-case but
> > perhaps people may find other uses for it?
> 
> We used to have such a thing, and it opened a lot of weird corner cases.
> Just thinking about the case you mentioned: would people be confused if
> "GIT_CONFIG=foo git branch --edit-description" doesn't respect
> core.editor specified in .git/config?

I found the original thread that removed the functionality[2]. I'm
probably not going to go with this approach since the notes approach
seems more promising but going back to your question, I think that would
make sense since by specifying GIT_CONFIG, a user is explicitly
overriding .git/config so they should also be aware of the consequences.

Thanks for your thoughts,

Denton

[1]: https://github.com/gitgitgadget/git/issues/438
[2]: https://public-inbox.org/git/alpine.LNX.1.00.0806300328380.19665@iabervon.org/

> 
> -Peff
