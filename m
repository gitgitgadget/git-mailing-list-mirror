From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Temporary directories getting errantly added into trees
Date: Wed, 21 Nov 2007 23:30:59 -0800
Message-ID: <20071122073059.GA28197@soma>
References: <4744FCD9.7020102@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 08:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv6Ws-0007wJ-2M
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 08:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXKVHbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 02:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXKVHbB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 02:31:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37232 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXKVHbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 02:31:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0DD797DC0FE;
	Wed, 21 Nov 2007 23:30:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4744FCD9.7020102@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65745>

Sam Vilain <sam@vilain.net> wrote:
> I just got through a rather nasty debugging session with git-rebase,
> which relies on a .dotest directory.  Turns out that .dotest was
> accidentally added to the tree in the history of the commit that was
> being rebased onto.

Hi Sam,

Ouch

> There are a lot of temporary files like that made by various scripts -
> eg, git-filter-branch makes .git-rewrite, etc.
> 
> I think it would be a good thing for all if you had to work very hard to
> put files like this in the tree, or perhaps it would be better to go
> through and make all the tools that create these temporary directories
> create them under .git instead.

Polluting the working tree is definitely a bad thing to do IMNSHO.

git-rebase --merge already puts its temporary directory inside
.git/.dotest-merge.  I hoped to set an example with that and
get more tools to do the same; but it hasn't happened yet...

-- 
Eric Wong
