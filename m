Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471321F453
	for <e@80x24.org>; Thu, 20 Sep 2018 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeIUBpp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 21:45:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45449 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbeIUBpp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 21:45:45 -0400
Received: by mail-io1-f67.google.com with SMTP id e12-v6so9366699iok.12
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D66ZsgCflQCzmqFgPkvKQx7oI/QtgvmQjvQlO/pwQvQ=;
        b=Wo5XtOPy8DucVwjT5b76Xth9degOYp1gJOb3Yt1VZVy2UqnSGtR9wI/VFXy2J9VsJz
         cRVm8C4HC+JIXcDqJ0wHwOvG3sP9bVLZ4UsKm+OO1fsQljQaeQ6zzeY6SpLXS/l46a3H
         zVAvun0qaluELgCIwic6dPQE2DqtMPbmp9ntm71OvU3qMz6afihhEjZLFrQFu8rY9iS3
         A/hCeYJ+Q1ANJ2H6jKSUOGvi3w3QNzoNpqjuVQ8mq208h06G7PuuB30gjXIa7H8kLCvZ
         eGgcI1ZcJlXqEpCc7EVA+PbPIA9745yN1wdfDlnNZwjgRPl5fFhMY6dzXi+JXgEbrSrt
         H5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D66ZsgCflQCzmqFgPkvKQx7oI/QtgvmQjvQlO/pwQvQ=;
        b=Wtlt5o9Vevdsbt7xqSr86SZTpS9R1U4IDdM70RCboJRHtUkldflfsSJ3jYT/IIFI9S
         Y/Ds9HwjEd2LD5H+M8x+MnJpIhHKVzxeyvgbGYcP5TJg5gZuzUHgM9vCt9vUmZ4wTr4m
         fNqBQJHrYR76cGdLXyEjAFo25Lkbn2qYCbcd07pa5YW8D+VKQWjWWFd1CeXrbqFUxwQy
         5SjP6c6b16O9aocVrlNkkVNNa/Pis+oQxPGg5Hb++dSMpANQHvE3AwjGGS5un3f58d1t
         xiKYuR7WF3aK4+JhzGl2lfuSNbxnKtXZ5IAzd9woeEPV0s9TdxdxVoYGP7zDmKfLFdVO
         MuZQ==
X-Gm-Message-State: APzg51CAD1WhkQjlshWaN71F9CVoAGA4tUEQhbS4VSf/2GJel8/XcsN1
        j+SEVDPcj/8logc1cnE4uE9lBA==
X-Google-Smtp-Source: ANB0VdbAiDXto9eva1dcl7N4mCV2SD+EGqum++Lf8uY7GN6AXnzIlncMRY05VKZJA6C+Jf0QUbEpog==
X-Received: by 2002:a02:4add:: with SMTP id s90-v6mr37513887jad.21.1537473636368;
        Thu, 20 Sep 2018 13:00:36 -0700 (PDT)
Received: from localhost ([173.225.52.219])
        by smtp.gmail.com with ESMTPSA id x13-v6sm9097894ioa.27.2018.09.20.13.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:00:35 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 20 Sep 2018 16:00:34 -0400
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180920200034.GA83799@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
 <20180920193751.GC29603@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920193751.GC29603@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 03:37:51PM -0400, Jeff King wrote:
> On Thu, Sep 20, 2018 at 02:04:11PM -0400, Taylor Blau wrote:
>
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 112041f407..b908bc5825 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -616,6 +616,12 @@ core.preferSymlinkRefs::
> >  	This is sometimes needed to work with old scripts that
> >  	expect HEAD to be a symbolic link.
> >
> > +core.alternateRefsCommand::
> > +	When listing references from an alternate (e.g., in the case of ".have"), use
> > +	the shell to execute the specified command instead of
> > +	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
> > +	Output must be of the form: `%(objectname) SPC %(refname)`.
>
> We discussed off-list the notion that this could just be the objectname,
> since the ".have" mechanism doesn't care about the actual refnames.
>
> There's a little prior discussion from the list:
>
>   https://public-inbox.org/git/xmqqefzraqbu.fsf@gitster.mtv.corp.google.com/
>
> My "rev-list --alternate-refs" patches _do_ use the refnames, since you
> could do something like "--source" that cares about them. But there's
> some awkwardness there, because the names are in a different namespace
> than the rest of the refs. If we were to just say "nope, you do not get
> to see the names of the alternates" then that awkwardness goes away. But
> it also loses some information that could _possibly_ be of use to a
> caller.
>
> Back in that earlier discussion I did not have a strong opinion, but
> here we are cementing that decision into a user-visible interface. So it
> probably makes sense to revisit and decide once and for all.

