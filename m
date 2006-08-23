From: Paul Mackerras <paulus@samba.org>
Subject: git cherry-pick feature request
Date: Wed, 23 Aug 2006 16:29:04 +1000
Message-ID: <17643.62896.396783.890223@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 08:29:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFmEo-0004jr-2m
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 08:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWHWG3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 02:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHWG3O
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 02:29:14 -0400
Received: from ozlabs.org ([203.10.76.45]:9088 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932364AbWHWG3N (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 02:29:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BBCAE67D14; Wed, 23 Aug 2006 16:29:12 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25897>

Junio,

I have added a feature on the "new" branch of gitk which allows the
user to cherry-pick commits on to the head of the current branch.
Currently I am using 'sh -c "git cherry-pick -r $id 2>&1"' for this.

The reason for the "2>&1" is that git cherry-pick writes stuff to
stderr even when there is no error, and the Tcl exec command assumes
that if the command writes to stderr that it failed somehow.

Also, if the merge fails, git cherry-pick leaves the commit partially
merged rather than restoring the original state.

Could I have a flag to git cherry-pick (-q for quiet, maybe) that
tells it not to print anything if the command succeeds?  Could I also
have a flag that tells it to clean up if the merge fails and leave the
tree in its previous state?

Or is there some other git command that already does all this that I
should use instead?

Thanks,
Paul.
