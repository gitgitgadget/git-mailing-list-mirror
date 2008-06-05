From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 16:22:57 +0300
Message-ID: <20080605132257.GA30995@mithlond.arda.local>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080605081911.GA5946@mithlond.arda.local> <alpine.DEB.1.00.0806051131310.21190@racer> <bd6139dc0806050421l3a242a98sdfa51248b380badc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jun 05 15:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FRe-0002DJ-Uq
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbYFENXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbYFENXE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:23:04 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35813 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754328AbYFENXD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:23:03 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F1005BD386; Thu, 5 Jun 2008 16:22:58 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K4FQf-00087s-KY; Thu, 05 Jun 2008 16:22:57 +0300
Content-Disposition: inline
In-Reply-To: <bd6139dc0806050421l3a242a98sdfa51248b380badc@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83926>

Sverre Rabbelier wrote (2008-06-05 13:21 +0200):

> On Thu, Jun 5, 2008 at 12:32 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 5 Jun 2008, Teemu Likonen wrote:
> >> Add subcommand "help" to the list of most commonly used subcommands
> >
> > Hrmpf.  IMO "help" is not really a _git_ command.  And I use it
> > really, really rarely.
> 
> I agree with this, but not because I don't use it rarely, but because
> there is no such command 'git-help'. I know that we are urging the
> user away from the dash notation, but if we want to advertise 'git
> help' as an actual command, at least make 'git' recognize it as an
> actual command instead of displaying the default usage notice (type
> 'git help' and see what I mean).

Well, you guys know the internals, I don't, but I have to admit that
your opinions sound weird to me at the moment. I mean, what's the
purpose of the command list printed after typing just "git"? To help
users, I'd say. Making help commands/options easily available is for the
same purpose. If manuals, mailing lists, web pages, IRC logs and your
grandmothers advertise "git help" as _the_ help command but at the same
time user can't find the command advertised in the git's own "metahelp"
page it's quite confusing.

I came up with this suggestion because of my personal confusion. Command
"git" speaks only about --help option and I was coming to a conclusion
that "git help" is deprecated and instructions are just out-of-date.
Then I read the "git help help" manual and saw that actually "git
--help" is internally converted to "git help" so it's probably not
deprecated (quite the opposite actually). And yet the front page printed
by "git" does not show it.

But ok, here's another suggestion: If "git help" is not a real git
command then maybe not list it with other commonly used commands.
Instead print separate instructions before or after the list. Something
like this:

  Type "git help <command>" for more information on a specific command
  or other topic.


Examples from other tools:

  $ hg help | grep help
   help         show help for a command, extension, or list of commands
  use "hg -v help" to show aliases and global options
  
  $ bzr help | grep help
    bzr help init      more help on e.g. init command
    bzr help commands  list all commands
    bzr help topics    list all help topics
  
  $ svn help | grep help
  Type 'svn help <subcommand>' for help on a specific subcommand.
     help (?, h)
