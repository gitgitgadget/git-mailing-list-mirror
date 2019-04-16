Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0596C20248
	for <e@80x24.org>; Tue, 16 Apr 2019 18:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfDPSsV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 14:48:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 14:48:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so337583wmi.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4RqUzF9LnRV9PSTxazPwsU+ES3Ia8InAP+xAYn/2V0g=;
        b=uQiIZ+ZmIxlzukJC/Z2lLNseTfcxkkgRYasRAmaSORTKRS39L7dQvWcWIWW/gyTGSR
         jhWoarCsT9EC00qcApZ9ksHduVnMykHYlEMfLQU52HmYzSivYCmfnQ7FIrnYpLWj4CQ0
         PkZaqAXE88y7HV9Sxv3SJ3ONo3zYMmtsceYxWKKSlt/NM5YTAZQ1ugMuFFwk6iN/5M7x
         lcbPXd3nphHtrNyPYp5IqLrXS49ejq06x2QgoAQVE7XVkBnPwSbnFXJu3IcCHTqO3Sor
         wBOzrYx4BmutwHH8J8cqwlGqikYLUX6Y+Vnh49qJPSOYGdgcGNbnmEieosUz+FEaGgpq
         xpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4RqUzF9LnRV9PSTxazPwsU+ES3Ia8InAP+xAYn/2V0g=;
        b=JU/weDL/tPgvMCZc+oBgCCLkbWkrOwmiEmtpPSyTjae8UUKbWStln15x1WQRgCAFV0
         wtjcsibF8nAQmx7LW3NCMZFub0Tv9AYupVNayErSxg6J5PTECwOx34Cd3QUgTWG/1BOQ
         trnoucG2QpN4Ps+CCHoEHBh2MttihBERbH2xH8tM9jTF8vrEc3ItTokGwlN1FoPBFL0F
         wppehZWnHXaS1pSGFucZQXP2FC3S746qJCM3gDbogIWc+YpVliFxkcx+oimGXnWld+FF
         6aO6t5tB3TmNugugI7AXcTcFuAV3AjWF/ZiWAGNoGhGNwWaZUyJVVKSreQhz0q7CRtBR
         Uoyw==
X-Gm-Message-State: APjAAAWn7uZx9sd4OzlyMU/rQxEoqZirNTKACehGxhfTi7hjucV8kV31
        0qzT5+QD7eyA4n9pFbi7rA20D1Pc
X-Google-Smtp-Source: APXvYqxK3eRfRWoPH5BF8jOX6pPErkyDNoc9Wmk/DbLTLvmuDppfdab07NtO6xxySCrSyu4IMbnKOg==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr28901385wml.110.1555440498903;
        Tue, 16 Apr 2019 11:48:18 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id t17sm48747323wrr.26.2019.04.16.11.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 11:48:17 -0700 (PDT)
Date:   Tue, 16 Apr 2019 19:48:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Vetter <christian@rasenplanscher.info>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git stash --keep-index undeletes file
Message-ID: <20190416184816.GU16414@hank.intra.tgummerer.com>
References: <1555437849815.60450@rasenplanscher.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555437849815.60450@rasenplanscher.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/16, Christian Vetter wrote:
> Steps to reproduce
> + mkdir git-stash-test
> + cd git-stash-test
> + git init
> + touch file
> + git add file
> + git commit -m init
> + git rm file
> + git stash push --keep-index
>  
>  
> Result: 
> `git status` gives this output:
> > On branch master
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> > 
> >         deleted:    file
> > 
> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> > 
> >         file

I think this is the correct result.  --keep-index keeps the changes
that are in the index, in this example that 'file' is deleted, but
restores the working tree to 'HEAD', where 'file' existed.  It's now
showing up as untracked because Git doesn't know about it.

Similarly if you just did 'git stash push' without --keep-index,
'file' would be restored in your working tree, but 'git status' would
report the working tree as clean because it would also be restored in
the index.

> Expected: 
> `git status` gives this output:
> > On branch master
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> > 
> >         deleted:    file

This is what you get before 'git stash push --keep-index'.  Do you
think the documentation on '--keep-index' is unclear, and could be
improved?  Or why did you think that this is the correct output?

> Verified on:
> + Windows 10, git version 2.21.0.windows.1 
> + Ubuntu 14.04, git version 2.21.0
