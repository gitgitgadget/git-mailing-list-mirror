From: =?UTF-8?B?QWRhbSBQacSFdHlzemVr?= <ediap@ET.PUT.Poznan.PL>
Subject: Regression in gitk from git-1.5.3-rc7
Date: Fri, 31 Aug 2007 08:26:20 +0200
Message-ID: <46D7B48C.9020206@et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 11:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR2m6-00010q-B1
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 11:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbXHaJ0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbXHaJ0R
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 05:26:17 -0400
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:59428 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbXHaJ0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 05:26:16 -0400
X-Greylist: delayed 614 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2007 05:26:16 EDT
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id l7V906tY007395
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 11:10:36 +0200 (CEST)
	(envelope-from ediap@ET.PUT.Poznan.PL)
Received: from [150.254.11.74] (pc1074.et.put.poznan.pl [150.254.11.74])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id l7V6QLw01693
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 08:26:21 +0200 (MET DST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
X-Enigmail-Version: 0.95.3
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2007.8.31.10729
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_24 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57141>

Hi!

First of all thanks for this great piece of software you are providing
for the community! I am a refugee from the SVN camp, BTW. ;-)

To the point...

Today I noticed a problem in gitk from git-1.5.3-rc7 package, which I
think did not exist in rc5. The problem is as follows:

I am working with two parallel branches (master and stable). And I often
use the cherry-pick option from gitk context menu to pick some patches
from the master branch to the stable one (I cannot merge, because stable
is a tracking branch of some remote SVN repository).
If the picked patch does not apply cleanly on stable, I fix the problem
in editor, then switch to git-gui to update the index and commit this
conflicted commit to the stable branch.

Now, I go back to gitk, and *without* updating the view (using <F5> for
instance), I try to cherry pick another patch from my master branch.
And in such a situation I got this error from git-gui:

===== cut here =====

can't read "arcnos(6e9a6c5fdabddeac2717d810997a1c4787ec72a2)": no such
element in array
can't read "arcnos(6e9a6c5fdabddeac2717d810997a1c4787ec72a2)": no such
element in array
    while executing
"set a $arcnos($p)"
    (procedure "splitarc" line 5)
    invoked from within
"splitarc $p"
    (procedure "addnewchild" line 20)
    invoked from within
"addnewchild $newhead $oldhead"
    (procedure "cherrypick" line 26)
    invoked from within
"cherrypick"
    invoked from within
".rowctxmenu invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .rowctxmenu 1"
    (command bound to event)

===== cut here =====

BTW, the patch which I am trying to cherry-pick to stable is correctly
committed, but gitk is not usable any more (I need to close it and start
again).

The above described problem does not occur when I refresh the gitk tree
manually before cherry-picking another commit.

Best regards,
/Adam


-- 
.:.  Adam Piatyszek - "ediap"       .:.  JID: ediap(at)jabber.org .:.
.:.  ediap(at)users.sourceforge.net .:.  PGP key ID: 0x1F115CCB   .:.
