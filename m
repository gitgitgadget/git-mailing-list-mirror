Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417AE1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 04:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdL0Ef5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 23:35:57 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:38303 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbdL0Eft (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 23:35:49 -0500
Received: by mail-it0-f50.google.com with SMTP id r6so24436955itr.3
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 20:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qt9e8pZ8p0k0BTUFfglxjLrylcIa8cLsIbmICOxrznk=;
        b=P+oihC6NnNcX5kAhMqoJ/pjsIpY4Q7o+sQXl+XH0PORhrWDZ7RSQ80wLDnN6n+URah
         1RXhMguOKYJvBKUanwPGqV+PnSja8yMaDgbFPPjNEywEzEYuxSGUsnLgSkR5xNG+23f4
         rLavGbz2RkBVo6pVvvT4LNBVtJNjEbkhIOXe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qt9e8pZ8p0k0BTUFfglxjLrylcIa8cLsIbmICOxrznk=;
        b=pqQniEqxTvEJs06MAziNLbvQG+MYDcsVenfv+gr2gMPm3j+mFZBb+bfmH7HAWbFZn6
         6ZqvJFHpxhAHtCpwzeNNNeMrAAaX/MAuHUOelxovL4A8iFxPQkqCmdFoqNYsaWGfGNWl
         OFe8ao2OBcrRvU3sWY4voQ2ILYmnGTsxClDGzzqATyU1H+rs+qJD5AZjTITyqnfr8EM4
         JvMXSL3kYVucHA9MgGOJnPYq4L++9r4CAo4aNatscHMK9lu/msIUENuF7hfKriDvw9q0
         6+A/IGAo21PzIjZqBAw6+ZMV/iHjplIXDyKDSFS5pF7iBpSF1sKdcV/dsN7WK9O3f15E
         yjxQ==
X-Gm-Message-State: AKGB3mKYxvx238Dut9pZDP70jFsxqs+Th+1Iq8iHLq58UgEo98Gw02h6
        2v5VeKqqxoAdmJ0ofgpZUVQ4yOF3Yi4=
X-Google-Smtp-Source: ACJfBotudUEswuqWRPgaeRjGfMKDJlklu4zX5BgetwKAg3nwE59CUiVR2A+ThSk4kfcjNZY5yWlnRg==
X-Received: by 10.36.79.75 with SMTP id c72mr34548195itb.146.1514349348327;
        Tue, 26 Dec 2017 20:35:48 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:59aa:140c:4d30:a473])
        by smtp.gmail.com with ESMTPSA id j194sm10311714ite.7.2017.12.26.20.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 20:35:47 -0800 (PST)
Date:   Tue, 26 Dec 2017 21:35:46 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171227043544.GB26579@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171225035215.GC1257@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 24, 2017 at 10:52:15PM -0500, Theodore Ts'o wrote:
> Here's another potential use case.  The stable kernels (e.g., 3.18.y,
> 4.4.y, 4.9.y, etc.) have cherry picks from the the upstream kernel,
> and this is handled by putting in the commit body something like this:
> 
>     [ Upstream commit 3a4b77cd47bb837b8557595ec7425f281f2ca1fe ]

I think replaces could apply to cherry picks like this too. The more I
think about it, I actually think that replaces isn't a bad name for it
in the cherry pick context. When you cherry pick a commit, you create a
new commit that is derived from it and stands in for or replaces it in
the new context. It is a stretch but I don't think it is that bad.

You can tell that it is a cherry pick because the referenced commit's
history is not reachable in the current context.

Though we could consider some different names like "derivedfrom",
"obsoletes", "succeeds", "supersedes", "supplants"

> ----
> 
> And here's yet another use case.  For internal Google kernel
> development, we maintain a kernel that has a large number of patches
> on top of a kernel version.  When we backport an upstream fix (say,
> one that first appeared in the 4.12 version of the upstream kernel),
> we include a line in the commit body that looks like this:
> 
> Upstream-4.12-SHA1: 5649645d725c73df4302428ee4e02c869248b4c5
> 
> This is useful, because when we switch to use a newer upstream kernel,
> we need make sure we can account for all patches that were built on
> top of the 3xx kernel (which might have been using 4.10, for the sake
> of argument), to the 4xx kernel series (which might be using 4.15 ---
> the version numbers have been changed to protect the innocent).  This
> means going through each and every patch that was on top of the 3xx
> kernel, and if it has a line such as "Upstream 4.12-SHA1", we know
> that it will already be included in a 4.15 based kernel, so we don't
> need to worry about carrying that patch forward.

