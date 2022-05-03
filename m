Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F412C433FE
	for <git@archiver.kernel.org>; Tue,  3 May 2022 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiECQA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiECQA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 12:00:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542731DF7
        for <git@vger.kernel.org>; Tue,  3 May 2022 08:56:53 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x9so13742805qts.6
        for <git@vger.kernel.org>; Tue, 03 May 2022 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aSlI1BP4MO0kg+xXcAla7ZyYcbL/l+PUGCfbplzJju0=;
        b=LACtGMxMCwHqIRoP+xChl3DX7r7yZS4iz3h1NSFu+DMtfYMwSywM0btFt3UVanJ9yf
         mgtfJFy7ATun+lwsEYMGtlxVxmU88hc2zVycc4k4pzK1DMfhrS1m/5+NKCX1hJZMxd7B
         9WrOw1vyGywdrV+/OLhoii0CUUYsFEZyZwuMHFPKBqCKUQp8p51YJXyT7j1QGjQAaZCj
         6rhNBpiKggr//ccMf4Zs0I3t2lVgh/7+8TIowhfkUpEB9x4wOdN4dpqyFqc8F5q8QrzC
         cYGEhiAwUKVSHruf3k+Gwlt3G19aQf/NcVnPS1EWLpPrTxbskPAKQhkBoi9//IVcCze/
         qbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aSlI1BP4MO0kg+xXcAla7ZyYcbL/l+PUGCfbplzJju0=;
        b=HlYOKc7RTJYE9PNyIt4m49xYdlvXusm1xTU1wsLDn8M4bjRSwsN0t3z9FbBEEVHjFC
         j/Mo3ZDBxRy74Fhu73dQZ6NAYKCxu4x366rgy1MItUV3X4kiD9rwqcwEUpYAiO0xuiMP
         GNxyG822vrIVjOZ5gnmUhHOfFQkgdcBG0CJ8FakcyIuMk3HgESimCgKZ8ya/AbNDqKJw
         CxILPnj686mTy1Pz5IZHcV1LkrL4+Xc0WmKO8Uwi9SgoJpOKb9K05r+b/fP2kiNZWtXX
         YdTa/ftAIi2pbOLn3Svz8G9wIZl0mQ4MjeD7GPC8HLVNJsFYFgqqF9CulyXVzVmml00I
         txwQ==
X-Gm-Message-State: AOAM532jUgqP0TrfhHtCASRKTaxjxL8It4hOUdsNfHFSMOH2TmpS6F64
        tfpEfYJBlazAfdAnpPlPsqZ3ZWhK8ek=
X-Google-Smtp-Source: ABdhPJy3EdZqgwyly4LZh/5lREjG1sB/tc+vuQFgGzaxY4RK5l8mCNQRI1k98DzWlMQNR9JAHR/JvQ==
X-Received: by 2002:ac8:5e54:0:b0:2f1:f60d:2b3c with SMTP id i20-20020ac85e54000000b002f1f60d2b3cmr15401388qtx.667.1651593412050;
        Tue, 03 May 2022 08:56:52 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8744a000000b002f39b99f695sm5920321qtr.47.2022.05.03.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:56:51 -0700 (PDT)
Date:   Tue, 3 May 2022 08:56:49 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Message-ID: <20220503155649.b4ehcez2ytfwyq6e@carlos-mbp.lan>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
 <9b92b380-1da1-b76d-1eb4-469aba289694@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b92b380-1da1-b76d-1eb4-469aba289694@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2022 at 03:03:59PM +0100, Phillip Wood wrote:
> > +
> > +# this prerequisite should be added to all the tests, it not only prevents
> > +# the test from failing but also warms up any authentication cache sudo
> > +# might need to avoid asking for a password
> 
> If this is required for all the tests then it would be simpler just to skip
> all the tests if it is not satisfied as you do above.

it is obviously not required (as shown by some tests in patch 3 not having
it and by my choice if the word "should"), but it still recommended, which
I was hoping would be explained by that comment since if sudo to root is
only allowed "temporarily" by someone typing their password, then sudo keeps
that authentication in a cache, that could probably expire otherwise.

Ironically, this comment was meant to explain why it was not checked once
at the beginning and being used instead in almost every test, but presume
I wasn't clear enough, not sure if worth resubmitting either.

> Running "sudo env" shows that it sets $HOME to /root which means that these
> tests will pick up /root/.gitconfig if it exists.

I think this depends on how sudo is configured, but yes ANY environment
variables could be set to unsafe values that would confuse git if it assumes
it is still running as part of the test suite.

My approach was to make sure (with the prerequisite) that at least we have
PATH set to the right value, so we won't start accidentally running the
system provided git, but you are correct that at least for patch1, the only
thing I can WARRANT to work is `git status`, but it should be also clear
to whoever writes tests using sudo, that it can't be otherwise since git it
is not only running as root, but it is running in the environment that sudo
provides when doing so.

> Normally when running the
> tests we set $HOME to $TEST_DIRECTORY so they are run in a predictable
> environment. At least anything pointed to by core.hooksPath or
> core.fsmontior in that file is expecting to be run as root.

which should be the same expectation of anyone running `sudo make install`
in their own repository, so we are just mimicking the use case we care
about.

core.hooksPath or core.fsmonitor might be relevant now, but there is no way
for me to predict what else might be in the future, and then again `sudo -H`
will behave differently than `sudo` and there is nothing git can do to
prevent that, so I keep thinking $HOME is not that special eitherway.

it might be worth adding that as well as a constrain into the prerequisite
though, so if your sudo does change HOME then we skip these tests, or we
try harder to call sudo in a way that doesn't change HOME instead.

> I think it is
> worth spelling this out explicitly in the commit message (currently it is a
> bit vague about what the implications of not having better integration with
> the test framework are) and the top of the test file. Note that t1509
> sources test-lib.sh as the root user so does not have this issue.

As explained below, there is no way to "explictly" document all things that
might be relevant, and being vague was therefore by design.

t1509 has also a different objective AFAIK, which is to test in an environment
where everything is running as root, which is not what we want to do here.

root is relevant only when we got it through sudo, hence I don't think that
just reading test-lib.sh through sudo as well would be a "solution" in this
case, but I agree with you that for a full integration a lot more would be
needed, which was again documented and punted explicitly.

> > +test_lazy_prereq SUDO '
> > +	sudo -n id -u >u &&
> > +	id -u root >r &&
> > +	test_cmp u r &&
> > +	command -v git >u &&
> > +	sudo command -v git >r &&
> > +	test_cmp u r
> > +'
> > +
> > +test_expect_success SUDO 'setup' '
> > +	sudo rm -rf root &&
> > +	mkdir -p root/r &&
> > +	sudo chown root root &&
> > +	(
> > +		cd root/r &&
> > +		git init
> 
> Using git -C <directory> would eliminate a lot of the sub shells in this
> file

My assumption (and help me understand if it was incorrect) is that these
tests should document the expected use cases, so you are correct that
both cd and -C accomplish the same in the end, but I think that cd is what
users would more normally use, and by writing with it (specially since it
requires a subshell) is also more easy to spot and understand that an
invocation of git with -C.

I have to admit I didn't even thought of using -C originally because of
that, but if you think that makes the test easier to understand and better
I am sure happy to include that in a reroll.

Carlo
