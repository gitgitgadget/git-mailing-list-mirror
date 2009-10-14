From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 12:33:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910141233060.4985@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <20091014050851.GE31810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 12:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1AM-00064x-EQ
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbZJNKbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 06:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbZJNKba
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:31:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:60009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932553AbZJNKba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:31:30 -0400
Received: (qmail invoked by alias); 14 Oct 2009 10:30:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 14 Oct 2009 12:30:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6j9J62WG6pw1Ouc15e/c1dR5StTcIka2L9VKHen
	VJZk7Akdj1aTEZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20091014050851.GE31810@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130278>

Hi,

On Wed, 14 Oct 2009, Jeff King wrote:

> On Wed, Oct 14, 2009 at 12:44:34AM -0400, Daniel Barkalow wrote:
> 
> > +char *get_detached_head_string(void)
> > +{
> > +	char *filename = git_path("DETACH_NAME");
> > +	struct stat st;
> > +	if (stat(filename, &st) || !S_ISREG(st.st_mode))
> > +		return NULL;
> > +	struct strbuf buf = STRBUF_INIT;
> > +	strbuf_read_file(&buf, filename, st.st_size);
> > +	strbuf_trim(&buf);
> > +	return strbuf_detach(&buf, 0);
> > +}
> 
> Would it hurt to tuck this information into HEAD itself, as we already
> put arbitrary text into FETCH_HEAD?

AFAIR we still remember HEAD to be a symlink.

Ciao,
Dscho
