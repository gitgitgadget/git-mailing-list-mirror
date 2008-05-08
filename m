From: Nicolas Pitre <nico@cam.org>
Subject: Re: How to (re-)create .git/logs/refs
Date: Thu, 08 May 2008 13:28:50 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805081313190.23581@xanadu.home>
References: <200805081256.11465.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
X-From: git-owner@vger.kernel.org Thu May 08 19:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9wT-0000fZ-7D
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYEHR3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYEHR3O
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:29:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50207 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYEHR3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:29:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0K003YI8K234V0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 May 2008 13:28:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200805081256.11465.hs4233@mail.mn-solutions.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81544>

On Thu, 8 May 2008, Holger Schurig wrote:

> So my question:
> 
> a) is there a way to re-create .git/logs/refs ?

No.

The reflog records how _you_ modified your various branches locally.  
This has no direct relationship with the dates the commits in those 
branches were created.  It records what was your own view of the 
repository in time.  So if you performed an import of a SVN repository 
last week, then it is normal that you don't have any view into that 
particular repository's state before last week.

> b) is there a simple way to get a list of ISO-dates and
>    associated SHA1?  Then I could use a little python code to
>    determine the SHA1 id that corresponds to some date (I need
>    to access old versions of the source via bitbake and/or
>    www.openembedded.org, so adding a custom fetch method with
>    some python magic is a non-brainer).

Have a look at the documentation for the --pretty=format option in the 
git-log man page.  For example:

	git log --pretty=format:"%H %ai"

might be just what you're looking for.


Nicolas
