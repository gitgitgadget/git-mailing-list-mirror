From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 07:24:13 -0400
Message-ID: <20070823112413.GJ7267@thunk.org>
References: <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz> <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com> <Pine.LNX.4.64.0708231006220.20400@racer.site> <20070823102036.GG7267@thunk.org> <Pine.LNX.4.64.0708231122450.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 13:24:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOAnW-0002IK-De
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 13:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbXHWLYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 07:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbXHWLYS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 07:24:18 -0400
Received: from thunk.org ([69.25.196.29]:53134 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbXHWLYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 07:24:17 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IOAwD-0008Uj-AP; Thu, 23 Aug 2007 07:33:21 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IOAnN-0001hr-HQ; Thu, 23 Aug 2007 07:24:13 -0400
Content-Disposition: inline
In-Reply-To: <e1dab3980708230355x1d5d2febw6814e8f24d745ddd@mail.gmail.com> <Pine.LNX.4.64.0708231122450.20400@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56495>

On Thu, Aug 23, 2007 at 11:31:56AM +0100, Johannes Schindelin wrote:
> And that is _exactly_ where I fail to see benefits from.  You only get the 
> full power of C by using C.  You only get the full power of all open 
> source C programmers by using C.  And you only get the full flexibility, 
> speed, name-your-own-pet-peeve using C.

Sure, but not all porcelein commands need the full power of C.  Take
"git-gc" for example.  It was a *very* short shell script before it
was rewritten to use C.

> I have seen boxes where the administrators locked down everything.  And 
> Cygwin _does_ need to write the registry, and there is _no_ easy way to 
> have two independent Cygwin installs on the same machine.  This is where 
> MinGW/MSys really shines.

So are you claiming that MingGW/MSys is so good that it has a
perl/bash that is fully Linux compatible, so that we don't need to
convert our various internal commands that are implemented in shell to
C?  I didn't think that was a commonly held assessment...

> > So for those people who think an internal scripting language would be a 
> > worthwhile way of implementing certain git commands, instead of 
> > converting them all to C, my suggestion would be to "show us the code".  
> > Actually create the git to LUA bindings, and then show how easily it 
> > would be to rewrite a bunch of the existing git commands which are 
> > currently implemented in shell in LUA instead.
> 
> And force everybody who wants to contribute to _those_ parts of Git to 
> learn LUA?  It is not about languages.  It is about people.  Choosing an 
> obscure language automatically limits your most valuable resource: people.

I don't know enough about LUA to say for sure.  Having taken a quick
look at lua.org, the implementation looks pleasantly small, and LUA
scripts look more comprehensible than say Tcl (which is not saying
much, I know).  But part of "show me the code" is people demonstrating
that no really, LUA is an appropriate tool for simple scripts that is
portable enough that we don't need to have external dependencies on
bash and perl, and that it is easier than rewriting all of our shell
scripts in C.  Maybe that is a true statement.  I don't know.  My
suggestion to "Show us the code" was a way of hoping someone who cared
enough about this issue could show us.

On Thu, Aug 23, 2007 at 11:55:41AM +0100, David Tweed wrote:
> 
> *nix person: "Dunno, I've never seen that before. I wonder what's
> causing it: is it a git thing I've never seen, is it a bash/Perl-on-Windows
> weirdness, is it something implemented not as expected in the cygwin
> libraries, is it native Windows behaviour that's actually "right"?
> Or is it some mixture of the four? And given that I've never
> used cygwin and other tools on windows, I'm ******** if I know...."

This is definitely the case with Cygwin, and I *thought* it was an
issue with MSys/MingGW.  Johannes seems to be arguing otherwise, but I
don't have first hand experience, since happily I haven't had to do
Windows development since 1999, when I stopped working on Kerberos at
MIT.  (Back then we had some really gross perl scripts that converted
Unix makefiles into Windows makefiles, and I used Cygwin, so I know
how unsatisfying that would be for a die-hard Windows programmer.)

> I personally don't care exactly what's used implementing git on non-unix
> platforms, but I get nervous as more and more "layers" are added so
> it becomes more and more difficult to figure which layer a user problem
> is occurring at. If it looks to difficult to "help out with" issues on Windows,
> that would be a big enough reason for me not to use git on such projects.

I think people are aware of that, and that's why the debate is going
on about either rewriting all internal shell scripts to C, or perhaps
using some extension language.

My personal belief is that for anything longer than a relatively
trivial size, the right answer *is* to rewrite it to C, and we have
some GSoC students doing just that.  But for some of the simpler
scripts, maybe it makes sense to consider LUA.  I don't know.  But
someone who cares is going to have to implement a proof of concept and
then convince everyone that it is worthwhile for the git community to
learn LUA.  If it's not a simple enough language, or write-only
language like Perl (quick!  what does this do?  
$_="krJhruaesrltre c a cnP,ohet";$_.=$1,print$2while s/(..)(.)//;),
then such a proposal will fall flat on its face.  But from my very
quick examination of LUA, it seems to avoid the obvious problems of
Perl (too easy to write obfuscated code, no stable language specification,
too big), Python (too big, no stable language specification), Tcl 
(awful syntax), so if someone is willing to champion it, it should be
given a fair hearing.

Or maybe we just convert everything over to C.  That's an acceptable
outcome as well, and probably the most likely given that we're doing
this already.

						- Ted