Are 3xx and 4xx internal version numbers? If I understand correctly, in
your example, 3xx is the heavily patched internal kernel based on 4.10
and 4xx is the internal patched version of 4.15. I think I'm following
so far.

Let's say that you used a "replaces" reference instead of your
"Upstream-4.12-SHA1" reference. The only piece of metadata that is
missing is the "4.12" of your string. However, you could replicate this
with some set arithmetic. If the sha1 referred to by "replaces" exists
in the set of commits reachable from 4.15 then you've answered the same
question.

> In other cases, we might decide that the patch is no longer needed.
> It could be because the patch has already be included upstream, in
> which case we might check in a commit with an empty patch body, but
> whose header contains something like this in the 4xx kernel:
> 
> Origin-3xx-SHA1: fe546bdfc46a92255ebbaa908dc3a942bc422faa
> Upstream-Dropped-4.11-SHA1: d90dc0ae7c264735bfc5ac354c44ce2e

So, the first reference is the old commit that patched the 3xx series?
What is the second reference? What is "4.11" indicating? Is that the
patch that was included in the upstream kernel that obsoleted your 3xx
patch?

If I understood that correctly. You could use a "replaces" reference for
the first line and the second line would still have to be included as a
separate header in your commit message? Does this mean "replaces" is not
useful in your case? I don't think so.

> Or we could decide that the commit is no longer no longer needed ---

no longer no longer needed? Is this a double negative indicating that it
is needed again? Or, is it a mistake?

> perhaps because the relevant subsystem was completely rewritten and
> the functionality was added in a different way.  Then we might have
> just have an empty commit with an explanation of why the commit is no
> longer needed and the commit body would have the metadata:
> 
> Origin-Dropped-3xx-SHA1: 26f49fcbb45e4bc18ad5b52dc93c3afe

The metadata in this reference indicates that it was dropped since 3xx.
Doesn't the empty body (and maybe a commit message saying dropping a
patch) indicate this if a "references" pointer were used instead? The
3xx part of the metadata could be derived again by set arithmetic.

> Or perhaps the commit is still needed, and for various reasons the
> commit was never upstreamed; perhaps because it's only useful for
> Google-specific hardware, or the patch was rejected upstream.  The we
> will have a cherry-pick that would include in the body:
> 
> Origin-3xx-SHA1: 8f3b6df74b9b4ec3ab615effb984c1b5

Replaces reference and set arithmetic.

> (Note: all commits that are added in the rebase workflow, even the
> empty commits that just have the Origin-Dropped-3xx-SHA1 or
> Upstream-Droped-4.11-SHA1 headers, are patch reviewed through Gerrit,
> so we have an audited, second-engineer review to make sure each commit
> in the 3xx kernel that Google had been carrying had the correct
> disposition when rebasing to the 4xx kernel.)

This is great! I designed a strikingly similar workflow for local
patches to Openstack Neutron about four years ago. Each time we moved
forward to a new version of upstream, we went through a very similar
process. I don't have access to those scripts any longer but here is
what I recall.

With each now upstream version, we'd generate a list of commits we
created locally using git. I recall it being a fairly simple set
difference between the upstream tag and our downstream tag. I wrote
scripts that would take each of them and proposed them as new gerrit
reviews against the new upstream. I made sure to keep the same gerrit
change-id as the old one in the new review. Gerrit allowed this because
it was a new branch for each now revision and gerrit allows the same
change-id in different reviews as long as the branch is different. I'm
not sure if you kept the same change-id or not but it was very useful to
me. I could see the history of the patch applied to various upstream
versions with the click of a link in gerrit.

My automated script would cherry pick but wouldn't attempt to resolve
any conflicts. Instead, it would commit the conflict markers exactly as
they occurred and flag the review as conflicted. A human would have to
come along and recreate the cherry pick in their own workspace to
resolve the conflicts. Then they'd post the result to the same gerrit
review as the second patch set. This way, the resolution of the
conflicts could easily be reviewed in the tool.

We'd run our CI against each and every one also to be sure that we
weren't breaking it.

