Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904F420248
	for <e@80x24.org>; Thu, 11 Apr 2019 11:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKLHG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 07:07:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKLHF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 07:07:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so6744486wrq.8
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9kKl1tjoSUyoZC05vunrU519gOGb34Y73gHnZYIquNQ=;
        b=Om7tWC3C1f/IfbaJ4jbgDhZaEbP6scjGUA19+yoBe3Xv3W1wT4riBjnFwrPCYpxx6X
         L3enkOZgO0QwBnVwN3TD0CGgIBMn7QWPOn2R7f1R4IBhQ5f0SSyrXq+QNdG0TDI7rZ3J
         5vfwntYEFwt27i/pL5nj0UNQgMZINy3qkWEAdS3iLfEZOsbUTnGm3iOUJ8DNTaIo2LUo
         y/l4XazZiWPhEXL5m5KS8lSsKAssLJRUKVe+xwjpqc6wWAsL+19pjAKi9cEkUS3w36VJ
         KuUt1l/Gs9PdZrfpQH56MGRQPVfYqB6NeT/Kr9luRXt+2TwQ3lU3zOpqJbZ/6Nc/B01N
         Rpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9kKl1tjoSUyoZC05vunrU519gOGb34Y73gHnZYIquNQ=;
        b=MTzhpulp1jEJLWPmhfR+Pb/jotSvZrvVzQTU6THA5m2DArxH7Ad331MOKObpINm0k7
         xNbI2eb/i1zeZKZMkbvPh3PG5oQLOsZBQkQEnFzLUuxkMCvHqZxemvF1h8NTNbuU3Nh2
         l9u/vq5TMTxNbggnWO159ybzb75FrGlgKeHR/DdmTGHTN+Xe+sjjOScadm22UrjsBaay
         CSKwbOkUtLieN3r/HbDH2Y5hLk1ccaBGHZw1u0DyoCMk1UDxg3ofm2tHuaSRlgn6g54e
         zEGULMACAXyX8/wHLnIHW0oqF28QAGmntyqqM1UatUkB9p28hKpepOcYB6qGje+H87Zp
         h8OQ==
X-Gm-Message-State: APjAAAWex3zLcF+YmMDy/Fm88FPXJFijRZSP3DJVkrIXmN0yqt3mII0j
        fA3TogL7IsW+d37BCwxXR3UUWHfV
X-Google-Smtp-Source: APXvYqwUeu0/gPQAzVuy53kAK3LTSkY4kUtdkkaEomi974tGsy9JW2PjcEGT5at8VPPK5kdqgbiS4A==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr29186197wru.202.1554980823688;
        Thu, 11 Apr 2019 04:07:03 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id v6sm48295489wrt.56.2019.04.11.04.07.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Apr 2019 04:07:03 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:07:02 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Pull without fetch
Message-ID: <20190411110702.qz5sta3jm3kh434h@feanor>
References: <20190406131200.xcd7gtf7dlc567uh@doriath>
 <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
 <20190408145340.3rdprg3yu5shpelu@feanor>
 <20190408161134.gdxmxvqitxioeibp@feanor>
 <xmqqr2ab7ghr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr2ab7ghr.fsf@gitster-ct.c.googlers.com>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 11 Apr 2019 10:56:07 +0200
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, let me thank you for your very thorough review!

From Junio C Hamano, Tue 09 Apr 2019 at 17:03:12 (+0900) :
> It may be better to present the whole remedy, not just this new
> piece that is an ingredient of it, i.e.
> 	Teach a new --no-fetch option to `git pull`, so that the old
> 	`git fetch && inspect && git merge FETCH_HEAD` sequence can
> 	be generalized for workflows with newer `pull` features as a
> 	`git fetch && inspect && git pull --no-fetch` sequence.
> or something like that, perhaps?

Indeed.

> What worries me about this topic (before even reading the patch
> text) revolves around how we guarantee that the "inspect" step in
> that sequence does not affect the environment negatively.  In order
> for the three-step sequence (no other options to `fetch` or `pull`
> steps) to be truly equivalent to `git pull` (no other options) when
> inspection is satisfactory, the "inspect" step probably should not
> change the currently checked out branch; an unsplit `git pull` would
> base its decision to choose which branch(es) from what remote to
> fetch from based on what the currently checked-out branch is [*1*],
> and it is not too implausible for `git fetch` to learn the same
> trick, even though currently a `git fetch` without options seem to
> always fetch from the default remote, without taking the current
> branch or any other enviornmental conditions into account.

Well it does take into account the current branch to know what is the
"default remote", and when doing a `git fetch remote refspec`, if 'remote'
is the default remote then it also adds the upstream branch to the refspec
(cf add_merge_config called by get_ref_map in fetch.c).

