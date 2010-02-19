From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: [RFE] pre/post-stash hooks
Date: Fri, 19 Feb 2010 12:33:46 -0500
Organization: MAD House Graphics
Message-ID: <hlmi1o$fk5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 18:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiWkP-0002wN-5V
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 18:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab0BSReZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 12:34:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:38933 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab0BSReX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 12:34:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiWk5-0002hi-7R
	for git@vger.kernel.org; Fri, 19 Feb 2010 18:34:17 +0100
Received: from c-68-39-198-198.hsd1.de.comcast.net ([68.39.198.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 18:34:17 +0100
Received: from scottg.wp-hackers by c-68-39-198-198.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 18:34:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-68-39-198-198.hsd1.de.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Lightning/1.0b2pre Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140468>

While I had known about git stash, and just never used it, I'd finally 
gotten to the point where it was needed, only to discover something that 
I found interesting.

My use case may a bit rare at the moment, I'll admit, but not at all 
far-fetched, and probably growing in usage as time goes on.

In contrib/hooks is the script 'setgitperms.perl' which, when added to 
pre-commit, post-merge, and post-checkout, makes sure to track the file 
permissions fully, not just +/-x. This can be vitally important for 
webdevelopers who must keep certain permissions on certain directories, 
such as for e-commerce solutions like Magento, etc, so that the clients 
may upload new product images through the interface rather than via ftp.

However when I recently used stash to push some changes aside while I 
did something else first, and then ran git stash pop, I realized that 
there weren't any hooks that would enable setgitperms.perl to be 
ensuring/tracking the file permissions are applied correctly after stash 
usage.

Granted that full directory/file permissions may not be all that 
important to some of you coders, but I can assure you that web 
developers may not see it that way.

Again granted, I could probably set up a Makefile, but not everyone 
knows how to do that (particularly those webdevelopers who aren't coders 
who would typically be familiar with Makefiles.

Also granted I could probably find a way to work around this issue with 
an alias, but my thought is that I shouldn't have to.

There are some of us who exist who have this funny thought that 
computers should be able to do things for us without us having to 
explicitly tell them to, specifically, every time. We'd prefer to set 
things up generally "just do this EVERY time for EVERYthing" and forget 
about it, and let the computer handle it. I'm sure you're familiar with 
us, since we are us. :-)

So, with this in mind, in addition to requesting pre/post-stash hooks 
just for this alone, I'd like to solicit some thought from the rest of 
you as to potential possible usages/requirements for said hooks for 
reasons _other_ than running 'setgitperms.perl'

Are there any reasons why pre/post-stash hooks _shouldn't_ exist?

How difficult would it be to implement?

-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
