From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 1 Mar 2006 18:14:43 +0100
Message-ID: <200603011814.43573.Josef.Weidendorfer@gmx.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <4405C6BE.2000706@op5.se> <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 18:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEUui-000771-7P
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWCAROu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCAROu
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:14:50 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:28853 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932409AbWCAROt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 12:14:49 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id A26E61759;
	Wed,  1 Mar 2006 18:14:44 +0100 (MET)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.1
In-Reply-To: <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16991>

On Wednesday 01 March 2006 17:24, Linus Torvalds wrote:
> The thing about it being .git/refs/heads/svn/xyzzy is that then you can do
> 
> 	git checkout svn/xyzzy
> 
> and start modifying it. Which is exactly against the point: the thing is 
> _not_ a branch and you must _not_ commit to it.
> 
> It's much more like a tag: it's a pointer to the last point of an 
> svn-import.

Isn't it the same with tracked branches of a remote git repo?
With this reasoning, all heads that git-clone clones aside from the
special "master" should not be under .git/refs/heads, but better
under .git/refs/remotes/<remoteRepoName>/ ?

<remoteRepoName> is "origin" in the case of git-clone, so .git/remotes/origin
would contain
 URL: http://host/repo.git
 Pull: master:remotes/origin/master

Then there would not be the need for the confusing special branch "origin"
after cloning, as namespaces are separate.

Josef
