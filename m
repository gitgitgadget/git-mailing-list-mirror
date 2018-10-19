Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB7A1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 08:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeJSQa7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 12:30:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46891 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJSQa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 12:30:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so30625325edg.13
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qEaNqYBsJ0O4MEg1Zh9hBGEQP3iskODaSzH5YxcjSLs=;
        b=S4FnK+hX25JjTCB7LvIxKbk8X8LAPZx8P+ROjp95E6C4sUFqhFzVvTqG9IFMCHh1P5
         ia7RH5pJyDQeE8JpHl0lGgWJ6epsBAEL0QUo2t4VpdeLFge2wjrGkUJr3JZxM7mB90pl
         hH5WLdkoEDE2FtA1QxOLCmdLlUohJSAI5sxYVkLqk+Dg3oW+3fYe38+BKNr2K1UbRpjz
         6yiiSzY1wn0ML29zD9Db0N+xnKzmaa4BpeKEcAp0G7qInUeYiJkHKZOVpumKKFCPK1du
         XK+wRZ68eZNlEm5uwT0C5A5qpJHu19pRsDpQfvW3IYO3kYewhIEylWI15XlvHand/5Wz
         sPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qEaNqYBsJ0O4MEg1Zh9hBGEQP3iskODaSzH5YxcjSLs=;
        b=Kf+98rA4iqAaYMzf6YdrknMegeaWjBAByxrvTPkqoyVy5j1vV6BUKlPxtBvAbxWqYq
         4h4JTc9csPQzWitI99HDK7gxGwYOdN6AShBsl69J0VuRDzXtvvslvwtB0gsRourH+w62
         rJ+nHx7mn85fqZB9HRWJZS8Yih0NPs9B0q/cg1T5kn197ChHQgyfsf0Ye1ugBylN5Lx7
         LJDLNJeIPVzGdR+VOvqw6XzCmuYy3GpPpKTQzDxq4vKz0sOLgvGjQSlzzFLpcuqKk+fE
         +EaRkhJ37JyvstYC/Gl8ek28iR1Yst9y9efnCIUoB60/s132yn5pqmV0Dw/H6GzFFGJz
         PHig==
X-Gm-Message-State: ABuFfog+06X8ed8bW9aCuR3WESHDeR5cLilxXdGNmwJZKOLOS3b6dpSr
        ib7WQHhhSIKUbIPECn4YliQ=
X-Google-Smtp-Source: ACcGV61NbjMRu4I91K+8XbRJlpyxpaTBUUVNJKdrQaiDbTSC4ZgdNULEjO27zcAMvPlSIOWaxObGfA==
X-Received: by 2002:a17:906:778e:: with SMTP id s14-v6mr30401804ejm.190.1539937555341;
        Fri, 19 Oct 2018 01:25:55 -0700 (PDT)
Received: from szeder.dev (x4db1e3c6.dyn.telefonica.de. [77.177.227.198])
        by smtp.gmail.com with ESMTPSA id y21-v6sm4732354eje.45.2018.10.19.01.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 01:25:54 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:25:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/13] ci/lib.sh: encapsulate Travis-specific things
Message-ID: <20181019082552.GV19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <815152e0f57d545ae2fae7429c16e5be497746be.1539598316.git.gitgitgadget@gmail.com>
 <20181018220106.GU19800@szeder.dev>
 <xmqqy3au3d26.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy3au3d26.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 11:06:25AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Mon, Oct 15, 2018 at 03:12:00AM -0700, Johannes Schindelin via GitGitGadget wrote:
> >> diff --git a/ci/lib.sh b/ci/lib.sh
> >> index 06970f7213..8532555b4e 100755
> >> --- a/ci/lib.sh
> >> +++ b/ci/lib.sh
> >> @@ -1,5 +1,26 @@
> >>  # Library of functions shared by all CI scripts
> >>  
> >> +if test true = "$TRAVIS"
> >> +then
> >> +...
> >> +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> >> +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> >> +fi
> >
> > Please set all these variables ...
> 
> Do you mean "VAR=VAL; export VAR" is kosher, "export VAR=VAL" is
> not?
> 
> >> @@ -81,7 +102,6 @@ check_unignored_build_artifacts ()
> >>  # and installing dependencies.
> >>  set -ex
> >
> > ... after we turn on 'set -x', so the variables' values will be
> > visible in the logs.
> 
> Ah, no, you didn't.  Although I think both are valid points, I think
> ci/lib.sh is expected to be used only inside a more predictable
> environment (e.g. we know the shell used is not a random POSIX shell
> but one that is happy with "export VAR=VAL"), so it should be OK.

Yes.  Travis CI runs an Ubuntu LTS, where /bin/sh is dash, which
understands 'export VAR=val' just fine.  I don't know what Linux
distro runs on Azure Pipelines, but the build definition in patch 6
explicitly asks for Bash, so that should be fine as well.

> Showing the values of these variables in the log may still be good
> idea.
> 
> > (Or move this 'set -ex' to the beginning of the script?  Then we
> > could perhaps avoid similar issues in the future.)
> 
> Sure (provided that it is an issue to begin with---if we are
> interested in the value of TRAVIS_BRANCH, for example, being able to
> see it only because "CI_BRANCH=$TRAVIS_BRANCH" assignment is made
> feels a bit sideways---we'd be better off explicitly logging
> anything we are interested in in the longer term, no?).

Well, all the $TRAVIS_* and $CI_* variables are not that interessant,
because they are only used in the build scripts, and then we can see
their substituted values in the build logs.  The same applies to
the variables $cache_dir and $BREW_INSTALL_PACKAGES as well.

$GIT_PROVE_OPTS and $GIT_TEST_OPTS, however, are only used in
't/Makefile' but not in the build scripts, thus their values don't
show up in the build logs.

I run some Travis CI builds with custom $GIT_TEST_OPTS, which, of
course, conflicted with this patch, and I messed up the conflict
resolution.  I think I would have noticed sooner what went wrong, if
the value of $GIT_TEST_OPTS were visible in the build logs.

I've found the output with 'set -x' sufficient so far, and don't think
that an explicit logging facility is worth it.

