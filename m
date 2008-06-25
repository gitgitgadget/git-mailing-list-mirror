From: Raimund Bauer <ray007@gmx.net>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 22:12:54 +0200
Message-ID: <1214424774.6570.21.camel@doriath>
References: <20080625023352.GC20361@mit.edu>
	 <willow-jeske-01l6@3PlFEDjCVAh-01l6@3N@FEDjCXZO>
	 <willow-jeske-01l6Cy0dFEDjCVqc>
	 <alpine.LNX.1.00.0806251421520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Jeske <jeske@willowmail.com>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:14:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbNM-0005Sd-0a
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYFYUM6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYFYUM6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:12:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:52457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751867AbYFYUM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:12:57 -0400
Received: (qmail invoked by alias); 25 Jun 2008 20:12:56 -0000
Received: from chello084112102232.8.11.vie.surfer.at (EHLO [192.168.1.100]) [84.112.102.232]
  by mail.gmx.net (mp054) with SMTP; 25 Jun 2008 22:12:56 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1/m2ix4R/Pmtn1mvDEwCl+EOe3GzZBkPapxSQRCAj
	DSU0ijvppi68Hl
In-Reply-To: <alpine.LNX.1.00.0806251421520.19665@iabervon.org>
X-Mailer: Evolution 2.22.2 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86338>

On Wed, 2008-06-25 at 15:17 -0400, Daniel Barkalow wrote:

> You have a fundamental misconception about git's data model. A commit=
=20
> doesn't have a particular branch it is on. There is only the DAG, whe=
re=20
> each node is a commit that is structured identically to all of the ot=
her=20
> commits. Branches pick out particular nodes in the DAG at particular=20
> times.

But a branch in repository also has a local history. The ref-log.
And git could use that to produce a distributed branch-history.

<wishful thinking>

A developer prepares a series of commits in a local branch to push to
the server.
On the server the ref-log of a branch gets updated with a new entry for
each push, and other developers pulling from the server get the servers
ref-log as ref-log of their remote tracking branch and can see the
push-points there.

Those push-points seem to be somehow more important than other commits =
-
there was a reason for the first developer to push right this branch
tip, right?
Seems like valuable (optional) information to me.

=EF=BB=BF</wishful thinking>

> It therefore doesn't make any sense to ask if a commit is directly ha=
nging=20
> off of master. If your local branch is up to date, and you commit, yo=
ur=20
> commit's parent is the current master. If you now check out master an=
d=20
> merge your local branch, master gets the same (non-merge) commit.

Check if the commit is in master's ref-log?

regards,
Ray
