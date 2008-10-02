From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git commit hash clash prevention
Date: Thu, 2 Oct 2008 12:07:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021202420.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081002085358.GA5342@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:02:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlL0x-0002kb-P4
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbYJBKBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYJBKBR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:01:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:45696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753304AbYJBKBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:01:16 -0400
Received: (qmail invoked by alias); 02 Oct 2008 10:01:13 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 02 Oct 2008 12:01:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qc9sAnH/qszdNnjYPcjPFzPYrooDRGLD+j/slin
	F/hg7xKn86a+ZA
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081002085358.GA5342@lapse.rw.madduck.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97302>

Hi,

On Thu, 2 Oct 2008, martin f krafft wrote:

> the other day during a workshop on Git, one of the attendants asked 
> about the scenario when two developers, Jane and David, both working on 
> the same project, both create a commit and the two just so happen to 
> have the same SHA-1. I realise that the likelihood of this happening is 
> about as high as the chance of <insert witty joke here>, but it *is* 
> possible, isn't it? Even though this is thus somewhat academic, I am 
> still very curious about it.

It _is_ academic.  Did you already discuss the chance that your wife gives 
birth to a mouse?  I haven't done the maths yet, but I am pretty certain 
that this would be more likely than an unintended SHA-1 collision.

> What happens when David now pulls from Jane? How does Git deal with 
> this?

Basically, the commit that David has will not be overwritten.  So every 
commit referring to Jane's commit would point to David's in his 
repository.

But the more likely case (well, as likely goes) would be that either 
Jane's or David's object is actually a blob.  And Git would complain about 
a type mismatch then.

Ciao,
Dscho
