From: John Locke <mail@freelock.com>
Subject: git svn clone a non-standard repository
Date: Tue, 24 Jun 2008 11:32:37 -0700
Message-ID: <48613DC5.2000506@freelock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 20:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDKu-0007zP-0z
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYFXSch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYFXSch
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:32:37 -0400
Received: from logan.freelock.com ([216.231.62.127]:33561 "EHLO
	logan.freelock.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbYFXScg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:32:36 -0400
Received: from localhost (foraker.freelock.com [127.0.0.1])
	by logan.freelock.com (Postfix) with ESMTP id A088FA0456
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 11:32:35 -0700 (PDT)
Received: from logan.freelock.com ([127.0.0.1])
 by localhost (foraker.freelock.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25663-04 for <git@vger.kernel.org>;
 Tue, 24 Jun 2008 11:32:35 -0700 (PDT)
Received: from [192.168.9.243] (router.freelock.lan [192.168.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by logan.freelock.com (Postfix) with ESMTP id 7CC56A0448
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 11:32:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
X-Virus-Scanned: by amavisd-new at freelock.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86102>

Hi,

I'm trying to create a git repo of the Dojo Toolkit, which has a quite 
non-standard layout. There are 4 modules to the current Dojo project 
that I care about (and some others in the repo that I'm not interested 
in). The problem is, the trunk code is split out into 
<modulename>/trunk, while tags are in tags/<tagname>/<modulename> and 
branches are in branches/<branchname>/<modulename>. e.g:

moduleA/trunk <- contains trunk development of moduleA
moduleA/tags   <- empty
moduleA/branches <- empty
moduleB/trunk
moduleB/tags
moduleB/branches
moduleC/trunk
moduleC/tags
moduleC/branches
moduleD/trunk
moduleD/tags
moduleD/branches
moduleE/trunk <- I don't care about this one...
trunk/   <- contains ancient version, not actual trunk
tags/1.0.0/moduleA <- contains tagged version of moduleA
tags/1.0.0/moduleB <- contains tagged version of moduleB
tags/1.0.0/moduleC <- contains tagged version of moduleC
tags/1.0.0/moduleD <- contains tagged version of moduleD
tags/1.0.1/moduleA
tags/1.0.1/moduleB
...

So I'd like to set up a git repo that tracks this SVN repository, and 
allows me to see:
moduleA/
moduleB/
moduleC/
moduleD/
... in my checkout, whether I'm on trunk or a tag.

What's the best way to set this up?

I've started with "git svn clone http://path/to/svn -T moduleA/trunk -t 
tags -b branches", and it's been sucking down branches for a couple days 
now, still not done. Can I set up moduleB/moduleC/moduleD as additional 
remotes in this same repository, and end up with the desired result? Was 
thinking I would add additional svn sections to .git/config, and then 
git svn fetch -- will this work, or is there a better way?


Thanks,

-- 
John Locke
"Open Source Solutions for Small Business Problems"
published by Charles River Media, June 2004
http://www.freelock.com
