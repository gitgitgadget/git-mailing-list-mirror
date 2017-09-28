Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC34820A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdI1WUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:20:13 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:53793 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdI1WUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:20:12 -0400
Received: by mail-pg0-f46.google.com with SMTP id j70so1672910pgc.10
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jl17a9DyST0UqMSrhz780NuNTOFHV/iJKtcncROO+To=;
        b=qoTehx3m2P+X3Va27hqcNKA+0Pwvv70xLQRfAkgjhKQ4ck/6byEXB0enFDIc1y0wUd
         6zkZAK3ZktdBwaeaDmx+WFtVKT2YJRNzpWrIXJpMkw3COADQmRz32HIXlYPvppMWnl/0
         n1pv3Tv9WMSaGIkeyd4AwBqcPP2iZvW/1NJMpMKjqStOLQGTTwHH1UYViUJgKXBIc+qw
         CVh+atKg0+Ir+qml5PwlgdLewbfmUl/s2YCR8aLB5YeaU9mVKK4lfBLXNgBaixg/Nwlh
         RgUNqvXHzkaCkMgzHEzrkCNopTLudy7M5QPlXwBwN0m+hKH7phTvX7XGQQekXHYJMYiK
         FXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jl17a9DyST0UqMSrhz780NuNTOFHV/iJKtcncROO+To=;
        b=R0jc994hn1DfbFlj+NXzgdwKpFc41QK5wSs6UqMvDWZaxTqUWxmF7KiN+BSJyoZyp6
         TWkWgtAgLSZxtdrPGECHv4J+ipWaV8WCOwTr8pzlApFcA2dGGMBqxueiGvRRyKWVi9hr
         3X7eJL1/+8DXdECXLLmturE9ALWcFj3fEqaW4PAQTt9ZPp9QW7ektD+DKVZ6ngpc0CRy
         AME7c70KuXZtEhvUOn3lC4TgDsqoDmfPI0sC61j+x8iynrfn77UG/W+mFqoxBAEZ2pzC
         atuvSiPJKHN+mbckDUhAPStfP0qbSYH5PTl/IRLxNSvyP5TjaGQ4qxnJvtmTpOgHQ1le
         01QQ==
X-Gm-Message-State: AHPjjUh9SN+EsqaBgWN+MGHHENwkiePCYbOaexP0AWT9im8No14gbK9o
        JoiTFcvdFimmvp/2sH3kg1Pk1w==
X-Google-Smtp-Source: AOwi7QAtSKkeves95fqCZYGayao4tVMZ1iZz15dH+cFdhhu3UYoHbuTw9kzEFXw/H/t6v3ZsZRqJpw==
X-Received: by 10.101.92.6 with SMTP id u6mr5556651pgr.198.1506637211795;
        Thu, 28 Sep 2017 15:20:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c55b:7140:f55d:7eed])
        by smtp.gmail.com with ESMTPSA id r81sm4495730pfj.106.2017.09.28.15.20.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 15:20:10 -0700 (PDT)
Date:   Thu, 28 Sep 2017 15:20:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 7/9] connect: tell server that the client understands
 v1
Message-ID: <20170928222009.GD177031@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-8-bmwill@google.com>
 <xmqqk20k64r4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk20k64r4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Teach the connection logic to tell a serve that it understands protocol
