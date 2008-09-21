From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/7 v2] prefix discovery at runtime (on Windows)
Date: Sun, 21 Sep 2008 18:24:31 +0200
Message-ID: <1222014278-11071-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRpP-0002GU-1n
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYIUQ3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYIUQ3W
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:29:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:51222 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbYIUQ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:29:21 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOdAu004993;
	Sun, 21 Sep 2008 18:24:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxN015855;
	Sun, 21 Sep 2008 18:24:38 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96409>

This is the second version of the patch series that fixes discovery of
the installation prefix at runtime on Windows.  It introduces a compile
flag RUNTIME_PREFIX, which can be set to explicitly request prefix
computation at runtime.

You can find the first version at

  http://article.gmane.org/gmane.comp.version-control.git/92605

I mainly improved some of the commit messages and rebased to the
current master.

PATCH 6/7 might need further discussion.  Hannes noted that PATCH 6/7
touches a sensible part of exec_cmd.c, although he thinks that the
proposed change might be good.  See
http://article.gmane.org/gmane.comp.version-control.git/92626 for his
comment.  I did not modify PATCH 6/7.

        Steffen

 [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
 [PATCH 2/7] system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set
 [PATCH 3/7] Refactor git_set_argv0_path() to git_extract_argv0_path()
 [PATCH 4/7] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
 [PATCH 5/7] Add calls to git_extract_argv0_path() in programs that call git_config_*
 [PATCH 6/7] Modify setup_path() to only add git_exec_path() to PATH
 [PATCH 7/7] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
