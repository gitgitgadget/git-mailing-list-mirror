From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: removing a commit from a branch
Date: Wed, 4 May 2011 10:17:07 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1105041014480.16939@ds9.cixit.se>
References: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Gergely Buday <gbuday@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 11:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHYCt-00084X-7U
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 11:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802Ab1EDJRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 05:17:14 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:43459 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751691Ab1EDJRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 05:17:13 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p449H8Pg025163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 May 2011 11:17:08 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id p449H7cY025160;
	Wed, 4 May 2011 11:17:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172729>

Gergely Buday:

> I have a problematic commit in a series of commits on a branch. It
> contains adding a large binary file, which I would like to avoid to
> push to our main repository. How can I remove that from the series of
> commits? A command-line solution, please, if possible.

If the branch is simple (no merges and such), I'd use "git rebase 
--interactive branchpoint" (where "branchpoint" is where the branch is 
rooted), or "git rebase --interactive problematic^" (where "problematic" is 
the commit you want to edit, note the trailing "^" to start from its parent 
commit).

Then change the "pick" for the problematic commit to "edit", run the rebase, 
fix up the commit by using "git rm" and "git commit --amend" when it pauses, 
and then let it finish using "git rebase --continue".

"git --help rebase" for more information.

-- 
\\// Peter - http://www.softwolves.pp.se/
