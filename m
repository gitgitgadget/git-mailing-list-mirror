From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git commit hash clash prevention
Date: Thu, 2 Oct 2008 17:39:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021735410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081002085358.GA5342@lapse.rw.madduck.net> <m3prmjqeq8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:34:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlQC2-0002g3-Ge
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbYJBPdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYJBPdH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:33:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:58954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752461AbYJBPdF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:33:05 -0400
Received: (qmail invoked by alias); 02 Oct 2008 15:33:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 02 Oct 2008 17:33:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sRlRQmuTs5pgX9Su/mJ6UM3+mzvVmF/KnaKd7EY
	KaRvnqcnlTfh8M
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <m3prmjqeq8.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97357>

Hi,

On Thu, 2 Oct 2008, Jakub Narebski wrote:

> martin f krafft <madduck@madduck.net> writes:
> 
> > the other day during a workshop on Git, one of the attendants asked
> > about the scenario when two developers, Jane and David, both working
> > on the same project, both create a commit and the two just so happen
> > to have the same SHA-1. I realise that the likelihood of this
> > happening is about as high as the chance of <insert witty joke
> > here>, but it *is* possible, isn't it? Even though this is thus
> > somewhat academic, I am still very curious about it.
> > 
> > What happens when David now pulls from Jane? How does Git deal with
> > this?
> 
> Cannot happen in practice.
> 
> But just in case git trusts object it already has in repository over
> object which just got fetched (or pushed).

Oh, maybe the most important part: both David and Jane would have to 
rewrite their respective history, changing the respective commits in a 
simple way (such as adding a space to the first line of the commit message 
or some such).  Then, Git is changed to not accept that particular SHA-1 
(we'd introduce a black "list").

All in all, it would be like a borked commit; not really easy to fix, but 
the world would not stop turning because of it.

Ciao,
Dscho
