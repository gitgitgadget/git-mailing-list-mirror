From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Mon, 26 Jan 2009 00:29:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260026310.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <alpine.DEB.1.00.0901251622310.14855@racer> <7vwscjceec.fsf@gitster.siamese.dyndns.org> <200901252303.29204.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-2022-JP?Q?=1B$B$i$$$7$J$J$3=1B=28J?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:30:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRER5-00018y-9s
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbZAYX3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbZAYX3P
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:29:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:34013 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750789AbZAYX3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:29:14 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:29:12 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp001) with SMTP; 26 Jan 2009 00:29:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EH3JcR86EY8CyZeR4gPQpFIIERvdmkzlCPaPhiU
	HFECNZo2XXURrx
X-X-Sender: gene099@racer
In-Reply-To: <200901252303.29204.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107128>

Hi,

On Sun, 25 Jan 2009, Jakub Narebski wrote:

> On Sun, 25 Jan 2009, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > So maybe I answered my question myself:
> > >
> > > 	merge parents $sha1 [$sha1...] original $sha1 $msg
> > 
> > When you are reparenting, how would original commit get in the 
> > picture? You wouldn't want the resulting merge to claim it merged X 
> > (which would be what's in original's commit log) when in fact it now 
> > merged Y because the user reparented it, would you?
> 
> Well, the subject part of merge (with merged branches names) shouldn't, 
> I guess, change. The summary (shortlog) part might, or perhaps even 
> should following rewrite (if it was present here).
> 
> But there is one issue I am wondering about: could we pick up _merge_ 
> _resolution_? So if you have evil merge, and the change is for example 
> splitting commits without visible final changes, or just changing some 
> commit message before merge, it would get recreated without problems?

Nanako had a script at some stage; I would prefer an subcommand to "git 
rerere" which reconstructs the whole merge in-memory, and then records the 
conflict's resolution.

However, I really think you are getting ahead of yourself.  That is by no 
means something we want to have in rebase -p.  And even then, it would 
have to be non-automatic, i.e the user has to check the resolution.

We _know_ that git rerere does a fine job most of the time, almost all of 
the exceptions to be found when working with rebase -i extensively, as you 
are prone to take different decisions during development.

Ciao,
Dscho
