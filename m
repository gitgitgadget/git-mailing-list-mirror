Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64561211B5
	for <e@80x24.org>; Fri, 25 Jan 2019 21:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAYVdM (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 16:33:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37747 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYVdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 16:33:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so11802952wrt.4
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=c0muv28MThP0guTZbrlvNs7nLdhVlNNkzIhqmRwL1SY=;
        b=I61V0mM5z3Kt1G0Y8oyTuSQoXbN26XBNchX2/qNYA6Ea5HWpsFf8jvw9DRTm7/0ECN
         O6JHdCErMFZV2liohQ24X+Pc8hthfjC0bKsB2XxWxSw+AreV75nHwtLgp6T2gooOJKUy
         wOvHORw6iuB3ByntVzkEG3LTImFST9XBDxrHoh0VQR05AcEVfuuWj1V97QRUnQi6tauB
         0GaTpLBJdiWdTofcFFKAg14xbI40vy2xS0rkWOefGegBvZoPTVPsP+E3KvwWTOwE71kz
         b71Ve8zj0PK4Mukwy6NkpkU0Siyl3KjFYd+5EOHkmIVhXvce63XkXjDtrJ3//QOpv/8a
         utSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=c0muv28MThP0guTZbrlvNs7nLdhVlNNkzIhqmRwL1SY=;
        b=O002wov/KHVes4RI+Srx4XmwBMfcjxxiJtO2ksohGBgo5zK9Jw3iA8Xvrx61OIovLr
         KnE24AgKLTIcTQYCZ95H1P/zP1u9+h9jKWm9wiyUrNNoEu1MG85X9+/qWLD1qvSGutwY
         2ai/BmCi6VTpaax7ftlqgI6xGHxrYPCGvfpABSVRRlKVIV7//Bb/UKQufrGS/wfUMPgZ
         NOtmqKQpzD065Q+6JHV7Btc9ML0HgLXzZoebGQDSeDfV0HPwzoo+LVEamu6n0kKPGcH9
         MxXBfweoMW7r1lUVPfPTKiwV0J25hAgDbcuO104bP3SM9F3KrLkhirrH9HTyIJK77/B/
         jYPg==
X-Gm-Message-State: AJcUukdAgSsSo7GPQ8XtEpOyrTiL1KHe8Yt2gIILXsUN5gPBnedgFAya
        PLqqQDSXJyM7WKWu1pFmpu4=
X-Google-Smtp-Source: ALg8bN5i0bub6xiZCza2s6pWQ92YIxgxTTWwT9C5Cm85402h3Hg/mUFkyqRSl1uoCjDNXxH31lj0ww==
X-Received: by 2002:adf:d089:: with SMTP id y9mr13424269wrh.22.1548451989478;
        Fri, 25 Jan 2019 13:33:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j24sm133240670wrd.86.2019.01.25.13.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:33:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Israel\, Daniel M" <dmi1@lanl.gov>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Writing merge strategy?
References: <244FE6CE-C045-4EC9-8C3F-8D16CF4D09EB@lanl.gov>
Date:   Fri, 25 Jan 2019 13:33:08 -0800
In-Reply-To: <244FE6CE-C045-4EC9-8C3F-8D16CF4D09EB@lanl.gov> (Daniel
        M. Israel's message of "Fri, 25 Jan 2019 00:55:52 +0000")
Message-ID: <xmqqimycfmnf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Israel, Daniel M" <dmi1@lanl.gov> writes:

> I need a custom merge strategy (not driver) for a tool I’m writing, and I’m wondering:
>
> 1. Is there documentation for the API anywhere?

It used to be far easier to figure out back when git-merge.sh was a
script before 1c7b76be ("Build in merge", 2008-07-07) and it got
even harder to figure out after we removed contrib/examples/ at
49eb8d39 ("Remove contrib/examples/*", 2018-03-25), but you can
still find in "git show 1c7b76be^:git-merge.sh" output the following
snippet that shows how your merge strategy is called by the caller:

-- >8 -- snipsnap -- >8 --

    git-merge-$strategy $common -- "$head_arg" "$@"
    exit=$?
    if test "$no_commit" = t && test "$exit" = 0
    then
        merge_was_ok=t
	exit=1 ;# pretend it left conflicts.
    fi

    test "$exit" = 0 || {

	# The backend exits with 1 when conflicts are left to be resolved,
	# with 2 when it does not handle the given merge at all.

	if test "$exit" -eq 1
	then
	    cnt=`{
		git diff-files --name-only
		git ls-files --unmerged
	    } | wc -l`
	    if test $best_cnt -le 0 -o $cnt -le $best_cnt
	    then
		best_strategy=$strategy
		best_cnt=$cnt
	    fi
	fi
	continue
    }

    # Automerge succeeded.
    result_tree=$(git write-tree) && break

-- 8< -- snipsnap -- 8< --

You'll be called with common ancestor commit(s), double-dash, HEAD
(i.e. the commit the work by histories are being merged into), and
the commits being merged, on the command line.  You are expected to

 - update the index with the merge result and exit with 0, if you
   auto-resolved the merge cleanly; or

 - update the index with the cleanly merged result at stage #0, and
   for conflicted paths, place the common anestor version at stage
   #1, the version from HEAD at stage #2 and the version(s) from
   merged commit(s) at stage #3.  Signal that your automerge is
   usable with manual resolution by exiting with 1; or

 - do nothing and exit with 2, to signal that you were not capable
   of handling this particular merge.

The "git merge" command that called your strategy is responsible for
making a commit out of the index you left, recording the parent
commits, reacting to "merge --no-commit -S" and other options.

> 2. Does git-merge actually do any magic, or could I just run the
> script that implements my merge directly?  In other words, is
> there really any difference between a merge strategy and a script
> that creates the tree I want and then commits it using
> git-commit-tree with multiple -p arguments.

Other "magic" we let "git merge" do are things like handling
fast-forward, iterating over multiple strategies and use what works,
etc.

If you are not doing a strategy but a custom script, you'd be
reinventing "git merge".  As long as your custom script produces a
commit object that records the resulting tree, parent commits and
log message correctly, nobody who examines that resulting merge
commit would not even know you did not use "git merge" to record it.

And that is perfectly fine as long as the result suits your needs
