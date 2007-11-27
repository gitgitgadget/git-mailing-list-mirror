From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 15:35:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0711271531110.1011@ds9.cixit.se>
References: <200711271127.41161.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:36:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1Xb-0005jb-VR
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbXK0Of1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbXK0Of0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:35:26 -0500
Received: from ds9.cixit.se ([193.15.169.228]:60034 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbXK0OfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:35:25 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id lAREZKnQ016641
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Nov 2007 15:35:20 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id lAREZJhP016635;
	Tue, 27 Nov 2007 15:35:20 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <200711271127.41161.gapon007@gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 27 Nov 2007 15:35:20 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66217>

gapon:

> i have discovered "weird" behaviour of git in this scenario*:

Yeah, I have run into it several times myself, and that is being both
user A and B at the same time. The problem seems to be that git allows
you to push into a repository which has a check-out, causing it to
change states in a subtle way. That's just plain broken.

Git should either handle it somehow (perhaps by forcing the push into a
new branch, which the pushee needs name), or just plainly refuse to
push into a repository with a check-out.

I have learned to work around this problem by always pulling between my
repositories, not pulling. I could probably have worked around it by
having a master repository that is bare, but I have found that
difficult because I am tracking an upstream non-Git repository, so to
push and pull changes from that, I need a repository where I can have a
check-out.

> * yes, i know that this scenario is "incorrect" but... it's possible
> and therefore i think it should be somehow handled - i tried a
> similar one with hg and bzr and i like their behaviour more

Yeah. It's even more irritating that recovering from the error state is
difficult as well.

-- 
\\// Peter - http://www.softwolves.pp.se/
