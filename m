From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 16:37:09 -0500
Message-ID: <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:43:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3Ie-00035V-4e
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab0BLVnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:43:39 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38961 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0BLVni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 16:43:38 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2010 16:43:38 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B8BA31FFC43B; Fri, 12 Feb 2010 21:37:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.227] (unknown [64.134.71.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E50A01FFC1CE;
	Fri, 12 Feb 2010 21:37:03 +0000 (UTC)
In-Reply-To: <ron1-519083.13253112022010@news.gmane.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139749>


On Feb 12, 2010, at 4:25 PM, Ron Garret wrote:

> Yeah, I considered that.  The problem with that is that the actual 
> process turns out to be pretty obtrusive.  The scenario is that I've 
> done a bunch of hacking on the main branch and I realize that it's going 
> nowhere.  Nothing is working, everything is a horrible mess that's 
> spinning wildly out of control.  I want to get rid of everything I've 
> done and start over from an earlier snapshot that I knew was working.  
> But I also want to keep a copy of this current messy state around for 
> reference just in case there's a snippet here and there that might be 
> salvageable later on.  I don't know of any easy way to save the messed 
> up file onto another branch.  I'd have to save the file somewhere (in 
> the stash maybe?), check out the snapshot branch, retrieve the saved 
> file, do the commit, and then switch back to the main branch.

Have you tried creating a new branch without saving the state?

git checkout -b failed-experiment
git commit -a -m "Back to the drawing board"
git checkout master

Or if a series of commits seem to have gone bad:

git commit -a -m "Well, that didn't work."
git branch failed-experiment
git reset --hard origin/master # or other good state

You can of course replace the -a to commit with the needed "git add <file>" commands and leave off the -m to leave real messages about why it went bad using $EDITOR.

~~ Brian