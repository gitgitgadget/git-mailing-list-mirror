From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-submodule: Avoid printing a spurious message.
Date: Tue, 11 Nov 2008 22:09:16 +0100
Message-ID: <87myg67ywz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 22:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L00W3-0002gP-0a
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 22:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYKKVJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 16:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYKKVJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 16:09:28 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:51009 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbYKKVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 16:09:27 -0500
Received: from adsl-84-226-5-209.adslplus.ch ([84.226.5.209] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1L00UB-00006B-QR
	for git@vger.kernel.org; Tue, 11 Nov 2008 15:09:26 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id BC52C1E78E9; Tue, 11 Nov 2008 22:09:16 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100678>

Fix 'git submodule update' to avoid printing a spurious "Maybe you want
to use 'update --init'?" once for every uninitialized submodule it
encounters.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b63e5c3..220d94e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -323,7 +323,7 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" != "0" &&
-			say "Submodule path '$path' not initialized"
+			say "Submodule path '$path' not initialized" &&
 			say "Maybe you want to use 'update --init'?"
 			continue
 		fi
-- 
1.6.0.4.637.ga2ff4

-- 
Alexandre Julliard
julliard@winehq.org
