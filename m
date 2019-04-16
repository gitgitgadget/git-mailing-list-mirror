Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CDF20248
	for <e@80x24.org>; Tue, 16 Apr 2019 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfDPV7u (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 17:59:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37059 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPV7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 17:59:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so29187255wrm.4
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ubwrm5Uk4EXRsu7b7UMDUBl0JWo8CPVXQeDL6h4uBbI=;
        b=g2rmKYvIB5o/mWDwVBXYx9lUq1Sr4o7heT3l0a7XifgMLlHh6BMpMLGaGepfaJjvKq
         E7Nz7adcQ9xzMy8/HKy2JwOSVbbouGy+5/mWMe5CignKZPX4FdtQr2/Jd+lOsW/cz0k7
         lb+Oaywgdh4mzrVDikV15qe5sUDR/RQp29hInuH8a370X4GhJx4sI4TLMRV+pXY6CNeU
         RD7uTuGSV2grs1t2Uhv6P8o+i0XlPBSJ4Zf9FDJ1Bp4X4Nw5ZIKdjLZsxQGrmyPzvEhu
         gUAfxnzpbX4ycrEFLXslXMORBRcxDWjPTRxuHw1fRqD9D1y9612Pcmnh/iEsz5NNT/1n
         AzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ubwrm5Uk4EXRsu7b7UMDUBl0JWo8CPVXQeDL6h4uBbI=;
        b=F2WTVMj58fBfnWZKQSUJHJJjzb9xRgc20fGpnBv2ZhnB0VTwdnBWwsn+U0eVl1HJ8s
         JoRhmF4KSQZUvQmxRY0C9YGHPTrY7KNJGMHGuu+p06jSQi8xherWJzBLP4YyB5j7swJ3
         M69Z2v0cAt12rqjv9EEOv5Iis9fFDuIfLFS+95J0/SAVSVGjlcl2Ky2bM3zLIvi5+lnz
         vZpz6vSwDDjdyuWtj9CO01InenETRGi/mXXDj5qmSWD2jJ97pjIhbYikxE331IPmL9es
         ksUXA8uJ86KNohYOj2/yskF039laXmlh8l3GTtUcmU+OZf2RKfAYFmF1L6wgvoEzHmy+
         /ozw==
X-Gm-Message-State: APjAAAXFaIGDUmorJHBtd50RIPvt0PLYENuOlEDbNntYbGpevnV4ijSq
        CuScia2oc0MRrHNzja95eRVAf8oM
X-Google-Smtp-Source: APXvYqy99rkLBYgVZz7AlOETAHSztsI74kDhsjzPHLNY/y4iJVaOhHmhL6swvpGGkZT95Rxzc7QXhg==
X-Received: by 2002:adf:e487:: with SMTP id i7mr25039291wrm.264.1555451988261;
        Tue, 16 Apr 2019 14:59:48 -0700 (PDT)
Received: from localhost ([2.25.81.3])
        by smtp.gmail.com with ESMTPSA id m13sm474025wmg.42.2019.04.16.14.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 14:59:46 -0700 (PDT)
Date:   Tue, 16 Apr 2019 22:59:45 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Vetter <christian@rasenplanscher.info>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git stash --keep-index undeletes file
Message-ID: <20190416215945.GV16414@hank.intra.tgummerer.com>
References: <1555437849815.60450@rasenplanscher.info>
 <20190416184816.GU16414@hank.intra.tgummerer.com>
 <1555444649793.14863@rasenplanscher.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555444649793.14863@rasenplanscher.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[please don't top post on this list]

On 04/16, Christian Vetter wrote:
> Thank you, Thomas!
> 
> Now that you explained this, I do understand the behaviour, and agree that it is correct.
> While this seems to be clear with a deeper understanding of git than I have,
> it might be a good idea to specifically point this out in the docs in the context of `--keep-index`.
> That would have helped me.

On second thought, I might have been too quick to jump to conclusions
here, and might have misunderstood --keep-index myself.  I think what
you described here is actually a bug, although it's a pretty long
standing one.  So I'm a bit surprised nobody noticed it before.

Thanks for reporting it.

> This does, however, bring me back to a related issue by which I stumbled across this:
> If, in the given scenario, I run `git stash apply`, the file is not removed. `git status` still outputs this:
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
> 
> Can you explain that behaviour as well?
> The way I understand it, `git stash push --keep-index; git stash apply` should result in zero change to the output of `git status`.
> What am I not getting?

Your interpretation of what should happen sounds like the right
behaviour here, and what actually happens seems incorrect.  I don't
have time to dig into this more right now though unfortunately.

> ________________________________________
> From: Thomas Gummerer <t.gummerer@gmail.com>
> Sent: Tuesday, April 16, 2019 20:48
> To: Christian Vetter
> Cc: git@vger.kernel.org
> Subject: Re: [BUG] git stash --keep-index undeletes file
> 
> On 04/16, Christian Vetter wrote:
> > Steps to reproduce
> > + mkdir git-stash-test
> > + cd git-stash-test
> > + git init
> > + touch file
> > + git add file
> > + git commit -m init
> > + git rm file
> > + git stash push --keep-index
> >
> >
> > Result:
> > `git status` gives this output:
> > > On branch master
> > > Changes to be committed:
> > >   (use "git reset HEAD <file>..." to unstage)
> > >
> > >         deleted:    file
> > >
> > > Untracked files:
> > >   (use "git add <file>..." to include in what will be committed)
> > >
> > >         file
> 
> I think this is the correct result.  --keep-index keeps the changes
> that are in the index, in this example that 'file' is deleted, but
> restores the working tree to 'HEAD', where 'file' existed.  It's now
> showing up as untracked because Git doesn't know about it.
> 
> Similarly if you just did 'git stash push' without --keep-index,
> 'file' would be restored in your working tree, but 'git status' would
> report the working tree as clean because it would also be restored in
> the index.
> 
> > Expected:
> > `git status` gives this output:
> > > On branch master
> > > Changes to be committed:
> > >   (use "git reset HEAD <file>..." to unstage)
> > >
> > >         deleted:    file
> 
> This is what you get before 'git stash push --keep-index'.  Do you
> think the documentation on '--keep-index' is unclear, and could be
> improved?  Or why did you think that this is the correct output?
> 
> > Verified on:
> > + Windows 10, git version 2.21.0.windows.1
> > + Ubuntu 14.04, git version 2.21.0
