From: Xavier Maillard <zedek@gnu.org>
Subject: format-patch and send-email
Date: Sun, 18 Feb 2007 09:49:54 +0100
Message-ID: <5680.1171788594@localhost>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 09:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIhn8-0005iF-TF
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 09:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbXBRIxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 03:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbXBRIxD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 03:53:03 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:50895 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161178AbXBRIxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 03:53:01 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 44F6969B6
	for <git@vger.kernel.org>; Sun, 18 Feb 2007 09:53:00 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1I8nsLT005681
	for <git@vger.kernel.org>; Sun, 18 Feb 2007 09:49:54 +0100
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40065>

Hi,

I tried to use format-patch and send-email but I think I am
misusing them because it does not react as I would expect.

First, here is how git log looks like on my little repository:

commit 50c7032fa011b1e5c7bd63e4bc474c802017677d
Author: Xavier Maillard <zedek@gnu.org>
Date:   Fri Feb 16 20:20:18 2007 +0100

    * Added 2007 to the copyright notice
    * Added a note on relation between org-publish and blorg
    * Changed/corrected things here and there
    * Added a warning on needed skills before manipulating your own templates

commit 0e35f7847c7becc52ebcd51d9b043c626f9b3b3f
Author: Xavier Maillard <zedek@gnu.org>
Date:   Fri Feb 16 20:03:42 2007 +0100

    new file: doc/blorg.texi (original version)

Now I want to extract a patch and set it ready to be sent (I
added head -20 just to illustrate my problem):

git-format-patch --stdout -k 0e35f7847c7becc52ebcd51d9b043c626f9b3b3f | head -12


>From 50c7032fa011b1e5c7bd63e4bc474c802017677d Mon Sep 17 00:00:00 2001
From: Xavier Maillard <zedek@gnu.org>
Date: Fri, 16 Feb 2007 20:20:18 +0100
Subject: * Added 2007 to the copyright notice
To: <maillaxa@gmail.com>
* Added a note on relation between org-publish and blorg
* Changed/corrected things here and there
* Added a warning on needed skills before manipulating your own templates
---
 doc/blorg.texi |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

The "To" header has been set up in my .git/config file. But why
the 'Subject' is like this and also why are there 2 'From'
headers ?

Actually, why can't I just do like this ? :

git format-patch <origin> | git send-email ?

Thank you for your explanations.

Xavier
