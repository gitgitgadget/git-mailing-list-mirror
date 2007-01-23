From: Jeff King <peff@peff.net>
Subject: [PATCH] contrib/vim: update syntax for changed commit template
Date: Mon, 22 Jan 2007 22:21:15 -0500
Message-ID: <20070123032115.GA20554@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juergen Ruehle <j.ruehle@bmiag.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 04:21:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9CDp-0004Hq-8d
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 04:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbXAWDVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 22:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbXAWDVS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 22:21:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4566 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932498AbXAWDVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 22:21:18 -0500
Received: (qmail 12793 invoked from network); 22 Jan 2007 22:21:37 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Jan 2007 22:21:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2007 22:21:15 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37480>


Signed-off-by: Jeff King <peff@peff.net>
---
It looks like things have settled down here, so it would be nice to
apply this before v1.5.0 (though I still think "changed but not updated"
is terrible wording, my previous message to that effect received no
response).

On Thu, Jan 11, 2007 at 08:17:12AM +0100, Juergen Ruehle wrote:
> Thanks for tracking this. It would be nice if we could make the
> syntax highlighting less dependent on the exact wording.

Unfortunately, I don't see another way short of counting which "stanza"
we're in, and that is highly dependent on the formatting of stanzas, as
well as what the user might have written in his commit message. This way
is reasonably robust, and the messages shouldn't change too frequently.

 contrib/vim/syntax/gitcommit.vim |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vim/syntax/gitcommit.vim b/contrib/vim/syntax/gitcommit.vim
index d911efb..332121b 100644
--- a/contrib/vim/syntax/gitcommit.vim
+++ b/contrib/vim/syntax/gitcommit.vim
@@ -1,7 +1,7 @@
 syn region gitLine start=/^#/ end=/$/
-syn region gitCommit start=/^# Added but not yet committed:$/ end=/^#$/ contains=gitHead,gitCommitFile
+syn region gitCommit start=/^# Changes to be committed:$/ end=/^#$/ contains=gitHead,gitCommitFile
 syn region gitHead contained start=/^#   (.*)/ end=/^#$/
-syn region gitChanged start=/^# Changed but not added:/ end=/^#$/ contains=gitHead,gitChangedFile
+syn region gitChanged start=/^# Changed but not updated:/ end=/^#$/ contains=gitHead,gitChangedFile
 syn region gitUntracked start=/^# Untracked files:/ end=/^#$/ contains=gitHead,gitUntrackedFile
 
 syn match gitCommitFile contained /^#\t.*/hs=s+2
-- 
1.5.0.rc1.gda86
