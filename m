From: Geert Bosch <bosch@adacore.com>
Subject: =?ISO-8859-1?Q?gitweb/test/M=E4rchen_has_an_identity_crisis?=
Date: Mon, 9 Apr 2007 15:13:49 -0400
Message-ID: <FBFBF002-4887-4216-9CF0-42407E93045C@adacore.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HazJL-0003bC-P4
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbXDITNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 15:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbXDITNw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:13:52 -0400
Received: from nile.gnat.com ([205.232.38.5]:61923 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294AbXDITNv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 15:13:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 6EC5748CBEB
	for <git@vger.kernel.org>; Mon,  9 Apr 2007 15:13:50 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 04135-01-7 for <git@vger.kernel.org>;
 Mon,  9 Apr 2007 15:13:50 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 3956148CBC0
	for <git@vger.kernel.org>; Mon,  9 Apr 2007 15:13:50 -0400 (EDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44078>

In the git repository, after git checkout -f:
potomac:~/git%git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
=2E..
#       gitweb/test/M=E4rchen

potomac:~/git%rm gitweb/test/Ma\314\210rchen
potomac:~/git%git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#
#       deleted:    gitweb/test/M=E4rchen

Aaaarghh!! There seems something inconsistent in the encoding
of the =E4 letter that confuses git on my Mac OS X system.
My environment has LANG=3Den_US.UTF-8 set, in case that matters.

=46ilename completion results in Ma\314\210rchen, but the index
encodes it as M\303\244rchen:
0107272   g   i   t   w   e   b   /   t   e   s   t   /   M   ?   ?   r
         147 151 164 167 145 142 057 164 145 163 164 057 115 303 244 16=
2

The filesystem seems to be fine with either:
potomac:~/git%ls -l gitweb/test/Ma\314\210rchen gitweb/test/M\303=20
\244rchen
-rw-r--r-- 1 bosch staff 17 2007-04-09 14:51 gitweb/test/M=E4rchen
-rw-r--r-- 1 bosch staff 17 2007-04-09 14:51 gitweb/test/M=E4rchen

Anybody has insights in what causes this? Thanks in advance!

   -Geert