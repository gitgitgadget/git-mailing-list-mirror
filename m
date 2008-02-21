From: Sam Vilain <sam@vilain.net>
Subject: Re: Interrupted git-svn dcommit, now I get segmentation faults
Date: Fri, 22 Feb 2008 08:27:18 +1300
Message-ID: <47BDD096.7040606@vilain.net>
References: <loom.20080221T062522-821@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Ball <ceball@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 20:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSH3b-0008D1-Gk
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 20:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYBUTZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 14:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYBUTZf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 14:25:35 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:33794 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbYBUTZe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 14:25:34 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 23A9D21D222; Fri, 22 Feb 2008 08:25:33 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id C413821D21C;
	Fri, 22 Feb 2008 08:25:27 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <loom.20080221T062522-821@post.gmane.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74646>

Chris Ball wrote:
> Hi,
> 
> I mistakenly interrupted a git-svn dcommit, and now whenever I run
> git-svn dcommit I get a segmentation fault, but the commit is
> successful. I have just switched from Subversion to Git, so I'm not
 [...]
> git diff still showed the change on my machine, so I ran git-svn dcommit
> again:
> 
> $ git-svn dcommit
> Committing to https://svn/repository ...
> Merge conflict during commit: Your file or directory 'path/to/file' is
> probably out-of-date: The version resource does not correspond to the
> resource within the transaction.  Either the requested version
> resource is out of date (needs to be updated), or the requested
> version resource is newer than the transaction root (restart the
> commit). at /usr/bin/git-svn line 420

If you get stuff like that you can move the git-svn state out of the
way, and re-run git-svn fetch; it will rebuild the metadata.

 $ mv .git/svn .git/svn.bad
 $ git-svn fetch

Not a fix I know, but might work for you ;)

Sam.
