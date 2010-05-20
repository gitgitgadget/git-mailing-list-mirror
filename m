From: Andy Parkins <andyparkins@gmail.com>
Subject: gitblogger
Date: Thu, 20 May 2010 18:29:30 +0100
Message-ID: <ht3reo$b6i$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 19:28:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF9XZ-0007ak-1z
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 19:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab0ETR2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 13:28:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:56395 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab0ETR2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 13:28:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OF9XM-0007Vv-Qs
	for git@vger.kernel.org; Thu, 20 May 2010 19:28:00 +0200
Received: from 91.84.15.31 ([91.84.15.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 19:28:00 +0200
Received: from andyparkins by 91.84.15.31 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 19:28:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 91.84.15.31
User-Agent: KNode/4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147400>

Hello,

Just a small announcement of a little project I just published.  Normally I 
wouldn't bother troubling you all, but I thought whoever it was wrote the 
key feature (git-notes) might appreciate knowing it was being used...

I've been wanting for a while to keep my blog in git (in fact I did do so, 
except it was a full ikiwiki installation, but ikiwiki is so slow, and meant 
I had to use my own computer to host my blog).  What I wanted was to have a 
post-receive hook that automatically compiled the markdown-syntax source 
files to HTML articles and posted them to my blogger account.  However, I 
wanted to be able to modify, rename, delete, etc, etc the local files while 
keeping the remote end in sync.

I was motivated to write the necessary script when I noticed that git 1.7 
comes with shiny git-notes support.  This is just what I needed -- when you 
post an article to blogger using the GData API, it gives you back a freshly 
assigned post ID.  That post ID is the only (reliable) way you have of 
keeping track of the link between the remote article and the local file that 
generated it.  My script grabs that ID and uses git-notes to store it 
against the object hash of the original article file.

Then, when you change that article in the repository (git diff-tree is a 
godsend by the way), it's a simply matter of using git-notes again to look 
up the postID and send the appropriate GData command to update that article.

Summary: git-notes... excellent, exactly the tool I needed.

If you write a blog and would prefer git + markdown for maintaining it over 
HTML in a web interface, the repository is at

http://gitorious.org/git_blogger



Andy
-- 
Dr Andy Parkins
andyparkins@gmail.com
