From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 04/28] Allow "guilt import-commit" to run from a dir
 which contains spaces.
Date: Sun, 23 Mar 2014 16:07:39 -0400
Message-ID: <20140323200739.GJ1661@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-5-git-send-email-cederp@opera.com>
 <20140323170409.GG1661@meili.valhalla.31bits.net>
 <CAP=KgsSBcsG1kMfyc=MbUDCuC+4W9Boa2Fwf-FSg6XNxaCAt8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 21:07:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRog6-0007KV-1F
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 21:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaCWUH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 16:07:26 -0400
Received: from josefsipek.net ([64.9.206.49]:1722 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaCWUHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 16:07:25 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 4D602554D8;
	Sun, 23 Mar 2014 16:07:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAP=KgsSBcsG1kMfyc=MbUDCuC+4W9Boa2Fwf-FSg6XNxaCAt8g@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244804>

On Sun, Mar 23, 2014 at 08:57:08PM +0100, Per Cederqvist wrote:
> On Sun, Mar 23, 2014 at 6:04 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> 
> > On Fri, Mar 21, 2014 at 08:31:42AM +0100, Per Cederqvist wrote:
> >
> >> Signed-off-by: Per Cederqvist <cederp@opera.com>
> >> ---
> >>  guilt-import-commit | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/guilt-import-commit b/guilt-import-commit
> >> index 20dcee2..9488ded 100755
> >> --- a/guilt-import-commit
> >> +++ b/guilt-import-commit
> >> @@ -23,7 +23,7 @@ if ! must_commit_first; then
> >>  fi
> >>
> >>  disp "About to begin conversion..." >&2
> >> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
> >> +disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
> >
> > I wonder if it'd be better to use 'git rev-parse' here instead of looking at
> > the refs directly.
> >
> > IOW,
> >
> > disp "Current head: `git rev-parse \`git_branch\``" >&2
> 
> That is probably a good idea. I only made the minimum change
> required to get the test suite to pass.

I totally understand.

> > Maybe even $() instead of the inner `` to clean it up some more.
> 
> Yes, given that that construct is already used in several places
> it is apparently portable enough for guilt. (I guess nobody uses
> /bin/sh on Solaris to run guilt. It doesn't support the $(...)
> construct.)

Hrm?  I'm using OpenIndiana (OpenSolaris derivative) and my /bin/sh seems to
be a symlink to ksh93.  What version of Solaris are you seeing this behavior
on?

Jeff.

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw
