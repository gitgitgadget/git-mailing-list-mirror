From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] githooks documentation: post-checkout hook is also called
 after clone
Date: Sun, 22 Mar 2009 19:46:38 +0100
Message-ID: <49C6878E.8060509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: patnotz@gmail.com, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:48:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlSic-0004TC-By
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZCVSqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZCVSqu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:46:50 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51748 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZCVSqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:46:49 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9E8B3FBF129B;
	Sun, 22 Mar 2009 19:46:47 +0100 (CET)
Received: from [80.128.99.176] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277)
	id 1LlSh2-0003De-00; Sun, 22 Mar 2009 19:46:45 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18smiDQb/AF7Y+J3xLUGVmeoTT4W/JfYFWvW71r
	Jml1UNJAdJOdc8RzDPPj3hkjMxSE00hvhdtWvaJtd0bvhWxyKe
	XbPWOCqdA/+kySAMkRTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114164>

The documentation of the post-checkout hook just talks
about git-checkout. But recently git-clone was changed to
call it too, unless the -no-checkout (-n) option is used.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Thanks to Pat Notz for noticing that the hook is not called
on clone when the --no-checkout (-n) option is used.


 Documentation/githooks.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1fd512b..1c73673 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -151,6 +151,10 @@ indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
 This hook cannot affect the outcome of 'git-checkout'.
 
+It is also run after 'git-clone', unless the --no-checkout (-n) option is
+used. The first parameter given to the hook is the null-ref, the second the
+ref of the new HEAD and the flag is always 1.
+
 This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
-- 
1.6.2.1.275.ga797b
