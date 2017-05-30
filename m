Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21D22027C
	for <e@80x24.org>; Tue, 30 May 2017 18:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdE3SLe (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 14:11:34 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36812 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdE3SLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 14:11:33 -0400
Received: by mail-pf0-f173.google.com with SMTP id m17so79158483pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzgfEloCxhUTWONOC9CNlIV2wqTr3jl4PLp9RG3FQS0=;
        b=bZ62ZDQL5XmgKd6ZBz5bCWgCdGA7qOwqBA9vkM7/Ms4PySUWGfKOl9zGRXxbyxHEAG
         YbUdhK8YCpNff7sOPwWGzPT5vUziel39v0VLc7LUKm96mGRxDBWBA3eX53sxTybfA8lP
         D54ZgI2tlDt1hleGztvf6jRnohovNw62td4g5NaMPqZj7BeGTF0gHwX8lO75ssI7InJZ
         oRI004hVREcO/8BNqabf/hBDYvoxkeKwI7JcfVB8RCzZL8OSl5jii8ZKK6cH6CB6zuQs
         nzwHFo92U0BTMNuQl//+oP4Yc4Uef9+KIA/7E7MRCbukcgzZR77Za5BRM90qOIxJDlZd
         VdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzgfEloCxhUTWONOC9CNlIV2wqTr3jl4PLp9RG3FQS0=;
        b=Dfab60LZT2Tke0I60f1VOOft/TMbG0KWyTzADGi83JRTFFyVrizbBQZDfdoRiOoaeQ
         mJse6uqlqxHy0F0nTT9XYe2fEQCpZWWPIS6HuDeYF8pedXfsNxr3a1aE/+Rnqe9x+GoB
         KX10eC8phtZ0e4jml20rlf95Q7m1IpzcqwWk4bM2jKcXxD6I9nscQSPVSaZWm5SGGoW+
         LOag4KmpAHBbDm06TOETgzS61Ny9Hes+vxO5QRSSNiCd3OUfF8w0qOPVon9J6vTtobQy
         UpnJBkHwmVhpGJYZY9tra1aENOnvnVCxQcpg26j71a5WKw1VblwyzflWmm0lodCy35BA
         +0MQ==
X-Gm-Message-State: AODbwcDmJMkyj6mf3Erc3lad+BZMmlpJ6YJS3D6NC/XXdmWDSvcafPoT
        IvTSsYSvjnBTYMconPo=
X-Received: by 10.84.135.101 with SMTP id 92mr61000030pli.114.1496167887548;
        Tue, 30 May 2017 11:11:27 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:2531:ecb3:c847:ba4b])
        by smtp.gmail.com with ESMTPSA id 80sm21794749pfy.18.2017.05.30.11.11.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 11:11:26 -0700 (PDT)
Date:   Tue, 30 May 2017 11:10:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     John Shahid <jvshahid@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
Message-ID: <20170530181051.GA81679@aiede.mtv.corp.google.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

John Shahid wrote:

> It looks like the git push recurse-submodules behavior has changed.
> Currently with 2.13 you cannot run "git push
> --recurse-submodules=on-demand" if the parent repo is on a different
> branch than the sub repos, e.g. parent repo is on "develop" and
> sub-repo on "master". I created a test that can be found here [1].
>
> A bisect shows that the change to propagate refspec [2] to the
> submodules is the culprit. imho this is an undesired change in
> behavior. I looked at the code but couldn't see an easy way to fix
> this issue without breaking the feature mentioned above. The only
> option I can think of is to control the refspec propagation behavior
> using a flag, e.g. "--propagate-refspecs" or add another
> recurse-submodules option, e.g. "--recurse-submodules=propagate"

Thanks for reporting.  The old behavior of "git push
--recurse-submodules" was a little loose (it would run "git push" in
the submodule and rely on defaults to determine the behavior) and when
propagating refspecs we considered taking the opportunity to tighten
that by propagating the default refspec when you run "git push
--recurse-submodules" without a refspec.

We didn't make that change.  If starting over, it might be a natural
thing to do, but we didn't want to break existing users.  So

  git push --recurse-submodules=on-demand

should continue to work as before.  *puzzled*

[...]
> We have a parent repo on a branch called "develop" and a submodule on
> a branch called "master". Prior to git version 2.13 if we had an
> unpushed commit in the submodule and ran "git push origin develop
> --recurse-submodules=on-demand" git would happily push the develop
> branch of the parent repo and the master branch of the submodule,
[...]
> pushing to ref refs/heads/develop:refs/heads/develop
> pushging to remote origin
> fatal: src refspec 'refs/heads/develop' must name a ref
> fatal: process for submodule 'sub' failed
> fatal: The remote end hung up unexpectedly

Aha, you are passing a refspec!

Can you say more about how this change affects you?  Would you be able
to push without a refspec, or do you e.g. have scripting that was
relying on the existing loose behavior?

To put this in more context: part of the ideal that
--recurse-submodules options are trying to achieve is to allow
thinking of a repository as a single unit, including submodules, most
of the time.  To this end, "git clone --recurse-submodules" clones a
repository including its submodules, "git checkout
--recurse-submodules" checks out submodules as part of a checkout
operation, avoiding a separate "git submodule update --init" operation,
"git fetch --recurse-submodules" fetches upstream changes for both the
parent repository and submodules, and so on.

Unfortunately "git checkout --recurse-submodules" was missing a piece,
impacting this workflow.  If I run

	git checkout --recurse-submodules -b develop

then today this creates a "develop" branch in the superproject but not
within submodules. This hurts the illusion of the project being a single
unit and makes the meaning of operations like

	git push --recurse-submodules develop:master

unclear.

Ideas for next steps:

 1. If "git checkout --recurse-submodules -b develop" does the right
    thing, then this situation is harder to get in in the first place.
    The series at [3] is meant to do that.

 2. The error message shown above is very unclear. It leaks
    implementation details and doesn't give the user a clear hint
    about what to do to resolve it.  Would some message like the
    following have helped?

	$ git push --recurse-submodules origin develop
	fatal: branch "develop" does not exist in submodule "sub"
	hint: use "git -C sub branch develop <sha1>" to create such a branch
	hint: or push without a branch name to push the current branch

 3. Outside of the output from any particular command, we are missing
    an equivalent of "man gitworkflows" to describe how the
    --recurse-submodules options are meant to work.  The series at [4]
    aims to start addressing that.

Given all the above, this looks like a real and serious bug but I
think to find a different way from --recurse-submodules=propagate to
fix it.  The idea, especially with [5], is for submodules to work
intuitively without requiring special options.  This can require more
work in the short term getting the default behavior to work well with
a variety of use cases but I think it is time well spent.

Thoughts?

Thanks and hope that helps,
Jonathan

> [1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
> [2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780
[3] http://public-inbox.org/git/20170501180058.8063-1-sbeller@google.com/
[4] http://public-inbox.org/git/20170209020855.23486-1-sbeller@google.com/
[5] http://public-inbox.org/git/20170526191017.19155-1-sbeller@google.com/
