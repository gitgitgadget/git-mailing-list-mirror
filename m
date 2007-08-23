From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 11:31:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231122450.20400@racer.site>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz> <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
 <Pine.LNX.4.64.0708231006220.20400@racer.site> <20070823102036.GG7267@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 12:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO9zZ-0001Cq-Bs
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 12:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240AbXHWKcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 06:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758250AbXHWKcV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 06:32:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:42321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755879AbXHWKcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 06:32:20 -0400
Received: (qmail invoked by alias); 23 Aug 2007 10:32:18 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp020) with SMTP; 23 Aug 2007 12:32:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BPKtgOU3BfLR+Uwht1lTOGU9ddnf7cgYyThxWP/
	KE46of7EpxrL6b
X-X-Sender: gene099@racer.site
In-Reply-To: <20070823102036.GG7267@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56491>

Hi,

On Thu, 23 Aug 2007, Theodore Tso wrote:

> On Thu, Aug 23, 2007 at 10:10:20AM +0100, Johannes Schindelin wrote:
> > > > Red herring.  The proposal was not to do nothing, but rather give git
> > > > a dedicated scripting language internal to it.
> > > 
> > > That is a really neat idea.
> > 
> > Why?  Why should just _having_ a dedicated scripting language _per se_ be 
> > a neat idea?  We do not _need_ it!  We script git in bash, perl, other 
> > people in Python, Ruby, and even Haskell.  So why should we _take away_ 
> > that freedom from others to script Git in whatever language they like 
> > most?  There is no good reason.
> 
> Users should be able to script in whatever language they want; that's
> clear.  However, what some people were talking about was an internal
> scripting language that would be used for writing git commands, as an
> alternative to an alternative future where everything gets moved to C.

And that is _exactly_ where I fail to see benefits from.  You only get the 
full power of C by using C.  You only get the full power of all open 
source C programmers by using C.  And you only get the full flexibility, 
speed, name-your-own-pet-peeve using C.

Mind you, I use scripts a lot.  I even have some projects where I 
git-added a script to add aliases which are so large as to fit half a 
terminal.

But we should not _force_ people to have bash or perl when they do not 
plan to use it themselves.

> (To accomodate those Windows users who for some silly reason refuse to 
> install Cygwin, bash, and perl on their Windows development box.  :-)

I have seen boxes where the administrators locked down everything.  And 
Cygwin _does_ need to write the registry, and there is _no_ easy way to 
have two independent Cygwin installs on the same machine.  This is where 
MinGW/MSys really shines.

> So for those people who think an internal scripting language would be a 
> worthwhile way of implementing certain git commands, instead of 
> converting them all to C, my suggestion would be to "show us the code".  
> Actually create the git to LUA bindings, and then show how easily it 
> would be to rewrite a bunch of the existing git commands which are 
> currently implemented in shell in LUA instead.

And force everybody who wants to contribute to _those_ parts of Git to 
learn LUA?  It is not about languages.  It is about people.  Choosing an 
obscure language automatically limits your most valuable resource: people.

We saw that already with filter-branch (which saw some duplicate efforts, 
because one developer was not comfortable with shell; we had two different 
programs with different suboptimal behaviours).

> But if people are just gushing over the glories of elisp and saying 
> things like *someone* should create a scripting language for git, it's 
> just going to be a waste of everyone's time.

Amen,
Dscho
