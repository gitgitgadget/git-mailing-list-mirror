From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Is there a reason the credential cache server cowardly refuses to delete/reuse the socket file?
Date: Sun, 15 Jun 2014 09:48:24 -0400
Organization: PD Inc
Message-ID: <1EFC4B213D584B1EBAE78E6882705B6D@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:48:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwAnR-0007ou-Ci
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 15:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbaFONs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 09:48:26 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47076 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbaFONs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 09:48:26 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5FDmOgJ004850
	for <git@vger.kernel.org>; Sun, 15 Jun 2014 09:48:24 -0400
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+IoHowEJrflLwqQHypZYhosO2u/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251675>

Whenever my computer crashes, I am left with a socket file. On next git
invocation it tries to conenct to the file, but the daemon is not running so it
barfs until I delete the file.

jpyeron@black /projects/dcarr/saar
$ git push
fatal: unable to connect to cache daemon: No error
Username for xxxxxxxxxxxxxxxxxx
^C

jpyeron@black /projects/dcarr/saar
$ ls -al ~/.git-credential-cache/
total 1
drwx------+ 1 jpyeron Domain Users 0 Jun  9 14:09 .
drwxr-xr-x+ 1 jpyeron root         0 Jun  8 22:45 ..
srwxr-xr-x  1 jpyeron Domain Users 0 Jun  9 14:09 socket

jpyeron@black /projects/dcarr/saar
$ rm -f ~/.git-credential-cache/socket

jpyeron@black /projects/dcarr/saar
$ git push
Username for xxxxxxxxxx
Password for xxxxxxxxxxx
Counting objects: 27, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (9/9), done.
Writing objects: 100% (14/14), 2.09 KiB, done.
Total 14 (delta 6), reused 0 (delta 0)
To xxxxxxxxxxxxxxxxx
   345112c..48909da  master -> master

jpyeron@black /projects/dcarr/saar
$ git --version
git version 1.7.9

jpyeron@black /projects/dcarr/saar
$ cygcheck.exe -V
cygcheck (cygwin) 1.7.30
...

-Jason


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
