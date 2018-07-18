Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64301F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGRSZ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:25:56 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39985 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbeGRSZz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:25:55 -0400
Received: by mail-pg1-f175.google.com with SMTP id x5-v6so2322048pgp.7
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AjSu3XMtThcSfMpKcjEbGri0q0ET7L33L3eTXHWkbuA=;
        b=WE2rA5ukKH2eLWh5yZUJKrai29uVcIocg8G2DaWnga943zc48C3znWeSoMiGCdiTRf
         kdA367UpLbCAHIItczstNoIxch7gPXO4R4VwHMMQu6EERnZKMbRQGl3EsjTa8xVenAM3
         zERm789PB9jOQ5qP6pBDkeqOHIgUUZk93BVpqa+LKjAA2x2ZnSulSFpEa6sVT6OK9Khk
         lGsqwjQhxxPLD0WYZ9LIixaNN9WDHc11lK4fKUEl5krH/fH+/GdxmbCyQUZJDUR8HGzr
         0bJkLpH40+goDiYwqrISf9wWnCFykOxdJ6Q7oS3Jr5682FdXDwqbxAIlLjr9vDdDfkj6
         505Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AjSu3XMtThcSfMpKcjEbGri0q0ET7L33L3eTXHWkbuA=;
        b=ShXV/FspMKD3UGqUdtaOfAdg40S/1qa1kq8q3AR8jVOsW3sc+ElCvxohbI9vrO65av
         1ELZnnUK7JUBpTKL52Hz8wylNdEHQnFONcUkZYz1f52UE9HgiY520xwR7/KAkjcTQ+J2
         boZXy4WePBV7MxmzmvW/mOnjmQ2ZUobT/hvEgLyb6MI9Gdo8httIKw4StsJZeO3RM6NL
         32wQzLy/ojvybpSC3fgO4jIhsepZjJpuKFnsOwH6lU5UlkgNnrsG0Be4O3r+S9WZyUzZ
         8eoBLvqBrcbzdZ6CWwEQHf5f+vmJ14uD8XDsZ/1ZUrTKmYbmD+oi9MCTymVt1A9iFYc2
         3pcw==
X-Gm-Message-State: AOUpUlGDPp5oesvTnfvvzHk7E8B2MdwYlpgJ2i2fIZsmdu1p86DWj9Y8
        youkI29nTjkIwr5b4fI8HsYvXg==
X-Google-Smtp-Source: AAOMgpcmbhBrIMhjiDfd5UQzlXo6SYUQJ//dCxvxPzSEdXpJfv8R7JNB+YtWMf0r7+PwTFEKBaaldA==
X-Received: by 2002:a63:7b4d:: with SMTP id k13-v6mr6685299pgn.64.1531936016662;
        Wed, 18 Jul 2018 10:46:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r25-v6sm5550278pge.81.2018.07.18.10.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:46:55 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:46:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180718174654.GD17137@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
 <20180718171127.GB17137@google.com>
 <CACsJy8DaeUWo1qmgyxZ_9kuKLyRP+m1kgNGkoj6LtOMTknvEYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DaeUWo1qmgyxZ_9kuKLyRP+m1kgNGkoj6LtOMTknvEYQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/18, Duy Nguyen wrote:
> On Wed, Jul 18, 2018 at 7:13 PM Brandon Williams <bmwill@google.com> wrote:
> > > > > What I've got now is a rough design for a more flexible push, more
> > > > > flexible because it allows for the server to do what it wants with the
> > > > > refs that are pushed and has the ability to communicate back what was
> > > > > done to the client.  The main motivation for this is to work around
> > > > > issues when working with Gerrit and other code-review systems where you
> > > > > need to have Change-Ids in the commit messages (now the server can just
> > > > > insert them for you and send back new commits) and you need to push to
> > > > > magic refs to get around various limitations (now a Gerrit server should
> > > > > be able to communicate that pushing to 'master' doesn't update master
> > > > > but instead creates a refs/changes/<id> ref).
> > > > Well Gerrit is our main motivation, but this allows for other workflows as well.
> > > > For example Facebook uses hg internally and they have a
> > > > "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> > > > brings up quite some contention. The protocol outlined below would allow
> > > > for such a workflow as well? (This might be an easier sell to the Git
> > > > community as most are not quite familiar with Gerrit)
> > >
> > > I'm also curious how this "change commits on push" would be helpful to other
> > > scenarios.
> > >
> > > Since I'm not familiar with Gerrit: what is preventing you from having a
> > > commit hook that inserts (or requests) a Change-Id when not present? How can
> > > the server identify the Change-Id automatically when it isn't present?
> >
> > Right now all Gerrit users have a commit hook installed which inserts
> > the Change-Id.  The issue is that if you push to gerrit and you don't
> > have Change-ids, the push fails and you're prompted to blindly run a
> > command to install the commit-hook.  So if we could just have the server
> > handle this completely then the users of gerrit wouldn't ever need to
> > have a hook installed in the first place.
> 
> I don't trust the server side to rewrite commits for me. And this is

That's a fair point.  Though I think there are a number of projects
where this would be very beneficial for contributors. The main reason
for wanting a feature like this is to make the UX easier for Gerrit
users (Having server insert change ids as well as potentially getting
rid of the weird HEAD:refs/for/master syntax you need to push for
review).  Also, if you don't control a server yourself, then who ever
controls it can do what it wants with the objects/ref-updates you send
them.  Of course even if they rewrite history that doesn't mean your
local copy needs to mimic those changes if you don't want them too.  So
even if we move forward with a design like this, there would need to be
some config option to actually accept and apply the changes a server
makes and sends back to you.  This RFC doesn't actually address those
sorts of UX implications because I expect those are things which can be
added and tweaked at some point in the future.  I'm just trying to build
the foundation for such changes.

> basically rewriting history (e.g. I can push multiple commits to
> gerrit if I remember correctly; if they all don't have change-id, then
> the history must be rewritten for change-id to be inserted). Don't we
> already have "plans" to push config from server to client? There's

I know there has been talk about this, but I don't know any of any
current proposals or work being done in this area.

> also talk about configuring hooks with config file. These should make
> it possible to deal with change-id generation with minimum manual
> intervention.

-- 
Brandon Williams
