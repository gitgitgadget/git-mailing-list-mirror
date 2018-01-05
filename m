Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF161F404
	for <e@80x24.org>; Fri,  5 Jan 2018 05:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeAEFGy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 00:06:54 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:40681 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeAEFGx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 00:06:53 -0500
Received: by mail-it0-f53.google.com with SMTP id f190so308731ita.5
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 21:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WlDWwXibisvqFIy6xl3JV6vgDqr9ZhzwTasucj77ivk=;
        b=YWqm6CTZaSn/Ovff6TWT6D6jLMAs2BW+UZq4kizrHyfePPI0EVV4q7+W9ksdCZiniM
         pFwOtonU9wCyo938D3uifdDSfy38F1S5uWgxwAOD0gMgDyDz8WWo71i3EPkUENGgn7h/
         ULjyC71pEJHQRLqN9tJjgl0A3eJ+REzg21jLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WlDWwXibisvqFIy6xl3JV6vgDqr9ZhzwTasucj77ivk=;
        b=dgF1QCTx+/aQn9vz+Yd/oqW9hi0sDBD5spuUa84fYZdGd4psKIU+vTnpirxSonOCcH
         UNkJ27+BHTcKVPt5Mtvwj4/3yUb/Okoz6t+ukTyow9ov5O4R4fNCtFq/5AS9odyuD/7K
         acJNyaqwSmDH1Xo2CPhkU46ZW7u/7W21Lm5oysvUwbpjcq4Vy5HKH9OqGI8dMfpyMaYV
         R9fzayXFDH6JWbti8dq5BXstauNR9OxY67jVEh40aYQCbYlhfiJdoZc2F6vbTyzPYWn6
         LB2++Ulsn5Zrd31a3a+41YrlJluuKV1dIzPrlpg957mWDz57bBBkt++K2iOR/o22e3Z3
         329A==
X-Gm-Message-State: AKGB3mKYNV54h3/WdiwzDoDB1jVypDR6hE4dwVopnzoVskZMfDBqCHjy
        JPYi+X7tPUuLm45y6AGWVGcYPfMArnA=
X-Google-Smtp-Source: ACJfBotLIu25ZHFBRPT2MKoBFSLNzyaqDHtYNm4UMFKViy4CevvBfMrIrWHbCPk77MenPNchv1wiYA==
X-Received: by 10.36.169.9 with SMTP id r9mr1995206ite.137.1515128812864;
        Thu, 04 Jan 2018 21:06:52 -0800 (PST)
Received: from Carl-MBP.local ([2601:282:8001:ffba:f0d7:a5cd:e618:32a7])
        by smtp.gmail.com with ESMTPSA id e7sm2979212ita.17.2018.01.04.21.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 21:06:52 -0800 (PST)
Date:   Thu, 4 Jan 2018 22:06:50 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180105050647.GB12861@Carl-MBP.local>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171226180436.GA28565@thunk.org>
 <20171226203153.GA21429@Carl-MBP.ecbaldwin.net>
 <45915667.ye9M3CbBo5@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45915667.ye9M3CbBo5@mfick-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 01:06:27PM -0700, Martin Fick wrote:
> On Tuesday, December 26, 2017 01:31:55 PM Carl Baldwin 
> wrote:
> ...
> > What I propose is that gerrit and github could end up more
> > robust, featureful, and interoperable if they had this
> > feature to build from.
> 
> I agree (assuming we come up with a well defined feature)
> 
> > With gerrit specifically, adopting this feature would make
> > the "change" concept richer than it is now because it
> > could supersede the change-id in the commit message and
> > allow a change to evolve in a distributed non-linear way
> > with protection against clobbering work.
> 
> We (the Gerrit maintainers) would like changes to be able to 
> evolve non-linearly so that we can eventually support 
> distributed Gerrit reviews, and the amended-commit pointer 
> is one way I have thought to resolve this.

I really think that keeping these references is the key to doing this.

> > I have no intention to disparage either tool. I love them
> > both. They've both made my career better in different
> > ways. I know there is no guarantee that github, gerrit,
> > or any other tool will do anything to adopt this. But,
> > I'm hoping they are reading this thread and that they
> > recognize how this feature can make them a little bit
> > better and jump in and help. I know it is a lot to hope
> > for but I think it could be great if it happened.
> 
> We (the Gerrit maintainers) do recognize it, and I am glad 
> that someone is pushing for solutions in this space.  I am 
> not sure what the right solution is, and how to modify 
> workflows to deal better with this.  I do think that starting 
> by making your local repo track pointers to amended-commits, 
> likely with various git hooks and notes (as also proposed by 
> Johannes Schindelin), would be a good start.   With that in 
> place, then you can attack various specific workflows.

I have started a prototype that I will use to demonstrate this. I hope
to have something in a couple of weeks. I do have a day job also, so it
will be slow going. One idea that I had was to put my own server with
special hooks in it in front of gerrit to illustrate how collaboration
on a gerrit change, or even a chain of them, can be made safe. It would
act as a middle man between my client and the gerrit server. I'd just
have to change remote reference on my client to demonstrate.

> If you want to then attack the Gerrit workflow, it would be 
> good if you could prevent pushing new patchests that are 
> amended versions of patchsets that are out of date.  While 
> it would be great if Gerrit could reject such pushes, I 
> wonder if to start, git could detect and it prevent the push 
> in this situation?  Could a git push hook analyze the ref 
> advertisements and figure this out (all the patchsets are in 
> the advertisement)?  Can a git hook look at the ref 
> advertisement?

I'll think about this. At the least, the hook would have to look at the
server to see if there are new revisions. It would be difficult to close
race conditions that occur because the client will always be using
potentially out of date information even if it just went and pulled down
the latest stuff. I think I still like my middle man idea better as a
short term proof of concept.

Preventing pushing amended/rebased versions of out of date changes is
simple. Follow the "predecessor" references until you hit a known
commit. If that commit is the latest revision of the change then it is
up to date. If that commit not the latest revision, then it is out of
date. Reject it. This is what I plan to illustrate in my middle man
server.

If you traverse the entire graph of predecessors without finding a known
commit, then you have a new change. (In fact, the changeset id in the
commit message in a gerrit change seems unnecessary at this point). It
gets a little more complicated when you think about combining/squashing
changes (resulting in two or more "predecessor" references from a single
commit) or dividing a change into multiple but it works.

The harder part is the push/pull interaction between client and server.
When you go to push your amended update to a patchset, you want git to
send along any other new commits to complete the predecessor graph on
the server side. For example, you might rebase your commit and then
amend it to fix something. Personally, I'd like the rebase and the amend
to both be kept separately.

Similarly, when you've just had a push rejected because you're out of
date, you want to be able to easily pull down the commits you're missing
so that you can merge locally and try to push again.

You also don't want gc to garbage collect the intermediate commits. I
think gerrit uses many references internally in the git repo to "pin"
older revisions in the repository so that they don't appear orphaned. I
think I'm going to have to do something similar in my prototype.

If you think about it, this is all very much like what git already does
with its commit history and branches. If you stick to a strict
branch/merge model and don't rewrite commits, then it is unnecessary.
However, for those that do rewrite commits (such as anyone using the
gerrit workflow), this is a way to bring that power to them.

I'd like to point out the RECOVERING FROM UPSTREAM REBASE section of the
git-rebase man page. If we have the graph of "predecessor" references
for a change, it could be used to automatically recover from the cases
described in this section much like regular branching and merging.
Rewriting changes would no longer be something to consider "a bad idea"
for these reasons.

Carl
