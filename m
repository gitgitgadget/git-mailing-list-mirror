From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: RCS keyword expansion
Date: Mon, 15 Oct 2007 15:03:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710151457131.1901@ds9.cixit.se>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710121057540.25221@racer.site> <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
 <Pine.LNX.4.64.0710121231410.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 16:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQYI-0006lK-Bl
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765373AbXJOOD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 10:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765380AbXJOOD0
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:03:26 -0400
Received: from ds9.cixit.se ([193.15.169.228]:33437 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765359AbXJOODY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:03:24 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9FE3LnQ011857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Oct 2007 16:03:21 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9FE3KxC011852;
	Mon, 15 Oct 2007 16:03:20 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0710121231410.25221@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 15 Oct 2007 16:03:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60999>

Hi!

> Finding out which commit last changed that file is slow.  That's why
> it breaks down.

That might be, but it only needs to be done when a file is updated.

> You are just to used to CVS/SVN to see that there is a much better
> way in git.

I can see that favouring the argument that having a $Id$ that gives me
the global state id when the file was last updated is a bad idea. Fair
enough. Give me a local state tham (which you did, hash id for the file
contents).

My problem now is the file date. That could possibly be fixed by having
it updated before I check in the file.


So, to summarize, if I've understood the responses here correctly, what
I really want is:

 on commit:
  - replace "$Date$" (or whatever) with the current time.
  - store the contents.

 on checkout:
  - update the file.
  - replace "$Id$" (ditto) with a magic identifier for the file state.
  - update git's state so that it doesn't see the "$Id$" expansion
    as a change in the file contents.

Now the question is: Where can I find documentation on how to do this
(i.e what should I search for--"hooks"?)?

And, if this goes into the ".git" directory, can I still have it
replicated when I clone a repository? I noticed that my ".git/ignore"
file wasn't replicated and that I had to replace it with a local
".gitignore" to get it under version control.

-- 
\\// Peter - http://www.softwolves.pp.se/
