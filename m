Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4891F404
	for <e@80x24.org>; Mon, 12 Feb 2018 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbeBLTXc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 14:23:32 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:39695 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeBLTXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 14:23:31 -0500
Received: by mail-pg0-f41.google.com with SMTP id w17so8139084pgv.6
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9yuQZNJGStDr0dpyeCjNpINQ4f5anM6iur2CMpTgBPA=;
        b=Lj2yBaB7qdKskfZkFjiBk4E74+U6pNgq2YERUuEFWqoDfRrjz86IXhkmJN7GSJgNA2
         NmTv1T/N6xpAWFaPsk6hmrt9zRKgfF2vV7avi/bS5R4/IyM6mXn9ysGybpKRgDq1wlgO
         E/gLovVB4scqMUo4XmxMV2IN/xL313QxS0DMyb8MKLJYlW5FrALFzfYErpUJFk7yX+Ht
         UgHm3/Cz9fo6Su5QUMnMSsbbmK4DursocY90780RAnBJCEN9Wew3yKQMFAq5exzGqAjU
         BV6VGa7/SncOSGW2B5gymn5nNhmxp3ppyCrY+WEqGFC2HR8P5UO3hMwrVb/q15RfkaaY
         XbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9yuQZNJGStDr0dpyeCjNpINQ4f5anM6iur2CMpTgBPA=;
        b=FunVyl0etbR5EOj450Hik9h5HqVRGExgP3273UF2DJDwzer1UkOXuhCAsaBqPw7Coq
         N1hCx887BTdoGXsgRkjzWYIUPTNOFphW1SJika7tLhg8HDCITcVrK8ZVoQRxIreexr7R
         QUkB2kT8SwPU7NSEefkL1V7qIbdZMr9JhO8uU1YT3boFCKGaCTxwmEpnZRN23oNShzh4
         Ph16uyr2GogPpM1k+e3edLcsXr1MynCmlW1nfPn47ZnHTNgwIXhOz4FrIi1eAQAJsH7p
         WtYkB6C8hdPBLat/GtIfcAgJ32VEdiMsuSUrIXT1XkOoGKFVzrzERFHLU3/zT5UOmgVo
         z1VA==
X-Gm-Message-State: APf1xPBnEbQ4UqtogfL2yq5U1ox4we20Q9xzpgSG+A1RUuSieC9Cna3l
        p8cmfbk4etaE2qsrz7LUfVUNhg==
X-Google-Smtp-Source: AH8x224HZ8BO0PyBaEmGxLUlpQYfUPb0ZkTeb7vqA2ViwbnkV+tULUXEkSc39zFDRzAOduq7qu8vQg==
X-Received: by 10.99.97.81 with SMTP id v78mr8625576pgb.243.1518463410046;
        Mon, 12 Feb 2018 11:23:30 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 64sm279091pgj.39.2018.02.12.11.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 11:23:29 -0800 (PST)
