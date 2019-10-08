Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068971F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfJHMcC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:32:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfJHMcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:32:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id p14so18262003wro.4
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FWFNl886VIeE9OhyOjPKYlSoMPxaR/2WUvsikNDTHwA=;
        b=KP9D09fukyoF8AtQ28sqy+RTXjRvKX5YQxu1rv+fS8XfcfygTspn8PJSGPfmOA7Bjr
         64AWGJpRyed4wSSBJCpEkfUJEZW9wfe5+IHLAfCIf7pwOvr2KDb1LoEJmJ5ja+GtkMdm
         N2lhTZTFokz46CsPLQ2BDMqdysIlm0yseGnnznvxeITGgigvPobmgZXg8I8tZC6cvyux
         MGllz7XcmhFoy1+kpj20K/pNxx2yOCHNEivdux2PofpfdZmsK7Ya4s+7JIuDYQs+8Kzo
         LweX33VgMZvIX92JhvDMWboHC1ab4MjL/u09oDSiI0hPObNTX6864rtHB4ftfVo+/UIb
         WjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FWFNl886VIeE9OhyOjPKYlSoMPxaR/2WUvsikNDTHwA=;
        b=NeoAvaRA66Me1qNea01Kygtl7ek0oEORQTiQNIZpHoTkd3XubEJkNQPxaIkI42cVev
         +VnTFEdFTwv032QpXlZJViYcMq/gTRb5KFRnCb2u0TRTkC7tKLR1DSK6YRbJs4Qje70f
         bXfazxfcPz2axo3AxE8gZ6M1wu4naj6dIXtagSYdZ1Ztt2kH97E1y/v5wrtjutyzDTI8
         9fRZAMHWst595M61KGwmko5O/Ur8UvU/TXKbh2X0i+RSrL59d3QvDd1mSRNY+CLOJa33
         67uQCSjYQqJ7cS2muFVmsuQeqY7Lx+U5yDOIeCEY52xUm5AvncqHwrugHuXSq5AxfyGC
         sC7g==
X-Gm-Message-State: APjAAAUXCxYciLF78Xm2GRP4myiwi4syUye0hnRUb33TaOtevT56KfG3
        5Ae4LAgGKST2Gim8admHNhAxohmn
X-Google-Smtp-Source: APXvYqz2gqB19uvisJ5Oj6JwuxV1kuu0ojMeup6ioBjY2kvhTB+13N7pRsQbSLMCZ3f7JwsQ5VsU9Q==
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr26274892wrj.321.1570537918546;
        Tue, 08 Oct 2019 05:31:58 -0700 (PDT)
Received: from szeder.dev (x4dbe0d12.dyn.telefonica.de. [77.190.13.18])
        by smtp.gmail.com with ESMTPSA id h10sm17586441wrq.95.2019.10.08.05.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:31:57 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:31:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Anders Janmyr <anders@janmyr.com>
Subject: [BUG] a commit date-related bug in 'git describe' [was: Re: Possible
 bug in git describe, additional commits differs when cloned with --depth]
Message-ID: <20191008123156.GG11529@szeder.dev>
References: <CA+UvoT7EBa6S6Fi7scYTo8mYKx=n1e=sPvxy5TRP3vG7gw97Xw@mail.gmail.com>
 <20190927120201.GM2637@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190927120201.GM2637@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 02:02:01PM +0200, SZEDER Gábor wrote:
> On Fri, Sep 27, 2019 at 11:51:07AM +0200, Anders Janmyr wrote:
> > I'm not sure if this is a bug or not but `git describe` gives
> > different results when the repo has been cloned with `--depth` or not.
> > 
> > In the example below from the git repository the number of additional
> > commits since the
> > last tag differs 256 vs. 265.
> > 
> > ```
> > $ git clone https://github.com/git/git
> > $ cd git/
> > $ git describe
> > v2.23.0-256-g4c86140027
> > $ git rev-list -n 1 HEAD
> > 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
> > 
> > 
> > $ git clone --depth=50 https://github.com/git/git git-depth
> > $ cd git-depth/
> > $ git describe
> > v2.23.0-265-g4c861400
> > $ git rev-list -n 1 HEAD
> > 4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
> > ```
> 
> I don't think this is a bug, but rather an inherent limitation of
> shallow histories with lots of merges, and it affects not only 'git
> describe', but any limited history traversal.
> 
> In the Git project new features are developed on their dedicated
> branches, which are then eventually merged to 'master'.  Alas, we make
> mistakes, and sometimes we realize that a feature was buggy after it
> has already been merged to 'master'.  In such cases the bugfix is
> often applied not on top of 'master', but on top of the feature
> branch, so it can be merged to maintenance releases as well.
> 
> This results in a history like this:
> 
>   M2     Merge the bugfix to 'master'
>   |  \
>   |   \
>  v2.0  |
>   |    o  Bugfix for new feature
>  CO2   |
>   |    |
>   M1  /  Merge 'new feature' to 'master'
>   | \/
>   |  o   new feature
>   |  |
>   |  o
>   |  |
>   | CO1
>   |  |    
>   | /
>  v1.0
> 
> Describing M2 in a full repository results in something like
> v2.0-2-gdeadbeef, because M2 contains only two commits that aren't in
> v2.0, (M2 and the bugfix).
> 
> Now let's suppose that in a shallow repo the given '--depth=<N>'
> resulted in a cutoff at commits CO1 and CO2, meaning that the shallow
> repo does not include commits M1 and v1.0.  Consequently, Git can't
> possibly see that the commits implementing the new feature are already
> merged and thus reachable from v2.0, so it will count those commits as
> well, resulting in v2.0-5-gabcdef.
> 
> There is a lot more going on in the Git repository, so it's not as
> simple as above.  Case in point is the merge d1a251a1fa (Merge branch
> 'en/checkout-mismerge-fix', 2019-09-09), which merges a fix to a bug
> that happened before v2.22.0-rc0, but that bug was not introduced in
> the feature branch, but while merging that branch to 'master'.  The
> result is still the same, though: since there are a lot of commits on
> the ancestry path between that buggy merge and v2.23.0, '--depth=50'
> doesn't include them all in the shallow clone, so Git can't possibly
> know that that merge is reachable from v2.23.0.
> 
>   # same in both the full and shallow repos
>   $ git log --oneline v2.23.0..d1a251a1fa^ |wc -l
>   57
> 
>   # in the full repo
>   $ git log --oneline v2.23.0..d1a251a1fa |wc -l
>   59
> 
>   # in the shallow repo
>   $ git log --oneline v2.23.0..d1a251a1fa |wc -l
>   132

