From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 07:26:21 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com>
 <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Oct 12 07:26:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgD2c-0002VK-HQ
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 07:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXJLF0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 01:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbXJLF0T
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 01:26:19 -0400
Received: from smtp.getmail.no ([84.208.20.33]:47757 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbXJLF0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 01:26:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JPS00F019RT5D00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 12 Oct 2007 07:26:17 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPS0041B9RT5NB0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 12 Oct 2007 07:26:17 +0200 (CEST)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPS002729RT79F0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 12 Oct 2007 07:26:17 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id 7AB282FC18; Fri,
 12 Oct 2007 07:26:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 76BAE2FC0C	for <git@vger.kernel.org>; Fri,
 12 Oct 2007 07:26:21 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0710112144380.4174@racer.site>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60656>

Johannes Schindelin:

> The problem is this: for efficiency, git does not change files which have 
> not changes between the last version checked out (whatever that is) and 
> the current version.
>
> This seems counterintuitive to people coming from SVN/CVS: they expect
> _every_ file to be touched when checking out.

No? That would just be strange. Only the files that are actually changed 
should be updated, no others. A $Date$ or $Id$ will show the last 
time/commit that specific file was changed, not the latest global state (I 
guess the fact that most modern VCSs have global state makes this a bit more 
difficult to achieve, in RCS/CVS/PVCS and others the change history is local 
to a file and thus it is trivial to find the large change for that 
particular file).

> As Randal already suggested: if you need something like this, you better 
> have a build procedure which replaced $Date$ _at a given time_ (make 
> install) with the current date.

But that's not what I want. Then my build procedure would need to do a "git 
status", or whatever you use to get the last commit information about a 
file, on each file that is changed and is to be installed. It would be a lot 
easier if that was done already on checkout through some kind of hook.

-- 
\\// Peter - http://www.softwolves.pp.se/
