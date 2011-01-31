From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t5526: Fix wrong argument order in "git config"
Date: Mon, 31 Jan 2011 17:51:25 +0100
Message-ID: <4D46E88D.1020806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Libor Pechacek <lpechacek@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 17:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjwzb-0007n2-00
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 17:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085Ab1AaQwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 11:52:37 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:58790 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab1AaQwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 11:52:36 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id B10C0186B12CB;
	Mon, 31 Jan 2011 17:51:25 +0100 (CET)
Received: from [93.240.120.190] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PjwyL-0007Rt-00; Mon, 31 Jan 2011 17:51:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/6XPDnxQUeH4YnhNwmLmTqfpGzXXQQbJH/PEmS
	NXv02SYD3aHUFTNgI3pE/he3Zm/U9BNh4BCNn+d/uSw/p43FSa
	TtI6PNacaP8dcKOWmNgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165734>

This fixes a typo where the "git config" arguments "-f" and "--unset" were
swapped leading to the creation of a "--unset" file.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Now that 1.7.4 is out and somebody else already stumbled across this
typo I introduced ...

 t/t5526-fetch-submodules.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 884a5e5..a5f4585 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -124,7 +124,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
-		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
+		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSubmodules &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_cmp expect.out actual.out &&
-- 
1.7.3.4.27.g3921d.dirty
