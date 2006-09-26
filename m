From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 17:23:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
References: <45196628.9010107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 23:23:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKOf-0005P0-Gy
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 23:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWIZVXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWIZVXR
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 17:23:17 -0400
Received: from iabervon.org ([66.92.72.58]:16653 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932426AbWIZVXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 17:23:16 -0400
Received: (qmail 1254 invoked by uid 1000); 26 Sep 2006 17:23:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Sep 2006 17:23:15 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <45196628.9010107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27823>

On Tue, 26 Sep 2006, A Large Angry SCM wrote:

> Git, unfortunately, does not make it easy. What is wanted is to put all
> of the subprojects in one repository and be able to checkout the various
> parts from a local copy of the repository. The problem is, with Git, a
> repository can have at most one working directory associated with it at
> a time. This is because Git stores a lot of information about the
> contents of the working directory in the repository. In fact, the usual
> situation is that the repository, itself, is in the working directory.

There are a bunch of use cases which people see as subprojects, with 
slightly different desires. For example, I personally don't think there's 
any point to subprojects if a commit of the parent project doesn't specify 
the embedded commits of each subproject (so, for example, you can use 
bisect on the parent project to figure out which act of updating a 
subproject broke the resulting system). AFAICT, your design doesn't handle 
that, but uses the most recently fetched versions of all subprojects, with 
the revision control of the parent only handling revisions in the 
arrangement and membership of subprojects in the parent.

	-Daniel
*This .sig left intentionally blank*
