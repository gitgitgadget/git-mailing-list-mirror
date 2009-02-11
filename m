From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 1/3] completion: For consistency, changed "git rev-parse" to __gitdir calls.
Date: Wed, 11 Feb 2009 10:37:12 -0500
Message-ID: <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 16:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHBI-0002IF-BQ
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbZBKPh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbZBKPh2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:37:28 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:35903 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774AbZBKPh0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 10:37:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 0E2DF80D8005;
	Wed, 11 Feb 2009 10:30:55 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jEq0TnBWrltX; Wed, 11 Feb 2009 10:30:54 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E9C5680D8036;
	Wed, 11 Feb 2009 10:30:54 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109427>

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f44f63c..6bbe09a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -80,7 +80,7 @@ __gitdir ()
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
 {
-	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local g="$(__gitdir)"
 	if [ -n "$g" ]; then
 		local r
 		local b
@@ -1797,7 +1797,7 @@ _gitk ()
 	__git_has_doubledash && return
 
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	local g="$(__gitdir)"
 	local merge=""
 	if [ -f $g/MERGE_HEAD ]; then
 		merge="--merge"
-- 
1.6.1.2.390.gba743
