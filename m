From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 1/2] completion: Fix GIT_PS1_SHOWDIRTYSTATE to prevent unbound variable errors.
Date: Fri,  6 Feb 2009 11:05:37 -0500
Message-ID: <1233936338-10679-1-git-send-email-ted@tedpavlic.com>
References: <20090206155823.GO26880@spearce.org>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Feb 06 17:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTEb-0003ig-Tm
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZBFQFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZBFQFu
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:05:50 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:41524 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751341AbZBFQFu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 11:05:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 062F880D8067;
	Fri,  6 Feb 2009 10:59:27 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QphnFtgNj1rY; Fri,  6 Feb 2009 10:59:26 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id DC26180D8063;
	Fri,  6 Feb 2009 10:59:26 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <20090206155823.GO26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108750>

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 307bf5d..6e04985 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -125,7 +125,7 @@ __git_ps1 ()
 		local w
 		local i
 
-		if test -n "$GIT_PS1_SHOWDIRTYSTATE"; then
+		if test -n "${GIT_PS1_SHOWDIRTYSTATE-}"; then
 			if test "$(git config --bool bash.showDirtyState)" != "false"; then
 				git diff --no-ext-diff --ignore-submodules \
 					--quiet --exit-code || w="*"
-- 
1.6.1.2.390.gba743
