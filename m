From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/8] builtin-clone
Date: Thu, 17 Apr 2008 19:32:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804171923040.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:33:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmdbE-0003Sh-HZ
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 01:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbYDQXcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 19:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbYDQXcS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 19:32:18 -0400
Received: from iabervon.org ([66.92.72.58]:42446 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbYDQXcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 19:32:17 -0400
Received: (qmail 6282 invoked by uid 1000); 17 Apr 2008 23:32:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Apr 2008 23:32:15 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79844>

This is my latest version, rebased approximately on current master (or 
recent maint, I guess). It's missing all of Johan's stuff, which is tests 
for stuff I've fixed and (after this series) a series to make the clone 
generate packed refs. I believe Johannes has a bunch of changes, and I 
haven't been working on this lately, and it needs review more than 
anything, so I'm sending it out.

Daniel Barkalow (8):
  Mark the list of refs to fetch as const
  Add a lockfile function to append to a file
  Add a library function to add an alternate to the alternates file
  Add a function to set a non-default work tree
  Have a constant extern refspec for "--tags"
  Allow for having for_each_ref() list extra refs
  Provide API access to init_db()
  Build in clone

 Makefile                      |    2 +-
 builtin-clone.c               |  546 +++++++++++++++++++++++++++++++++++++++++
 builtin-fetch.c               |   10 +-
 builtin-init-db.c             |  180 +++++++-------
 builtin.h                     |    1 +
 cache.h                       |    7 +
 contrib/examples/git-clone.sh |  522 +++++++++++++++++++++++++++++++++++++++
 environment.c                 |    6 +
 git-clone.sh                  |  522 ---------------------------------------
 git.c                         |    1 +
 lockfile.c                    |   17 ++
 refs.c                        |   18 ++
 refs.h                        |    9 +
 remote.c                      |    9 +
 remote.h                      |    2 +
 sha1_file.c                   |   12 +
 transport.c                   |   16 +-
 transport.h                   |    4 +-
 18 files changed, 1256 insertions(+), 628 deletions(-)
 create mode 100644 builtin-clone.c
 create mode 100755 contrib/examples/git-clone.sh
 delete mode 100755 git-clone.sh
