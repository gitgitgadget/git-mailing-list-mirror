From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git-svn: commit all changes as one svn revision?
Date: Fri, 23 May 2008 18:31:30 +0200
Message-ID: <200805231831.42984.trast@student.ethz.ch>
References: <9af502e50805230908t76c9b26exd36cfb6d0f1a9bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 18:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzaQf-0007bG-Nz
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 18:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbYEWQqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbYEWQqv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 12:46:51 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:6104 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYEWQqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 12:46:50 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 May 2008 12:46:50 EDT
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 23 May 2008 18:31:36 +0200
Received: from vpn-global-dhcp3-230.ethz.ch ([129.132.210.230]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 23 May 2008 18:31:35 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <9af502e50805230908t76c9b26exd36cfb6d0f1a9bcf@mail.gmail.com>
Content-Disposition: inline
X-OriginalArrivalTime: 23 May 2008 16:31:35.0968 (UTC) FILETIME=[77E54200:01C8BCF2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82721>

You wrote:
> I make a bunch of git commits developing something that was checked
> out from a svn repo using git-svn.  I want to commit all the changes
> since my last dcommit as one revision, rather than having each git
> commit checked in separately, as dcommit behaves.

I usually do

$ git checkout -b side master
... edit, commit ...
$ git checkout master
$ git merge --no-ff side
$ git-svn dcommit

The resulting merge commit looks like a normal merge to Git (keeping
history intact), but like a squashed commit of all changes on 'side'
to SVN.

(If you made all commits on master, you can branch 'side' and hard
reset master to origin/master first.)

- Thomas

-- 
Thomas Rast
trast@student.ethz.ch
