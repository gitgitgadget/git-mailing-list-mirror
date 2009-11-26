From: Yann Dirson <ydirson@linagora.com>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Thu, 26 Nov 2009 15:30:16 +0100
Message-ID: <20091126143016.GF15136@linagora.com>
References: <20091125164734.GF21347@linagora.com>
 <20091126004817.GL11919@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 15:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDfMX-00083R-R7
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 15:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760532AbZKZOaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 09:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760347AbZKZOaN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 09:30:13 -0500
Received: from [194.206.158.221] ([194.206.158.221]:36066 "EHLO
	cyann.linagora.lan" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760286AbZKZOaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 09:30:12 -0500
Received: from yann by cyann.linagora.lan with local (Exim 4.69)
	(envelope-from <yann@linagora.com>)
	id 1NDfMO-0007Wk-Vt; Thu, 26 Nov 2009 15:30:16 +0100
Content-Disposition: inline
In-Reply-To: <20091126004817.GL11919@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133797>

On Wed, Nov 25, 2009 at 04:48:17PM -0800, Shawn O. Pearce wrote:
> > When importing a git repo into eclipse, we get a list of projects to
> > import, but that list is empty.  What is expected by egit to get this
> > list filled ?
> 
> There should be .project files in the repository.  I think we scan
> the entire checkout tree for .project files, but maybe we are doing
> something stupid and only looking at the top level directory of
> the checkout.

Right, we could make it work - the devs just did not have the habbit
of commiting .project files.

> > It also does not look like it would be possible to use the "share"
> > functionnality to setup such a repository from multiple projects (or
> > from a project set), right ?
> 
> Nope, I don't think this is supported right now.  You need to
> initialize the git repository by hand in the higher level directory
> that holds the projects.

Yes, we did that by git-add'ing the initial projects manually and
pushing them, and we can now "import" that.

That makes me wonder if it should work to add a new project afterwards
from within Eclipse.  If we create a new project under the git tree,
and try to use "share", then we get presented a folded list containing
the project we want to add, which when unfolded reveals "..\.git"
(yes, this test done on windows) as repository, which is promising.

But then the field below near the "Create" button (the one with
"\.git" text on the right) gets polulated with the full project path
when we click on the project in the list, and we could not unlock the
"next" or "finish" button.  Are we just trying things the way they
should work but hit functionnality that is just not finished, or are
we completely off-track ?

Thanks much,
-- 
Yann