> > v1.  This is done in 2 different ways for the built in protocols.
> >
> > 1. git://
> >    A normal request is structured as "command path/to/repo\0host=..\0"
> >    and due to a bug in an old version of git-daemon 73bb33a94 (daemon:
> >    Strictly parse the "extra arg" part of the command, 2009-06-04) we
> >    aren't able to place any extra args (separated by NULs) besides the
> >    host.  In order to get around this limitation put protocol version
> >    information after a second NUL byte so the request is structured
> >    like: "command path/to/repo\0host=..\0\0version=1\0".  git-daemon can
> >    then parse out the version number and set GIT_PROTOCOL.
> 
> Same question as a previous step, wrt the cited commit.  It reads as
> if we are saying that the commit introduced a bug and left it there,
> that we cannot use \0host=..\0version=..\0other=..\0 until that bug
> is fixed, and that in the meantime we use \0host=..\0\0version=.. as
> a workaround, but that reading leaves readers wondering if we want
> to eventually drop this double-NUL workaround.  I am guessing that
> we want to declare that the current protocol has a glitch that
> prevents us to use \0host=..\0version=..\0 but we accept that and
> plan to keep it that way, and we'll use the double-NUL for anything
> other than host from now on, as it is compatible with the current
> version of Git before this patch (the extras are safely ignored),
> but then it still leaves readers wonder if the mention of the
> old commit from 2009 means that this double-NUL would not even work
> if the other end is running a version of Git before that commit, or
> we are safe to talk with versions of Git even older than that.
> 
> I do not think it is a showstopper if we did not work with v1.6.4,
> but it still needs to be clarified.

I wrote an updated commit msg for the daemon change, I can make a
similar change here.  And this mechanism shouldn't cause any issues with
both the pre and post 73bb33a94 git-daemon servers.

> 
> > 2. ssh://, file://
> >    Set GIT_PROTOCOL envvar with the desired protocol version.  The
> >    envvar can be sent across ssh by using '-o SendEnv=GIT_PROTOCOL' and
> >    having the server whitelist this envvar.
> 
> OpenSSH lets us do this, but I do not know how well this works with
> other implementations of SSH clients.  The log message perhaps needs
> to ask for volunteers to check if it is OK with the implementations
> they use, and offer conditional code (just like we have for putty
> and plink customizations) otherwise.

I'll make a comment indicating that

> 
> Other than that, the code changes looked good.
> 
> > diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
> > new file mode 100755
> > index 000000000..1988bbce6
> > --- /dev/null
> > +++ b/t/t5700-protocol-v1.sh
> > @@ -0,0 +1,223 @@
> > +#!/bin/sh
> > +
> > +test_description='test git wire-protocol transition'
> > +
> > +TEST_NO_CREATE_REPO=1
> > +
> > +. ./test-lib.sh
> > +
> > +# Test protocol v1 with 'git://' transport
> > +#
> > +. "$TEST_DIRECTORY"/lib-git-daemon.sh
> > +start_git_daemon --export-all --enable=receive-pack
> > +daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
> > +
> > +test_expect_success 'create repo to be served by git-daemon' '
> > +	git init "$daemon_parent" &&
> > +	test_commit -C "$daemon_parent" one
> > +'
> > +
> > +test_expect_success 'clone with git:// using protocol v1' '
> > +	GIT_TRACE_PACKET=1 git -c protocol.version=1 \
> > +		clone "$GIT_DAEMON_URL/parent" daemon_child 2>log &&
> > +
> > +	git -C daemon_child log -1 --format=%s >actual &&
> > +	git -C "$daemon_parent" log -1 --format=%s >expect &&
> > +	test_cmp expect actual &&
> > +
> > +	# Client requested to use protocol v1
> > +	grep "version=1" log &&
> > +	# Server responded using protocol v1
> > +	grep "clone< version 1" log
> 
> This looked a bit strange to check "clone< version 1" for one
> direction, but did not check "$something> version 1" for the other
> direction.  Doesn't "version=1" end up producing 2 hits?

I think you discovered this in your next email but the "version=1" check
is to check for the request sent to git-daemon, the "command
path/to/repo\0host=blah\0\0version=1\0" one. While the "clone< version
1" check is to make sure that the server responded with the correct
version.

