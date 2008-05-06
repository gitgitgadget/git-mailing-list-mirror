From: Andrew Morton <akpm@linux-foundation.org>
Subject: git-checkout sometimes silently fails
Date: Tue, 6 May 2008 12:22:56 -0700
Message-ID: <20080506122256.04ca7d77.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 21:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtSlv-00085l-9A
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 21:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbYEFTXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 15:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbYEFTXa
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 15:23:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46229 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752542AbYEFTX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 15:23:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m46JMuh9032550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 6 May 2008 12:22:58 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m46JMuNx023083
	for <git@vger.kernel.org>; Tue, 6 May 2008 12:22:56 -0700
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.776 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81377>


I've had this happen before and I don't know what to do to make it stop. 
Usually sufficient fiddling will prevent it from happening.


y:/usr/src/git26> cat .git/branches/linux-next 
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git

y:/usr/src/git26> git-checkout master
Switched to branch "master"
y:/usr/src/git26> cat kernel/*.c|sum
34439  2057
y:/usr/src/git26> git-checkout linux-next
Switched to branch "linux-next"
y:/usr/src/git26> cat kernel/*.c|sum     
34439  2057
y:/usr/src/git26> git-checkout origin 
Note: moving to "origin" which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 5717922... Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
y:/usr/src/git26> cat kernel/*.c|sum          
34439  2057


y:/usr/src/git26> git --version
git version 1.5.5.rc1

help?
