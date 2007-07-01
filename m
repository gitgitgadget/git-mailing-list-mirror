From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sun, 1 Jul 2007 14:48:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011313580.4438@racer.site>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org>
 <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net> <20070701082202.GB6093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 15:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4zmt-0006c5-M4
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 15:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbXGANs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 09:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755001AbXGANsZ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 09:48:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:56363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbXGANsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 09:48:25 -0400
Received: (qmail invoked by alias); 01 Jul 2007 13:48:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 01 Jul 2007 15:48:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1852DV88rE57M+iVUpLl+N3AymK3OI6tdFXN40KEb
	CrZ3wQIIoT36qJ
X-X-Sender: gene099@racer.site
In-Reply-To: <20070701082202.GB6093@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51296>

Hi,

On Sun, 1 Jul 2007, Jeff King wrote:

> On Sat, Jun 30, 2007 at 12:17:10PM -0700, Junio C Hamano wrote:
> 
> > So I am somewhat negative on this, unless there is a way for
> > scripts to say "Even though I say 'git foo', I do mean 'git foo'
> > not whatever the user has aliased".
> 
> I had submitted GIT_NOALIAS=1 patches a while back, but IIRC, the
> consensus was that it was a bit too ugly and fragile in concept.

I think it is not GIT_NOALIAS that is ugly and fragile in concept. It is 
the whole notion that you can define default parameters via aliases that 
is ugly and fragile.

The possibility to say

	git config alias.log '!rm -rf /home/peff'

on somebody _else's_ machine makes me go shudder.

And there's another thing. On some machines, rm is aliased to 'rm -i'. 
That's good, right? NO! It _forces_ me to either look at the aliases on 
that particular box, or alternatively (which is what I actually do), 
specify _exactly_ what I want (I never do "rm", I always do "rm -i" or "rm 
-f", or "git rm"). That's because the default behaviour is 
_different_ on _different_ boxes. Repeat after me: consistency is good, 
inconsistency is bad.

So, yes, I am glad we have the option of using GIT_NOALIAS (which I forgot 
until jasam had this idea on IRC, independently), but no, I'd like not to 
use it. Not because GIT_NOALIAS is ugly, but because individual 
overriding default behaviours via peculiar aliases is.

Ciao,
Dscho
