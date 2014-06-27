From: Felix Eckhofer <felix@tribut.de>
Subject: Passing rev-list options in git-filter-branch broken
Date: Fri, 27 Jun 2014 18:26:04 +0200
Message-ID: <987cd4ccd2b86a840b900a25e0edf0f9@tribut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 18:36:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Z8h-00043k-BZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 18:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbaF0Qgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 12:36:35 -0400
Received: from metis.tribut.de ([78.46.43.195]:42260 "EHLO metis.tribut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbaF0Qge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 12:36:34 -0400
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jun 2014 12:36:34 EDT
Received: from webmail.tribut.de (localhost [127.0.0.1])
	by metis.tribut.de (Postfix) with ESMTP id EB19113578B
	for <git@vger.kernel.org>; Fri, 27 Jun 2014 18:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tribut.de; s=dkim;
	t=1403886365; bh=xNJIIe87OXncHBo1QzeGVm2kXzFkrSH2dnlFfHyURMs=;
	h=Date:From:To:Subject;
	b=PAXRKTrLdp1tU7zAgLzWopGg1xPsg4U2xvRGHdUjGDIZv0ogKmwlLIf2fPGGnWRhc
	 z33Fggf5E8Kr6dcYjPLFFe9thBc1KqyhM0fDQOf9l+08eiJlyzkUxfHEK9jfAZWl8r
	 mshwdDrFAkN9QZqM0SWwOmyd3SkOJeaSBviZyxwJufPDo2k/8bTd7Fsa4qgMRnAd+n
	 IERlnaGsOnt4nWrzsVVsBVoDGNJrqSbH8/ZZxkQqVMJmAodeGoFzYboEZrgHn0qxIZ
	 HUzoGbyJqS1utVaHkPZ1ApgjXNoAfjpqCwlQNzAZjU1lokqY7gzZ6Emc47AE48rrwG
	 cbIL7DioUXz9Q==
X-Sender: felix@tribut.de
User-Agent: Roundcube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252559>

Hey.

When trying to rewrite svn revisions in commit messages to corresponding 
git commit hashes, I came across the following problem (using git 
1.9.1):

   $ git filter-branch --msg-filter svnrev2git.py -- --date-order --all
   fatal: options not supported in --stdin mode
   Could not get the commits

This seems to have been caused by 3361a548db. After reverting this 
commit, using --date-order appears to work again.


Regards
felix
