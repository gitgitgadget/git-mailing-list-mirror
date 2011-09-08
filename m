From: anikey <arty.anikey@gmail.com>
Subject: Git Bug - diff in commit message.
Date: Thu, 8 Sep 2011 07:49:13 -0700 (PDT)
Message-ID: <1315493353942-6772145.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 16:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1fur-00071V-4x
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 16:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab1IHOtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 10:49:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:40943 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab1IHOtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 10:49:15 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <arty.anikey@gmail.com>)
	id 1R1fuj-00082x-Ug
	for git@vger.kernel.org; Thu, 08 Sep 2011 07:49:13 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180976>

Hi, peops. I'm pretty much sure that's a bug.

What I did was putting git diff (i needed to tell people that for my changes
to start working they needed to aplly message-inline patch to some code
which was not under git) in commit message. Like adding:

diff --git a/app/controllers/settings_controller.rb
b/app/controllers/settings_controller.rb
index 937da74..0e8440d 100644
--- a/app/controllers/settings_controller.rb
+++ b/app/controllers/settings_controller.rb
@@ -42,7 +42,7 @@ class SettingsController < ApplicationController
   end
 
   def snmp_mibs
-    render layout: 'ext3'
+    render layout: 'ext3_2'
   end
 
   def cfg_auth_keys(auth_type=:all)

though the commit itself didn't contain that change. So while `git rebase
some_branch_name` I started getting:

First, rewinding head to replay your work on top of it...
Applying: My cool patch.
fatal: sha1 information is lacking or useless
(app/controllers/settings_controller.rb).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 My cool patch.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".

I wasn't able to figure out what was wrong for a very long time, when things
came to my mind.

Thanks.

--
View this message in context: http://git.661346.n2.nabble.com/Git-Bug-diff-in-commit-message-tp6772145p6772145.html
Sent from the git mailing list archive at Nabble.com.
