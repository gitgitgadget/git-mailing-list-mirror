Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6A21FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932763AbeAHVq3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 16:46:29 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33130 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeAHVq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 16:46:28 -0500
Received: by mail-qt0-f172.google.com with SMTP id e2so15489447qti.0
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 13:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Os+0nXMN/uOUPd6CjpfYDH8j/Dzl+aGIbgyO66awHtY=;
        b=UYCmK/2We+geK/X+rVlKyP65supx/XFKRCrwZ19RPFdgBPxT++7Y8hsxw2Xio5OV9x
         F/5gxlxaVo5oCHfCrkYCUHsNsX6wfiv2/KjDqAr/QfWWCM5RSPsg4fzIp+PKoIS/HB9C
         xBSd3yAke2CaJOsAw5zlI0r2flK3yAeIyGWS1HHKhjx8QsMfL94ourfRMuper6nF4p1a
         N+Utv9eamBPJsafOpAMyEshpHvjNTVH6UPoR7oCEWY3+t7UqTHPUwwKZ69kp2jGSe4qg
         q6Qk52WJYIaOWnyp1GzLoMvvaHZVxH2MVRHY464nxwKadGajQGU0DkmqJvTZHPWueYVj
         UWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Os+0nXMN/uOUPd6CjpfYDH8j/Dzl+aGIbgyO66awHtY=;
        b=I+s/gR6u9YPO/MsfP72TtpkojXiCXMZccicxdBNbdEJcKLqeT4Ss/Maf55a+Qw6IyP
         /aZgGfu9VY5G++zWov/xfRrRI13eMladq8rpjpqrUXUWofJtWP4JcLQ9mkbQ1vG6gUa3
         yc2XbkGQH64iTQJ9tKOjRdUnkRIdnC2MObLJSnM86TFnnp7j1zdhKcd64ptsABWkUNmD
         SUXX51BZfO7jbpaIxJPD2aohtzEHgrtuuhaAhZuR+SDwg5ykglMcXhb/T5c28bWFrrqO
         Fokmjwv2qTFIXT6MnR5YWuxPd3A4ZQ0y7lg44hIWxo8dx8gxQmXtgfneImzsUmYYSEux
         cc2Q==
X-Gm-Message-State: AKwxytf3e03Q5OdheGWYz2PEekGyZQeyjjQdk8wuLzEZdX4uTHBTk/pw
        b23vlp1nyojkMnt2pxcmNuPkYKsd/fBvseWlflAXI4Z3YPE=
X-Google-Smtp-Source: ACJfBosvTBz0vmPTb1TNMJXOThGHyAWPCnfpsf1PvuLUW5ArXfUYa91GhpYig9X6YK6qjrQ1qwRluNoXSBuVb0anPnU=
X-Received: by 10.200.26.66 with SMTP id q2mr385357qtk.174.1515447987207; Mon,
 08 Jan 2018 13:46:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 13:46:26 -0800 (PST)
In-Reply-To: <CAP=KgsSQOG=mmUDfSFDw0HJYvJWVPFU7M5T+k4VhfuRC_v9dww@mail.gmail.com>
References: <CAP=KgsSQOG=mmUDfSFDw0HJYvJWVPFU7M5T+k4VhfuRC_v9dww@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 13:46:26 -0800
Message-ID: <CAGZ79katKiRwXLJscxbO-+JWLedgKmZ7Un-65i4CqefX9Fedqg@mail.gmail.com>
Subject: Re: cherry-picking fails after making a directory a submodule
To:     Per Cederqvist <cederp@opera.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 1:08 PM, Per Cederqvist <cederp@opera.com> wrote:
> I have a situation where I have switched a directory from being a
> subdirectory to being a submodule.  I then try to cherry-pick a commit
> from a taskbranch that was made before the switch to the master
> branch.  The commit touches a file outside the subdirectory/submodule.
> Yet "git cherry-pick" fails with this error message:
>
>> error: could not apply 78c403e... Add a project feature
>> hint: after resolving the conflicts, mark the corrected paths
>> hint: with 'git add <paths>' or 'git rm <paths>'
>> hint: and commit the result with 'git commit'
>
> I can resolve the situation by running "git add libfoo && git
> cherry-pick --continue".  The generated commit contains no changes to
> "libfoo".
>
> I don't understand why I need to manually add libfoo, as the commit
> I'm cherry-picking doesn't touch anything in libfoo.
>
> The script below can reproduce the issue.  Tested with git 2.15.1,
> 2.14.0 and 2.8.0, all with the same result.
>
> Is this a bug in "git cherry-pick"?

Could you please test with
github.com/git/git/commit/c641ca67072946f95f87e7b21f13f3d4e73701e3
included? (See its parent commit, for the test)

From my cursory read that commit is the issue addressed in that commit.
