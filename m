Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE3E2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 21:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758181AbdCUVOQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 17:14:16 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38412 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755793AbdCUVOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 17:14:14 -0400
Received: by mail-wm0-f42.google.com with SMTP id t189so21918378wmt.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSY4ceEGR0sXXm599IYo6bMG4wDw4pOp/N0Cq+EN5I8=;
        b=gUTwxOdH+dvrDfpig01ylGxQRUuyZXUh91427wdtrZWkNy87mq/SakseJsK9FtCMcF
         ZLK2pvOJjkvUq3saHG70/SteoaVtcHw8dqu/JfyAwI8K5GUYUjyYp4EBgj9aLqh7Q6BJ
         lS7DUkaqa71SAiS9mirp5bVNAUfQTNN/QAHgeIjxj2QqV2lRrnja+7LJa7Y2lWG1V1dN
         IwllGbwswTN5UVqqqrwYnxt2BFJsay+DWZXLxyFyUqFthRsn4gJf+PG4tWi0M8cEi6DM
         11BTD9EaM3FUd/NSQxLU1Ak+UpGOToJs7Xh2JePqUrqewa8YPh5n1rzRek9S+lBSo0x8
         cTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSY4ceEGR0sXXm599IYo6bMG4wDw4pOp/N0Cq+EN5I8=;
        b=C1nCH1qqbPzTE1uh+q/rKrJc3yMpvCqcytgEXMhFfkxttW6zPWb3BodowDfHLrxbZG
         pe5NCT2TBkaUo8Hsf70rLN7SzyJ9wgRsjt+g1AOpTWAyDdWVca04TCwlO1nOzcBeJUUy
         tDk23fdVD5We6/HQKNmsRdfXAe3RaWouQVp1g0cQ6GVUbPyEWDzzINS6WdrpkYL7HmH6
         WMEUwRs8gq3kn8Mxl9dbIKVkIgkcM0W3Zdb8XpZUQFuDY2faQ1tuDh5NH5+QmAF0Imyw
         NvBB5Uy9qdCF63J7OFPB4PC2sswJCIIeSlZg/R0xnUok7BCF+nS7HlyZxF3fjP5xWY//
         Z7nQ==
X-Gm-Message-State: AFeK/H2p+maX+l5haJ24I3bx0O8cFkhhrupopjTO5eDSjcyj3NiKlhT8e5hQudH9R5Zzww==
X-Received: by 10.28.141.201 with SMTP id p192mr4869482wmd.66.1490130847702;
        Tue, 21 Mar 2017 14:14:07 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id t63sm19037413wme.16.2017.03.21.14.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Mar 2017 14:14:07 -0700 (PDT)
Date:   Tue, 21 Mar 2017 21:14:24 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 3/3] stash: pass the pathspec argument to git reset
Message-ID: <20170321211424.GE27158@hank>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-4-t.gummerer@gmail.com>
 <20170320190843.aw3fsenjvcek7a44@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170320190843.aw3fsenjvcek7a44@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Jeff King wrote:
> On Sun, Mar 19, 2017 at 08:23:51PM +0000, Thomas Gummerer wrote:
> 
> > For "git stash -p --no-keep-index", the pathspec argument is currently
> > not passed to "git reset".  This means that changed that are staged but
> > that are excluded from the pathspec still get unstaged by git stash -p.
> 
> Yeah, I noticed this while playing around with patch 2. This seems
> like an improvement to me. Unlike the other patches (which are just
> tweaking quietness), I think this one really needs a test.
>
> Also, s/changed/changes/ above.

Thanks.  Will add a test in the re-roll.

> > ---
> > So this make things a bit inconsistent in for example the following
> > situation:
> > 
> >     $ git status -s
> >      M git-stash.sh
> >     M  read-cache.c
> > 
> > where using git stash -p --no-keep-index, when only changes in
> > git-stash.sh are added to the stash would reset read-cache.c, but with
> > git stash -p --no-keep-index -- git-stash.sh, read-cache.c would not
> > be reset.
> 
> I think it's OK. You can't select (or not select) changes from the index
> anyway. TBH, I kind of wonder if "git stash -p --no-keep-index" makes
> any sense at all.

Yeah I don't have any use case for it, but maybe someone does, so I
think fixing it this way now is the best way forward.

> > However it does bring things more in line with git stash --
> > <pathspec>, so I think this is an improvement.
> 
> I did notice one other case while looking at this that I think is much
> more serious. The "read-tree" call in the non-patch-mode case doesn't
> use a pathspec either. So if we have our same setup where "one" and
> "two" have unstaged changes and we do:
> 
>   git stash push -k one
> 
> Then we stash "one", but the change in "two" is wiped out completely!

Good catch, that's definitely another bug :/ 

> I don't think read-tree takes pathspecs, so it would have to drop the
> "-u" and replace it with checkout-index. I'm confused about why we would
> need it in the first place, though. We should have already dealt with
> the working tree files in the earlier block, so there should be nothing
> to checkout.
> 
> The "-u" goes all the way back to 7bedebcaa (stash: introduce 'stash
> save --keep-index' option, 2008-06-27). I wonder if it has always been
> unnecessary, but we never noticed because it's just a noop.

I do think the "-u" is necessary.  Say we have a repository with
changes in 'foo' and 'bar', where the changes in bar are added to the
index.

Then 'git stash -k' would wipe out the changes in both 'foo' and 'bar'
through 'git reset --hard', but we do want the changes in 'bar' to
still exist on disk, which they wouldn't without the "-u".

But I'll replace the "-u" with checkout-index, so we can respect the
pathspec.

Thanks!

> -Peff
