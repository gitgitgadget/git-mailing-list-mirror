From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to (re-)create .git/logs/refs
Date: Tue, 13 May 2008 06:24:34 -0700 (PDT)
Message-ID: <m33aom5oc2.fsf@localhost.localdomain>
References: <200805081256.11465.hs4233@mail.mn-solutions.de>
	<200805130842.06112.hs4233@mail.mn-solutions.de>
	<alpine.DEB.1.00.0805131244300.30431@racer>
	<200805131413.14753.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
X-From: git-owner@vger.kernel.org Tue May 13 15:26:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvuVW-0006SR-1t
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 15:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723AbYEMNYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756926AbYEMNYj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 09:24:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:62449 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533AbYEMNYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 09:24:37 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1230402nfc.21
        for <git@vger.kernel.org>; Tue, 13 May 2008 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=CfDaDAzLfWTzIz68aWvwW5Zp/lwZz130MuUbe1/6SEs=;
        b=PQ0gTKSZYt5EDu2TZwZErjQQv0xFURa4xm0mRMA0kJooKNZnP96oB/Ih76de0YVDE0LrPvH4UFuXjfBntp7mkmHar+3CvtqH6PwXSYP6N5uSRioHxrIa2XRLNfJgogECvs+gFWRaH7t9nyFxYipDDtoRsC6I8t/4I4Wi1ZymT3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=DGHYSytvtaU3nVmP7/rmbPUovSSXUxwOeodlmXARf8dCWCVtld9dAjFHWy3JkwnHHjzEIx0rBFpueMxAlxiaj9Z93oFveXZEvZO/W8TtKptUTRcH2/YOPtHvEZlqH75v1PJO78xfH4/JX3b06gWDYdegaX2nzQtHiXnVqBqxe7s=
Received: by 10.210.88.3 with SMTP id l3mr8448871ebb.114.1210685076323;
        Tue, 13 May 2008 06:24:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.214])
        by mx.google.com with ESMTPS id d25sm6014590nfh.27.2008.05.13.06.24.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 May 2008 06:24:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4DDOWTb021236;
	Tue, 13 May 2008 15:24:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4DDOUvk021232;
	Tue, 13 May 2008 15:24:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200805131413.14753.hs4233@mail.mn-solutions.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82028>

Holger Schurig <hs4233@mail.mn-solutions.de> writes:

> > Are you sure you understand what @{date} does?  It shows you
> > the state _this_ repository was in at that date.
> 
> Who says so? "man git-rev-parse" just says:
> 
> o  A ref followed by the suffix @ with a date specification
>    enclosed in a brace pair (e.g. {yesterday}, {1 month 2 weeks 3
>    days 1 hour 1 second ago} or {1979-02-26 18:30:00}) to specify
>    the value of the ref at a prior point in time. This suffix may
>    only be used immediately following a ref name and the ref
>    must have an existing log ($GIT_DIR/logs/<ref>).
> 
> It just states "at a prior point in time", not "at a prior point 
> in time in your git repository/checkout".

Please read carefully: "value of the _ref_" at a given time.
It means value where ref pointed to at given time.  That of
course depends on what you did with repository: did you just fetch,
or perhaps you made those commits, or perhaps you rebased branch,
or decided that the work you did is wrong and rewound to previous
version using reset.

As this is purely local matter, it matter only for _your_
repository.

> > It is a common misconception that you can reference anything
> > by date in a distributed setup.  (Before you ask, I will just
> > mention "clock skew" and "parallel branches" to give you an
> > idea why this is a misconception.)
> 
> My idea was to use the first commit (from git-rev-log) where the 
> date is below the specified date.

Which might be not what you want, as you can get revision which
was on some side branch.
 
> To give you some context: Bitbake (from www.openembedded.org) is 
> a tool that can download software, patch it, configure it, 
> compile it and create packages out of it. Nothing fancy, except 
> that it can do this for a huge amount of embedded devices, 
> usually using a cross-compiler for ARM, MIPS, whatever.
>
> And it can download not just tar files, it can also use CVS, SVN, 
> hg, git and so on.
> 
> In OpenEmbedded, many patch recipes specify the version to use. 
> If you deal with versioned stuff, e.g. 
> filename-frob-3.14.tar.bz, this is fine. Sometimes the version 
> is a SVN revision number. And sometimes it's a git, mercury or 
> monotone hash. However, the latter beast are almost 
> non-describing. So many bitbake recipes specify a SRCDATE, and 
> you can immediately see if SRCDATE=20070501 that it uses an 
> ancient version of the software, from 1st May 2007. You won't 
> see that if it would specify 
> GIT_REV=6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4. Of course you 
> can do
> 
>   GIT_REV=6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4
>   # This is from 2007 May 1st
> 
> but then you're redundant and chances are high that those two 
> lines get out-of-sync.
 
Thanks for explanation.  This is most useful when proposing solutions
to real problem...

The solution, of course, is to use git-describe output instead of
full SHA-1 (this of course assumes that you tag your releases).
Something like "v1.5.5.1-215-gc853afb" is, I think, quite well
self-described.  There is still place for ambiguity due without
the shortened sha-1 part due to parallel development, but I think
no less than using date.
 
> So, when I have SRCDATE=20070501, I'd be happy if git would, for 
> me, find out that this is 
> 6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4, even when the commit 
> 6e2df4fd066c450b0b3c8e0f1769d4163e2b52c4 was not done on my 
> local machine, but is a commit that I pulled from the outside.
> 
> Also, when I do "git checkout @{20070501}", I don't usually mind 
> if, e.g. because of time-skew or multi-heads, I'm not at the 
> 17th commit in this area, but on the top-most for which this 
> condition is true. I can use "git log" and "git reset" or 
> whatever to dig my way to the state I want, but git would do the 
> dull work for me.

You can try 

 $ git checkout "$(git log -1 --pretty=format:%H --before=2007-05-01)"

but YMMV, i.e. if you hit upon correct revision or not would depend
on luck.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
