Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4456E1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeGRR7N (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:59:13 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:55387 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGRR7N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:59:13 -0400
Received: by mail-it0-f49.google.com with SMTP id 16-v6so5211731itl.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=APqWzRTKr/uGu7tMunZUvUdFwZQrBBJZzJkm2ejlvkQ=;
        b=uqBBZJKztRb1exmaPRLCf/hu3ycQIJtD0RiK2BmljqdjD5ll2q8WC28oR4Z6CoF9Wt
         1vQPR8ncuZ4dBBGp5Rev4By0k0lzwwmZKfatmcazM1kEpUHNHJND4GKma+j9AQj+zS7E
         1NVugs30I/txsGoecxJtW7Ivlk73NTtnTxdLzoAeojw0KHIyfmQQlzNbV5O9m/wjj7NY
         ZPFPtpDFea7APcgXke7sebsOz1fWY/IRuTcdZpEbbuA/KMrddgPumWDry1tOX8Q1pBjC
         +6u/OqtEEpI+Db5kJR2Q2XLIqcmi32Qd9dc+l4Ll1yqkVzJU5+sfHtf2ibknCQTMGReM
         qgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APqWzRTKr/uGu7tMunZUvUdFwZQrBBJZzJkm2ejlvkQ=;
        b=UU9AbGXvVwK5UxWtYTxHltfADY+wTPfby4cIWftUe9LgJaA1O51z1MIexQsksy4ZFH
         imQj/P9W/Ln5Mxpmq4QRiAtNrMZpCH7SkGFdnY9stxSyQ2amU3CEfXtyKaS8+NqG4gTn
         KKOVzTj0xE1jpfi9zaTrLO/UsOr9JcTbZt8JLu0d7Lq11fLl4d09HFLBuRO4ec3nwRea
         xFjI38R+IGDAKT3SsFwijVLqoqvPukYzTBo7BNdKKVaVO1LE1zrtg0feeChecbzvM4D6
         eBzd+VU/upkW7ug1X8ySg12PpvJNuaVlLv1vm8lve4cQ5Z9UjfZddhw1SXJ4TK4GCnMh
         L0ug==
X-Gm-Message-State: AOUpUlG5/m+SDUi/6Ca7eAWsG8S/9b5xcBC4/y7lGkiwd6vkMEd0dl+1
        myo9J/tiIinfhXjVYE7Ee6YyI70TYyz6SSKM58M=
X-Google-Smtp-Source: AAOMgpe9lserm7IQ64aWYZ83TsCqu5IhsSaVHjOK6MDL3dbJ+kSrilLuqY5nwkrDdszDcpqZktEgYSu4wNele5qWu2A=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr1514547itc.68.1531934419594;
 Wed, 18 Jul 2018 10:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com> <20180718171127.GB17137@google.com>
In-Reply-To: <20180718171127.GB17137@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Jul 2018 19:19:53 +0200
Message-ID: <CACsJy8DaeUWo1qmgyxZ_9kuKLyRP+m1kgNGkoj6LtOMTknvEYQ@mail.gmail.com>
Subject: Re: [RFC] push: add documentation on push v2
To:     Brandon Williams <bmwill@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 7:13 PM Brandon Williams <bmwill@google.com> wrote:
> > > > What I've got now is a rough design for a more flexible push, more
> > > > flexible because it allows for the server to do what it wants with the
> > > > refs that are pushed and has the ability to communicate back what was
> > > > done to the client.  The main motivation for this is to work around
> > > > issues when working with Gerrit and other code-review systems where you
> > > > need to have Change-Ids in the commit messages (now the server can just
> > > > insert them for you and send back new commits) and you need to push to
> > > > magic refs to get around various limitations (now a Gerrit server should
> > > > be able to communicate that pushing to 'master' doesn't update master
> > > > but instead creates a refs/changes/<id> ref).
> > > Well Gerrit is our main motivation, but this allows for other workflows as well.
> > > For example Facebook uses hg internally and they have a
> > > "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> > > brings up quite some contention. The protocol outlined below would allow
> > > for such a workflow as well? (This might be an easier sell to the Git
> > > community as most are not quite familiar with Gerrit)
> >
> > I'm also curious how this "change commits on push" would be helpful to other
> > scenarios.
> >
> > Since I'm not familiar with Gerrit: what is preventing you from having a
> > commit hook that inserts (or requests) a Change-Id when not present? How can
> > the server identify the Change-Id automatically when it isn't present?
>
> Right now all Gerrit users have a commit hook installed which inserts
> the Change-Id.  The issue is that if you push to gerrit and you don't
> have Change-ids, the push fails and you're prompted to blindly run a
> command to install the commit-hook.  So if we could just have the server
> handle this completely then the users of gerrit wouldn't ever need to
> have a hook installed in the first place.

I don't trust the server side to rewrite commits for me. And this is
basically rewriting history (e.g. I can push multiple commits to
gerrit if I remember correctly; if they all don't have change-id, then
the history must be rewritten for change-id to be inserted). Don't we
already have "plans" to push config from server to client? There's
also talk about configuring hooks with config file. These should make
it possible to deal with change-id generation with minimum manual
intervention.
-- 
Duy
