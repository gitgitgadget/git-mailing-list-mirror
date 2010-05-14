From: "Albert Krawczyk" <albert@burgmann.anu.edu.au>
Subject: Git log follow question
Date: Fri, 14 May 2010 10:57:34 +1000
Message-ID: <006d01caf300$703e96a0$50bbc3e0$@burgmann.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 14 03:35:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCjnz-0007Gr-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 03:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753Ab0ENBfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 21:35:05 -0400
Received: from anumail9.anu.edu.au ([130.56.64.135]:40134 "EHLO
	anumail9.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab0ENBfD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 21:35:03 -0400
X-Greylist: delayed 2233 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2010 21:35:03 EDT
Received: from mailout2.anu.edu.au (mailout2.anu.edu.au [130.56.64.233])
	by anumail9.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4E0vjsX023605
	for <git@vger.kernel.org>; Fri, 14 May 2010 10:57:45 +1000 (EST)
Received: from mailout2.anu.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 0DE3C9E82B6
	for <git@vger.kernel.org>; Fri, 14 May 2010 10:57:45 +1000 (EST)
Received: from smtphost.anu.edu.au (ds2.anu.edu.au [130.56.64.54])
	by mailout2.anu.edu.au (Postfix) with ESMTP id 7D4EC9E8476
	for <git@vger.kernel.org>; Fri, 14 May 2010 10:57:44 +1000 (EST)
Received: from AlbertDesktop (burg237222.anu.edu.au [150.203.237.222])
	by smtphost.anu.edu.au (8.14.3/8.14.3) with SMTP id o4E0viba007883
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 14 May 2010 10:57:44 +1000 (EST)
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Acry/4nXw1+/maQCSEi0vZ2Or3c/GA==
Content-Language: en-au
X-PMX-Version: 5.5.9.395186, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2010.5.14.4818 internal
X-PMX-Outbound: anu.edu.au
X-PMX-Info: from-anu
X-PerlMx-Spam: Gauge=X, Probability=10%, Report='
 TO_IN_SUBJECT 0.5, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1600_1699 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, FORGED_MUA_OUTLOOK 0, TO_NO_NAME 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __OUTLOOK_MUA 0, __OUTLOOK_MUA_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __USER_AGENT_MS_GENERIC 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147037>

Hi Everybody,

I'm having an issue understanding the way git log --follow works with git
log --parents

When I run 
git log --parents --pretty=format:Commit:%H%nParent:%P%n%n alloc.c
I get: 
Commit:4b25d091ba53c758fae0096b8c0662371857b9d9
Parent:100c5f3b0b27ec6617de1a785c4ff481e92636c1

Commit:100c5f3b0b27ec6617de1a785c4ff481e92636c1
Parent:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3

Commit:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3
Parent:579d1fbfaf25550254014fa472faac95f88eb779

Commit:579d1fbfaf25550254014fa472faac95f88eb779
Parent:855419f764a65e92f1d5dd1b3d50ee987db1d9de

Commit:855419f764a65e92f1d5dd1b3d50ee987db1d9de
Parent:

When I try to run git log --parents --follow I get this:
git log --parents --follow --pretty=format:Commit:%H%nParent:%P%n%n alloc.c

Commit:4b25d091ba53c758fae0096b8c0662371857b9d9
Parent:75b44066f3ed7cde238cdea1f0bf9e2f1744c820

Commit:100c5f3b0b27ec6617de1a785c4ff481e92636c1
Parent:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3

Commit:2c1cbec1e2f0bd7b15fe5e921d287babfd91c7d3
Parent:f948792990f82a35bf0c98510e7511ef8acb9cd3

Commit:579d1fbfaf25550254014fa472faac95f88eb779
Parent:446c6faec69f7ac521b8b9fc2b1874731729032f

Commit:855419f764a65e92f1d5dd1b3d50ee987db1d9de
Parent:64e86c57867593ba0ee77a7b0ff0eb8e9d4d8ed5

As you can see git log --parents and git log --follow --parents produce very
different results, and as far as I can tell they should produce identical
outputs. 

Could somebody tell me if I'm doing something wrong with the syntax? Or have
I stumbled onto a quirk I fail to understand?

Thanks,
Albert 
