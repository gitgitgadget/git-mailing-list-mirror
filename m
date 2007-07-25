From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 10:39:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707251024390.14781@racer.site>
References: <46A5B5F5.6000202@trolltech.com> <Pine.LNX.4.64.0707241002410.14781@racer.site>
 <7vd4yigmla.fsf@assigned-by-dhcp.cox.net> <46A5DF1F.2030307@trolltech.com>
 <Pine.LNX.4.64.0707241337470.14781@racer.site> <46A5FDF0.3060801@trolltech.com>
 <Pine.LNX.4.64.0707241431540.14781@racer.site> <46A63EAA.6080203@trolltech.com>
 <Pine.LNX.4.64.0707241923450.14781@racer.site> <46A654A6.5070802@trolltech.com>
 <20070724231529.GA29156@steel.home> <46A6F21D.2010306@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 11:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDdLM-00068N-93
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 11:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbXGYJjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 05:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756602AbXGYJjh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 05:39:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:56332 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756014AbXGYJjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 05:39:36 -0400
Received: (qmail invoked by alias); 25 Jul 2007 09:39:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 25 Jul 2007 11:39:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+pgo7re5+LvKgLdlkK3/WBvWzhp0kwi5NApXhYl
	ysLSxQegyJOvBP
X-X-Sender: gene099@racer.site
In-Reply-To: <46A6F21D.2010306@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53676>

Hi,

On Wed, 25 Jul 2007, Marius Storm-Olsen wrote:

> Alex Riesen said the following on 25.07.2007 01:15:
>
> > I have to stay with Windows, but I'd absolute hate having their stupid 
> > line-ending by default. As will my project supervisor, and he gets 
> > changes from something like 300 developers. You will definitely get 
> > their votes against changing the default
> 
> Ok, so maybe not changing the default.
> Though it's weird behavior for _most_ Windows developers out there, I agree
> that the current Windows Git population would mostly prefer the Unix line
> endings. And I can see how someone who's working on Windows and handling a lot
> of patches from other developers of multiple OSs also wanting the
> non-platform-standard Unix line-endings.

Even MacOSX saw the light.  More and more tools on Windows (not from M$, 
mind you, they still want to lock you in, and I am continually amazed at 
the _willingness_ to be locked in!) are behaving sane.

> > Marius said:
> >
> > > I believe, especially at the moment, most Git users on Windows are 
> > > mostly developing code in a cross-platform manner, and therefore 
> > > care about this problem.
> > 
> > Yes. They solve it by working fulltime in \n-lineending. Avoiding that 
> > stupid Visual Studio and Notepad helps too.
> 
> Huh? You just removed more than 3 _million_[1] potential users.. (Some say 8
> million [2]) Is that a good argument? Why should developers on Windows avoid
> using Windows tools? Because they're 'idiots'? (ref further down in your
> reply)

When somebody does not want the same as you, it comes natural to think of 
that person as an idiot.  That's psychology, not something rational.

However, I think we are talking about an almost non-issue here: those 3-80 
million users "just waiting" for Git probably would not touch it without a 
complete installer.  And that installer could just ask "which line ending 
do you want to suffer through today?"

Which brings _me_ back to my pet hate: why on earth is _no_ one of those 
30-800 billion Windows users trying to do something about the lack of a 
proper native Windows support for Git?  The MinGW port contains commits 
from these people (skipping everything that is in official git.git):

Johannes Schindelin
Johannes Sixt
Junio C Hamano
Mark Levedahl
Simon 'corecode' Schubert

I know for certain that the first person, and also the third person, are 
not exactly Windows users.  I guess not even the last two persons are.

Note that more work has been done on git-gui, because those poor Windows 
developers are evidently so uncomfortable with the keyboard that a GUI is 
needed.  AFAIK only Johannes Sixt and Shawn Pearce worked on the 
Windows/git-gui interaction (and again, Shawn is not a Windows user).

Han-Wen made an installer, right, but that installer is lacking bash and 
perl, and proper testing, because it was just a proof-of-concept.  
Han-Wen is no Windows user either.  I tried to pick up on that work, but 
unfortunately "gub" (the cross compiling framework he used) is so 
Pythonesque that I was put off.

So this leaves me with the question: do Windows users really want a proper 
native Windows support for Git?  If the answer is yes, why don't they _do_ 
(as in "not talk") something about it?

(Let me take a BIG, BIIIIIG exception here: Johannes Sixt has worked long 
and hard and extremely well on this beast.  He is certainly the exception 
that proves the rule.)

Ciao,
Dscho