> In the worst case, after "inspect" step, `git pull --no-fetch` may not
> even find a useful FETCH_HEAD; this includes a case like `git pull
> --no-fetch some_other_remote` is run that is totally unrelated to the
> previous `git fetch` that left the FETCH_HEAD.  The code needs to notice
> strangeness like that and deal with it (most of the time, I think
> erroring out saying "you did something stupid/unexpected since you ran
> `git fetch`, so --no-fetch refuses to work" is sufficient).

Ok, so in my mind `git pull --no-fetch` was meant as the 'modern' version of
`git merge FETCH_HEAD`. If a remote or refspec is specified they are
currently discarded (I agree it would be better to error out). This means
that doing a `git fetch` while on branch master, followed by a checkout to
branch `feature` and a `git pull --no-fetch` will try to merge with
master's upstream rather than feature's upstream; exactly like `git merge
FETCH_HEAD` would have done.

In other words the current philosophy of `git pull --no-fetch` is as
follow: we integrate the previously fetched branches with the current
branch. Integrate means merge or rebase according to the value of
branch.<current>.rebase. We do not care what the current upstream branch
is, how the user did his previous fetch, and if it was not related to the
current branch it is his responsibility.

Now in your sidenote 2 you mention another approach:

> Instead of handling this feature at the "pull" level, teach "git fetch" a
> new option "--no-fetch" that pretends to have fetched from the given
> remote and given refspec, by looking at the tips of remote-tracking
> branches instead of talking to the remote, and populate FETCH_HEAD as if
> we got exactly the same thing as we saw when we last talked to the
> remote.
> [...]
> That would make the feature much easier to explain.

This approach is quite different from `git merge FETCH_HEAD`. Indeed it is
'construct our own FETCH_HEAD and then do the git merge FETCH_HEAD'.
In this case, the remote and refspec provided to `git pull --no-fetch`
actually matters. The only difference with a normal pull/fetch is that we
only use the local remotes branches, we never update them.

So this is probably what you meant in your previous email about doing a
'noop fetch', I had not understood that, sorry!

Now the question is which approach to implement? I think that your
approach is indeed better; with your method a `git pull --no-fetch` behave
much more similarly with a normal `git pull` than with my method, and there
is less room for the user to shoot himself in the foot.

I would even argue that even in the good old days, `git merge FETCH_HEAD`
was just a convenient approximation of a putative `git pull --no-fetch`, so
when implementing `--no-fetch` we should strive for the best end-user
result rather than do the same approximation as I did.

> this without such a background probably gets lost.  Aren't there
> restrictions on the first fetch done and the subsequent "pull" that does
> not fetch?  For example, if you have a remote, origin, and also pull from
> repositories without a nickname, doing this is not something you would be
> willing to support, I presume:
>          $ git fetch origin $ git pull --no-fetch
>          https://github.com/gitster/git master

So currently this would simply discard the arguments and merge with what's
is in FETCH_HEAD.
 
> The reasons why I suspect you are not supporting the above are (1) `git
> fetch origin` won't grab anything from my repository, and nothing in
> FETCH_HEAD is useful to help the `pull` step of the sequence, and (2)
> `git pull https://github.com/gitster/git master` without a set nickname
> would not keep "the last time seen" value in refs/remotes/ hierarchy, so
> there is nothing to help --no-fetch "pretend" as if it fetched previously

In a 'noop fetch' implementation, this would need to barf that `--no-fetch`
only works for name based remotes, not for url based ones.

> > @@ -912,8 +915,9 @@ int cmd_pull(int argc, const char **argv, const
> > char *prefix) oidclr(&rebase_fork_point); }
> >  
> > -	if (run_fetch(repo, refspecs)) -		return 1; +	if
> > (opt_fetch) +		if (run_fetch(repo, refspecs)) +
> > return 1;
> 
> I know this is PoC, but the real implementation must have the else clause
> to deal with "what if we do not fetch" case.
> 	if (opt_fetch) { if (run_fetch(repo, refspecs)) return 1; } else {
> 	... make sure what is in FETCH_HEAD is compatible ... with
> 	run_fetch(repo, refspecs) we are skipping ... would have left, if
> 	we didn't skip it. ... and otherwise barf loudly. }

In the current implementation, the else part would be
- error out if the user specified remotes or refspecs
- fails with a more informative message than
fatal: could not open '.git/FETCH_HEAD' for reading: No such file or directory
  if FETCH_HEAD does not exists. Something like:
fatal: you need to fetch first before running `git pull --no-fetch`.

> > +	git pull --no-fetch . nofetch && +	stat --format %Y
> > .git/FETCH_HEAD > fetch_head_after &&
> I do not think you want to do this.
> A more to-the-point test arrangement would be something like
> 	- prepare the source repository - git fetch from the source
> 	repository - go back to the source repository and add a commit -
> 	run git pull --no-fetch
>       - inspect the resulting merge commit.  Is the second parent the
>       original commit you grabbed when you fetched?  Or is it the new one
>       added to the source repository since you fetched?
> One obvious advantage of doing so is that it is the exact motivating use
> case you gave when you came to the list with this feature. Also, it
> allows the "teach `git fetch --no-fetch` to pretend as if it fetched the
> same thing, based on the remote-tracking branches" implementation, by not
> caring the file timestamp of FETCH_HEAD.

Yes, I realised after sending the RFC patch that in the test I should
really test the feature I want rather than an hacky approximation of it,
sorry about that.

I admit I was a bit unconfortable with the structure of t5520-pull.sh where
tests depends on the state of the git repositories of previous tests rather
than creating the git repos from scratch (presumably for the sake of
speed), so I was afraid to break things. But I see that I can probably
reuse the repos from the test 'setupt for detecting upstreamed changes'.


So I'll try (when I have time...) to do a RFC implementation of a 'noop
fetch' approach. I first need to understand the source of fetch.c better,
in particular how to do something like store_updated_refs when we are doing
a noop fetch (so without using transports).

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
