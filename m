Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F85C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLKWwq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:52:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKWwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:52:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so15749197wrt.11
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=99UkRep2Snn+XUrtXiJHzpZSVmyGzXyR7LsLp7yUv0I=;
        b=m5X1ZtsSrQUZ8BSq9JI8blwT53QYfsXl/fbv8ABI8EeZbRG+NyupITF6vc3zgbjgMD
         GhM7uPaX6sJKCQpigBBqULzOF1m7hArfpNBFF+aaNuoiBTU3hOdRJMNY/3pe5+8FW2Kp
         ookO5AAq/EL6G0n8ZwnY9oJlt/H9WnHeBxGtiH/Vn4qPTPBTpKH/oak2cTbWM6hoT5Wu
         IVzTdo8Yi3CSBMpOXxxPNb6+7IeoFYDyUW+nb3NiE+2itkzQExjcpYOLPe2RUTZ5h3wj
         mPOCVuaIWLZCXXwqgU7sopn91K4QQLj4EyGxAKBMTrcG3jKnz7uuFL5r0oa5M8FMUKzF
         veFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99UkRep2Snn+XUrtXiJHzpZSVmyGzXyR7LsLp7yUv0I=;
        b=XSNyPmdg8okVlywVNEa8SYcSRe/+YwkzeIU/tzR79hR6jLBF6ZX484GwCvJB9JwqU5
         deA0CUWM7m7jgUC9IIwCzr8czN7pGcUkR3QSdxMd08SAadufEDZJjGKKH7L5GW14FfQe
         rNiPnTkzTs/l9Uz8aRwG6/Oyr11rCMy5jPM73sDRmEBNFeLjMvKuL5yK0pgs/A/oiIYJ
         fChxQ3GWscYOpp0ezb24GSzRLJb013nPUDLisc7Hc/Vm60JaGijv82iJ4tP7T8h2IDzu
         6lAdg5qMZo3rn79L5G9rQtZ6YHAK4s9UskHOnfdevz9Yy7GPOD/MkLAZx0p/FLS24BLP
         gqdA==
X-Gm-Message-State: AA+aEWZYYMUgW1p9qE6diL6iI8dI5gSzZZvh9HXZZZ2FWiIPqz647BNY
        FmyEFtDOTaWkLv4i/xONhMU=
X-Google-Smtp-Source: AFSGD/VuQ/eKwgvu7qN7M/mKaKZHTWz05tfxhe7YshlA56pHAj7/+6rUnMxaWi/jW3sbN+2ai63oOw==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr14635522wrh.317.1544568763574;
        Tue, 11 Dec 2018 14:52:43 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id t63sm1264313wmt.8.2018.12.11.14.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:52:42 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:52:41 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
Message-ID: <20181211225241.GW4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <CABPp-BFaWtDiBPuGQVU_+VGQtDkemDKnvjHhz+h1sbUGssffmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFaWtDiBPuGQVU_+VGQtDkemDKnvjHhz+h1sbUGssffmQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Elijah Newren wrote:
> On Sun, Dec 9, 2018 at 12:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Here's the series I mentioned a couple of times on the list already,
> > introducing a no-overlay mode in 'git checkout'.  The inspiration for
> > this came from Junios message in [*1*].
> >
> > Basically the idea is to also delete files when the match <pathspec>
> > in 'git checkout <tree-ish> -- <pathspec>' in the current tree, but
> > don't match <pathspec> in <tree-ish>.  The rest of the cases are
> > already properly taken care of by 'git checkout'.
> 
> Yes, but I'd put it a little differently:
> 
> """
> Basically, the idea is when the user run "git checkout --no-overlay
> <tree-ish> -- <pathspec>" that the given pathspecs should exactly
> match <tree-ish> after the operation completes.  This means that we
> also want to delete files that match <pathspec> if those paths are not
> found in <tree-ish>.
> """
> 
> ...and maybe even toss in some comments about the fact that this is
> the way git checkout should have always behaved, it just traditionally
> hasn't.  (You could also work in comments about how with this new mode
> the user can run git diff afterward with the given commit-ish and
> pathspecs and get back an empty diff, as expected, which wasn't true
> before.  But maybe I'm belaboring the point.)
> 
> 
> > The final step in the series is to actually make use of this in 'git
> > stash', which simplifies the code there a bit.  I am however happy to
> > hold off on this step until the stash-in-C series is merged, so we
> > don't delay that further.
> >
> > In addition to the no-overlay mode, we also add a --cached mode, which
> > works only on the index, thus similar to 'git reset <tree-ish> -- <pathspec>'.
> 
> If you're adding a --cached mode to make it only work on the index,
> should there be a similar mode to allow it to only work on the working
> tree?  (I'm not as concerned with that here, but I really think the
> new restore-files command by default should only operate on the
> working tree, and then have options to affect the index either in
> addition or instead of the working tree.)

