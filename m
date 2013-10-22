From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Moving commits from one branch to another (improving my git
 fu!)
Date: Tue, 22 Oct 2013 06:52:50 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1310220647400.13299@ds9.cixit.se>
References: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 08:04:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYV5K-0005Iv-SL
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 08:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab3JVGEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 02:04:51 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:34846 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750842Ab3JVGEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 02:04:50 -0400
X-Greylist: delayed 714 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2013 02:04:50 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r9M5qpZZ006046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Oct 2013 07:52:51 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r9M5qpeS006043;
	Tue, 22 Oct 2013 07:52:51 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 22 Oct 2013 07:52:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236457>

Mandeep Sandhu:

> Here's what I did when I was in topicA:
>
> $ git rebase dev stable topicA
> (this was suggested in the manpage as well).

I guess you also had an "--onto" in there, as the above would throw a 
syntax error. As long as the branches are in order, I cannot see how 
that wouldn't do what you wanted.

However, the easiest way to do it would probably just to run:

  git checkout topicA
  git rebase dev

As long as "dev" already contains all the commits in "stable", that 
should work fine. If not, then you would need something more 
complicated.

Another way to do it would be to use cherry-pick on a new branch:

  git checkout -b new_topicA dev
  git cherry-pick stable..topicA

-- 
\\// Peter - http://www.softwolves.pp.se/
