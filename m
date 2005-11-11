From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 15:22:37 +0100
Message-ID: <200511111522.37979.Josef.Weidendorfer@gmx.de>
References: <1124832796.23795.9.camel@dv> <200511110213.54846.Josef.Weidendorfer@gmx.de> <1131684784.31172.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 15:25:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaZo1-0003on-5j
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 15:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVKKOWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 09:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVKKOWn
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 09:22:43 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:27880 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750789AbVKKOWm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 09:22:42 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 3D0EE265E;
	Fri, 11 Nov 2005 15:22:39 +0100 (MET)
To: Pavel Roskin <proski@gnu.org>
User-Agent: KMail/1.8.2
In-Reply-To: <1131684784.31172.16.camel@dv>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11598>

On Friday 11 November 2005 05:53, Pavel Roskin wrote:
> I'm not sure if we understand each other, but "recorded" refers to
> automatically determined branch name.  If cg-clone can determine the
> branch name, that name should be saved and used for updates.
> 
> Whether the branch name is saved in .git/branches/ using hash notation
> (old style) or in .git/remotes/ (new style) is irrelevant.

Yes.
But for the conrete implementation it is relevant.

AFAIK, there is not really a "new" and "old" style, but more the
git way (attributes for remote repositories in .git/remotes) and the
Cogito way (attributes for a remote branch).

"Recording" talks about storing the name of the remote branch that
maps to the local "origin" branch, so I would vote for storing this
in .git/branches/origin.

For cg-clone, this is no problem because cg-clone writes this file itself.
Another thing is if you add later on a remote branch with cg-branch-add
without specifying a concrete remote branch name. Do we want the
record the branch name at the first cg-fetch for the future?

> That's why I mentioned the idea of having a separate file to indicate
> the default branch for export.

Agree.

Josef
