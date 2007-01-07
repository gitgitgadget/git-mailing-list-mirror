From: Steven Grimm <koreth@midwinter.com>
Subject: git.git missing recent revisions?
Date: Sun, 07 Jan 2007 00:23:39 -0800
Message-ID: <45A0AE0B.3050109@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 07 09:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3TJI-0003Yc-Jh
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 09:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbXAGIXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 03:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXAGIXR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 03:23:17 -0500
Received: from tater.midwinter.com ([216.32.86.90]:46385 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932432AbXAGIXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 03:23:16 -0500
Received: (qmail 22100 invoked from network); 7 Jan 2007 08:23:15 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 7 Jan 2007 08:23:15 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36136>

I noticed Junio's latest "what's in git.git" message listed my two 
patches, which surprised me since I do a pull at least once a day on my 
git source repo and hadn't seen them show up yet.

So I did a fresh clone:

$ git-clone git://git.kernel.org/pub/scm/git/git.git/ git
$ cd git
$ git branch
* master

My changes aren't there. I looked at the headers of Junio's latest email 
message to see what my head revision should be (and by the way, putting 
the rev IDs there was a pretty cool idea!):

X-master-at: 13e86efbeae5994a85cc482b3964db7298c5c6ea
X-next-at: 71bb6ea083c59115d35c36f9bfd1986d30bf92e1

But "git-rev-list --all | grep 13e86efbeae5994a85cc482b3964db7298c5c6ea" 
doesn't return any results -- I don't have the current head in my 
freshly made clone. Here's what I see when I do "git-log | head -4" on 
master:

    commit 244a70e608204a515c214a11c43f3ecf7642533a
    Author: Luben Tuikov <ltuikov@yahoo.com>
    Date:   Thu Jan 4 18:37:45 2007 -0800

The latest rev on "next" isn't much newer:

    commit e0f60cf4d6caee4d81a50f6dba671c8cd94edb2e
    Merge: cc16482... e194cd1...
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Thu Jan 4 23:23:17 2007 -0800

So it looks like the public git.git repository hasn't been updated since 
Thursday night, and in particular doesn't contain my changes even though 
Junio's latest "what's in git.git" message says they should be in the 
master branch. Is that amount of latency expected, or is it a sign of 
something wrong? I'm running 1.4.4.1.g4d95 on OS X.

-Steve
