From: Jeff King <peff@peff.net>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 08:58:53 -0400
Message-ID: <20090529125853.GB11785@sigill.intra.peff.net>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, yury239@gmail.com
To: Paul Tarjan <ptarjan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 14:59:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA1gC-00016V-59
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 14:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759326AbZE2M6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 08:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758980AbZE2M6x
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 08:58:53 -0400
Received: from peff.net ([208.65.91.99]:59855 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759609AbZE2M6w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 08:58:52 -0400
Received: (qmail 26509 invoked by uid 107); 29 May 2009 12:58:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 29 May 2009 08:58:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2009 08:58:53 -0400
Content-Disposition: inline
In-Reply-To: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120275>

On Fri, May 29, 2009 at 12:43:35AM -0700, Paul Tarjan wrote:

> I'm new to git and probably doing something very dumb, but I can't
> seem to resolve this.
> 
> I have a remote repository and a local one. I ssh to the remote
> machine, goto the repository directory (not a bare repository), edit a
> file and commit it. All if fine.
> 
> I leave the remote host and go into the local git directory. Doing
> "git pull origin master" says "Already up-to-date." but there is a
> file I changed remotely, and I want to pull it locally!
> 
> The local repo was made with "git clone http://example.com/.git". I
> have no branching (both are on master).

Your repository is accessed over http.  You need to run "git
update-server-info" to build the files for clients to see the actual
updates.

Usually such a repo is bare, and gets updates only by push. In that
case, enabling the update hook to run update-server-info is sufficient.
But in your case, you are actually working on the remote repo via commit
and other means, so there is no convenient way to always
update-server-info after a change.

Is there a particular reason you cloned over http instead of over ssh?

-Peff
