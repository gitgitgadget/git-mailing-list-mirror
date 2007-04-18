From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svn: don't allow globs to match regular files
Date: Wed, 18 Apr 2007 00:45:03 -0700
Message-ID: <7v3b2yjfcw.fsf@assigned-by-dhcp.cox.net>
References: <20070418071733.GA10627@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He4qn-0002OU-4b
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 09:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbXDRHpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 03:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbXDRHpI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 03:45:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52618 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932932AbXDRHpG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 03:45:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418074505.UVIL1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Apr 2007 03:45:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id oXl41W0031kojtg0000000; Wed, 18 Apr 2007 03:45:04 -0400
In-Reply-To: <20070418071733.GA10627@muzzle> (Eric Wong's message of "Wed, 18
	Apr 2007 00:17:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44869>

Eric Wong <normalperson@yhbt.net> writes:

> git only tracks the histories of full directories, not
> that of individual files.  Sometimes, SVN users will
> place[1] a regular file in the directory designated
> for subdirectories of branches or tags.
>
> Thanks to jrockway on #git for pointing this out.
>
> [1] mistakenly or otherwise, such as a README

It is not clear what this "glob" means to me.  Enlightenment?

My cursory reading of the code is that you are grabbing things
under branches/ and tags/, expecting each of what you would find
there is the whole-tree of a revision, and do not want to see
any regular file immediately underneath branches/ and tags/.

Is that what is happening here?
