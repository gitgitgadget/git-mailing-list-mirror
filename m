Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAE020248
	for <e@80x24.org>; Sat,  6 Apr 2019 05:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfDFFbT (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 01:31:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40444 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFFbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 01:31:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so4152667pgo.7
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 22:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gWTLTu5OsVjfZN0wdfF7C1a+mvU0Dxj22QjYI80J5+E=;
        b=bytMNlQZUyINmNH8bbjYQsp8GpZ/W0Q1sDtlMjObafoudfAW5SoDQzC5F+CxFV6lK/
         d+3lXnXHCe9WHXciNfHtFhwJE7rbEL1+QWolsiUYJ9NzNvazpL0KiA00tOYwq1/y9zBN
         X2GlS4bRl0k6wTCNDQ4DuN4FD7bC1Bm/ou038hKFhx1brMDfFU2+ek73MBGo50ecCkPn
         tzm4l5ysIEfVRYaOI98XosWGFIkScgkRwbYdwZnvzRlVKukK3gvcoRbaK7P1d8tGHa0h
         HTL6fQm1ye5w7YY6YPm9kLhsZI7bmogLYSRN5Ef+IvuUeO/LZpVYkxUxeDLXawyviIYY
         qi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gWTLTu5OsVjfZN0wdfF7C1a+mvU0Dxj22QjYI80J5+E=;
        b=t3xxJlKbbNe4uoGZGGL1l/vYRCZG/zeYrogdRwQ3up0lpvRXyCweaiPPTNNYHuqaBx
         WmOibEMrKPksYet7SkNx0k/wvJJbh6G/HVx3d8rzQTheyKs/qQZFO9qVzyt7ooBBfHCm
         XiS7sAijM5Y7Jkf85Z/AVvJgXkXmrisyCyKvBsHqnF5ZZyLDoLfR2sywA0cOMztaJqWC
         pLPRN9rPcLd2svHTyfocxYwrjqdwD2vAWK2R2Zq3w2vlxDscnVCmojObE79Pb1+G7vsG
         ZLGN3sAfO4ePWaDVfG5PjvL2Ko/F3tpJkdwvznaStsPK27V785mBXwCwTQ0l9ZTQEM4H
         K6Ow==
X-Gm-Message-State: APjAAAW5EddqOO9VPnCO7RNO49u9LzyAkAUIwxqY6gxIoQ2ACJa77aWM
        5igxk/+97yNbY6/fBITftLhH8Q==
X-Google-Smtp-Source: APXvYqz2L48thfjbJY2QK6CLSfNvnh2mi8ef040CPbVsybuu8NDv6HEgUOoxhTybU01bFuh3b2QWrA==
X-Received: by 2002:a62:1f92:: with SMTP id l18mr17161519pfj.180.1554528677500;
        Fri, 05 Apr 2019 22:31:17 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e077:74b2:7faa:e131])
        by smtp.gmail.com with ESMTPSA id d8sm19874224pgv.34.2019.04.05.22.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 22:31:16 -0700 (PDT)
Date:   Fri, 5 Apr 2019 22:31:15 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190406053115.GB37216@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405182412.GC2284@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 02:24:12PM -0400, Jeff King wrote:
> On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
>
> > > +test_expect_failure 'traverse unexpected non-tree entry (seen)' '
> > > +	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1
> >
> > This test saves standard output and error, but doesn't look at them.
>
> I think we want to be checking for "not a tree" here, which is later
> added with the fix. But either we should have the test_i18ngrep here
> initially, or we should add both the redirect and the grep with the fix.

Right, pointing out that saving the standard output and error of 'git
rev-list' and then doing nothing with it as being redundant is certainly
right.

I think that the 'fix' here is to write instead:

  +test_expect_failure 'traverse unexpected non-tree entry (seen)' '
  +	test_must_fail git rev-list --objects $blob $broken_tree
  +'

And _then_ add '>output 2>&1 &&' to the end, capturing the output, as
well as the appropriate test_i18ngrep. This matches the pattern that
we've been otherwise following in the series so far.

(FWIW, I think that this is also the result of squashing the series down
a few times...)

> > > +test_expect_success 'setup unexpected non-commit parent' '
> > > +	git cat-file commit $commit |
> > > +		perl -lpe "/^author/ && print q(parent $blob)" \
> > > +		>broken-commit &&
> >
> > Don't run git commands upstream of a pipe, because the pipe hides
> > their exit code.  This applies to several other tests below as well.
>
> I disagree with that rule here. We're not testing "cat-file" in any
> meaningful way, but just getting some stock output from a known-good
> commit.
>
> > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> > dependency?
>
> Heh, this was actually the subject of much discussion before the patches
> hit the list. If you can write such a one-liner that is both readable
> and portable, please share it. I got disgusted with sed and suggested
> this perl.

I admit that this gave me a chuckle, too. When preparing this series to
send it, I did something like:

  $ git rebase -x 'make && cd t && ./t6102-*.sh

but found that it was broken on the BSD sed that ships with macOS
10.14.2. I didn't notice until preparing the series for upstream because
I wrote it on my Debian 9 VM, with GNU sed (where it is not broken ;-)).

It was originally written as:

	test_expect_success 'setup unexpected non-commit parent' '
		git cat-file commit $commit | sed "/^tree/a\
		parent $blob" >broken-commit &&
		broken_commit="$(git hash-object -w --literally -t commit \
			broken-commit)"
	'

> -Peff

Thanks,
Taylor