Date:   Mon, 12 Feb 2018 11:23:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180212192327.GA209601@google.com>
References: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10, Leo Gaspard wrote:
> On 02/10/2018 01:21 PM, Jeff King wrote:
> > On Sat, Feb 10, 2018 at 01:37:20AM +0100, Leo Gaspard wrote:
> > 
> >>> Yeah, tag-following may be a little tricky, because it usually wants to
> >>> write to refs/tags/. One workaround would be to have your config look
> >>> like this:
> >>>
> >>>   [remote "origin"]
> >>>   fetch = +refs/heads/*:refs/quarantine/origin/heads/*
> >>>   fetch = +refs/tags/*:refs/quarantine/origin/tags/*
> >>>   tagOpt = --no-tags
> >>>
> >>> That's not exactly the same thing, because it would fetch all tags, not
> >>> just those that point to the history on the branches. But in most
> >>> repositories and workflows the distinction doesn't matter.
> >>
> >> Hmm... apart from the implementation complexity (of which I have no
> >> idea), is there an argument against the idea of adding a
> >> remote.<name>.fetchTagsTo refmap similar to remote.<name>.fetch but used
> >> every time a tag is fetched? (well, maybe not exactly similar to
> >> remote.<name>.fetch because we know the source is going to be
> >> refs/tags/*; so just having the part of .fetch past the ':' would be
> >> more like what's needed I guess)
> > 
> > I don't think it would be too hard to implement, and is at least
> > logically consistent with the way we handle tags.
> > 
> > If we were designing from scratch, I do think this would all be helped
> > immensely by having more separation of refs fetched from remotes. There
> > was a proposal in the v1.8 era to fetch everything for a remote,
> > including tags, into "refs/remotes/origin/heads/",
> > "refs/remotes/origin/tags/", etc. And then we'd teach the lookup side to
> > look for tags in each of the remote-tag namespaces.
> > 
> > I still think that would be a good direction to go, but it would be a
> > big project (which is why the original stalled).
> 
> Hmm... would this also drown the remote.<name>.fetch map? Also, I think
> this behavior could be emulated with fetch and fetchTagsTo, and it would
> look like:
> [remote "my-remote"]
>     fetch = +refs/heads/*:refs/remotes/my-remote/heads/*
>     fetchTagsTo = refs/remotes/my-remote/tags/*
> The remaining issue being to teach the lookup side to look for tags in
> all the remote-tag namespaces (and the fact it's a breaking change).
> 
> That said, actually I just noticed an issue in the “add a
> remote.<name>.fetch option to fetch to refs/quarantine then have the
> post-fetch hook do the work”: it means if I run `git pull`, then:
>  1. The remote references will be pulled to refs/quarantine/...
>  2. The post-fetch hook will copy the accepted ones to refs/remotes/...
>  3. The `git merge FETCH_HEAD` called by pull will merge FETCH_HEAD into
> local branches... and so merge from refs/quarantine.
> 
> A solution would be to also update FETCH_HEAD in the post-fetch hook,
> but then we're back to the issue raised by Junio after the “*HOWEVER*”
> of [1]: the hook writer has to maintain consistency between the “copied”
> references and FETCH_HEAD.
> 
> So, when thinking about it, I'm back to thinking the proper hook
> interface should be the one of the tweak-fetch hook, but its
> implementation should make it not go crazy on remote servers. And so
> that the implementation should do all this refs/quarantine wizardry
> inside git itself.
> 
> So basically what I'm getting at at the moment is that git fetch should:
>  1. fetch all the references to refs/real-remotes/<name>/{insert here a
> copy of the refs/ tree of <name>}
>  2. figure out what the “expected” names for these references will by,
> by looking at remote.<name>.fetch (and at whether --tags was passed)
>  3. for each “expected” name,
>      1. if a tweak-fetch hook is present, call it with the
> refs/real-remotes/... refname and the “expected end-name” from
> remote.<name>.fetch
>      2. based on the hook's result, potentially to move the “expected
> end-name” to another commit than the one referenced by refs/real-remotes/...
>      3. move the “expected” name to the commit referenced in
> refs/real-remotes
> 
> Which would make the tweak-fetch hook interface simpler (though more
> restrictive, but I don't have any real use case for the other change
> possibilities) than it is now:
>  1. feed the hook with lines of
> “refs/real-remotes/my-remote/heads/my-branch
> refs/remotes/my-remote/my-branch” (assuming remote.my-remote.fetch is
> “normal”) or “refs/real-remotes/my-remote/tags/my-tag refs/tags/my-tag”
> (if my-tag is being fetched from my-remote)
>  2. read lines of “<refspec> refs/remotes/my-remote/my-branch”, that
> will re-point my-branch to <refspec> instead of
> refs/real-remotes/my-remote/heads/my-branch. In order to avoid any
> issue, the hook is not allowed to pass as second output a reference that
> was not passed as second input.
> 
> This way, the behavior of the tweak-fetch hook is reasonably preserved
> (at least for my use case), and there is no additional load on the
> servers thanks to the up-to-date references being stored in
> refs/real-remotes/<name>/<refspec>
> 
> Does this reasoning make any sense?
> 
> 
> [1] https://marc.info/?l=git&m=132478296309094&w=2


Maybe this isn't helpful but you may be able to implement this by using
a remote-helper.  The helper could perform any sort of caching it needed
to prevent re-downloading large amounts of data that is potentially
thrown away, while only sending through the relevant commits which
satisfy some criteria (signed, etc.).

-- 
Brandon Williams
