From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] githooks documentation: post-checkout hook is also called
 after clone
Date: Sun, 22 Mar 2009 17:44:51 +0100
Message-ID: <49C66B03.6020908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 17:46:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlQoc-0001ac-OP
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 17:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZCVQo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 12:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbZCVQo4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 12:44:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:51285 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbZCVQoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 12:44:55 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C10CDF973AAF;
	Sun, 22 Mar 2009 17:44:53 +0100 (CET)
Received: from [80.128.47.63] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277)
	id 1LlQn6-0006UT-00; Sun, 22 Mar 2009 17:44:52 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18Se611nEH2hncIp2sVeCEJwhfylFRg6mjx/TB/
	eiOGA5Lw0KQ91hFJ1lblBl4D7n98Go2qH82kHLF8V5aqNvLOcT
	86IUprpTkQwcmpKXPFJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114151>

The documentation of the post-checkout hook just talks
about git-checkout. But recently git-clone was changed to
call it too, so we have to document that in githooks.txt.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/githooks.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1fd512b..76deefc 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -151,6 +151,9 @@ indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
 This hook cannot affect the outcome of 'git-checkout'.
 
+It is also run after 'git-clone'. The first parameter given to the hook is
+the null-ref, the second the ref of the new HEAD and the flag is always 1.
+
 This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
-- 
1.6.2.1.275.ga797b
