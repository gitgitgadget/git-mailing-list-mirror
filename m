From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Fri, 27 Jun 2014 16:47:25 -0400
Organization: PD Inc
Message-ID: <B901ECBC8F944F039AFD6B53929FF18C@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:49:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0d4x-00040F-4l
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 22:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbaF0Us7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 16:48:59 -0400
Received: from mail.pdinc.us ([67.90.184.27]:42027 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbaF0Us6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 16:48:58 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5RKkk1F004542
	for <git@vger.kernel.org>; Fri, 27 Jun 2014 16:46:46 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+SSQBebocagFO/T8i/RQxIQBN3Rw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252580>

There are two identical files from the same original parent, but both were
renamed in their own branches. One branch moved the file to a new folder, the
other renamed the file in the same folder.

Steps to reproduce the issue:
git init
git fetch https://github.com/pdinc-oss/CipherShed.git
git fetch https://github.com/srguglielmo/CipherShed.git
git checkout -b test b60070f4d0879e277f44d174a163bbb292325fea
git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68

CONFLICT (rename/rename): Rename "TrueCrypt.sln"->"src/TrueCrypt.sln" in branch
"HEAD" rename "TrueCrypt.sln"->"CipherShed.sln" in
"a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68"

git reset --hard b60070f4d0879e277f44d174a163bbb292325fea
git mv src/TrueCrypt.sln src/CipherShed.sln
git commit -m 'renamed to be congruent with a0c84ff'
git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68

Sill get a CONFLICT (rename/rename): Rename
"TrueCrypt.sln"->"src/CipherShed.sln" in branch "HEAD" rename
"TrueCrypt.sln"->"CipherShed.sln" in "a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68"

I will have many more to come, any suggestions?

Repos:

https://github.com/srguglielmo/CipherShed/commit/1ca13ed2271d60ba93d40bcc8db17ce
d8545f172

https://github.com/pdinc-oss/CipherShed/commit/b60070f4d0879e277f44d174a163bbb29
2325fea



--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