Sometimes, patches were rendered obsolete by something upstream. In this
case, we would close the gerrit review without merging indicating that
the patch was dropped and the reason.

For patches that we proposed upstream, we'd use the same gerrit id in
the upstream review. This helped us tie them together and identify them
as equivalent patches.

When all of the gerrit reviews for all of the patches were merged, we'd
merge the result to master. I recall doing something special for this
final merge but I don't recall exactly what it was. Maybe it was to use
the "theirs" strategy or something like that.

I remember having a script called "delinearize" which would actually
find the minimum chain of preceding patches that had to come before a
given one in order for it to rebase cleanly to the upstream base. Most
of the time, the patches rebased cleanly to the upstream. This meant
that they really didn't depend on any of the patches that came before
them. This was very useful because it allowed us humans to switch
between a bunch of mostly independent gerrit reviews for the newly
cherry-picked patches and do a lot of things in parallel. We could merge
them in any order as long as they went through the entire review
process.

> The point is that for this much more complex, real-world workflow, we
> need much *more* metadata than a simple "Replaces" metadata.  (And we
> also have other metadata --- for example, we have a "Tested: " trailer
> that explains how to test the commit, or which unit test can and
> should be used to test this commit, combined with a link to the test
> log in our automated unit tester that has the test run, and a
> "Rebase-Tested-4xx: " trailer that might just have the URL to the test
> log when the commit was rebased since the testing instructions in the
> Tested: trailer is still relevant.)

So far, I haven't seen that it is that much more complex. I've actually
had experience doing practically the same thing. Yes, it was a complex
process but we didn't need much more than the gerrit-id in the reviews
and an external dashboard listing the patches out with a link to each
review. Even the dashboard was pretty much obsolete once the whole
process was declared done for a given upstream revision.

Your "Tested" trailer sounds completely orthogonal. I'm not sure that
showing a need for other orthogonal metadata is necessarily a good
argument against my proposal. It doesn't seem relevant.

> And since this metadata is not really needed by the core git
> machinery, we just use text trailers in the commit body; it's not hard
> to write code which parses this out of the git commit.
> 
> > Various git commands will have to learn how to handle this kind of
> > history. For example, things like fetch, push, gc, and others that
> > move history around and clean out orphaned history should treat
> > anything reachable through `replaces` pointers as precious. Log and
> > related history commands may need new switches to traverse the history
> > differently in different situations.
> 
> I'd encourage you to think very hard about how exactly "git log" and
> "gitk" might actually deal with these links.  In the Google kernel
> development use cases, we use different repos for the 3xx and 4xx
> kernels.  It would be possible to make hot links for the
> Original-3xx-SHA1: trailers, but you couldn't do it using gitk.  It
> would actually have to be a completely new tool.  (And we do have new
> tools, most especially a dashboard so we can keep track of how many
> commits in the 3xx kernel still have to be rebased to the 4xx kernel,
> or can be confirmed to be in the upstream kernel, or can be confirmed
> to be dropped.  We have a *large* number of patches that we carry, so
> it's a multi-month effort involving a large number of engineers
> working together to do a kernel rebase operation from a 4.x upstream
> kernel to a 4.y upstream kernel.  So having a dashboard is useful
> because we can see whether a particular subsystem team is ahead or
> behind the curve in terms of handling those commits which are their
> responsibility.)
> 
> My experience, from seeing these much more complex use cases ---
> starting with something as simple as the Linux Kernel Stable Kernel
> Series, and extending to something much more complex such as the
> workflow that is used to support a Google Kernel Rebase, is that using
> just a simple extra "Replaces" pointer in the commit header is not
> nearly expressive enough.  And, if you make it a core part of the
> commit data structure, there are all sorts of compatibility headaches
> with older versions of git that wouldn't know about it.  And if it

The more I think about this, the less I worry. Be sure that you're using 

> then turns out it's not sufficient more the more complex workflows
> *anyway*, maybe adding a new "replace" pointer in the core git data
> structures isn't worth it.  It might be that just keeping such things
> as trailers in the commit body might be the better way to go.

It doesn't need to be everything to everyone to be useful. I hope to
show in this thread that it is useful enough to be a compelling addition
to git. I think I've also shown that it could be used as a part of your
more complex workflow. Maybe even a bigger part of it than you had
realized.

Carl
