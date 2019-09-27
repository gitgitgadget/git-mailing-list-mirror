Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B299F1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 12:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfI0MCH (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 08:02:07 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37223 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0MCH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 08:02:07 -0400
Received: by mail-wr1-f54.google.com with SMTP id i1so2433741wro.4
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsVU7h/AMJQnyqPwXDcuhLkau2+rWHdZhWjETdnJ9KQ=;
        b=tukZ6OzuBgv17fYzyuoBBdZeZrvKjW2DZfg7/695ot7vqTxiWtcjizL0VnmHjSbhJf
         536pNPCxJJHfK6nTLIOF3jZ4gzFte61G1ylPVxHTBMMxx7F5zBht1MQ+8rWYO1CK06J3
         7Awqg5n9WtvIjePT9MBPb9We4/A2ckSgwRa/XFtFNqm3lrlcM3bG9JxjzxlkI0NsjhQX
         uchGGJXDSBn7E7wYswTn3REZS1s5qqY58vW5oUmOrwbQYfKzYhb+5UcVSOw1nikDwivr
         UcwGBedf1pp10YIu3u+5j02QYrU8O18SzO9w9eVMZ3Bve1R4cvIWDmc9B8RcBxObovme
         +gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsVU7h/AMJQnyqPwXDcuhLkau2+rWHdZhWjETdnJ9KQ=;
        b=X0D2NkImDQEdo1T8Lnd4y4DX7hcPrAgXsPyQM/0aY8wifwFQ9hrxL5ZBZ8ZLo1eNyB
         dABLGCnjNWOXazEyuXJH9HGWcx9gGPpXwH/OE+XCm0hK4vou846uDtl4/GKLyqg85NFt
         ylclp+Bvd8uhD81MJMqWMnUR4kKgZxyn4VmlaLB3dE99rdQalZSuy5wVtpiiwxyDwixz
         7rknNOAwhwvDN5woNp/8vx5hLcqmKzqfvwXlMG9CxL9kHhJ21ilxdRH+djqPWx0BEwQj
         Acr9sPQePFnswu5hhlf7zq54ySXrPVkKC/ngt35ykGwNsMJ3o78vour//ICSVO/a1eAw
         Q+Hw==
X-Gm-Message-State: APjAAAWJAb4nEY6eB7RCWrY1oPvFUn4xqzBQG5y7CMey5CzpOyRrvQTK
        DKuV2Nh6T+GR3RzCHIfuNjrYRhk5Dow=
X-Google-Smtp-Source: APXvYqxFBTJh1yoCo6FZQCh3LAHyosjy5zqHAOwens292/dVonbcAwOdtKN4STm/uXK6yFo+SewinQ==
X-Received: by 2002:adf:ec85:: with SMTP id z5mr2878916wrn.374.1569585725367;
        Fri, 27 Sep 2019 05:02:05 -0700 (PDT)
Received: from szeder.dev (x4db42589.dyn.telefonica.de. [77.180.37.137])
        by smtp.gmail.com with ESMTPSA id b7sm2508821wrj.28.2019.09.27.05.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 05:02:04 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:02:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Anders Janmyr <anders@janmyr.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible bug in git describe, additional commits differs when
 cloned with --depth
Message-ID: <20190927120201.GM2637@szeder.dev>
References: <CA+UvoT7EBa6S6Fi7scYTo8mYKx=n1e=sPvxy5TRP3vG7gw97Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+UvoT7EBa6S6Fi7scYTo8mYKx=n1e=sPvxy5TRP3vG7gw97Xw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 11:51:07AM +0200, Anders Janmyr wrote:
> Hi,
> 
> I'm not sure if this is a bug or not but `git describe` gives
> different results when the repo has been cloned with `--depth` or not.
> 
> In the example below from the git repository the number of additional
> commits since the
> last tag differs 256 vs. 265.
> 
> ```
> $ git clone https://github.com/git/git
> $ cd git/
> $ git describe
> v2.23.0-256-g4c86140027
> $ git rev-list -n 1 HEAD
> 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
> 
> 
> $ git clone --depth=50 https://github.com/git/git git-depth
> $ cd git-depth/
> $ git describe
> v2.23.0-265-g4c861400
> $ git rev-list -n 1 HEAD
> 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
> ```

I don't think this is a bug, but rather an inherent limitation of
shallow histories with lots of merges, and it affects not only 'git
describe', but any limited history traversal.

In the Git project new features are developed on their dedicated
branches, which are then eventually merged to 'master'.  Alas, we make
mistakes, and sometimes we realize that a feature was buggy after it
has already been merged to 'master'.  In such cases the bugfix is
often applied not on top of 'master', but on top of the feature
branch, so it can be merged to maintenance releases as well.

This results in a history like this:

  M2     Merge the bugfix to 'master'
  |  \
  |   \
 v2.0  |
  |    o  Bugfix for new feature
 CO2   |
  |    |
  M1  /  Merge 'new feature' to 'master'
  | \/
  |  o   new feature
  |  |
  |  o
  |  |
  | CO1
  |  |    
  | /
 v1.0

Describing M2 in a full repository results in something like
v2.0-2-gdeadbeef, because M2 contains only two commits that aren't in
v2.0, (M2 and the bugfix).

Now let's suppose that in a shallow repo the given '--depth=<N>'
resulted in a cutoff at commits CO1 and CO2, meaning that the shallow
repo does not include commits M1 and v1.0.  Consequently, Git can't
possibly see that the commits implementing the new feature are already
merged and thus reachable from v2.0, so it will count those commits as
well, resulting in v2.0-5-gabcdef.

There is a lot more going on in the Git repository, so it's not as
simple as above.  Case in point is the merge d1a251a1fa (Merge branch
'en/checkout-mismerge-fix', 2019-09-09), which merges a fix to a bug
that happened before v2.22.0-rc0, but that bug was not introduced in
the feature branch, but while merging that branch to 'master'.  The
result is still the same, though: since there are a lot of commits on
the ancestry path between that buggy merge and v2.23.0, '--depth=50'
doesn't include them all in the shallow clone, so Git can't possibly
know that that merge is reachable from v2.23.0.

  # same in both the full and shallow repos
  $ git log --oneline v2.23.0..d1a251a1fa^ |wc -l
  57

  # in the full repo
  $ git log --oneline v2.23.0..d1a251a1fa |wc -l
  59

  # in the shallow repo
  $ git log --oneline v2.23.0..d1a251a1fa |wc -l
  132

> In the example above the first version also gives additional digits
> for the SHA,
> g4c86140027 vs. g4c861400, but that is not always the case.

Git shows as many hexdigits as needed to form a unique object name
with a few additional digits worth of safety margin.  There are a lot
more objects in the full repository than in the shallow clone, which
means more hexdigits in the abbreviated object name.


Thanks for letting us know.  I think this is worth a warning in
the documentation of 'git clone --depth'.

