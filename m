From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -p: seed first commit in case it's before the
 merge bases.
Date: Sun, 18 Jan 2009 01:19:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901180108480.3586@pacific.mpi-cbg.de>
References: <496F6AC3.7050704@drmicha.warpmail.net> <cover.1232233454.git.stephen@exigencecorp.com> <ac1a4533de095f916dd68029793c8ee6eb02d200.1232233454.git.stephen@exigencecorp.com> <a524993b13ee586cf0e8fbd3b6459ccd6767c6d8.1232233454.git.stephen@exigencecorp.com>
 <alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 01:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOLP3-0006yp-A4
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 01:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbZARATO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 19:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbZARATN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 19:19:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:45168 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753815AbZARATN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 19:19:13 -0500
Received: (qmail invoked by alias); 18 Jan 2009 00:19:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 18 Jan 2009 01:19:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189aitMqn49gj+4/JNminAtu3WZHX/ozUE0z5+vAW
	O7xuoC0htrNqLK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901180041540.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106116>

Hi,

On Sun, 18 Jan 2009, Johannes Schindelin wrote:

> However, I have a strong feeling that just piling onto the current code 
> will not fix the underlying issues.

BTW just to clarify what I mean by "underlying issues": if you say "git 
rebase -i" in Sitaram's test case, you will see the two commits -- as 
expected.

However, if you add "-p", all of a sudden you will only see "noop".  IMO 
there is no excuse that the code can hide them at all.  If the commits are 
reachable from HEAD but not from $UPSTREAM, they have to be in the list.  
As simple as that.

Another thing that I find horribly wrong: there is a "touch 
$REWRITTEN/sha1".  There was a simple design in the beginning: the files 
in $REWRITTEN are actually a mapping from old SHA-1 (file name) to new 
SHA-1 (content).  This was broken, without any good explanation.

Ciao,
Dscho
