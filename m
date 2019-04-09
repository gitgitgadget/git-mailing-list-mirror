Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D708920248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIIDR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:03:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfDIIDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:03:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so19601551wrq.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I31dif/7sQ1vK5lNkxCBycOTF2p00d3bFE00BQHt0Jg=;
        b=S7LuHFXn8Vneq07J/IlKxu00GxEfpA1XWZ1mrAco7TZ9Zr1xdZobs5meBy08AJWykA
         fP0QuBEKNeNyzAS1mUWp3tTS4JcLV5V25Jw/jLYfUDhmV4qh1JnAJWhblpQUljyeSCFP
         QVE9oGPbElc4eHe3XB7ws4My5tpFZ8GbZEAzL09iNKLMOQiZ4occs+Rk5gSzwoCqpZ+L
         sOUPYdF+ny/YFbHMU4ixOvW0gIQMZOJBeXnfGKDLjxc9xboKd5imFtPysg+PLnvOyqkD
         N3YzdEpLKQ14nL7iSQfG0LYcKeQzfRNquV33Hk21GiZ11YnOIcObQvFnULM82HVQrrJ3
         brTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I31dif/7sQ1vK5lNkxCBycOTF2p00d3bFE00BQHt0Jg=;
        b=h/JPMMVwP80x2LSGhdecVEAfB6ZlmYsmwE9ntBpUWtvmJCMJNdP4pK3FjnS3dfLIol
         bHQbC/GjPjcW+84Uewj4datkDHA5AJMBCAWLPLk/2Y58BztmVZblZVYXR5IM3SwQFehg
         nr4nc62MyQoQtgQ3qGcKVCnGrTpdyrUlmOjMFAur7K+fxW4K8KV9CxiHFHu3MbYZmTGL
         XEdBK2hPxSfU/H75qyAMGLrs7J/pqt2zLyH6ZYRErM5cFFaItrMkFT0jyzAk/9BDn780
         9y07qOJF/R+6nJT7zunBbW2jcm+uLkDPG5snhcuLJZABeyI0okYxJYSlIQ+U9WVBXL86
         oqQA==
X-Gm-Message-State: APjAAAWusY2p/tH2YoVeVWJqUhcJPz9B2ymFaS/j4EMpjvWVmTsl8r4a
        X3dEjMEVNUzwe+iR0cliG3Y=
X-Google-Smtp-Source: APXvYqwrOchmLu9a60VjPLrpBsVtc6f9624Oj4w/ZzjGulccUGr5FiUjEWW7cGWX59245CJmOHxRhw==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr21378312wro.232.1554796993837;
        Tue, 09 Apr 2019 01:03:13 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 192sm19774526wme.13.2019.04.09.01.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 01:03:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Pull without fetch
References: <20190406131200.xcd7gtf7dlc567uh@doriath>
        <xmqq4l79cmb4.fsf@gitster-ct.c.googlers.com>
        <20190408145340.3rdprg3yu5shpelu@feanor>
        <20190408161134.gdxmxvqitxioeibp@feanor>
Date:   Tue, 09 Apr 2019 17:03:12 +0900
In-Reply-To: <20190408161134.gdxmxvqitxioeibp@feanor> (Damien Robert's message
        of "Mon, 8 Apr 2019 18:11:34 +0200")
Message-ID: <xmqqr2ab7ghr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> In the good old days `git pull` was essentially `git fetch` followed by
> `git merge FETCH_HEAD` so it was easy to separate the fetching part from
> the integrating part.
>
> But nowadays there are no easy way to do the integrating part of `git
> pull`. Indeed, `git pull` learnt to read the config values of
> `branch.<current>.rebase` and `pull.rebase`, whose possible values are
> growing. At the time of this commit, they can be 'true', 'merges',
> 'preserve' and 'interactive'.
>
> To remedy this, add a new --no-fetch option to `git pull`.

It may be better to present the whole remedy, not just this new
piece that is an ingredient of it, i.e.

	Teach a new --no-fetch option to `git pull`, so that the old
	`git fetch && inspect && git merge FETCH_HEAD` sequence can
	be generalized for workflows with newer `pull` features as a
	`git fetch && inspect && git pull --no-fetch` sequence.

or something like that, perhaps?

What worries me about this topic (before even reading the patch
text) revolves around how we guarantee that the "inspect" step in
that sequence does not affect the environment negatively.  In order
for the three-step sequence (no other options to `fetch` or `pull`
steps) to be truly equivalent to `git pull` (no other options) when
inspection is satisfactory, the "inspect" step probably should not
change the currently checked out branch; an unsplit `git pull` would
base its decision to choose which branch(es) from what remote to
fetch from based on what the currently checked-out branch is [*1*],
and it is not too implausible for `git fetch` to learn the same
trick, even though currently a `git fetch` without options seem to
always fetch from the default remote, without taking the current
branch or any other enviornmental conditions into account.  In the
worst case, after "inspect" step, `git pull --no-fetch` may not even
find a useful FETCH_HEAD; this includes a case like `git pull
--no-fetch some_other_remote` is run that is totally unrelated to
the previous `git fetch` that left the FETCH_HEAD.  The code needs
to notice strangeness like that and deal with it (most of the time,
I think erroring out saying "you did something stupid/unexpected
since you ran `git fetch`, so --no-fetch refuses to work" is
sufficient).

	Side note *1* There may be things other than what is
	currently checked out that can serve as an input to this
	decision, and moreover, we need to be prepared that other
	Git developers may want to invent other things later after
	this feature gets in that affects how `fetch` works, and
	leave the door open for them to do so without breaking the
	feature we are introducing here.

