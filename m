From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 1/2] completion: Fix GIT_PS1_SHOWDIRTYSTATE to prevent unbound variable errors.
Date: Fri,  6 Feb 2009 10:46:49 -0500
Message-ID: <1233935210-4941-2-git-send-email-ted@tedpavlic.com>
References: <1233935210-4941-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSwY-0004Z0-Dk
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbZBFPrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbZBFPrF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:47:05 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:42953 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753651AbZBFPrE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:47:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 3947380D806A;
	Fri,  6 Feb 2009 10:40:40 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBW202tYq1u2; Fri,  6 Feb 2009 10:40:40 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 156A880D8067;
	Fri,  6 Feb 2009 10:40:40 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
In-Reply-To: <1233935210-4941-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108742>

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
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
1.6.1.2.319.gbd9e
