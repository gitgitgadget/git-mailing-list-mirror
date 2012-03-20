From: Christian Hammerl <info@christian-hammerl.de>
Subject: Annoying absolute path for "core.worktree" to submodule
Date: Tue, 20 Mar 2012 10:52:43 +0100
Message-ID: <20120320105243.2e8a489b@christian-hammerl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 10:52:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9vkJ-0005oa-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 10:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab2CTJwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 05:52:47 -0400
Received: from w3variance.de ([85.197.82.140]:59540 "EHLO w3variance.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab2CTJwq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 05:52:46 -0400
Received: from ip-95-222-97-168.unitymediagroup.de ([95.222.97.168] helo=localhost.localdomain)
	by w3variance.de with esmtpa (Exim 4.75)
	(envelope-from <info@christian-hammerl.de>)
	id 1S9vjt-0001dM-7w; Tue, 20 Mar 2012 10:52:25 +0100
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193492>

Hey folks,

I really love the work you are doing on GIT but the last update
regarding submodules is a bit annoying. Although the path inside the
".git" file is stored relative to the submodule's path, the path in
".git/modules/path-to-submodule/config" is stored as an absolute path
for "core.worktree".

I develop (for some projects) within a chroot where I have a different
username and therefore the path differs if I am currently inside the
chroot or not. If the submodule is initialized inside the chroot, I
always get this message when I cd into the project's directory outside
of the chroot:

fatal: Could not switch to
'/home/chroot-username/parent-path-of-submodule': File or directory not
found
fatal: 'git status --porcelain' failed in submodule
relative-path-to-submodule

This is caused by using `__git_ps1` for my bash-prompt. I don't know
exactly where the problem is and what actions (called by __git_ps1) are
responsible for this.

Any suggestions how to deal with this?

And no, removing __git_ps1 from my bash-prompt is not the answer, I
like this feature very much. ;-)

Thanks in advance
Christian