Ok, so above I explained why 'git describe' is not buggy in a shallow
clone, but rather this is the best it can do under the circumstances.

Unfortunately (or but of course?), 'git describe' is in fact buggy,
but in a different way, and curiously the above mentioned commit
d1a251a1fa shows why.  Bear with me.

First, the desired behavior according to the manpage of 'git
describe':

  ... it suffixes the tag name with the number of additional commits
  on top of the tagged object ...

The Examples section in the manpage is even more explicit:

  The number of additional commits is the number of commits which
  would be displayed by "git log <tag>..<described-commit>".

Now let's have a look at that problematic commit:

  $ git describe d1a251a1fa
  v2.23.0-135-gd1a251a1fa
  $ git log --oneline v2.23.0..d1a251a1fa | wc -l
  59

Uh-oh, 59 != 135.

This is happening because:

  - Git is too fast ;) and the committer date has a one second
    granularity, so scripts can easily create subsequent commits with
    the same committer date.  Case in point are the two subsequent
    merge commits f3c19f85c5 and 4a3ed2bec6 at the bottom of this
    simplified history snippet (kind of a hand-edited 'git log --graph
    --format="%h %cd %s"'):

    *   d1a251a1fa 2019-09-09 12:26:36 -0700 Merge branch 'en/checkout-mismerge-fix'
    |\
    * | ... a big chunk of history simplified away ...
    | * acb7da05ac 2019-08-16 09:58:00 -0700 checkout: remove duplicate code
    * | a5e4be2f68 2019-04-25 16:41:15 +0900 Merge branch 'ab/commit-graph-fixes'
    * | f3c19f85c5 2019-04-25 16:41:14 +0900 Merge branch 'ab/gc-reflog'
    |/
    *   4a3ed2bec6 2019-04-25 16:41:14 +0900 Merge branch 'nd/checkout-m'

  - 'git describe' implements its own history traversal: it iterates
    over all parents of a commit, adds any yet unseen parents to a
    commit list ordered by date, and then continues with the first,
    i.e. most recent commit from that list.  While doing so it uses
    several bits in 'commit->object.flags' to track reachability
    information from several candidate tags at once, and copies these
    flags from each commit to its parents; this is important to
    compute the correct number of additional commits.  Another
    important thing is the implementation detail that
    commit_list_insert_by_date() inserts a new commit after all other
    commits with the same date that are already in the list.

So while traversing the above piece of history in date order
acb7da05ac is visited before a5e4be2f68, which is OK in itself as they
are on parallel running branches.  However, it means that 4a3ed2bec6
is added to the commit list before f3c19f85c5, which in turn means
that 4a3ed2bec6 is visited before f3c19f85c5, even though the former
is the parent of the latter.  Consequently, those reachability flags
that are important to compute the number of additional commits were
copied from 4a3ed2bec6 to its parents before those flags could be
updated with the values from f3c19f85c5, which makes many of the
ancestor commits incorrectly appear as unreachable from the candidate
tags.  Ultimately this causes that 135 != 59 difference shown above.

There are several thousands commits in git.git where 'git describe'
reports incorrect number of additional commits.

Now, I suppose that this particular case could be fixed by modifying
commit_list_insert_by_date() (or use a new variant of it) to insert a
new commit before all other commits with the same date that are
already in the list.  However, I also suppose that a clock skew could
lead to similar incorrect additional commit counts, and merely
tweaking the details of commit_list_insert_by_date() could not help
with that.

I think the proper way to fix this issue would be to make 'git
describe' traverse the history in topographical order.  Alas, I'm
afraid this would result in a noticable performance penalty on big
histories without a commit graph.

