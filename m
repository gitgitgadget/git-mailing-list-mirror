From: Resul Cetin <Resul-Cetin@gmx.net>
Subject: shell commands in ReleaseNotes
Date: Sat, 19 Sep 2009 23:57:32 +0200
Message-ID: <200909192357.32369.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 19 23:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mp7w9-0008GN-KU
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 23:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZISV5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Sep 2009 17:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbZISV5e
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 17:57:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:43329 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751455AbZISV5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Sep 2009 17:57:33 -0400
Received: (qmail invoked by alias); 19 Sep 2009 21:57:35 -0000
Received: from unknown (EHLO resul-server) [89.246.210.205]
  by mail.gmx.net (mp008) with SMTP; 19 Sep 2009 23:57:35 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX1/Xjn59Om3XDpZR1jkhUXjpOoMJ17Ulj6qJK6hRvx
	2kO5hVdq838ogJ
User-Agent: KMail/1.12.1 (Linux/2.6.31-rc5; KDE/4.3.1; x86_64; ; )
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128828>

Hi,
I noticed that there are small part of commands at the end of a not yet 
released ReleaseNote-*.txt.
 ---
 exec >/var/tmp/1
 O=v1.6.4.1-266-g235db15
 echo O=$(git describe master)
 git shortlog --no-merges $O..master --not maint

As far as I understand it means that the output is redirected to /var/tmp/1.
Then there is O set to the last it which was used to generate a shortlog.
Then the current desciption (tag+suffix) is printed which can then used to 
replace the O= line in the small snipped. Then there will be created a 
shortlog from the last point it was created until master without stuff in 
maint (or reachable by maint? I am not sure about that one).

Real nice idea to create an overview about changes in a repository for writing 
a releasenotes. But how is it real used by the maintainer? My current idea 
would be: Open the editor an copy the snipped. Open a terminal, switch to the 
repository and go paste the snipped into it. After that the terminal has to be 
closed as it isn't really useful anymore. An extra editor will be used to open 
/var/tmp/1 and now the first step is to replace "O=v1.6.4.1-266-g235db15" with 
a new id at the first line in /var/tmp/1. Now the maintainer has to order all 
commits a little bit and write the release notes. After he finished it, he 
just commits it to master and is finished for this period of time.
Is this real how it is done in git.git or is there maybe something I don't see 
right now?

Best regards,
	Resul Cetin
