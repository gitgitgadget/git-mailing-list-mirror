From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Documentation/Makefile: remove cmd-list.made before redirecting to it.
Date: Mon, 6 Aug 2007 15:05:56 +0200
Message-ID: <86vebsby27.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 15:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II2Vs-0000am-Ki
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 15:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbXHFNUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 09:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbXHFNUM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 09:20:12 -0400
Received: from main.gmane.org ([80.91.229.2]:52817 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695AbXHFNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 09:20:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1II2V8-00020x-AA
	for git@vger.kernel.org; Mon, 06 Aug 2007 15:20:02 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 15:20:02 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 15:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:pxreol6E7MdhL7355d+1uV31C3k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55146>



If cmd-list.made has been created by a previous run as root, output
redirection to it will fail.  So remove it before regeneration.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 97ee067..120e7c0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -120,6 +120,7 @@ $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl $(MAN1_TXT)
 	perl ./cmd-list.perl
+	$(RM) $@
 	date >$@
 
 git.7 git.html: git.txt core-intro.txt
-- 
1.5.3.rc4.21.ga63eb
