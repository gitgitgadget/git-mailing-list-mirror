From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
 configured
Date: Sat, 7 Mar 2009 03:06:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903070256540.10279@pacific.mpi-cbg.de>
References: <20090305221529.GA25871@pvv.org> <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com> <200903052322.02098.markus.heidelberg@web.de> <200903052325.44648.markus.heidelberg@web.de> <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de> <7v4oy7szze.fsf@gitster.siamese.dyndns.org> <20090306114812.GA19534@pvv.org> <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de> <m3r61aisdo.fsf@localhost.localdomain>
 <7vr61ash8o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LflzG-0001eQ-Br
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZCGCEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 21:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZCGCEe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:04:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:46920 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752300AbZCGCEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 21:04:33 -0500
Received: (qmail invoked by alias); 07 Mar 2009 02:04:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 07 Mar 2009 03:04:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AA+dYZV6A73Z34hWU2ipixE0fbABrFcCVyFVnbQ
	FXVrWWairVh4zF
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vr61ash8o.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112503>

Hi,

On Fri, 6 Mar 2009, Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > ...
> >> Speaking of which, Steffen (who cannot reply right now, since he is 
> >> AFK for a while) had a patch to install "remote.<branch>.push = HEAD" 
> >> with clone and remote.  Would that be better?
> >
> > Errr... I thought that "remote.<remotename>.push = HEAD" works?
> >
> > But note that "remote.<name>.push = HEAD" (push current branch only) 
> > and "remote.<name>.push = :" (push matching branches, i.e. curent 
> > behavior) works only if you have remote configured... "git push <URL>" 
> > won't be affected, and people (probably) would want to either have 
> > 'nothing' as default, or/and be able to configure it to nothing, 
> > current, or matching (at least).
> 
> When you and Dscho contradict with each other, I seem to end up agreeing 
> with Dscho most of the time, but for this particular one, I completely 
> agree with you.

A word of caution.  Quite a few people (or at least a few people who write 
loud-enough emails) do not like me.  So even if you agree with my 
reasoning, you might want to point out that you are not agreeing with 
"Dscho", but rather mention that you happened to agree with a particular 
line of argument.

Certain people might mistake your being convinced by arguments for pure 
politics otherwise.

> I personally think Finn's suggested list is overengineered, and we 
> should start with only three: "nothing", "current" (aka HEAD), and 
> "matching". It is Ok to have a separate discussion to figure out what 
> other default behaviours are desireable, but I think that should come 
> after the dust settled from the transition, and more importantly, I 
> think the other kinds of fine-tuned behaviour needs to be per-remote, 
> and is not something the repository (or user) wide default push.default 
> can cover.

As long as the default does not change without warning, I am sure we are 
safe there.

Me mentioning Steffen's patch was more meant to kickstart people who 
missed the discussion into the intricacies, not to say that one or the 
other default makes most sense.

Personally, I am torn between the current default, which appears massively 
reasonable to me (probably due to being exposed to Git for quite some 
time), but I can also see why Steffen's approach appeals to some people.

Ciao,
Dscho
