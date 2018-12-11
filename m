Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006F320A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLKWgq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:36:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:36:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so15746165wru.4
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQvP0U/YxX9M3PuIG5IhqZ1s6mRclMdonjpgJ21OkZg=;
        b=qWdrdr6pd0mq17SdMrMt2uaVIpKLONYJHx2nCHDpm6Oxub/1A92Ss2qAXsMiSdYMtz
         w3FXrtbmWbs+ipdE/SlSaBOQNu3X69zFeX1ylfBudG5UVps1+yfDIM8ds2ObuRUU+WYs
         Sloeq4pviPw32AIRsq8rqdBREJxC2tYceSzYMEMyTlWukl/x42w7YWQbsCQGyhAHbdAG
         b2f29uIi/lZZvlih+ROWxm+PRC/NsVcvQ+6z5Gxxi/+DbW9DfBvtZlsKup7BrYLqUvLw
         uVGFsT4tNo+mEpbCeFZI4Filt+NHhpTchHIWR95CPDAAH1lImlnVY5QJaFDlpJ1bDoL+
         uxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQvP0U/YxX9M3PuIG5IhqZ1s6mRclMdonjpgJ21OkZg=;
        b=ceGyiC/uEhaz5+ZOu4oilvPq8M9cqyRBEOCB+9GQ9CRyMkSTQJBSFkx9iQo0DRZlqf
         3IKnlJpxTAFp/GCo5bVdIyia0T6OFo6UGa6m9TvoPI8vZwCR14cd7zu+vyEI7bpl4Ic2
         o7KGxsW9sfqJjhwoa5Dpa/hPfYMIbO+JuOvqjWoeDaD1soRzPlaDbJwRn+YnfkiINuYP
         6+B5S/6uWKgoMvoryONDsaUtdR2vPjWfPMIA0pUZFy7WrZkSpT251L+eM1jVdvS5K88K
         n61S9ubaA/451MRWJS0F2WVXKKlwhYPL7xVwvGO6A0rNJ2Ugvi03J5GP9BuJevWZB+Rv
         bq/w==
X-Gm-Message-State: AA+aEWb9YOPvF1/mIyYGP8ul0kZWSCipk3rcNRlUrsxh+IvRxpL8IZnJ
        9CjpbVt+Kfc80u7YtHGyaoU=
X-Google-Smtp-Source: AFSGD/VBDlcxU4OYuowLfeLJfmoHSTchdU4OVjjVX97OPd0cu/A6vV6C/UHGnUEhMc5/9iMzYjeUDQ==
X-Received: by 2002:adf:8544:: with SMTP id 62mr16041636wrh.1.1544567804135;
        Tue, 11 Dec 2018 14:36:44 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id a17sm15601826wrs.58.2018.12.11.14.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:36:43 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:36:42 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] checkout: allow ignoring unmatched pathspec
Message-ID: <20181211223642.GU4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-8-t.gummerer@gmail.com>
 <CABPp-BG9vjXF-entmun4+dMoOsZdjMgotSOtUUeNxO8c2VwgXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BG9vjXF-entmun4+dMoOsZdjMgotSOtUUeNxO8c2VwgXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Elijah Newren wrote:
> On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Currently when 'git checkout -- <pathspec>...' is invoked with
> > multiple pathspecs, where one or more of the pathspecs don't match
> > anything, checkout errors out.
> >
> > This can be inconvenient in some cases, such as when using git
> > checkout from a script.  Introduce a new --ignore-unmatched option,
> > which which allows us to ignore a non-matching pathspec instead of
> > erroring out.
> >
> > In a subsequent commit we're going to start using 'git checkout' in
> > 'git stash' and are going to make use of this feature.
> 
> This makes sense, but seems incomplete.  But to explain it, I think
> there's another bug I need to demonstrate first because it's related
> on builds on it.  First, the setup:
> 
>   $ echo foo >subdir/newfile
>   $ git add subdir/newfile
>   $ echo bar >>subdir/newfile
>   $ git status
>   On branch A
>   Changes to be committed:
>     (use "git reset HEAD <file>..." to unstage)
> 
>       new file:   subdir/newfile
> 
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
>     (use "git checkout -- <file>..." to discard changes in working directory)
> 
>       modified:   subdir/newfile
> 
> Now, does it do what we expect?
> 
>   $ git checkout HEAD -- subdir/newfile
>   error: pathspec 'subdir/newfile' did not match any file(s) known to git
> 
> This is the old overlay behavior; kinda lame, but you made no claims
> about fixing the default behavior.  What about with your new option?
> 
>   $ git checkout --no-overlay HEAD -- subdir
>   $ git status
>   On branch A
>   nothing to commit, working tree clean
> 
> Yes, the feature seems to work as advertised.  However, let's try
> again with a different variant:
> 
>   $ echo foo >subdir/newfile
>   $ git checkout --no-overlay HEAD -- subdir
>   $ git status
>   On branch A
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
> 
>       subdir/newfile
> 
> Why is the file ignored and left there?  Also:
> 
>   $ git checkout --no-overlay HEAD -- subdir/newfile
>   error: pathspec 'subdir/newfile' did not match any file(s) known to git
> 
> That seems wrong to me.

Ah interesting, this is a case I didn't consider.  I'm a bit torn on
this one.  My intention for the no overlay mode was that it would work
similar to what I'd expect 'git reset --hard -- <pathspec>' to work if
it existed, which means not removing untracked files if they exist.

While I think in the example you have above removing subdir/newfile
may be the right behaviour I'm not so sure in the case of 'git
checkout --no-overlay HEAD -- .' or ''git checkout --no-overlay HEAD
-- t/*' for example.  I don't think that should remove all untracked
files in the repository or in the t/ directory.  Removing untracked
files in that case would probably surprise users more than your case
above would.

I think it's okay to keep considering untracked files as special with
respect to how they are treated by 'git checkout --no-overlay'.

>                          The point of no-overlay is to make it match
> HEAD, and while subdir/newfile doesn't exist in HEAD or the index it
> does match in the working tree so the intent is clear. But let's say
> that the user did go ahead and specify your new flag:
> 
> 
>   $ git checkout --no-overlay --ignore-unmatch HEAD -- subdir/newfile
>   $ git status
>   On branch A
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
> 
>       subdir/newfile
> 
>   nothing added to commit but untracked files present (use "git add" to track)
> 
> So now it avoids erroring out when the user does more work than
> necessary, but it still misses appropriately cleaning up the file.

Yeah this is a good point, this could be more confusing to the user
than the previous case in my opinion.  Maybe I'll just drop this patch
for now (and the next one, as it's better to hold of until stash in C
lands anyway), and then try to do all this in-core for 'git stash'.
