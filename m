From: Carl Baldwin <cnb@fc.hp.com>
Subject: [RFC] Not grabbing ALL branches and tags with git clone
Date: Mon, 14 Nov 2005 11:26:16 -0700
Organization: Hewlett Packard
Message-ID: <20051114182616.GB19105@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 19:29:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebj24-0004sw-Mx
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 19:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVKNS0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 13:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVKNS0R
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 13:26:17 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:54675 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751226AbVKNS0Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 13:26:16 -0500
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id 5CA829D30
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 13:26:16 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 314EE41E1C8
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 18:26:16 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 25690B614; Mon, 14 Nov 2005 11:26:16 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11833>

Greetings,

Lately, I've found that 'git clone' gives me more than what I want.
Especially when there are a lot of branches and tags in the remote
repository.

I have found myself doing something like the following in most cases.

% mkdir work && cd work
% git init-db
% git fetch <url> <refspec>
% git checkout -f -b master <branch>

Usually, I will use a file in .git/remotes but you get the idea.  I was
thinking that it might make sense to make git clone able to do this.
Change the usage of git clone so that it looks like this:

git clone [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> <dir> [<refspec>] ...

git clone would behave exactly the same way if no refspec were given but
if a refspec (or multiple refspecs) were given on the command line then
git clone would behave more like my series of three commands above.

I haven't looked at what it would take to patch git clone for this
purpose.  Just wanted to see what you thought.

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
