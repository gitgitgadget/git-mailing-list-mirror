From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: The coolest merge EVER!
Date: Fri, 24 Jun 2005 13:49:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506241332150.30848-100000@iabervon.org>
References: <pan.2005.06.24.11.54.51.598627@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 19:47:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlsGy-0001dt-1a
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 19:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbVFXRxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFXRxi
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 13:53:38 -0400
Received: from iabervon.org ([66.92.72.58]:17927 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263169AbVFXRvO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 13:51:14 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DlsIu-0007F2-00; Fri, 24 Jun 2005 13:49:24 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.06.24.11.54.51.598627@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jun 2005, Matthias Urlichs wrote:

> Hi, Junio C Hamano wrote:
> 
> > I suspect there
> > would be a massive additional support needed if you want to make it easy
> > for Paul to pull changes made to gitk in your tree.
> 
> I don't think that's possible; after all, the trees are now merged, so any
> pull would fetch all of Linus' tree.

Linus could do:

 git-read-tree gitk-head
 git-update-cache gitk
 git-commit-tree `write-tree` -p gitk-head > gitk-patched-head
 git-read-tree HEAD
 git merge gitk-patched-head

(or, better, use a separate index file for the gitk index)

(to commit changes to the gitk script made in a git working directory)

The change I proposed earlier would be so that the system would know what
was going on and users wouldn't have to. Then someone who didn't know that
gitk was (also) a separate project and just committed changes to it would
still generate gitk commits when appropriate.

	-Daniel
*This .sig left intentionally blank*

