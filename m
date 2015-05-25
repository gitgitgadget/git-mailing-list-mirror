From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH] completion: suggest sequencer commands for revert
Date: Mon, 25 May 2015 11:59:35 +0200
Message-ID: <1432547975.4644.5.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 12:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwpQd-0003sW-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 12:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbbEYKQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 06:16:12 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:58901 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821AbbEYKQK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 06:16:10 -0400
X-Greylist: delayed 991 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2015 06:16:10 EDT
Received: from p5ddc1265.dip0.t-ipconnect.de ([93.220.18.101] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1YwpAW-0001jJ-DR; Mon, 25 May 2015 11:59:36 +0200
X-Mailer: Evolution 3.12.9-1+b1 
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1432548970;1e5946b5;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269834>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
---

Hi,

I added the sequencer commands for git revert. These are handy in case a git
revert needs manual intervention.

Thanks,
Thomas

 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bfc74e9..3c00acd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2282,6 +2282,11 @@ _git_reset ()
 
 _git_revert ()
 {
+	local dir="$(__gitdir)"
+	if [ -f "$dir"/REVERT_HEAD ]; then
+		__gitcomp "--continue --quit --abort"
+		return
+	fi
 	case "$cur" in
 	--*)
 		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
