Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74151F461
	for <e@80x24.org>; Sat, 29 Jun 2019 17:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF2RBO (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 13:01:14 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46058 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfF2RBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 13:01:14 -0400
Received: by mail-wr1-f44.google.com with SMTP id f9so9347256wre.12
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i9TMo0Y6vhI1eCP75hKvCIZEb/a8IJwqgFiPfSvec/g=;
        b=D8nb7pnQOu0ZZOLLIXfX98E33uaI8yuUQj4QbDYLTDP7p31a3hW1kVdF8/56tSuaoJ
         gfUwPMBi57mOhOOQj8WXTia5ebZ6SWngfUzf7SF3d0rJ0QV5l1om4MJtEpyF2PuyP9fz
         RcgUmY3WDwV8ugG2RlWE6K2R8qXQ0VzGUKdXd9+/z74Dzo8LT1CaiStqI1888845enbK
         76wnE+RcFGP+5xKhHUY1imoTdWWhvlF0ChNViXi8Uh/olQuhIaM45ywQF7rC/KT3o3Wv
         eAuB3ZcaecW7DK4OCVh25hKRDfuhLmsb5pj3VMHGYLCWxdcYJzhRwnE7TfVeb9O9a5J+
         QlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i9TMo0Y6vhI1eCP75hKvCIZEb/a8IJwqgFiPfSvec/g=;
        b=a5J8wcC6Ln1Dk/N0Khbtgtv10iNYALFV8GbDABx4LbUssDfCf7dr9S4Gmg1XOPhaMw
         AmqfzSI8QGQs0SAU8ka1XG+3y1o+LHVh++D+rPdfwM/GV/P2sl7jnHpdZeiUgOcRsr6l
         w1quDhkwOThZxUt+ZZJQxDzENHQDNqveVbhfCF1wqE/uEiF5A9UCeYhdj+kLOjyFrIXV
         Xl9PD+6+FJCClYx0Z+rOqBxsJIx8LlroiuMCI5xnZp36FXgjCeNuJivhQ2FMbkqIDj9Z
         yxNXWzlyw5IuqLdHfU2bDA18f1RKpVeFRk/yu27dUD1CkVkOl27vSlLqiDWDBvc3Dg6i
         qyBw==
X-Gm-Message-State: APjAAAV8Y0Baytr/+2A2K9D2DDo4AMWvXyKd5xknGhCo4J1H5Pek9DTk
        tB2FN+n1ESWGFiUKvGnRv7o=
X-Google-Smtp-Source: APXvYqyQfQ2uU9DJ7Mv0fslBdlwOdyCXYnpSYPzrsxS98/jz7kQ534ip6YRkmK0g/4+rr7o0MN+pUw==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr12931117wrt.295.1561827671817;
        Sat, 29 Jun 2019 10:01:11 -0700 (PDT)
Received: from szeder.dev (x4db511ea.dyn.telefonica.de. [77.181.17.234])
        by smtp.gmail.com with ESMTPSA id v67sm5687571wme.24.2019.06.29.10.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 10:01:10 -0700 (PDT)
Date:   Sat, 29 Jun 2019 19:01:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Travis not looking so good
Message-ID: <20190629170108.GF21574@szeder.dev>
References: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
 <20190601004143.GN8616@genre.crustytoothpaste.net>
 <20190602112239.GO951@szeder.dev>
 <20190626203559.GA71590@TaylorsMBP3745.attlocal.net>
 <20190627132319.GB21574@szeder.dev>
 <xmqqy31nasck.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy31nasck.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 09:46:51AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > However, we've always used the macOS build jobs as "build and test
> > with the latest and greatest", i.e. they install the latest available
> > Perforce and Git-LFS.  To keep up with this tradition we'd need to run
> > 'brew update' and in turn would need to 'brew install gcc'.
> >
> > [1] See e.g. a1ccaedd62 (travis-ci: make the OSX build jobs' 'brew
> >     update' more quiet, 2019-02-02) or
> >
> >     https://public-inbox.org/git/20180907032002.23366-1-szeder.dev@gmail.com/T/#u
> 
> Is the reason why you did not submit your bonus patch [*1*] in the series at
> 
>   https://public-inbox.org/git/20190614100059.13540-1-szeder.dev@gmail.com/
> 
> because it goes the opposite way, i.e. "build and test with whatever
> happens to be in the image"?

Basically yes... with the other factor being that when I'm not
particularly happy with any of the possible solutions for an issue,
then it tends to end up on a back burner and forgotten for a while...

> Unless what happens to come in the image at travis-ci.org is
> hopelessly outdated and does not match what normal users run,

We explicitly specify which macOS image we want to use in our builds
on Travis CI, see 2000ac9fbf (travis-ci: switch to Xcode 10.1 macOS
image, 2019-01-17), so it's up to us to change that.

Travis CI's current default macOS image is still Xcode 9.4, as it was
at the time of 2000ac9fbf, and the newest is 10.2, which now comes
with GCC 8.3 properly preinstalled (i.e. no 'brew link gcc@8'
necessary).

> isn't
> it is better to test with "whatever happens to be there" than not to
> test at all due to missing compiler?

Better, sure...  Right?  I'm not sure.


> [Reference]
> 
> *1* ... what I picked up from your branch reproduced here
> 
>   https://public-inbox.org/git/xmqqy324t4g0.fsf@gitster-ct.c.googlers.com/
> 
> It is missing explanation and sign-off,

And that patch should be split into two, of course: setting
HOMEBREW_NO_AUTO_UPDATE first to fix the build, and then set
HOMEBREW_NO_INSTALL_CLEANUP separately for a bit of additional
speedup.

> but if it lets the build
> jobs run, even in a tad stale environment, it may be worth
> resurrecting until those who want macOS port working can come up
> with a real "with the latest and greatest" alternative.

'brew update && brew install gcc && export CC=gcc-9' will do it...
but then we'll still spend that ~2.5 minutes spent on updating
Homebrew itself, and there's the possibility that Homebrew breaks, and
eventually GCC 10 will be released and we'll need to update that CC
variable.

Anyway, will look into this again later during the weekend.

