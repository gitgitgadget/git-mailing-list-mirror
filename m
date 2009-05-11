From: "Yann Dirson" <ydirson@linagora.com>
Subject: Re: [BUG] git-svn: HEAD pointing to a tag after cloning
Date: Mon, 11 May 2009 16:09:42 +0200 (CEST)
Message-ID: <53308.10.0.0.1.1242050982.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 11 16:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3WCO-0003x3-82
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZEKOJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZEKOJc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:09:32 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:53501 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZEKOJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 10:09:31 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 760A3429F01;
	Mon, 11 May 2009 16:09:31 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Mon, 11 May 2009 16:09:42 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118799>

> svn allows you to commit to tags as if they were branches - indeed they
> are branches just as much as svn branches are branches.
>
> Therefore, git-svn represents svn tags as git remote branches (not
> tags). After the clone is done, git-svn checks out the branch on which
> the last commit was done.

I am aware of that.  However, nothing seems to prevent svn tags to be
mapped to tag refs insead of head refs.  Maybe both behaviours could be
available, if someone wants to be able to "commit to svn tags" properly
from git, but since that is probably not the common case, I would rather
see this current behaviour as an option.

But we are going off-topic here.  That "feature" of git-svn checking out
"the branch on which the last commit was done" is fortunately not being
documented in the manpage :).  The problem here (distinct from the
tag-handling issue) is that you can barely predict what svn remote your
master branch will track !

> One may argue that master should point to trunk (for --stdlayout)
> instead after git svn clone, just like master points to master after git
> clone.

Exactly, that would simply be consistent.
