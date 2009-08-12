From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Problems with filters and git status - reproduction steps
Date: Wed, 12 Aug 2009 10:25:37 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908121020390.30907@ds9.cixit.se>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se> <200908092252.58363.j6t@kdbg.org> <alpine.DEB.2.00.0908120751500.30907@ds9.cixit.se> <alpine.DEB.2.00.0908120856110.30907@ds9.cixit.se>
 <4A828368.5010206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 11:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbA5i-0003gO-Bg
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 11:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbZHLJZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 05:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbZHLJZo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 05:25:44 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47240 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752546AbZHLJZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 05:25:43 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7C9PcIu025253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Aug 2009 11:25:38 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7C9PbXG025245;
	Wed, 12 Aug 2009 11:25:38 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4A828368.5010206@drmicha.warpmail.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 12 Aug 2009 11:25:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125686>

Michael J Gruber:

> I get "Changed but not updated" already here!

With git 1.5.6.5, I do get that. With git 1.6.4, I seem to only get it after 
the last step.

I have 1.5.6.5 on the server with the master repo, and am running 1.6.4 on 
the client (although when I ran the recipe through a shell script, I got the 
unclean status earlier, which made me think it ran an earlier version I have 
installed in another directory).

> Do you really want the date in the checked-in version of the file?

Yes. This way, the checked out copy that makes my web server can do its job 
without requiring any of the filters being installed. And the files in 
history are marked as necessary.

> I would assume otherwise. Then your clean filter should really be the 
> smudge filter, and you would need a clean filter to go with it (remove the 
> date and restore the keyword).

The problem with that approach is that the "smudge" filter does not have 
access to the file name, and so can not look up the last change date of the 
file it is re-writing. And I want the last time the file was *changed*, not 
the time it was checked out.

Also, I imported my entire CVS history with keywords expanded to allow for 
this (and "checked out" the Git-generated tree over my CVS check-out to not 
have Git update all the time-stamps).

-- 
\\// Peter - http://www.softwolves.pp.se/
