From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] gitk: disable checkout of remote branch
Date: Sun, 21 Jun 2009 09:11:28 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 11:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJ5b-0006iN-8k
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbZFUJLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZFUJLl
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:11:41 -0400
Received: from main.gmane.org ([80.91.229.2]:38000 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbZFUJLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:11:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MIJ5R-0001DF-W5
	for git@vger.kernel.org; Sun, 21 Jun 2009 09:11:41 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 09:11:41 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 09:11:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121974>

At the command line, this gives you a detailed warning message, but the
GUI currently allows it without any fuss.

Since the GUI is often used by people much less familiar with git, it
seems reasonable to make the GUI more restrictive than the command line,
not less.

This prevents a lot of detached HEAD commits by new users.

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---

Paul,

[Due to a quirk in how I access this list, the "cc" to you
will come from my work address, not my public gmail address
that the list sees.  Sigh...]

I sent this to the list some time ago, and later someone
helpfully suggested I should copy you.  Not wanting to send
it to the list twice, I sent that only to you, but it
probably got lost.

Could you please approve and include this in your repo?
This patch helps me a lot.

Naturally, if you think it's bad, I'd appreciate hearing
criticism.

Thanks and best regards,

Sitaram

 gitk-git/gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 gitk-git/gitk

diff --git a/gitk-git/gitk b/gitk-git/gitk
old mode 100644
new mode 100755
index 8c66d17..411bc52
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8770,6 +8770,9 @@ proc headmenu {x y id head} {
     set headmenuid $id
     set headmenuhead $head
     set state normal
+    if {[string match "remotes/*" $head]} {
+	set state disabled
+    }
     if {$head eq $mainhead} {
 	set state disabled
     }
-- 
1.6.3.2
