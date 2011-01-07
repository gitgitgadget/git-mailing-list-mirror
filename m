From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Wish: make commiter email address configurable per-repo
Date: Fri, 7 Jan 2011 14:43:51 +0100
Message-ID: <201101071443.51574.trast@student.ethz.ch>
References: <ig73o1$lbg$1@dough.gmane.org> <201101071420.40570.trast@student.ethz.ch> <ig7449$lbg$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 14:43:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbCbm-0000St-AP
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 14:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab1AGNnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 08:43:53 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:40150 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab1AGNnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 08:43:52 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 7 Jan
 2011 14:43:04 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 7 Jan
 2011 14:43:52 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc8-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <ig7449$lbg$2@dough.gmane.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164711>

Stephen Kelly wrote:
> Thomas Rast wrote:
> > See user.email in git-config(1).  Most people set it globally, as in
> > 
> >   git config --global user.email "author@example.com"
> > 
> > but there's nothing stopping you from doing
> > 
> >   git config user.email "alias@example.com"
> > 
> > to set it on a per-repo level.  (Or just edit .git/config, of course.)
> 
> Doesn't this set both the author and the committer?

Stephen Kelly wrote earlier:
> If my email address that I use for committing is not the same as that 
> configured in the bugzilla, the automated bug closing does not work.

Oh, I see.  Yes, it does.

Probably if KDE has this use-case then that means we need to implement
it as a feature on size alone, but I briefly looked into the code and
it requires a bit more restructuring than I'm willing to do over
coffee.

I think as a stop-gap measure you'll have to use an alias such as

  ci = commit --author="your usual <author>"

along with a local setting for user.email to force them to be
different.  (Note that this will re-set the author when saying 'git
ci --amend' on other people's commits!)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
