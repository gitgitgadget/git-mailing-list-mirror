From: Mark Plaksin <happy@usg.edu>
Subject: Syntax check via update hook?
Date: Fri, 08 May 2009 15:43:30 -0400
Message-ID: <wsprejtm71.fsf@usg.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 21:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2W5I-0008JW-Il
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 21:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbZEHTuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbZEHTuH
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 15:50:07 -0400
Received: from main.gmane.org ([80.91.229.2]:37808 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983AbZEHTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 15:50:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M2W55-0006i5-47
	for git@vger.kernel.org; Fri, 08 May 2009 19:50:03 +0000
Received: from stone.tss.usg.edu ([168.24.82.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 May 2009 19:50:03 +0000
Received: from happy by stone.tss.usg.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 May 2009 19:50:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: stone.tss.usg.edu
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.93 (gnu/linux)
Cancel-Lock: sha1:94frZPxY/nP475TLcoi8ssw8UvI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118626>

Howdy:

What's the best way to make the update hook do a syntax check?

We want to switch our Puppet [1] config repository from SVN to Git.  Our
SVN repository has a pre-commit hook that does a syntax check.  The hook
runs Puppet to check the syntax of the file(s) being committed and if the
check fails, the commit fails.  With SVN that hook runs on the server so
it's easy to have (the correct version of) the puppet binary there for
the hook to use.

Once Puppet config changes are committed to to our SVN repository they
are automatically pushed into our production Puppet config.  We want to
do something similar with Git--once commits are successfully pushed to
the master repository they are automatically pulled and become our
production Puppet config.

Git's pre-commit hook runs wherever a person happens to have checked out
the Git repository.  That could be a desktop, laptop...just about
anywhere.  It's harder to make sure the correct version of Puppet is in
all of those places.  So we'd love for the syntax check to run on the
server.  But we can't figure it out.

Thanks for any assistance!

Footnotes: 
[1]  http://reductivelabs.com/products/puppet/
