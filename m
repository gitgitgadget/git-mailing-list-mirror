From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] On error, do not list all commands, but point to --help option
Date: Sun, 21 Oct 2007 01:41:41 +0300
Organization: Private
Message-ID: <ir51if2y.fsf@blue.sea.net>
References: <bqaujirk.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 05:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjRH5-0006zz-Vr
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXJUDOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXJUDOg
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:14:36 -0400
Received: from main.gmane.org ([80.91.229.2]:54907 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbXJUDOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:14:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IjN19-0006IQ-0J
	for git@vger.kernel.org; Sat, 20 Oct 2007 22:42:03 +0000
Received: from a91-155-177-132.elisa-laajakaista.fi ([91.155.177.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 22:42:02 +0000
Received: from jari.aalto by a91-155-177-132.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 22:42:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-177-132.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:MuaVFfX88VRdA9u5Y3xGaIp1Xz0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61871>


- Remove out call to list_common_cmds_help()
- Send error message to stderr, not stdout.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 help.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 1cd33ec..814a8cd 100644
--- a/help.c
+++ b/help.c
@@ -185,8 +185,7 @@ static void show_man_page(const char *git_cmd)
 
 void help_unknown_cmd(const char *cmd)
 {
-	printf("git: '%s' is not a git-command\n\n", cmd);
-	list_common_cmds_help();
+	fprintf(stderr, "git: '%s' is not a git-command. See --help\n\n", cmd);
 	exit(1);
 }
 
-- 
1.5.3.2.81.g17ed
