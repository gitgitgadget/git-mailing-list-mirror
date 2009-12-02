From: Yann Dirson <ydirson@linagora.com>
Subject: Re: [egit] Git repository with multiple eclipse projects ?
Date: Wed, 2 Dec 2009 15:24:13 +0100
Message-ID: <20091202142413.GB18165@linagora.com>
References: <20091125164734.GF21347@linagora.com>
 <200911252227.40235.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, egit-dev@eclipse.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 15:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFq7y-0000T0-Cu
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 15:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbZLBOYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 09:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZLBOYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 09:24:09 -0500
Received: from [194.206.158.221] ([194.206.158.221]:35511 "EHLO
	cyann.linagora.lan" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753764AbZLBOYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 09:24:08 -0500
Received: from yann by cyann.linagora.lan with local (Exim 4.69)
	(envelope-from <yann@linagora.com>)
	id 1NFq7p-0000bn-64; Wed, 02 Dec 2009 15:24:13 +0100
Content-Disposition: inline
In-Reply-To: <200911252227.40235.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134335>

On Wed, Nov 25, 2009 at 10:27:39PM +0100, Robin Rosenberg wrote:
> onsdag 25 november 2009 17:47:34 skrev  Yann Dirson:
> > I am investigating whether it is possible at all to have several
> > eclipse projects in a single git repo, and have those projects
> > correctly seen as managed by git.
> >
> > When importing a git repo into eclipse, we get a list of projects to
> > import, but that list is empty.  What is expected by egit to get this
> > list filled ?
> 
> Both Egit and Jgit themselves have multiple projects in the same repo. 
> All projects must be located in the same directory structure.
> 
> repo/.git
>     |`--project1/.git
>     |`--project2
> 
> etc
> Other variations are possible.

You seem to talk about nested git repo here.  Do you mean using
submodules (I thought jgit did not support them yet) ?  git-subtree ?

> >
> > It also does not look like it would be possible to use the "share"
> > functionnality to setup such a repository from multiple projects (or
> > from a project set), right ?
> 
> Share only tells Eclipse to attach EGit as the team provider, provided
> it is located in a git repo, or lets you create a repo if none exists.

Looks like there is a possibly-windows-specific issue here.

The test repo is a git repo with a couple of eclipse projects just
beneath the top-level.  It can be checked-out from both Ubuntu
(Karmic) and Windows (Vista), and in both cases the projects can be
attached to the team provider from the "import" wizard.

On an Ubuntu box, I could use "team/disconnect", and then "share" to
attach to "../.git", it worked like a charm.  On the windows box
however, reconnecting was not possible: the "../.git" line is not
selectable.  Note that it does read "../.git" and not "..\.git".


Note that on my "mostly squeeze" Debian box, the import would succeed,
but in that case none of the projects were attached to the team
provider.  If afterwards I try to connect it, it silently does nothing.

In that case it may be a known bug: I have a ~/.git dir that is also
seen by jgit, and which I am also proposed in the "share" dialog.  If
I move it away, the request to attach is successful.

Best regards,
-- 
Yann
