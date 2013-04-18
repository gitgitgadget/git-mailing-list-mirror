From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Pushing/fetching from/into a shallow-cloned repository
Date: Thu, 18 Apr 2013 13:52:33 +0400
Message-ID: <20130418135233.87aa23896fa48dc2d87d80fb@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 11:52:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlWE-0003Zf-1N
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966886Ab3DRJwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:52:37 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56989 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966220Ab3DRJwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:52:36 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r3I9qWfB028142
	for <git@vger.kernel.org>; Thu, 18 Apr 2013 13:52:33 +0400
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221634>

The git-clone manual page, both [1] and my local copy coming with
Git for Windows 1.8.1, say about the --depth command-line option:

   --depth <depth>

     Create a shallow clone with a history truncated to the specified
     number of revisions. A shallow repository has a number of
     limitations (you cannot clone or fetch from it, nor push from nor
     into it), but is adequate if you are only interested in the recent
     history of a large project with a long history, and would want to
     send in fixes as patches.

But having done a shallow clone (--depth=1) of one of my repositories,
I was able to record a new commit, push it out to a "reference" bare
repository and then fetch back to another clone of the same repository
just fine.  I have then killed my test commit doing a forced push from
another clone and subsequently was able to do `git fetch` in my shallow
clone just fine.

So I observe pushing/fetching works OK at least for a simple case like
this one.

Hence I'd like to ask: if the manual page is wrong or I'm observing
some corner case?
