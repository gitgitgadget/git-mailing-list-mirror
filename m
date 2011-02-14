From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: future of git-gui as subsytem or submodule, WAS: [PATCH] git-gui:
	document the gui.maxfilesdisplayed variable
Date: Mon, 14 Feb 2011 23:03:18 +0100
Message-ID: <20110214220318.GD50815@book.hvoigt.net>
References: <20110213125324.GA31986@book.hvoigt.net> <7v39nruk9j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:03:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6Vy-0008Vb-CV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335Ab1BNWDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:03:21 -0500
Received: from darksea.de ([83.133.111.250]:47459 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751889Ab1BNWDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:03:20 -0500
Received: (qmail 18306 invoked from network); 14 Feb 2011 23:03:18 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Feb 2011 23:03:18 +0100
Content-Disposition: inline
In-Reply-To: <7v39nruk9j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166781>

Hi,

On Sun, Feb 13, 2011 at 11:51:04PM -0800, Junio C Hamano wrote:
> Two opposing thoughts.
> 
>  1. We can keep git-gui and git proper separate projects, move git-gui
>     documentation out of git to git-gui, and with clever Makefile trick
>     include and build git-gui related documentation conditionally only
>     when git-gui appears part of the git project tree (this anticipates a
>     future where git-gui is bound to git not with the subtree merge
>     strategy as we currently do, but as a submodule).
> 
>  2. Just like the Linux kernel project, we can make each subsystem with
>     separate maintainers just different repositories of the same git
>     project with their own focus.  We already do this for git-svn (which I
>     delegate to Eric Wong by pulling from him) and some parts of contrib/
>     tree; we have already been halfway there for gitweb/ (which I don't
>     regularly "pull from", but I mainly act as a patch monkey without
>     actively managing that part myself).  I don't see why we cannot extend
>     that model to git-gui and gitk.

I would vote for 2. Not because I think submodules will not become as easy to
use so they are ready for that but I think there are mainly two reasons
for using a submodule

  A. The submodule contains shared code which is used by multiple projects

  B. A submodule is used to keep large collection of files seperate from
     a project because most times they are not needed and would
     interfere with the project.

There are maybe more but these two do not apply to git-gui and I like
the way it is currently integrated in one repository with git. It also
underlines the fact that git-gui is AFAICS the standard and best
developed gui for git.

Another plus, if we extend that model to gitk, is that both could start
sharing code between each other (maybe relocate to the same directory).

Although 1. would be a good choice for getting more people involved in
enhancing submodule support, from a philosophical standpoint, I think 2.
is the more natural choice.

What do others think?

Cheers Heiko