Anyway, let's see what you wrote.

> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 118d9d86f7..cec06bf6e3 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -144,6 +144,15 @@ This option is only valid when "--rebase" is used.
>  Options related to fetching
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> +--fetch::
> +--no-fetch::
> +	Perform a fetch first. This option can be used to override
> +	--no-fetch.
> ++
> +With --no-fetch don't fetch before updating the branch via a merge or a
> +rebase. This can be used to review changes by doing a fetch first before
> +pulling.

Those who were in this discussion thread can guess that this is
referring to

	$ git fetch
          ... inspect ...
	$ git pull --no-fetch         

sequence, that emulates a single "git pull", but those who are
reading this without such a background probably gets lost.  Aren't
there restrictions on the first fetch done and the subsequent "pull"
that does not fetch?  For example, if you have a remote, origin, and
also pull from repositories without a nickname, doing this is not
something you would be willing to support, I presume:

         $ git fetch origin
         $ git pull --no-fetch https://github.com/gitster/git master

The reasons why I suspect you are not supporting the above are (1)
`git fetch origin` won't grab anything from my repository, and nothing
in FETCH_HEAD is useful to help the `pull` step of the sequence, and
(2) `git pull https://github.com/gitster/git master` without a set
nickname would not keep "the last time seen" value in refs/remotes/
hierarchy, so there is nothing to help --no-fetch "pretend" as if it
fetched previously [*2*].

Such a restriction must be spelled out to set the end-user
expectation for this new feature.

	Side note *2* This is about the design decision, but do we
	want this --no-fetch thing useful even for remotes without
	remote-tracking branches?  If we are willing to declare that
	we only support remotes with remote-tracking branches, then
	an alternative and probably a much better design that does
	not cause any of the "a user may do random and stupid things
	while inspecting, affecting the environment" worries I
	mentioned earlier becomes possible.  Instead of handling
	this feature at the "pull" level, teach "git fetch" a new
	option "--no-fetch" that pretends to have fetched from the
	given remote and given refspec, by looking at the tips of
	remote-tracking branches instead of talking to the remote,
	and populate FETCH_HEAD as if we got exactly the same thing
	as we saw when we last talked to the remote.  Then the
	change to "git pull --no-fetch" would be just to pass the
	option through to the underlying "git fetch".  That way, no
	matter what stupid things the user does in the intermediate
	"inspect" step, the condition that would affect `git pull`
	at the last step to decide which branches from what remote
	are used will be the same with or without `--no-fetch`, and
	we do not have to worry about restrictions on the earlier
	`git fetch` step relative to the final `git pull --no-fetch`
	step.  That would make the feature much easier to explain.

Anyway, let's keep reading.

>  /* Options passed to git-fetch */
> +static int opt_fetch = 1;
>  static char *opt_all;
>  static char *opt_append;
>  static char *opt_upload_pack;
> @@ -195,6 +196,8 @@ static struct option pull_options[] = {
>  
>  	/* Options passed to git-fetch */
>  	OPT_GROUP(N_("Options related to fetching")),
> +	OPT_BOOL(0, "fetch", &opt_fetch,
> +		N_("fetch before merging / rebasing (default)")),

Good.  The above two implements a --no-foo that is off by default
correctly.

> @@ -912,8 +915,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  			oidclr(&rebase_fork_point);
>  	}
>  
> -	if (run_fetch(repo, refspecs))
> -		return 1;
> +	if (opt_fetch)
> +		if (run_fetch(repo, refspecs))
> +			return 1;

I know this is PoC, but the real implementation must have the else
clause to deal with "what if we do not fetch" case.

	if (opt_fetch) {
		if (run_fetch(repo, refspecs))
			return 1;
	} else {
		... make sure what is in FETCH_HEAD is compatible
		... with run_fetch(repo, refspecs) we are skipping
		... would have left, if we didn't skip it.
		... and otherwise barf loudly.
	}


> +test_expect_success 'With --no-fetch will not fetch but still merge pending changes' '
> +	git checkout -b nofetch master^ &&
> +	echo modified >file &&
> +	git commit -a -m modified &&
> +	git checkout copy &&
> +	git reset --hard HEAD^ &&
> +	test "$(cat file)" = file &&
> +	stat --format %Y .git/FETCH_HEAD > fetch_head_before &&

Do we use "stat(1)" elsewhere?  I think we avoid things that are not
portable.

See Documentation/CodingGuidelines for shell scripting style guides.

> +	git pull --no-fetch . nofetch &&
> +	stat --format %Y .git/FETCH_HEAD > fetch_head_after &&

I do not think you want to do this.

In "git fetch && inspect && git pull --no-fetch" sequence, the
file timestamp of FETCH_HEAD is not something you care about.  What
you care about is that what you inspected gets used in the 'pull'
step, and nothing newer or older.

A more to-the-point test arrangement would be something like

	- prepare the source repository
	- git fetch from the source repository
	- go back to the source repository and add a commit
	- run git pull --no-fetch

        - inspect the resulting merge commit.  Is the second parent
          the original commit you grabbed when you fetched?  Or is
          it the new one added to the source repository since you
          fetched?

One obvious advantage of doing so is that it is the exact motivating
use case you gave when you came to the list with this feature.
Also, it allows the "teach `git fetch --no-fetch` to pretend as if
it fetched the same thing, based on the remote-tracking branches"
implementation, by not caring the file timestamp of FETCH_HEAD.
