From: davetron5000 <davetron5000@gmail.com>
Subject: move files between disparate repos and maintain version history
Date: Mon, 2 Mar 2009 12:30:58 -0800 (PST)
Message-ID: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 21:35:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeEqT-0007tK-PW
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 21:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbZCBUbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 15:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbZCBUbD
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 15:31:03 -0500
Received: from yx-out-2122.google.com ([74.125.44.24]:55915 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbZCBUbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 15:31:01 -0500
Received: by yx-out-2122.google.com with SMTP id 33so1209206yxl.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 12:30:59 -0800 (PST)
Received: by 10.100.142.15 with SMTP id p15mr975850and.8.1236025858966; Mon, 
	02 Mar 2009 12:30:58 -0800 (PST)
X-IP: 71.191.202.20
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) 
	AppleWebKit/528.16 (KHTML, like Gecko) Version/4.0 Safari/528.16,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111960>

Using git-svn at work, and had to do some svn moves that I'm wondering
would be handled with git?

Our repo is setup like this:

$SVNROOT/main/core/{trunk,tags,branches}
$SVNROOT/main/app/{trunk,tags,branches}

core and app are treated as different project roots internally, and my
git-svn treats them as such.

We recently needed to move some files from app to core.  I could've
just moved them in between my git repos, but the version history would
be lost, since these are two separate repos.  I did the move via svn
mv, which works simply because our "separate projects" are really just
in the same SVN repo.

So, is there a way I can move a file between two git repositories,
maintaining the change history?  I guess it would be something like
"apply all patches that this file was involved in, but ONLY apply the
ones affecting this file, to the new repo, then delete from the old"?
