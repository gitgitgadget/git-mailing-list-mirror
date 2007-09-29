From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Submodule usability
Date: Sat, 29 Sep 2007 13:24:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709291302240.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 19:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibg3r-0005iN-Et
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 19:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbXI2RY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 13:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbXI2RY4
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 13:24:56 -0400
Received: from iabervon.org ([66.92.72.58]:44154 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbXI2RYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 13:24:55 -0400
Received: (qmail 5935 invoked by uid 1000); 29 Sep 2007 17:24:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Sep 2007 17:24:53 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59481>

Would it be feasible in general to have "git status" cascade into 
submodules if they're checked out? As it is now, in a project with 
submodules, a "git commit -a" at the top can create a commit that lacks 
changes that are in the working tree and aren't mentioned to the user at 
all, which is a sure recipe for a stream of "add the change I forgot to 
add last time" follow-up commits.

While I'm on that topic, I think I want an "includesfile" config option 
that specifies patterns that should never be present untracked (but only 
as per-user configuration, since I think that's exclusively a matter of 
personal taste). I'll probably code this up myself unless I've missed 
somebody else doing it already. My first guess at effect is -a adds them, 
and they appear as "not added" in the "modified" section of status output 
instead of the "untracked" section.

Also, would it be reasonable to have a gitmodules option for submodules 
that the supermodule doesn't make sense without? E.g., multiple projects 
are now using kbuild as their build system, so, in order to share 
improvements to kbuild between projects, it would be useful to have it as 
a submodule. But, by default, the kernel wouldn't come with its build 
system any more, which would be a pain. So have a tracked option for the 
submodule that says that, when checking out the superproject, this 
particular subproject should be updated automatically.

	-Daniel
*This .sig left intentionally blank*
