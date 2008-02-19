From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/5] Cover letter for format-patch series
Date: Mon, 18 Feb 2008 22:55:59 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182242300.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 04:57:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRJbR-0002Fp-7z
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 04:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYBSD4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 22:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbYBSD4D
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 22:56:03 -0500
Received: from iabervon.org ([66.92.72.58]:54144 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbYBSD4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 22:56:01 -0500
Received: (qmail 22288 invoked by uid 1000); 19 Feb 2008 03:55:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 03:55:59 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74369>

This should take care of all of the comments, so far as they're practical 
to do in the initial series. Future work will include making the cover 
letter include useful shortlog and diffstat (if possible) for arguments 
that aren't a single linear and bounded series (at present, doing anything 
too tricky results in a cover letter without shortlog or diffstat).

Also, I haven't done anything here about making format-patch give an error 
if the series is empty, whether or not --cover-letter is used.

Note that [1/5] is new tests for format-patch, and independant of this 
series except in so far as it demonstrates that I haven't broken these 
things.

Daniel Barkalow (5):
      Add more tests for format-patch
      Improve message-id generation flow control for format-patch
      Export some email and pretty-printing functions
      Retain extra blank lines between the summary and the body
      Add a --cover-letter option to format-patch

 Documentation/git-format-patch.txt                 |   20 +-
 builtin-log.c                                      |  261 ++++++++++++++------
 commit.h                                           |   15 ++
 log-tree.c                                         |  126 +++++-----
 log-tree.h                                         |    2 +
 pretty.c                                           |   38 ++--
 revision.h                                         |    2 +-
 t/t4013-diff-various.sh                            |    1 +
 ...tch_--stdout_--cover-letter_-n_initial..master^ |  101 ++++++++
 t/t4014-format-patch.sh                            |   71 ++++++
 10 files changed, 477 insertions(+), 160 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
