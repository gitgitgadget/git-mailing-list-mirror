From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using VC build git (new patch)
Date: Sat, 15 Aug 2009 18:57:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908151851280.8306@pacific.mpi-cbg.de>
References: <1976ea660908150921n516178dbs2ce024ed729e2e02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 18:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McMZF-0002kC-1u
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 18:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbZHOQ5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbZHOQ5M
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 12:57:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:44946 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932072AbZHOQ5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 12:57:11 -0400
Received: (qmail invoked by alias); 15 Aug 2009 16:57:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 15 Aug 2009 18:57:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1876BUBMnc7pEPUsgLNzXg2CUZ54OPLmesaeAvLpP
	PHgNGfAlYCJHo9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1976ea660908150921n516178dbs2ce024ed729e2e02@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126012>

Hi,

On Sun, 16 Aug 2009, Frank Li wrote:

> New patch.

A single monster patch?

Hmm.

Please understand that I will not review that unless it is split up into 
nice little and reviewable chunks.

This diffstat does not let me expect well-defined changes, either, sorry:

 builtin-fast-export.c               |    1 +
 compat/fnmatch/fnmatch.c            |    2 +
 compat/mingw.c                      |   68 ++-
 compat/mingw.h                      |   21 +-
 compat/regex/regex.c                |    8 +-
 compat/snprintf.c                   |    7 +-
 compat/vcbuild/.gitignore           |    3 +
 compat/vcbuild/ReadMe               |   13 +
 compat/vcbuild/git/git.vcproj       |  197 +++++
 compat/vcbuild/include/dirent.h     |  127 ++++
 compat/vcbuild/include/unistd.h     |  174 +++++
 compat/vcbuild/libgit/libgit.vcproj | 1347 +++++++++++++++++++++++++++++++++++
 compat/vcbuild/porting.c            |   13 +
 compat/vcbuild/sys/time.h           |   21 +
 compat/winansi.c                    |    8 +
 git-compat-util.h                   |    2 +-
 help.c                              |    5 +-
 pager.c                             |    4 +-
 run-command.c                       |   11 +-
 run-command.h                       |    2 +-
 setup.c                             |    2 +-
 21 files changed, 2011 insertions(+), 25 deletions(-)

It still modifies mingw.c and mingw.h, even if it has been strongly 
suggested to leave those alone.

It touches all kinds of files that appear to be completely unrelated to 
Microsoft Visual C++.

Remember: breaking things for existing users (and changing something that 
works for them quite well readily risks that) is not an option.

And the commit message does not even explain half of it...

Ciao,
Dscho
