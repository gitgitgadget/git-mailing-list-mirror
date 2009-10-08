From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] The default encoding for reading commits is UTF-8
	rather than system default
Date: Wed, 7 Oct 2009 21:16:10 -0700
Message-ID: <20091008041609.GV9261@spearce.org>
References: <1254930273-1796-1-git-send-email-constantine.plotnikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 06:17:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvkRy-00040v-Mo
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 06:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbZJHEQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 00:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZJHEQq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 00:16:46 -0400
Received: from george.spearce.org ([209.20.77.23]:34694 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZJHEQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 00:16:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 16F7C381FE; Thu,  8 Oct 2009 04:16:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1254930273-1796-1-git-send-email-constantine.plotnikov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129669>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> See man git-commit (the section "DISCUSSION"), for justification why 
> UTF-8 should be used. Note that this was already correctly implemented 
> in ObjectWriter.writeCommit(...) method. But Commit.decode() was not
> implemented in the same way for some reason.

Commit predates that encoding code in ObjectWriter.writeCommit and
it looks like we just forgot to go back and fix it.  A very old bug.

Since our move to the Eclipse Foundation we really need to follow
their IP process, which for non-committers means creating a new bug
in their Bugzilla system:

  https://bugs.eclipse.org/bugs/enter_bug.cgi?product=EGit

See also:

  http://wiki.eclipse.org/EGit/Contributor_Guide#Contributing_Patches
  
>  .../tst/org/spearce/jgit/lib/T0003_Basic.java      |    3 +++
>  .../src/org/spearce/jgit/lib/Commit.java           |   18 +++++++-----------
>  2 files changed, 10 insertions(+), 11 deletions(-)

-- 
Shawn.
