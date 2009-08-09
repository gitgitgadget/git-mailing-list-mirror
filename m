From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/8] Foreign VCS helpers
Date: Sun, 9 Aug 2009 15:28:08 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908091525210.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 21:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaE41-0005Dq-Pc
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbZHIT2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 15:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbZHIT2I
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 15:28:08 -0400
Received: from iabervon.org ([66.92.72.58]:33222 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbZHIT2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 15:28:08 -0400
Received: (qmail 12174 invoked by uid 1000); 9 Aug 2009 19:28:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2009 19:28:08 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125367>

This is a replacement for the db/foreign-scm series in pu, now based
on next. The behavior specified for helpers is the same, so I'm not
reposting the particular helpers this time.

Daniel Barkalow (7):
  Use a clearer style to issue commands to remote helpers
  Use a function to determine whether a remote is valid
  Allow fetch to modify refs
  Allow programs to not depend on remotes having urls
  Add a config option for remotes to specify a foreign vcs
  Add support for "import" helper command
  Allow helpers to report in "list" command that the ref is unchanged

Johan Herland (1):
  Allow helpers to request marks for fast-import

 Documentation/config.txt             |    4 +
 Documentation/git-remote-helpers.txt |   22 ++++++-
 builtin-clone.c                      |    6 +-
 builtin-fetch.c                      |   19 +++--
 builtin-ls-remote.c                  |    4 +-
 builtin-push.c                       |   54 +++++++++-----
 remote.c                             |   15 +++-
 remote.h                             |    2 +
 transport-helper.c                   |  129 ++++++++++++++++++++++++++++++----
 transport.c                          |   21 ++++--
 transport.h                          |   41 ++++++++++-
 11 files changed, 261 insertions(+), 56 deletions(-)
