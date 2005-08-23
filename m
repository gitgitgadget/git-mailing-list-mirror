From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 15:43:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508231533570.23242@iabervon.org>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 21:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7edZ-0006x5-1a
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 21:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHWTkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 15:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHWTkZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 15:40:25 -0400
Received: from iabervon.org ([66.92.72.58]:15115 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932331AbVHWTkY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 15:40:24 -0400
Received: (qmail 14580 invoked by uid 1000); 23 Aug 2005 15:43:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 15:43:56 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7663>

On Tue, 23 Aug 2005, Carl Baldwin wrote:

> Hello,
>
> I recently started using git to revision control the source for my
> web-page.  I wrote a post-update hook to checkout the files when I push
> to the 'live' repository.
>
> In this particular context I decided that it was important to me to remove
> deleted files after checking out the new HEAD.  I accomplished this by running
> git-ls-files before and after the checkout.
>
> Is there a better way?  Could there be some way built into git to easily
> find out what files dissappear when replacing the current index with one
> from a new tree?  Is there already?  The behavior of git should NOT
> change to delete these files but I would argue that some way should
> exist to query what files disappeared if removing them is desired.

If you don't use -f, git-checkout-script removes deleted files. Using -f
tells it to ignore the old index, which means that it can't tell the
difference between removed files and files that weren't tracked at all.

	-Daniel
*This .sig left intentionally blank*
