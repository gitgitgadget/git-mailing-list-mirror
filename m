From: Stephen Bash <bash@genarts.com>
Subject: Re: git-svn with non-standard repository layout
Date: Wed, 5 Dec 2012 11:44:40 -0500 (EST)
Message-ID: <1056577717.281976.1354725880396.JavaMail.root@genarts.com>
References: <CAA01Csoam7pXqPKnjvJB46T_sdjcW2S1oXdQT3HbUdfN4TK0kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgI5o-00014I-DE
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 17:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab2LEQos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 11:44:48 -0500
Received: from hq.genarts.com ([173.9.65.1]:41467 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752307Ab2LEQor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 11:44:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 05E63BE25E2;
	Wed,  5 Dec 2012 11:44:47 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kHNKYWxKDJ0; Wed,  5 Dec 2012 11:44:40 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6FDA5BE2567;
	Wed,  5 Dec 2012 11:44:40 -0500 (EST)
In-Reply-To: <CAA01Csoam7pXqPKnjvJB46T_sdjcW2S1oXdQT3HbUdfN4TK0kw@mail.gmail.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC23 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211132>

----- Original Message -----
> From: "Piotr Krukowiecki" <piotr.krukowiecki@gmail.com>
> Sent: Wednesday, December 5, 2012 11:26:54 AM
> Subject: Re: git-svn with non-standard repository layout
> 
> On Tue, Dec 4, 2012 at 10:19 PM, Carsten Fuchs
> <carsten.fuchs@cafu.de> wrote:
> > Hi Piotr,
> >
> > Am 2012-12-04 18:29, schrieb Piotr Krukowiecki:
> >
> >> Is there a way to handle svn repository with following layout?
> >>
> >> repo/trunk
> >> repo/branches/branch1
> >> repo/branches/branch2
> >> repo/branches/work/developer1/branch3
> >> repo/branches/work/developer1/branch4
> >> repo/branches/work/developer2/branch5
> >
> > see my post at
> >     http://www.cafu.de/forum/viewtopic.php?f=14&t=1092
> > heading "Branches outside branches/".
> >
> > You may need something like
> >     git config --add svn-remote.svn.fetch
> > "path.../branchX:refs/remotes/branchX"
> > for each of your branches.
> 
> that works :)
> 
> Although not an ideal solution - I have to manually configure all
> branches + update them as they are created

It's not a 100% solution, but you can use a limited glob-like syntax in the branches and tags lines of the svn-remote config block.  You still need to do some manual work (one entry for each developer), but the wildcards eliminate a lot of the grunt work as individual branches are created.  See the very end of the git-svn manpage for examples (section titled CONFIGURATION).  I use that technique to track a subdirectory of the Slimdevices SVN repo [1], which has a similarly complex layout:

repo/7.1/trunk
repo/7.1/branches/branchA
repo/7.1/branches/branchB
repo/7.1/tags/tag1
repo/7.2/trunk
repo/7.2/branches/branchC
...

HTH,
Stephen
