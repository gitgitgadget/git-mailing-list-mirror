From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Fri, 30 Sep 2005 12:19:41 +0400
Message-ID: <200509301219.42087.snake@penza-gsm.ru>
References: <u5tzmqp8fzx.fsf@lysator.liu.se> <200509270834.55486.snake@penza-gsm.ru> <1127825656.30421.15.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 10:21:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELG7Y-0000Z1-9R
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 10:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVI3ITt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 04:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVI3ITt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 04:19:49 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:12673
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S932450AbVI3ITs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 04:19:48 -0400
Received: (qmail 8324 invoked from network); 30 Sep 2005 08:20:33 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 30 Sep 2005 08:20:30 -0000
To: David Mansfield <david@cobite.com>,
	Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: KMail/1.7.2
In-Reply-To: <1127825656.30421.15.camel@gandalf.cobite.com>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9547>

On Tuesday 27, September 2005 16:54 David Mansfield wrote:
> On Tue, 2005-09-27 at 08:34 +0400, Alexey Nezhdanov wrote:
> > (Re-post. Sorry for any inconvenience.)
> >
> > On September 14, 2005 23:34 Petr Baudis wrote:
> > > Dear diary, on Wed, Sep 07, 2005 at 09:18:03PM CEST, I got a letter
> > > where Junio C Hamano <junkio@cox.net> told me that...
> > >
> > > > David K?.A?Negedal <davidk@lysator.liu.se> writes:
> > > > > The authorship info in commits created by git-cvsimport-script
> > > > > only contains the username of the CVS committer.  This patch
> > > > > adds a flag -e <domain> to git-cvsimport-script that makes it
> > > > > possible to specify an email domain that is added to all email
> > > > > addresses in the commit "author" and "committer" fields.
> > > > >
> > > > > ---
> > > > > I have stopped using cvsimport, because cvsps seems to produce bad
> > > > > output on the repository I'm using it with, but I had already
> > > > > prepared this patch.
> > > >
> > > > Hmph.  One reason the original implementation did not do this is
> > > > because Linus and other people wanted to have a repeatability,
> > > > so making this an optional thing is good, but if we go this
> > > > route, I think if it would be nicer to have a --author-map
> > > > option that lets you feed a list of:
> > > >
> > > >     <author> ==> "A U Thor <author@author.dom>"
> > > >
> > > > mappings, instead of a single -e, which essentially does not add
> > > > much information to the result.
> > > >
> > > > I take that your oob comment indicates that you do not have much
> > > > incentive/inclination to further hack on this, so I am not
> > > > asking you to do the above even if you find my suggestion
> > > > worthwhile.
> > >
> > > Various tools use CVSROOT/users to map usernames to realname <email>.
> > > I actually wanted to send a patch, looked at the cvsimport script and
> > > got totally scared away (at least for now)... ;-)
> >
> > git uses cvsps output to determine authorship. Do you think if this
> > problem should be solved on cvsps side? It should be relatively easy
> > IMHO. David, can you add another key to output CVSROOT/users mapping
> > result instead of usernames if available?
>
> I apologize that I probably won't have time to look at this right now...
>
> David

Hello. I have improved my patch and tested it with git-cvsimport-script.
cvsps works as intended so I hope that you, David will accept this patch. You can find it here:
http://www.penza-gsm.ru/snake/use_CVSROOT_users.patch

Though git-cvsimport-script not works as good as I wanted. It confuses with cvsps output like
Author: Alexey Nezhdanov <snakeru at users.sourceforge.net>
and converts it to something like
Alexey Nezhdanov snakeru at users.sourceforge.net <Alexey Nezhdanov snakeru at users.sourceforge.net>

Unfortunately I do not know perl so I can not write a patch for git-cvsimport-script.
So I asking you, Matthias, to help with this or may somebody on this list can do it instead.

-- 
Respectfully
Alexey Nezhdanov
