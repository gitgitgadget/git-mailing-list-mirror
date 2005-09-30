From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Fri, 30 Sep 2005 09:54:45 -0400
Organization: Cobite, Inc
Message-ID: <1128088485.30421.80.camel@gandalf.cobite.com>
References: <u5tzmqp8fzx.fsf@lysator.liu.se>
	 <200509270834.55486.snake@penza-gsm.ru>
	 <1127825656.30421.15.camel@gandalf.cobite.com>
	 <200509301219.42087.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 15:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELLLw-0008G0-AS
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 15:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVI3Nyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 09:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVI3Nyv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 09:54:51 -0400
Received: from iris.cobite.com ([208.222.83.2]:44483 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S1030299AbVI3Nyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 09:54:50 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id F0DDD97DB6; Fri, 30 Sep 2005 09:54:18 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06091-01; Fri, 30 Sep 2005 09:54:18 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id BA88B98542; Fri, 30 Sep 2005 09:54:18 -0400 (EDT)
Received: from gandalf.cobite.com (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id CC92797DB6; Fri, 30 Sep 2005 09:54:15 -0400 (EDT)
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200509301219.42087.snake@penza-gsm.ru>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9560>

On Fri, 2005-09-30 at 12:19 +0400, Alexey Nezhdanov wrote:
> On Tuesday 27, September 2005 16:54 David Mansfield wrote:
> > On Tue, 2005-09-27 at 08:34 +0400, Alexey Nezhdanov wrote:
> > > (Re-post. Sorry for any inconvenience.)
> > >
> > > On September 14, 2005 23:34 Petr Baudis wrote:
> > > > Dear diary, on Wed, Sep 07, 2005 at 09:18:03PM CEST, I got a letter
> > > > where Junio C Hamano <junkio@cox.net> told me that...
> > > >
> > > > > David K?.A?Negedal <davidk@lysator.liu.se> writes:
> > > > > > The authorship info in commits created by git-cvsimport-script
> > > > > > only contains the username of the CVS committer.  This patch
> > > > > > adds a flag -e <domain> to git-cvsimport-script that makes it
> > > > > > possible to specify an email domain that is added to all email
> > > > > > addresses in the commit "author" and "committer" fields.
> > > > > >
> > > > > > ---
> > > > > > I have stopped using cvsimport, because cvsps seems to produce bad
> > > > > > output on the repository I'm using it with, but I had already
> > > > > > prepared this patch.
> > > > >
> > > > > Hmph.  One reason the original implementation did not do this is
> > > > > because Linus and other people wanted to have a repeatability,
> > > > > so making this an optional thing is good, but if we go this
> > > > > route, I think if it would be nicer to have a --author-map
> > > > > option that lets you feed a list of:
> > > > >
> > > > >     <author> ==> "A U Thor <author@author.dom>"
> > > > >
> > > > > mappings, instead of a single -e, which essentially does not add
> > > > > much information to the result.
> > > > >
> > > > > I take that your oob comment indicates that you do not have much
> > > > > incentive/inclination to further hack on this, so I am not
> > > > > asking you to do the above even if you find my suggestion
> > > > > worthwhile.
> > > >
> > > > Various tools use CVSROOT/users to map usernames to realname <email>.
> > > > I actually wanted to send a patch, looked at the cvsimport script and
> > > > got totally scared away (at least for now)... ;-)
> > >
> > > git uses cvsps output to determine authorship. Do you think if this
> > > problem should be solved on cvsps side? It should be relatively easy
> > > IMHO. David, can you add another key to output CVSROOT/users mapping
> > > result instead of usernames if available?
> >
> > I apologize that I probably won't have time to look at this right now...
> >
> > David
> 
> Hello. I have improved my patch and tested it with git-cvsimport-script.
> cvsps works as intended so I hope that you, David will accept this patch. You can find it here:
> http://www.penza-gsm.ru/snake/use_CVSROOT_users.patch
> 
> Though git-cvsimport-script not works as good as I wanted. It confuses with cvsps output like
> Author: Alexey Nezhdanov <snakeru at users.sourceforge.net>
> and converts it to something like
> Alexey Nezhdanov snakeru at users.sourceforge.net <Alexey Nezhdanov snakeru at users.sourceforge.net>
> 
> Unfortunately I do not know perl so I can not write a patch for git-cvsimport-script.
> So I asking you, Matthias, to help with this or may somebody on this list can do it instead.
> 

Cool. I'll definitely take a look.  Thanks for taking the time.

David
