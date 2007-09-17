From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 17:17:57 +0200
Message-ID: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
References: <11900314321506-git-send-email-hjemli@gmail.com>
	 <46EE7584.8010202@op5.se>
	 <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
	 <Pine.LNX.4.64.0709171422340.28586@racer.site>
	 <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com>
	 <Pine.LNX.4.64.0709171454031.28586@racer.site>
	 <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
	 <Pine.LNX.4.64.0709171603090.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXIMT-0001L8-9h
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 17:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbXIQPSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 11:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbXIQPSD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 11:18:03 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:9811 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbXIQPSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 11:18:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1329585rvb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cW8kBUrRLxNXSUZTkENoXi6vaiT6cnyWoDnPhUATw/g=;
        b=nPnLDVBCOgy1GGTGVRTEi5RjLuc7V56om1XiZhIZSgQkplnmv/zswVEvt5cBAQqOeChUFVtZIt8/VZPbBAii28QNI2YeBmpCsdQizO6FYhCEWoaDwagakxqdgxX4OyB4Jj4Q/d7YXzzd9r0ehwCGINcFFFTrkbKDqvZ9wt4wTbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=itca5aaD0Ydb22MRcLxWBP5dewSGY/ZuUTRX4xZt4FYKCNhzZv3f2A+bWKQUqJ25FFRWSKSzy8ndhrALXzuvNxLErYHK767bE0Ag42DuFOCdYuumQphwdV98bu3g2lPXG8XJVFYWjrWe6yhB778FQYqCe3Sas+XItwqU3sCCWTE=
Received: by 10.114.201.1 with SMTP id y1mr453waf.1190042277519;
        Mon, 17 Sep 2007 08:17:57 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 08:17:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709171603090.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58451>

On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Sep 2007, Lars Hjemli wrote:
>
> > On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > But then, I do not use svn branches here, and that might be the problem?
> >
> > Probably. The case I'm trying to solve is:
> >   -git-svn branch A is merged into git-svn branch B
> >   -A is a fast-forward of B
> >
> > This might look unrealistic, but it happened to me today when I wanted
> > to merge a feature-branch into a relase-branch. The release-branch had
> > previously been merged into the feature-branch (to get a few
> > bugfixes), but the release-branch had not changed since this merge. So
> > when merging the feature-branch into the release-branch it just
> > fast-forwarded, leaving me with an 'un-dcomittable' release-branch. I
> > obviously could have done the merge in subversion (haha!), but doing
> > it in git preserves the correct history.
> >
> > Btw: I have redone the merge with --no-ff, and dcommit then worked
> > like a charm ;-)
>
> Yep, I can see that now.
>
> But maybe there is a better method to detect the latest svn id, by not
> only looking up the svn ids, but making sure that they come from the
> current branch?

Actually, I looked into this last week (my --upstream rants), and I
guess git-svn could use the --track information in .git/config (if
present) as a sanity check when resolving the upstream. But this would
still make the subversion history look like crap after a fast-forward
merge of the kind I was messing with today. It was logically a merge,
but if dcommit had worked 'correctly' it would have created ~150 new
revisions in the release-branch instead of the single merge commit.

> (I'm happily unaware of git-svn's internals, so that might not be
> feasible... But I think that it might be worth fixing that for the git-svn
> idiot like me, since I would never guess that I have to specify --no-ff
> when working on branches that come from git-svn...)

In the normal cases there is no need for --no-ff, only in degenerated
cases like the one I stumbled upon today ;-)

I'll resend the patch with a link from merge-options.txt to
git-svn.txt and try to describe (in git-svn.txt) when to use --no-ff.

-- 
larsh
