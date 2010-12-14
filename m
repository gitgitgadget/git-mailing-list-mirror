From: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
Subject: subdirectory-filter does not delete files before the directory
 came into existence?
Date: Tue, 14 Dec 2010 23:21:35 +0100
Message-ID: <1292365295.6666.22.camel@ct>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 23:37:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdUu-00030x-8T
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203Ab0LNWhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:37:23 -0500
Received: from fep34.mx.upcmail.net ([62.179.121.52]:62713 "EHLO
	fep34.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759162Ab0LNWhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:37:22 -0500
Received: from edge04.upcmail.net ([192.168.13.239])
          by viefep14-int.chello.at
          (InterMail vM.8.01.02.02 201-2260-120-106-20100312) with ESMTP
          id <20101214222143.LUZK1458.viefep14-int.chello.at@edge04.upcmail.net>
          for <git@vger.kernel.org>; Tue, 14 Dec 2010 23:21:43 +0100
Received: from [192.168.1.103] ([62.194.83.75])
	by edge04.upcmail.net with edge
	id jAMh1f02L1dWq6u04AMiiN; Tue, 14 Dec 2010 23:21:43 +0100
X-SourceIP: 62.194.83.75
X-Mailer: Evolution 2.30.3 
X-Cloudmark-Analysis: v=1.1 cv=CqMFsqQC4gx7bBgpmnW/wKYuJF/a5pXPeCAfngFtYkU= c=1 sm=0 a=Ly5C8pC2vDYA:10 a=IkcTkHD0fZMA:10 a=OSRNABF3AAAA:8 a=hsgW3IgGpR9MxC6567MA:9 a=tURupO6tpvQ-1uhk8-VzvW4NmPcA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163702>

Hi,

There is a lot of information about extracting a directory from a git
project.  One thing I failed to find though is the following:

I try to extract a directory.  The result is fine, but there is a lot
of history in the result from *before* the directory was added to the
project.  Why?  How can I get rid of this?

If you want to see yourself, I did:

	git clone git://www.swi-prolog.org/home/pl/git/pl-devel.git
	git clone pl-devel odbc
	cd odbc
	git filter-branch --subdirectory-filter packages/odbc --prune-empty
--tag-name-filter cat -- --all
	
Now use e.g. qgit to look at the history.  As from 03/07/2002, when
the packages/odbc directory was created, all looks just fine.  Before
though ...

	Thanks for any hints

		--- Jan
