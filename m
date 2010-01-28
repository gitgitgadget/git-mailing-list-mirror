From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git gui: Quote git path properly when starting another gui
 in a submodule
Date: Thu, 28 Jan 2010 22:20:39 +0100
Message-ID: <4B61FFA7.4090205@web.de>
References: <878wbln0oa.fsf@users.sourceforge.net> <20100128005142.GK5452@spearce.org> <alpine.DEB.1.00.1001280244430.4985@pacific.mpi-cbg.de> <20100128014205.GA8166@spearce.org> <7v4om7ndm4.fsf@alter.siamese.dyndns.org> <20100128025647.GB8166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:20:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NabnD-00079N-BD
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab0A1VUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 16:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909Ab0A1VUl
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:20:41 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:33507 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0A1VUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 16:20:40 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id E0D8813CCE5E6;
	Thu, 28 Jan 2010 22:20:39 +0100 (CET)
Received: from [80.128.66.195] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nabn5-0002Yi-00; Thu, 28 Jan 2010 22:20:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <20100128025647.GB8166@spearce.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1863OQXUwdTQcAX8F33cc0WSUF/MFeSNOAT3zZp
	+UmtJXcpl177Tb4Zja0fF314p5+ZTAH16776JhVOX/bsooLvH8
	HZXTlcl6FPePjEN3GzjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138272>

In do_git_gui() the path of the git executable has to be put into a list,
otherwise calling it will fail when when spaces are present in its path.

Reported-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Am 28.01.2010 03:56, schrieb Shawn O. Pearce:
> Jens Lehmann (2):
>       git-gui: Use git diff --submodule when available
>       git-gui: Add a special diff popup menu for submodules

Today Heiko reported me this bug I introduced with the second patch.
Sorry for the hassle.


 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index a64191d..840f45c 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2000,7 +2000,7 @@ proc do_git_gui {} {
 	# -- Always start git gui through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
-	set exe [_which git]
+	set exe [list [_which git]]
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find git gui in PATH"]
 	} else {
-- 
1.7.0.rc0.163.g808df.dirty
