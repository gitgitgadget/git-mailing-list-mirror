From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 20:35:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806182030200.6439@racer>
References: <1213796224-995-1-git-send-email-michael@ndrix.org> <m37icmol6y.fsf@localhost.localdomain> <alpine.DEB.1.00.0806181756540.6439@racer> <200806181952.02048.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Junio Hamano <gitster@pobox.com>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:38:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K93Tw-0006uH-TP
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbYFRThS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbYFRThS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:37:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:59037 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbYFRThQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:37:16 -0400
Received: (qmail invoked by alias); 18 Jun 2008 19:37:14 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp018) with SMTP; 18 Jun 2008 21:37:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Z0NI3UaTZPH7gwCOGJZGGVmadG8FqhdKKu72INr
	Jb8/uWviZ8Dgli
X-X-Sender: gene099@racer
In-Reply-To: <200806181952.02048.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85402>

Hi,

On Wed, 18 Jun 2008, Jakub Narebski wrote:

> On Wed, 18 Jun 2008, Johannes Schindelin wrote:
>
> > BTW I think it is not nice at all how the dependency hell with Git.pm 
> > is made worse recently.
> 
> It is not dependency for Git.pm, but for Git.pm TEST.

So?  Why do you want to break the _test_ on those machines where you need 
them most?  We _know_ that a release from Junio works fine on Linux.

> > It is fascinating through how much _pain_ we go with the shell scripts 
> > to maintain portability, even with _very_ old or obscure systems (see 
> > the SCO server patches that came in not long ago!), and just walk over 
> > that portability when it comes to Perl...
> 
> And I pointed out how it could be resolved (use 5.8 specific feature, or 
> IO::String, or skip tests).

I have to point out that the platforms I was speaking of are not know to 
make upgrading as easy as Linux.  And some of them _do_ come with pretty 
old perl.  And yes, I had this exact issue (remember when I worked on 
removing Git's dependency on Python?  That was it.  Not enough quota.  
Uncooperative admin.  Desperate need for a sensible SCM).

In any case, I have to reiterate my point: breaking 
backwards-compatibility for _no_ good reason is wrong.  I have not looked 
at the patch in question, but I seriously doubt that this is the easiest, 
most elegant (and yes, backwards-compatible) solution.

Typically, it is not a good sign when you _require_ newer and newer 
features and versions of components you use.

Whatever,
Dscho
