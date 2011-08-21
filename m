From: Evan Shelhamer <shelhamer@imaginarynumber.net>
Subject: Re: Site dependent repositories
Date: Sun, 21 Aug 2011 05:46:29 +0000 (UTC)
Message-ID: <loom.20110821T074112-429@post.gmane.org>
References: <4E507C05.2090700@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 07:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv0vU-0005wq-CT
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 07:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab1HUFuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 01:50:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:36823 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab1HUFuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 01:50:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qv0v8-0005sd-T4
	for git@vger.kernel.org; Sun, 21 Aug 2011 07:50:07 +0200
Received: from c-24-62-205-17.hsd1.ma.comcast.net ([24.62.205.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 07:50:06 +0200
Received: from shelhamer by c-24-62-205-17.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 07:50:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.62.205.17 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_1) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179795>

Have you considered ignoring 'local' and 'extensions' and making each their
own repositories?

A 'site' repository would contain the dir structure you described, and would
have a .gitignore to ignore 'local' and 'extensions'. As these are now ignored
by git, you are free to create a git repo in each dir that will be independent
of the 'site' repo.

This way you would be able to push/pull 'site' repos without 'local' and
'extensions' being tracked or changed. However, you can still go into the
'local' and 'extensions' dirs and work with the git repos established for
these directories.

This brings up the problem of keeping a given 'site' repo and its inner
'local' and 'extensions' repos in sync, but you could do this by coordinating
pushs, pulls, and checkouts by a deploy script or something of that nature.