> 
> Not a complaint, but wondering if we can write it in such a way that
> does not have to make readers wonder.
> 
> > +'
> > +
> > +test_expect_success 'fetch with git:// using protocol v1' '
> > +	test_commit -C "$daemon_parent" two &&
> > +
> > +	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
> > +		fetch 2>log &&
> > +
> > +	git -C daemon_child log -1 --format=%s FETCH_HEAD >actual &&
> > +	git -C "$daemon_parent" log -1 --format=%s >expect &&
> > +	test_cmp expect actual &&
> 
> OK.  So the origin repository gained one commit on the 'master'
> branch (and a tag 'two').  By fetching, but not pulling, our
> 'master' would not advance, and that is where check on FETCH_HEAD
> comes from.  I suspect that the tag 'two' is also auto-followed with
> this operation and would be in FETCH_HEAD; is that something we want
> to check?  Alternatively, the "actual" log may want to see what the
> remote tracking branch for their 'master' has---then we do not have
> to worry about "FETCH_HEAD has two refs---which one are we checking?"

Yeah I can do that instead if you would prefer.

> 
> > +
> > +	# Client requested to use protocol v1
> > +	grep "version=1" log &&
> > +	# Server responded using protocol v1
> > +	grep "fetch< version 1" log
> > +'
> 
> Same "version=1" vs "fetch< version 1" strangeness appears here.
> 
> > +test_expect_success 'pull with git:// using protocol v1' '
> > +	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
> > +		pull 2>log &&
> > +
> > +	git -C daemon_child log -1 --format=%s >actual &&
> > +	git -C "$daemon_parent" log -1 --format=%s >expect &&
> > +	test_cmp expect actual &&
> 
> Here we can check our 'master', as we pulled their 'master' into it.
> What is this testing, though?  The fact that protocol.version=1
> given via "git -c var=val" mechanism is propagated to the underlying
> fetch?

Yeah, i guess we could realistically drop either the fetch or pull test
as they essentially do the same thing.  I was just being overly
cautious.

> 
> > +	# Client requested to use protocol v1
> > +	grep "version=1" log &&
> > +	# Server responded using protocol v1
> > +	grep "fetch< version 1" log
> > +'
> > +
> > +test_expect_success 'push with git:// using protocol v1' '
> > +	test_commit -C daemon_child three &&
> > +
> > +	# Since the repository being served isnt bare we need to push to
> > +	# another branch explicitly to avoid mangling the master branch
> 
> The other end avoids mangling the master just fine without us doing
> anything special ;-).  You are pushing to another branch because you
> cannot push into a branch that is currently checked out.
> 
> 	# Push to another branch, as the target repository has the
> 	# master branch checked out and we cannot push into it.

Sounds good I'll change that.

> 
> perhaps?
> 
> The tests for file:// looked identical, so the same set of comments
> apply.
> 
> > +# Test protocol v1 with 'ssh://' transport
> > +#
> > +test_expect_success 'setup ssh wrapper' '
> > +	GIT_SSH="$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" &&
> > +	export GIT_SSH &&
> > +	export TRASH_DIRECTORY &&
> > +	>"$TRASH_DIRECTORY"/ssh-output
> > +'
> > +
> > +expect_ssh () {
> > +	test_when_finished '(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)' &&
> > +	echo "ssh: -o SendEnv=GIT_PROTOCOL myhost $1 '$PWD/ssh_parent'" >"$TRASH_DIRECTORY/ssh-expect" &&
> > +	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
> > +}
> > +
> > +test_expect_success 'create repo to be served by ssh:// transport' '
> > +	git init ssh_parent &&
> > +	test_commit -C ssh_parent one
> > +'
> > +
> > +test_expect_success 'clone with ssh:// using protocol v1' '
> > +	GIT_TRACE_PACKET=1 git -c protocol.version=1 \
> > +		clone "ssh://myhost:$(pwd)/ssh_parent" ssh_child 2>log &&
> 
> Hmm, this is a fun one, as we deliberately make $(pwd) to have
> whitespace in the test setup.  I am impressed/kinda surprised that
> this works ;-)
> 
> Other than that, these also look more or less identical to file://
> and git:// tests, so the same set of comments apply.
> 
> Overall very nicely done.

Thanks! :D

> 
> Thanks.

-- 
Brandon Williams
