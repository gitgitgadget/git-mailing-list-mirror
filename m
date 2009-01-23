From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 21:05:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901232100020.21467@intel-tinevez-2-302>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
 <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com> <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de> <20090123165549.GI21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 21:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQSJS-0007FK-1N
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 21:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZAWUGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 15:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbZAWUGK
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 15:06:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:60458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752276AbZAWUGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 15:06:09 -0500
Received: (qmail invoked by alias); 23 Jan 2009 20:06:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 23 Jan 2009 21:06:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+m/pFtz0imeuPQc5jgrZhJ3XL1lklNagrtbquL9E
	zltjGD4NMpulda
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090123165549.GI21473@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106909>

Hi,

On Fri, 23 Jan 2009, Miklos Vajna wrote:

> On Fri, Jan 23, 2009 at 04:20:34AM +0100, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
>
> > But then, scripts have no business cloning repositories (fetching, 
> > yes.  But cloning?)
> 
> I think portals like repo.or.cz may do it.

"git grep git.clone" in repo.git suggests that only clonecheck.sh uses it, 
which is not called anywhere.

But more generally, the same should apply to such scripts as to human 
users: HTTP _is_ 2nd class, and the fetch _could_ succeed later.

> Isn't setting errno (or similar variable) in the HTTP code an option? 
> Then we could see why the transport failed and make a difference between 
> "network error" and "no refs found".

I'd rather see the HTTP code path taken by transport.c _fail_ (i.e. die()) 
when there is some sort of connection error.

Ciao,
Dscho
