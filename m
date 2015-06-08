From: Ariel Faigon <github.2009@yendor.com>
Subject: [PATCH 1/1]: git-completion.tcsh fails w/ noclobber
Date: Mon, 8 Jun 2015 16:01:33 -0700
Message-ID: <20150608230133.GA14473@yendor.com>
Reply-To: github.2009@yendor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 01:01:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z263I-000271-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 01:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbbFHXBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 19:01:47 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:45239 "EHLO
	homiemail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753245AbbFHXBe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 19:01:34 -0400
X-Greylist: delayed 97602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2015 19:01:34 EDT
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id 2EC7462606D
	for <git@vger.kernel.org>; Mon,  8 Jun 2015 16:01:34 -0700 (PDT)
Received: from go (c-67-188-70-105.hsd1.ca.comcast.net [67.188.70.105])
	(Authenticated sender: catch-all@yendor.com)
	by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPA id 0FBD262606A
	for <git@vger.kernel.org>; Mon,  8 Jun 2015 16:01:34 -0700 (PDT)
Received: by go (Postfix, from userid 1000)
	id D6DA51C04028; Mon,  8 Jun 2015 16:01:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271143>

tcsh users who happen to have 'set noclobber' elsewhere in their ~/.tcshrc or ~/.cshrc startup files get a 'File exist' error, and the tcsh completion file doesn't get generated/updated.  Adding a `!` in the redirect works correctly for both clobber (default) and 'set noclobber' users.

Helped-by: Junio C Hamano <notifications@github.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Ariel Faigon <github.2009@yendor.com>
---

 contrib/completion/git-completion.tcsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 6104a42..4a790d8 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -41,7 +41,7 @@ if ( ! -e ${__git_tcsh_completion_original_script} ) then
 	exit
 endif
 
-cat << EOF > ${__git_tcsh_completion_script}
+cat << EOF >! ${__git_tcsh_completion_script}
 #!bash
 #
 # This script is GENERATED and will be overwritten automatically.