Interesting, and thanks for the link to the prior discussion. I think
that I agree mostly with your rationale in [1], which boils down (for
me) to:

  - Other callers (like 'rev-list --alternate-refs') might care about
    them. Even if we don't have those patches in Git today, it's worth
    keeping their use case(s) in mind.

  - I didn't measure either, but I can't imagine that we're paying a
    huge price for this. So, it might be easy enough to keep saying,
    "please write output as '%(objectname) SP %(refname)'", even if we
    end up throwing out the refname, anyway.

> > +test_description='git receive-pack test'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +	test_commit one &&
> > +	git update-ref refs/heads/a HEAD &&
> > +	test_commit two &&
> > +	git update-ref refs/heads/b HEAD &&
> > +	test_commit three &&
> > +	git update-ref refs/heads/c HEAD &&
> > +	git clone --bare . fork &&
> > +	git clone fork pusher &&
> > +	(
> > +		cd fork &&
> > +		git config receive.advertisealternates true &&
> > +		git update-ref -d refs/heads/a &&
> > +		git update-ref -d refs/heads/b &&
> > +		git update-ref -d refs/heads/c &&
> > +		git update-ref -d refs/heads/master &&
> > +		git update-ref -d refs/tags/one &&
> > +		git update-ref -d refs/tags/two &&
> > +		git update-ref -d refs/tags/three &&
>
> Probably not worth nit-picking process count, but this could done with a
> single "update-ref --stdin".

Sure, I don't think that 7 `update-ref`'s vs 2 (`cat` + `git update-ref
--stdin`) will make or break the series, but I can happily shorten it as
you suggest ;-).

> > +		printf "../../.git/objects" >objects/info/alternates
>
> Also a nitpick, but I think "echo" would be more usual here (we handle
> the lack of a trailing newline just fine, but any use of printf makes me
> wonder if something tricky is going on with line endings).

'echo' indeed seems to be the way to go. This 'printf' preference is a
Git LFS-ism ;-).

> > +test_expect_success 'with core.alternateRefsCommand' '
> > +	test_config -C fork core.alternateRefsCommand \
> > +		"git --git-dir=\"\$1\" for-each-ref \
> > +		--format=\"%(objectname) %(refname)\" \
> > +		refs/heads/a refs/heads/c;:" &&
>
> This is cute and all, but might it be more readable to use
> write_script() to stick it into its own script?

Good idea, I'll do that.

> > +	cat >expect <<-EOF &&
> > +	$(git rev-parse a) .have
> > +	$(git rev-parse c) .have
> > +	EOF
> > +	printf "0000" | git receive-pack fork | extract_haves >actual &&
>
> There's been a push lately to avoid having git on the left-hand side of
> a fork, since we might otherwise miss its exit code (including things
> like asan/valgrind errors). So maybe:
>
>    ... receive-pack fork >actual &&
>    extract_haves <actual >actual.haves &&
>    test_cmp expect actual.haves
>
> or similar?

Sure, I agree that it's a good idea to not miss the exit code (since we
don't have pipefail on), etc. I adopted your suggestion into my local
copy.

> > diff --git a/transport.c b/transport.c
> > index 24ae3f375d..e7d2cdf00b 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -1328,10 +1328,21 @@ char *transport_anonymize_url(const char *url)
> >  static void fill_alternate_refs_command(struct child_process *cmd,
> >  					const char *repo_path)
> >  {
> > -	cmd->git_cmd = 1;
> > -	argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> > -	argv_array_push(&cmd->args, "for-each-ref");
> > -	argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> > +	const char *value;
> > +
> > +	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
> > +		cmd->use_shell = 1;
> > +
> > +		argv_array_push(&cmd->args, value);
> > +		argv_array_push(&cmd->args, repo_path);
>
> Setting use_shell allows the shell trickery in your test, and matches
> the modern way we run config-based commands. Good.
>
> > +	} else {
> > +		cmd->git_cmd = 1;
> > +
> > +		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
> > +		argv_array_push(&cmd->args, "for-each-ref");
> > +		argv_array_push(&cmd->args, "--format=%(objectname) %(refname)");
> > +	}
> > +
> >  	cmd->env = local_repo_env;
> >  	cmd->out = -1;
>
> And we still clear local_repo_env for the custom command, which is good
> to avoid confusion like $GIT_DIR being set when the custom command does
> "cd $1 && git ...". Good.

Thanks,
Taylor

[1]: https://public-inbox.org/git/20170125195425.q4fpvc4ten5mfjgl@sigill.intra.peff.net/