Yeah I think that would be nice to have, though I'm not sure what we
would name it in 'git checkout'.  Maybe just having it in 'git
restore-files' is good enough?

> > Actually deprecating 'git reset <tree-ish> -- <pathspec>' should come
> > later, probably not before Duy's restore-files command lands, as 'git
> > checkout --no-overlay <tree-ish> -- <pathspec>' is a bit cumbersome to
> > type compared to 'git reset <tree-ish> -- <pathspec>'.
> 
> Makes sense.
> 
> > My hope is also that the no-overlay mode could become the new default
> > in the restore-files command Duy is currently working on.
> 
> Absolutely, yes.  I don't want another broken command.  :-)
> 
> 
> > No documentation yet, as I wanted to get this out for review first.
> > I'm not familiar with most of the code I touched here, so there may
> > well be much better ways to implement some of this, that I wasn't able
> > to figure out.  I'd be very happy with some feedback around that.
> >
> > Another thing I'm not sure about is how to deal with conflicts.  In
> > the cached mode this patch series is not dealing with it at all, as
> > 'git checkout -- <pathspec>' when pathspec matches a file with
> > conflicts doesn't update the index.  For the no-overlay mode, the file
> > is removed if the corresponding stage is not found in the index.  I'm
> > however not sure this is the right thing to do in all cases?
> 
> Here's how I'd go about analyzing that...
> 
> If the user passes a <tree-ish>, then the answer about what to do is
> pretty obvious; the <tree-ish> didn't have conflicts, so conflicted
> paths in the index that match the pathspec should be overwritten with
> whatever version of those paths existed in <tree-ish> (possibly
> implying deletion of some paths).
> 
> Also, as you point out, --cached means only modify the index and not
> the working tree; so if they specify both --cached and provide no
> tree, then they've specified a no-op.
> 
> So it's only interesting when you have conflicts in the index and
> specify --no-overlay without a <tree-ish> or --cached.  This boils
> down to "how do we update the working tree to match the index, when
> the index is conflicted?"  A couple points to consider:
>   * This is somewhat of an edge case
>   * In the normal case --no-overlay is only different from --overlay
> behavior for directories; it'd be nice if that extended to all cases

I'm not sure I follow what you mean here.  How is --no-overlay
different from --overlay with respect to directories?  It's only
different with respect to deletions, no?

>   * How does this command behave without a <tree-ish> when
> --no-overlay is specified and a directory is given for a <pathspec>
> and there aren't any conflicts?  Are we being consistent with that
> behavior?
> 
> 
> However, I think it turns out that the answer is much simpler than all
> that initial analysis or what you say you've implemented.  Here's why:
> 
> If <pathspec> is a file which is present in both the working tree and
> the index and it has conflicts, then "git checkout -- <pathspec>" will
> currently throw an error:

I think what was missing from my original description, that actually
makes it slightly more interesting from what you describe below is the
'--ours' and '--theirs' flags in 'git checkout', with which one can
check out a version of the file in the working tree.  This is where it
gets more interesting.

I think I got the right solution for that in patch 5, with deleting
the file if it's deleted in "their" version and we pass --theirs to
'git checkout', and analogous for --ours.  I was just wondering if
there were any further edge cases that I can't think of right no.

> $ git checkout -- subdir/counting
> error: path 'subdir/counting' is unmerged
> 
> In fact, even if every entry in subdir/ is a path that is in both the
> index and the working tree (so that --no-overlay and --overlay ought
> to behave the same), if any one of the files in subdir is conflicted,
> attempting to checkout the subdir will abort with this same error
> message and no paths will be updated at all:
> 
> $ git checkout -- subdir
> error: path 'subdir/counting' is unmerged
> 
> as such, the answer with what to do with --no-overlay mode is pretty
> clear: if the <pathspec> matches _any_ path that is conflicted, simply
> throw an error and abort the operation without making any changes at
> all.
