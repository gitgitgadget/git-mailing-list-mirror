From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 6 Mar 2006 00:50:36 -0500
Message-ID: <20060306055036.GB26820@spearce.org>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com> <20060306024353.GA23001@mythryan2.michonline.com> <440BC92E.4060306@gmail.com> <440BCB67.4070406@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Martin Langhoff <martin.langhoff@gmail.com>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 06:51:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG8cp-0004Ma-1o
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 06:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCFFuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 00:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWCFFuv
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 00:50:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:14542 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751306AbWCFFuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 00:50:51 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FG8bx-0003gV-GM; Mon, 06 Mar 2006 00:50:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3C07C20FBBF; Mon,  6 Mar 2006 00:50:36 -0500 (EST)
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <440BCB67.4070406@michonline.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17275>

Ryan Anderson <ryan@michonline.com> wrote:
> A Large Angry SCM wrote:
> 
> > Ryan Anderson wrote:
> > ...
> >
> >>
> >> For annotate, the syntax I was using was:
> >>     git annotate Makefile headname
> >>
> >> I'm not married to it, so please, send a patch to change it if you want
> >> (Please fix up the test case I'm sending in this patch, as well.)
> >>
> >
> > Wouldn't
> >     git annotate <headname> <filename(s?)>
> > be more consistent with other git commands?
> >
> Yes, but <headname> (really, a commitish) needs to be optional.
> 
> I should probably switch to:
>     git annotate [-c|--commit <committish>] <filename>
> but that's partly why I'm asking for feedback.

Yes but doesn't git-diff accept:

	git-diff Makefile
	git-diff HEAD Makefile

?  (Which is rather ugly as what if you have a tracked file actually
called HEAD and you want the first form when the commit-ish is
omitted.)  So accepting an optional commit-ish before the filename
would be in line with what git-diff accepts today.

But maybe breaking convention from git-diff now is a good thing,
with a future change to cleanup git-diff.

-- 
Shawn.
