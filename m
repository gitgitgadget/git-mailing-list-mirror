From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fetch hangs or gives broken pipe on a specific "branch"
Date: Wed, 6 Jun 2007 01:27:28 -0700
Message-ID: <20070606082728.GA16321@muzzle>
References: <689181.83891.qm@web55015.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvqsA-0001uL-86
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbXFFI1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbXFFI1b
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:27:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54756 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbXFFI1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:27:30 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1013C2DC032;
	Wed,  6 Jun 2007 01:27:29 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 06 Jun 2007 01:27:28 -0700
Content-Disposition: inline
In-Reply-To: <689181.83891.qm@web55015.mail.re4.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49265>

Bill Priest <priestwilliaml@yahoo.com> wrote:
> I downloaded the latest release of git 1.5.2 and built
> it on RHEL box.  Subversion version is 1.4.2.  The
> repository and the git working directory are on the
> same machine (taking networking out of the picture).
> mkdir git_test
> cd git_test
> git-svn init -t tags -b branches -T trunk "my URL"
> Initialized empty Git repository in .git/
> git-svn fetch
> all tags were processed w/o error AFAICT; the first
> branch it tries to work on causes either a hang or a
> "Broken Pipe".  I changed from an http:// to svn:// on
> the git-svn init and everything worked correctly.
> This would seem to indicate some type of problem w/
> apache/httpd problem.  I looked in the httpd logs and
> didn't see any errors.
>    Is this a known problem?

No.  Is it reproducible?  In my experience, http(s):// has been much
less problematic than svn:// repositories (because I mainly access
https:// ones).

Also, are you certain the git-svn you're running is 1.5.2?  When you
say that it processed all tags before hitting a branch, that
sounds like the behavior of a pre-1.5.1 git-svn.  Run git-svn --version
just to be sure :)

git-svn 1.5.1+ fetches trunk, tags, and branches in chronological order.
Of course, your project may have never created a branch before any of
your tags are created...

Any details on the branch that caused it to fail would be appreciated,
thanks.

-- 
Eric Wong
