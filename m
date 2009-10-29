From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/2] Default Pager and Editor at build-time
Date: Thu, 29 Oct 2009 12:42:43 -0400
Message-ID: <1256834565-19443-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <20091029073224.GA15403@progeny.tock>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 17:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Y5w-0006un-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZJ2QnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755409AbZJ2QnR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:43:17 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:60984 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357AbZJ2QnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:43:16 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:50921 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N3Y5o-0004Gl-9v; Thu, 29 Oct 2009 12:43:20 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N3Y5o-00054O-7T; Thu, 29 Oct 2009 12:43:20 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9TGhKua019488;
	Thu, 29 Oct 2009 12:43:20 -0400
X-Mailer: git-send-email 1.6.5
In-Reply-To: <20091029073224.GA15403@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131613>

The two patches look ok to me (not withstanding the comments already
made about the test and possible future changes required).

I did make a few small tweaks to use | instead of / as the sed
substitution separator (since we're presumably working with full
paths).  The substitution was also extended into the .sh scripts
(git-am, explicitly).

Jonathan Nieder (1):
  Provide a build time default-editor setting

Junio C Hamano (1):
  Provide a build time default-pager setting

 Makefile                  |   19 +++++++++++++++++++
 editor.c                  |    2 +-
 git-add--interactive.perl |    3 ++-
 git-am.sh                 |    2 +-
 git-sh-setup.sh           |    6 ++++--
 git-svn.perl              |    8 +++++---
 pager.c                   |    2 +-
 t/Makefile                |    2 ++
 t/t7005-editor.sh         |   29 ++++++++++++++++++++++-------
 9 files changed, 57 insertions(+), 16 deletions(-)
