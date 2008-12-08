From: "Li Frank" <Frank.Li@freescale.com>
Subject: Can Git push only first parent history commits?
Date: Mon, 8 Dec 2008 10:52:38 +0800
Message-ID: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 03:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WG9-0002gO-C6
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbYLHCwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 21:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbYLHCwv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:52:51 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:58617 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbYLHCwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2008 21:52:51 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id mB82qkdV022311
	for <git@vger.kernel.org>; Sun, 7 Dec 2008 19:52:50 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mB82qiQa007302
	for <git@vger.kernel.org>; Sun, 7 Dec 2008 20:52:45 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can Git push only first parent history commits?
Thread-Index: AclY4AeZ2kBH0IAmTqi5xCM8474tRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102518>

        The commit history is: 
        origin/master
              Commit1..Commit2..Commit3(T1 branch). 
         
        I want to combined Commit1, Commit2 and Commit3 to one commit_X
and push to origin master and keep old T1 branch history.  So I can't
use rebase.  T1 branch history will be lost after rebase. 
        So I create T2 branch at origin/master:
	
        origin/master
              Commit1..Commit2..Commit3(T1 branch). 
	  T2 (branch).

        Then I use "git merge --no-ff --log T1" merge T1 to T2.  
        So 
	  origin/master
              	+--Commit1..Commit2..Commit3(T1 branch). +

	
+----------------------------------------------------------------+--Comm
itX(T2 branch).

       But when I push T2 to origin master, Commit1 ,2, 3 also pushed.
I expect there are only CommitX at origin master branch. 
       How can I do?
 
best regards
Frank Li
