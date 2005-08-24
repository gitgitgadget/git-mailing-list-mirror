From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Query about status of http-pull
Date: Wed, 24 Aug 2005 12:39:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508241233260.23242@iabervon.org>
References: <1124899847.7187.18.camel@lycan.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT Mailing Lists <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 18:47:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7yE7-0006nw-SI
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 18:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVHXQfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 12:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVHXQfk
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 12:35:40 -0400
Received: from iabervon.org ([66.92.72.58]:6666 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751139AbVHXQfj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 12:35:39 -0400
Received: (qmail 22451 invoked by uid 1000); 24 Aug 2005 12:39:13 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2005 12:39:13 -0400
To: Martin Schlemmer <azarah@nosferatu.za.org>
In-Reply-To: <1124899847.7187.18.camel@lycan.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7712>

On Wed, 24 Aug 2005, Martin Schlemmer wrote:

> Hi,
>
> Recently cogito again say that the rsync method will be deprecated in
> future (due to http-pull now supporting pack objects I suppose), but it
> seems to me that it still have other issues:
>
> -----
> lycan linux-2.6 # git pull origin
> Fetching HEAD using http
> Getting pack list
> error: Couldn't get 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf: not separate or in any pack
> error: Tried http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/05/72e3da3ff5c3744b2f606ecf296d5f89a4bbdf
> Cannot obtain needed object 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf
> while processing commit 0000000000000000000000000000000000000000.

It looks like pack-c24bb5025e835a3d8733931ce7cc440f7bfbaaed isn't in the
pack list. I suspect that updating this file should really be done by
anything that creates pack files, because people forget to run the program
that does it otherwise and then http has problems.

	-Daniel
*This .sig left intentionally blank*
