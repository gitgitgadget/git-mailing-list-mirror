From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 4/5] cvsserver: Make the database backend configurable
Date: Fri, 23 Mar 2007 19:39:31 +0100
Message-ID: <20070323183931.GK8017@planck.djpig.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de> <11743197611364-git-send-email-frank@lichtenheld.de> <46a038f90703191247y6b70c272s2473ab28acd63682@mail.gmail.com> <20070323151757.GH8017@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 19:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUofq-0005J2-Fk
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 19:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbXCWSjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 14:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbXCWSjf
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 14:39:35 -0400
Received: from planck.djpig.de ([85.10.192.180]:37498 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305AbXCWSje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 14:39:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C5CE288136;
	Fri, 23 Mar 2007 19:39:32 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05385-10; Fri, 23 Mar 2007 19:39:32 +0100 (CET)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id EDB3488137; Fri, 23 Mar 2007 19:39:31 +0100 (CET)
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070323151757.GH8017@planck.djpig.de>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42952>

On Fri, Mar 23, 2007 at 04:17:58PM +0100, Frank Lichtenheld wrote:
> On Tue, Mar 20, 2007 at 07:47:12AM +1200, Martin Langhoff wrote:
> > On 3/20/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > >Make all the different parts of the database backend connection
> > >configurable. This adds the following string configuration variables:
> > 
> > Nice. I guess the hard part of this is going to be creating DB schemas
> > that are reasonably portable. The SQL we use is as vanilla as it gets
> > ;-)
> 
> I've now actually made a quick test to see how we do when using other
> backends (with PostgreSQL 8.2, will also do one with MySQL later).

Done the MySQL tests, too.

> Some problems that I saw:
> 
>  - It would probably cool to be able to tell git-cvsserver that it
>    should use only one database for all modules (i.e. git branches)
>    This way one doesn't need to give the users database creation
>    privileges. Of course pre-creating all databases possibly ever needed
>    is possible but somewhat cumbersome.
>  
>  - DBI->tables seems to be a portability problem. e.g. with SQLite
>    it returns "head", "commitmsgs", etc; with PostgreSQL it returns
>    public.head, public.commitmsgs, etc. The output of MySQL might
>    be different, too.

It is `head`, and `revision`. Fun ;)
Why no etc.? Because pretty much every other used SQL command (than these
two "create table") fails with syntax errors. Not that I actually expected
anything else from MySQL...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
