From: Gelonida N <gelonida@gmail.com>
Subject: git diff --numstat <branch> always shows dirty submodules
Date: Sat, 12 Nov 2011 14:29:36 +0100
Message-ID: <j9lsc1$4uf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 14:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPDej-0002OX-Ba
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 14:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219Ab1KLN3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 08:29:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:59328 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab1KLN3u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 08:29:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RPDeW-0002Lr-Uc
	for git@vger.kernel.org; Sat, 12 Nov 2011 14:29:48 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 14:29:48 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 14:29:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185306>

Hi,

I recently started using submodules and they behave mostly as I like to.


Normally I use diff --numstat <branch>
to check quickly whether I am aligned with another branch or not.

The (for me) annoying feature of submodules is, that they are always
reported to be different due to files, which are not under git.


I type git diff --numstat master
I get
1       1       mysubmodule


Now I check the differences with git diff master mysubmodule
diff --git a/mysubmodule b/mysubmodule
index 1382b73..f4f1f1d 160000
--- a/mysubmodule
+++ b/mysubmodule
@@ -1 +1 @@
-Subproject commit xxxxxxxxx
+Subproject commit xxxxxxxxx-dirty

So the only difference (which I wasn't interested in) is, that the
submodule is dirty.


Is there any quick way flag / helper script / . . .
to show differences between two branches without raising the fact, that
submodules are dirty?

>From a user perspective I don't see why this is reported.
I am not being warned about dirty files in the top level repository
