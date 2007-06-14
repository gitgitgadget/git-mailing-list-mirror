From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stupid quoting...
Date: Thu, 14 Jun 2007 01:51:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706140145450.4059@racer.site>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706131316390.4059@racer.site>
 <86ejkgvxmb.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1398469498-1181782266=:4059"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 02:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hydbc-0003Ad-41
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 02:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbXFNAyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 20:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756896AbXFNAyb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 20:54:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:37711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756784AbXFNAya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 20:54:30 -0400
Received: (qmail invoked by alias); 14 Jun 2007 00:54:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 14 Jun 2007 02:54:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19b/PY+cydbTCVzt1XWXQmgYMFjML3wp+DqUeUy/q
	QDi9ebgJ2RNgqz
X-X-Sender: gene099@racer.site
In-Reply-To: <86ejkgvxmb.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50150>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1398469498-1181782266=:4059
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

[somehow I got the impression your mail did not make it to the list]

On Wed, 13 Jun 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 13 Jun 2007, David Kastrup wrote:
> >
> >> what is the point in quoting file names and their characters in
> >> git-diff's output?  And what is the recommended way of undoing the
> >> damage?
> >
> > The recommended way is not using spaces to begin with.
> 
> Who is talking about spaces?

That is the common reason for quoting. I mean, really, how many files do 
you have which contain newlines or backslashes or tabs? Huh?

> > I mean, does "David" contain spaces?
> 
> "Günter" contains non-ASCII characters.

And "Guenther" (sorry, have problems with my mailer, so I simulate it in 
plain ASCII" does not need quotes, _even_ if containing non-ASCII 
characters.

So what exactly was your point again?

> > People seem not to see the problem, and fail to blame Microsoft for 
> > all the damage they have done, introducing that stupid, stupid concept 
> > of filenames containing spaces, and _enforcing_ it.
> 
> The concept of UNIX file names is _any_ byte sequence not containing "/" 
> or an ASCII NUL.  Microsoft actually prohibits quite a few more 
> characters.  Filenames with spaces first came into serious use under 
> MacOS, the first graphical user interface where no shell and 
> metacharacters interfered with the choice of file names.
> 
> Blaming Microsoft here is completely ridiculous.

It is completely unridiculous. Before Microsoft -- in its infinite wisdom 
-- decided to create folders like "Program Files", and "Documents and 
Settings", and made it the _default_ (of all things) to save its 
ridiculous Word documents as "New Document", _nobody_ on this planet even 
_thought_ about including stupid whitespace in a filename.

You can tell that this is true by looking at now-ancient Unix scripts.

> >> I have something like
> >> 
> >> git-diff -M -C --name-status -r master^ master | {
> >>     while read -r flag name
> >>     do
> >> 	case "$name" in *\\[0-3][0-7][0-7]*)
> >> 		name=$(echo -e $(echo "$name"|sed 's/\\\([0-3][0-7][0-7]\)/\\0\1/g;s/\\\([^0]\)/\\\\\1/g'))
> >> 	esac
> >>         [...]
> >> 
> >> in order to get through the worst with utf-8 file names, and it is a
> >> complete nuisance (double quotemarks are treated later).
> >
> > Please understand that the quotes are not there for you, but for 
> > processing by other programs.
> >
> > However, I _suspect_ that you want to do something like
> >
> > 	name="$(echo $name)"
> >
> > because "echo" is exactly one of the programs this quoting was invented 
> > for.
> 
> Only that it does not work with echo.  echo requires \0NNN for octal
> escapes, not \NNN, and then only when "echo -e" is used.

Um. How does that apply here? Git only does quoting so that programs like 
echo get it right, when passed the name? No funny \0NNN or \NNN or 
whatever?

> You are really haphazard in distributing your blame.
> 
> Can you actually name a program that would work with the default
> output of git here?

echo.

Ciao,
Dscho

--8323584-1398469498-1181782266=:4059--
