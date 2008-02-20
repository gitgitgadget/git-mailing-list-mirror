From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Built-in checkout: wrong behaviour in subdirectories
Date: Wed, 20 Feb 2008 17:44:44 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802201740050.19024@iabervon.org>
References: <20080220223520.GA23642@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:45:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxgq-0000x3-II
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYBTWot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbYBTWot
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:44:49 -0500
Received: from iabervon.org ([66.92.72.58]:51787 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbYBTWos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:44:48 -0500
Received: (qmail 13017 invoked by uid 1000); 20 Feb 2008 22:44:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 22:44:44 -0000
In-Reply-To: <20080220223520.GA23642@localhost>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74559>

On Wed, 20 Feb 2008, Clemens Buchacher wrote:

> Hi,
> 
> The following test shows a problem since commit 782c2d6 (Build in checkout):
> 
> mkdir testrep
> cd testrep
> git init
> 
> : >file1
> git add file1
> git commit -m 'initial'
> 
> git branch dev
> 
> mkdir dir1
> cd dir1
> # this creates dir1/file1
> git checkout dev

I was just recently wondering why that worked (in the context of trying to 
have builtin-clone work the same way). Guess that explains it...

Junio: it looks like something used to cause read-tree to be run with 
pwd being the working tree root in git-checkout.sh; is that something that 
should be done in setup for builtin-checkout, or should unpack_trees learn 
how to deal correctly with a non-pwd work tree root?

	-Daniel
*This .sig left intentionally blank*
