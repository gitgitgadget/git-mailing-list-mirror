Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4081F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeBIL1T (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:27:19 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35853 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBIL1S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:27:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id f3so15657195wmc.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myW+L0GBWgahpbMCtCvbq6/HiDq9NBAkKgCoLvpfsvs=;
        b=nISERhrltX+JBR3ITg34/IsB0nG+aCr2IPuiQh9ovz2rEpnDFpGTt3JdzGLWfMSfuh
         znYtlttEqnVm3RM8YofJg6XK5FZG/mc+PeTNH/PGQR3kAGbIB4RuNXZDybghvNFa9RdF
         deRxXyKLCWwFmaPj+yZbgA6R+6y8UWTdE0uCrvKkYiJY+kBm1xruo3IsGt78+xaauJx1
         F0Hj9AIiBiOuIQPLhajzOu8QCd/aNyXqIqgW+DK7TzPYMf/WpJz0gkJITGWpsXGj2V8V
         nGP5Kp2K+T7nedAKOqBX4RSiRBNjKVaV8iqywkjWe+qeJ5vzlV9n4mg34ZnSugn0PCUn
         lJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myW+L0GBWgahpbMCtCvbq6/HiDq9NBAkKgCoLvpfsvs=;
        b=OYCCqB1yNFp5k3D/aX7qjeqLpQdvRMjnvdVLBnoDH4kEcCnKuH9jpBxv8El5sgYyfU
         zQN78dtGBTACueqc3Wo55VNga4QOXv+WIVL91XW1iQqdFbMAvt0pHHN82i8MHAZgW0fM
         T55YwfbzUAqZAucl2ZuTXsZxQOPHVj4A0dOUm4cGU7kqtzvnqcINSTgELaEmUUbp5zea
         nQbqUsbxXh0gS68Jtz2rCUeHUrfhperA0vWr8XgEMvOZ7tMg7spxGa0r8gKbxy3zQkwO
         webGlSrypeZKAvNoaEq+M59tUvcrZ+G7VvpwD5l1iFjRquHOIGYzV/Pr8jmjbYqJ29JH
         giPw==
X-Gm-Message-State: APf1xPD1uxu0H9g/B5fPIIwYGykkwVoc4PvYcRxq5MgYF3HaIxysZMpo
        gSnAnY7qCt8CgutFy78TJNrTLf7G
X-Google-Smtp-Source: AH8x225S5u+ccYNz2WjHw7cENWNqWxmSrDEKZlreOw+XPVbg9upagpSviljnvZ8Wbr9p9bLy3++oTg==
X-Received: by 10.28.182.86 with SMTP id g83mr1713763wmf.75.1518175637182;
        Fri, 09 Feb 2018 03:27:17 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p10sm2656966wrh.96.2018.02.09.03.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 03:27:16 -0800 (PST)
Date:   Fri, 9 Feb 2018 11:27:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new
 worktree
Message-ID: <20180209112727.GG2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-2-t.gummerer@gmail.com>
 <20180205021202.GA17847@duynguyen.dek-tpc.internal>
 <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07, Eric Sunshine wrote:
> On Sun, Feb 4, 2018 at 9:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > As a former translator, I'm not thrilled to see a sentence broken into
> > two pieces like this. I'm not a Japanese translator, but I think this
> > sentence is translated differently when the translator sees the whole
> > line "Preparing ..., setting ...".
> >
> > I think the purpose of "Preparing..." in the first place is to show
> > something when git is busy checkout out the worktree. As long as we
> > print it before git-reset, we should be good.
> 
> The original message was "Enter <worktree>" which had the potential to
> confuse someone into thinking the working directory had changed[1], so
> it was changed to "Preparing...". The reason for keeping that message
> (rather than dropping it outright) was to provide context to messages
> printed after it, especially messages such as "HEAD is now at..."
> which might otherwise confuse the reader into thinking that HEAD in
> the current worktree changed rather than HEAD in the new
> worktree[2,3].

Thanks for the background!  In that light, since we're already
customizing the "HEAD is now at..." message, is it worth dropping the
message now, maybe using something like "Worktree HEAD is now at ...",
or something similar?

This would loose the information about the identifier of the worktree,
but from a coarse look at the man page it doesn't seem like we
advertise that widely (The only thing related to it I could find is

    If the last path components in the working tree's path is unique among
    working trees, it can be used to identify worktrees. For example if
    you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
    then "ghi" or "def/ghi" is enough to point to the former working tree.

for which we don't need to print the identifier anywhere.  We don't
seem to mention the case where the last part is unique, and we add a
number to make the identifier unique.

So given that maybe it would even be better to hide the part about the
identifier, as it seems more like an implementation detail than
relevant to the end user?

> [1]: https://public-inbox.org/git/55A8F4B1.9060304@drmicha.warpmail.net/
> [2]: https://public-inbox.org/git/CAPig+cRSHwmmF9cCUbRrDCCW4kvg9PeOUxP5VQpSGfxzMxHWOQ@mail.gmail.com/
> [3]: https://public-inbox.org/git/CAPig+cSLs4-uKicVMBSKnEro_FYD722Hs1_U6qzTriM8Ciok2Q@mail.gmail.com/
