From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 00:51:09 +0200
Message-ID: <B3A195E0-84E7-4844-B939-98BC352C91A1@zib.de>
References: <20071024192058.GF29830@fieldses.org> <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <20071024223815.GN29830@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 00:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikp3C-0004Y8-RY
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbXJXWtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 18:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbXJXWtx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 18:49:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:51738 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775AbXJXWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 18:49:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9OMngWv012814;
	Thu, 25 Oct 2007 00:49:42 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1097b.pool.einsundeins.de [77.177.9.123])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9OMnfYr007026
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 00:49:41 +0200 (MEST)
In-Reply-To: <20071024223815.GN29830@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62251>


On Oct 25, 2007, at 12:38 AM, J. Bruce Fields wrote:

> On Thu, Oct 25, 2007 at 12:33:37AM +0200, Steffen Prohaska wrote:
>> Maybe. I know git quite well now and in a shared workflow "git pull"
>> with auto-fast-forward would help me. I often need to run "for each
>> local branch: git checkout ; git merge" to get rid of the errors
>> reported by "git push".
>
> Hm.  There's gotta be more efficient ways to do that.  Maybe "git  
> push .
> origin/branch:branch" for each local "branch"?
>
> But I'm still a little confused why you don't just want to "git push
> name-of-branch" and avoid the whole problem.

There are two points:

- The current implementation of "git push" creates a remote branch
   if it does not yet exist. I want a safety net: "git push" only pushes
   if the remote branch already exists. In a sense "git push" is safer
   than "git push branch-with-typo". I use "git push branchname"
   exclusively for _creating_ new branches on the remote.

- Sometimes I updated two local branches and want to push. "git push"
   just works.

I started to believe that "git push" should always do the right
thing. Maybe it is not possible, but actually "git push" always
does the right thing for me if I ignore the error messages
about local branches that need merging. I tend to merge all
such branches right away, although it is a bit of a hassel.
Otherwise, there will be a day I'll miss an important error.

What concerns me more is how to explain the behaviour to others.
Right now, I can't tell them that "git push" just works but need
to go into a lot of details.

	Steffen
