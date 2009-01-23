From: Ted Pavlic <ted@tedpavlic.com>
Subject: [kha/safe PATCH] completion bugfix: Place double pipes in front of alternate command.
Date: Thu, 22 Jan 2009 19:26:12 -0500
Message-ID: <1232670372-20000-1-git-send-email-ted@tedpavlic.com>
References: <20090122232928.GA23456@diana.vm.bytemark.co.uk>
Cc: git@vger.kernel.org, catalin.marinas@gmail.com,
	Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Fri Jan 23 01:27:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ9tl-0007IB-A8
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZAWA0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbZAWA0X
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:26:23 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:46697 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627AbZAWA0X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 19:26:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 2076A80D8055;
	Thu, 22 Jan 2009 19:20:24 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QboqfJacmoKP; Thu, 22 Jan 2009 19:20:24 -0500 (EST)
Received: from localhost.localdomain (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A625B80D8001;
	Thu, 22 Jan 2009 19:20:23 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
In-Reply-To: <20090122232928.GA23456@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106808>

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---

This is a patch against 

    git://repo.or.cz/stgit/kha.git stable

Unfortunately, the previous "[StGit PATCH 2/2]" had a small bug in it. A
bugfix was posted, but it didn't get picked up in kha/safe. This commit
should be applied against kha/safe to fix the problem.

Alternatively, the patch provided in

    <1232642662-12851-1-git-send-email-ted@tedpavlic.com>

is the proper patch to stgit/master.

Sorry for the extra bother.

 stgit/completion.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/completion.py b/stgit/completion.py
index 56e81c2..38f0670 100644
--- a/stgit/completion.py
+++ b/stgit/completion.py
@@ -130,7 +130,7 @@ def main_switch(commands):
 
 def install():
     return ['complete -o bashdefault -o default -F _stg stg 2>/dev/null \\', [
-            'complete -o default -F _stg stg' ] ]
+            '|| complete -o default -F _stg stg' ] ]
 
 def write_completion(f):
     commands = stgit.commands.get_commands(allow_cached = False)
-- 
1.6.1.213.g28da8
