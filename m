From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: git-mergetool changes file rights?
Date: Sat, 07 Mar 2009 16:55:38 +0100
Message-ID: <49B298FA.2050803@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 16:57:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfytg-0002Sh-4a
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 16:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbZCGPze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 10:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZCGPze
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 10:55:34 -0500
Received: from mxout-08.mxes.net ([216.86.168.183]:2617 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZCGPzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 10:55:33 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 261A9D05AF
	for <git@vger.kernel.org>; Sat,  7 Mar 2009 10:55:30 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081227)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112544>

Hello,

I've stumbled upon very weird problem:
grek@linux-p3yg:~/asf/git/infrastructure/apache-git-mirrors/bin> git --version
git version 1.6.1.3
grek@linux-p3yg:~/asf/git/infrastructure/apache-git-mirrors/bin> ls -l
razem 40
-rwxr-xr-x 1 grek users  773 mar  7 16:47 create-repo.sh
-rwxr-xr-x 1 grek users 3219 mar  7 16:50 email-update.sh
-rwxr-xr-x 1 grek users 3219 mar  7 16:50 email-update.sh.orig
-rwxr-xr-x 1 grek users 2086 mar  7 16:47 move-svn-project.sh
-rwxr-xr-x 1 grek users 1464 mar  7 16:47 update-authors.sh
-rwxr-xr-x 1 grek users  156 mar  6 16:16 update-daily.sh
-rwxr-xr-x 1 grek users  371 mar  7 16:47 update-every-minute.sh
-rwxr-xr-x 1 grek users  215 mar  7 16:47 update-gitweb.sh
-rwxr-xr-x 1 grek users 1104 mar  7 16:47 update-repo.sh
-rwxr-xr-x 1 grek users  188 mar  7 16:47 update.sh
grek@linux-p3yg:~/asf/git/infrastructure/apache-git-mirrors/bin> git mergetool
merge tool candidates: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff opendiff emerge vimdiff
Merging the files: email-update.sh

Normal merge conflict for 'email-update.sh':
  {local}: modified
  {remote}: modified
Hit return to start merge resolution tool (kdiff3):
error: open("bin/email-update.sh"): Permission denied
error: unable to index file bin/email-update.sh
fatal: updating files failed
grek@linux-p3yg:~/asf/git/infrastructure/apache-git-mirrors/bin> ls -l
razem 40
-rwxr-xr-x 1 grek users  773 mar  7 16:47 create-repo.sh
---x------ 1 grek users 3219 mar  7 16:53 email-update.sh
-rwxr-xr-x 1 grek users 3219 mar  7 16:53 email-update.sh.orig
-rwxr-xr-x 1 grek users 2086 mar  7 16:47 move-svn-project.sh
-rwxr-xr-x 1 grek users 1464 mar  7 16:47 update-authors.sh
-rwxr-xr-x 1 grek users  156 mar  6 16:16 update-daily.sh
-rwxr-xr-x 1 grek users  371 mar  7 16:47 update-every-minute.sh
-rwxr-xr-x 1 grek users  215 mar  7 16:47 update-gitweb.sh
-rwxr-xr-x 1 grek users 1104 mar  7 16:47 update-repo.sh
-rwxr-xr-x 1 grek users  188 mar  7 16:47 update.sh


Notice rights for email-update.sh.

What's going on here?

-- 
Best regards,
Grzegorz Kossakowski
