Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469731F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeGRShE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:37:04 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:56297 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbeGRShD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:37:03 -0400
Received: by mail-it0-f45.google.com with SMTP id 16-v6so5375028itl.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMOZg+J2CG3tz03X4dQwriTtRdlYpqdFXV4JHgCydzw=;
        b=FaCi+NGcrB59dgpvuOHHHBBXFJj2po/jkbHXeOsdjTBuWGbhwVh3Z9ftvq4Q5slX6y
         ZfUPDTnSmOYVOgqJMAT6pzItEGMafabGIBGKXE2MUsFGCzbvrE61XTHkybhtnLHo8kwD
         MEUp3sccyNyIPQxdR4mWHptHwJZeGlCGM+DUrYWB2PBzEZwjBR7iLZFXS3lHvS5HnZR6
         YfZyZPtPj+lPscscqR2I1+B81KVbhcXlUeT01orjZooVNCVbHOAib2E3lCh0mRrQeOMg
         Hl3os7/T52uQq/d2eiZN5JUO2GLUFlE2QIoKd1ojNM3Jc7Xj832XF/X/wenTdAvPPCO7
         6Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMOZg+J2CG3tz03X4dQwriTtRdlYpqdFXV4JHgCydzw=;
        b=B+rl1ct2TTzfatzAkhQTZpHnbc2NGyg65sCmYjjETMIzp3eiZM/Qdscl3BhHowlZiM
         Trf7sTdI62JW/ol1wMwYavnBwpfgbfM7VIog7Vd792vZTTT0oZc1Scul7kfmRy0AfmKp
         R9JBnr5orSKXAk1HIvJp1Vo7iYKCIB/9SK25DmESv1ZINTMnznRyNLXX1ohk1Ar/Rmbx
         ySTAD758i8F4iLehwJVyLZIFFeMQQz6h/rCulOOTHDyH6u5o4tBY16hi0UP5ye+Ny4AY
         MsZyykmZQEXeLLSdOjMZuOsX45JVA3t1H1eBDPz0x5cH3+CLjIyv278VyUHB/ytRByhp
         135w==
X-Gm-Message-State: AOUpUlHClLY1BscthLTE6J6NSQaVgBr/cAyQcAklOl3TuiPJf/Y1vTBt
        P3Cm5XJjDZtcMgOWJuAFx1JOADWYSeFGmmGwhx6rbg==
X-Google-Smtp-Source: AAOMgpdT9JPDA2M8gqxoRL/Qb8yg3nX/UzBfs3uVtpUSaLYhONOuSN48NH8FhFN3cJzN8knb7mT8FwwY/9ACOrW2PZw=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr1626541itc.68.1531936680941;
 Wed, 18 Jul 2018 10:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180717210915.139521-1-bmwill@google.com> <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com> <20180718171127.GB17137@google.com>
 <CACsJy8DaeUWo1qmgyxZ_9kuKLyRP+m1kgNGkoj6LtOMTknvEYQ@mail.gmail.com> <20180718174654.GD17137@google.com>
In-Reply-To: <20180718174654.GD17137@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Jul 2018 19:57:34 +0200
Message-ID: <CACsJy8A=ie_HrBzvvbbOmNVWKisBH8mbYYJYSsE3G+9k47XqdA@mail.gmail.com>
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

On Wed, Jul 18, 2018 at 7:46 PM Brandon Williams <bmwill@google.com> wrote:
>
> On 07/18, Duy Nguyen wrote:
> > On Wed, Jul 18, 2018 at 7:13 PM Brandon Williams <bmwill@google.com> wrote:
> > > > > > What I've got now is a rough design for a more flexible push, more
> > > > > > flexible because it allows for the server to do what it wants with the
> > > > > > refs that are pushed and has the ability to communicate back what was
> > > > > > done to the client.  The main motivation for this is to work around
> > > > > > issues when working with Gerrit and other code-review systems where you
> > > > > > need to have Change-Ids in the commit messages (now the server can just
> > > > > > insert them for you and send back new commits) and you need to push to
> > > > > > magic refs to get around various limitations (now a Gerrit server should
> > > > > > be able to communicate that pushing to 'master' doesn't update master
> > > > > > but instead creates a refs/changes/<id> ref).
> > > > > Well Gerrit is our main motivation, but this allows for other workflows as well.
> > > > > For example Facebook uses hg internally and they have a
> > > > > "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> > > > > brings up quite some contention. The protocol outlined below would allow
> > > > > for such a workflow as well? (This might be an easier sell to the Git
> > > > > community as most are not quite familiar with Gerrit)
> > > >
> > > > I'm also curious how this "change commits on push" would be helpful to other
> > > > scenarios.
> > > >
> > > > Since I'm not familiar with Gerrit: what is preventing you from having a
> > > > commit hook that inserts (or requests) a Change-Id when not present? How can
> > > > the server identify the Change-Id automatically when it isn't present?
> > >
> > > Right now all Gerrit users have a commit hook installed which inserts
> > > the Change-Id.  The issue is that if you push to gerrit and you don't
> > > have Change-ids, the push fails and you're prompted to blindly run a
> > > command to install the commit-hook.  So if we could just have the server
> > > handle this completely then the users of gerrit wouldn't ever need to
> > > have a hook installed in the first place.
> >
> > I don't trust the server side to rewrite commits for me. And this is
>
> That's a fair point.  Though I think there are a number of projects
> where this would be very beneficial for contributors. The main reason
> for wanting a feature like this is to make the UX easier for Gerrit
> users (Having server insert change ids as well as potentially getting
> rid of the weird HEAD:refs/for/master syntax you need to push for
> review).  Also, if you don't control a server yourself, then who ever
> controls it can do what it wants with the objects/ref-updates you send
> them.  Of course even if they rewrite history that doesn't mean your
> local copy needs to mimic those changes if you don't want them too.  So
> even if we move forward with a design like this, there would need to be
> some config option to actually accept and apply the changes a server
> makes and sends back to you.

This is the main pain point for me. I almost wrote a follow mail along
the line of "having said that, if we can be transparent what the
changes are or have some protection  at client side against
"dangerous" changes like tree/blob/commit-header replacement then it's
probably ok".

There's also other things like signing which will not work well with
remote updates like this. I guess you can cross it out as "not
supported" after consideration though.

> This RFC doesn't actually address those
> sorts of UX implications because I expect those are things which can be
> added and tweaked at some point in the future.  I'm just trying to build
> the foundation for such changes.

Speaking of UX, gerrit and this server-side ref-update. My experience
with average gerrit users is they tend to stick to a very basic set of
commands and if this is not handled well, you just replace the
one-time pain of installing hooks with a new one that happens much
more often, potentially more confusing too.

> > basically rewriting history (e.g. I can push multiple commits to
> > gerrit if I remember correctly; if they all don't have change-id, then
> > the history must be rewritten for change-id to be inserted). Don't we
> > already have "plans" to push config from server to client? There's
>
> I know there has been talk about this, but I don't know any of any
> current proposals or work being done in this area.

As far as I know, nobody has worked on it. You're welcome to start of course ;-)
-- 
Duy
