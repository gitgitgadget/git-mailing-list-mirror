Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496AA1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 19:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdFETmc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 15:42:32 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34880 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdFETma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 15:42:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id l89so13211369pfi.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdpvtKjtrI8pwYnU0/X7A3+mvjIw3KOxBQniVVDxKK8=;
        b=aIo/kgluuvWqgsIGvqEMhBzGmMiQoSSqb2Z2yyPMp451D+QyCcvyNfEnSUq2jIoD9B
         q+1R5XNC3h0Jx5n+bN6udhUWjUWA6ClUr34HMgGN6iDohsLTffReZehhmRcGpvWvGfvU
         /5xxpXpeqLcbfc3Fm3Fxf7PHvbUOEcORg71k15VHBCIPCCUEaWzfbLpSmZzW6UgHB2uG
         ZBkoi6OE6lGjW3WAJMljfCb5sskuyCG1Rz9twYal9w1KEdTxGjsVGmWangic7CvpGZrY
         IuuqeRCDXELLFz4MdfBy6Z+cFdaQvAUXv4zq1Spc3SnJhf2mQY3evfh4VGX9E5zs0MSu
         k47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdpvtKjtrI8pwYnU0/X7A3+mvjIw3KOxBQniVVDxKK8=;
        b=b03+E2wn9yt/WaAQ/QpJ+sNeTLh+2YIB14SgbBIaKorp+vV8TG0x6pDzSdkbI8Ocig
         iIaSOqcZELOkU6oV8N4BvT5dzOlc7Gyrb7gHZHsAi39Pi1468HxF7YVjA0YdPT8QTwim
         gykoJBzM4G7uuudDJ0CjAeFfMFqv+HgS419x+jvAm4UYp3NIOahXZUiOAB0XaIABMBy+
         rraD+Iurd0mKZECiUXzNvQD1CEwgJSidDGCJDLxTRBvGLptyVItV22As2CdTdWzrgMsr
         AHJg6sWfBZ6kTiavkvShH9dPriyDlYmhYVeVXr8svdNRVF+Yi0Os4n5aex2M8Eding44
         xCQg==
X-Gm-Message-State: AODbwcDVQNDo4JRUgfNSInoAGCC4RZQRkjSctF0aSxTkJv7vYKe+6srG
        +LaHN1CjEF+KOIs2ulOaCw==
X-Received: by 10.84.217.134 with SMTP id p6mr17129367pli.192.1496691749880;
        Mon, 05 Jun 2017 12:42:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b834:3af4:2e37:8db3])
        by smtp.gmail.com with ESMTPSA id b1sm18055963pfl.70.2017.06.05.12.42.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 12:42:28 -0700 (PDT)
Date:   Mon, 5 Jun 2017 12:42:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
Message-ID: <20170605194227.GE40426@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
 <xmqqzidr18an.fsf@gitster.mtv.corp.google.com>
 <xmqqefv3yo23.fsf@gitster.mtv.corp.google.com>
 <xmqqtw3yyhzc.fsf@gitster.mtv.corp.google.com>
 <20170602182215.GA57260@google.com>
 <xmqqpoemx8t4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoemx8t4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 06/02, Junio C Hamano wrote:
> >> 
> >> I lied.  This also conflicts somewhat with Peff's diff-blob topic.
> >> I think I resolved them correctly (there needs evil merges applied
> >> to two files when merging this topic), and hopefully can push out
> >> the result by the end of the day.
> >> 
> >> Thanks.
> >
> > If it ends up being too much of a headache for you to deal with, let me
> > know and I can rebase on top of those series.  That way you don't have to
> > deal with the conflict resolutions.  Just let me know what you'd like me
> > to do.
> 
> Sorry, I forgot to push the result out, even though I double checked
> the conflict resolution I did last night.  Now it is in the public
> repository.  I have one squash queued at the right place to update
> SHA1s to OIDs in the comment Brian pointed out.
> 

What you have at 'bw/object-id' matches the changes I made locally
(changing SHA1 to OID) and looks good to me!

> If you ever need to rebase this on top of future 'master' that
> already has js/blame-lib topic, fetching from me and checking
> the evil merge I did may turn out to be helpful:
> 
>  $ git fetch git://github.com/gitster/git refs/merge-fix/bw/object-id
>  $ git show FETCH_HEAD
> 
> but I can take patches based on the same old 'master'; as long as
> the evil merge above is correct, that would probably be preferrable,
> as it makes it easier to compare the two iterations of your series.

Sounds like basing it on the original 'master' would work easiest for
you, so I'll continue to do that :)

> 
> Repeating some backstory of "merge-fix" might be beneficial, if a
> reader is interested.  Otherwise the remainder of this message can
> safely be skipped.
> 
> After a topic (i.e. js/blame-lib) moves a lot of code around (i.e. a
> bulk of what used to be in builtin/blame.c is now in blame.c and
> some in diff.c), merging a topic that touches places in the code
> that was moved in-place (i.e. bw/object-id, which updates the code
> in builtin/blame.c) will leave a conflict that looks like:
> 
>     <<<<<<< HEAD
>     ... very little that is left after moving
>     ... bunch of code out of this file
>     ||||||| common
>     ... a lot of
>     ... stuff before
>     ... your change from SHA1 to OID
>     ... is here
>     =======
>     ... a lot of
>     ... stuff after
>     ... your change from SHA1 to OID
>     ... is here
>     >>>>>>> theirs
> 
> As far as builtin/blame.c is concerned, the resolution for this
> set of conflicts is just to take the HEAD version, ignoring all of
> your SHA1-to-OID changes.  Once it is resolved, "rerere" can help
> us remember this resolution to builtin/blame.c
> 
> But the ignored changes need to go somewhere else.
> 
> What the user who is doing a merge does at this point is to compare
> what is between ||||||| and ======= (i.e. common ancestor's version)
> with what is between ======= and >>>>>>> (i.e. their version) to
> figure out what the branch being merged did.  And the user needs to
> know where the common code went in the version in HEAD.
> 
>  $ git log [--no-merges] -p MERGE_HEAD.. -- builtin/blame.c
> 
> is helpful to locate the commit that lost the common lines from the
> file.  And "git show" on it will tell us that they mostly went to
> blame.c while some migrating to diff.c; we found out what you did by
> comparing "common" and "theirs" in the previous step and we apply
> these changes to these "new" places.
> 
> And that is the diff you see in refs/merge-fix/bw/object-id.  The
> script I use to re-build 'pu' every day (probably I use it three
> times a day on average) knows about that ref.  The script starts
> from the tip of 'master', and for each topic, (1) run "git merge"
> into HEAD, (2) take resolution recorded by "rerere" and (3) if
> merge/fix/$topic exists, cherry-pick it on top to squash into the
> merge made in (2).
> 
> Once I have taught my rerere database and refs/merge-fix/ about this
> merge, it is not too big a deal to redo the merge to adjust to an
> updated 'master' or a new interation of your series because of the
> above mechanism.  And that is why I say it is OK for an updated series
> to be based on the same old 'master'.
> 
> Thanks.
> 
> 

-- 
Brandon Williams
