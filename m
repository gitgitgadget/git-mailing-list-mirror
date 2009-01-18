From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date: Sun, 18 Jan 2009 20:11:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182010380.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org>
 <alpine.DEB.1.00.0901182005230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:13:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOd4Z-00010U-TQ
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbZARTLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbZARTLO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:11:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:44972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753053AbZARTLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:11:12 -0500
Received: (qmail invoked by alias); 18 Jan 2009 19:11:09 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 18 Jan 2009 20:11:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/k8Nhl0Frk0K9Ghw1nS8phowidKNsxtWFZvuzIea
	VzE1LtCwa208hu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901182005230.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106260>

Hi,

On Sun, 18 Jan 2009, Johannes Schindelin wrote:

> On Sun, 18 Jan 2009, Mike Hommey wrote:
> 
> > diff --git a/transport.c b/transport.c
> > index 56831c5..6919ff1 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -508,6 +508,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
> >  		free(ref);
> >  	}
> >  
> > +	http_cleanup();
> > +	free(refs_url);
> >  	return refs;
> >  }
> 
> You cannot http_cleanup() here, as http-push calls that function, but 
> continues to want to use curl.

Worse, a http clone will hit the same issue.

Ciao,
Dscho
