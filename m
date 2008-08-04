From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 4 Aug 2008 12:08:29 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808041208060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org>
 <4896D19C.6040704@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 12:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPww9-0007AZ-JV
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 12:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYHDKEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 06:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbYHDKEG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 06:04:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754548AbYHDKEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 06:04:04 -0400
Received: (qmail invoked by alias); 04 Aug 2008 10:04:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 04 Aug 2008 12:04:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tSo1oTg2tyqcgNnlgyf1xTUUsYh4SObHgzkCJ28
	4JyXqdoBjVdCjt
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <4896D19C.6040704@dawes.za.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91335>

Hi,

On Mon, 4 Aug 2008, Rogan Dawes wrote:

> Shawn O. Pearce wrote:
> 
> > Perhaps the smart server detection is something like:
> > 
> >  Smart Server Detection
> >  ----------------------
> > 
> >  To detect a smart (Git-aware) server a client sends an
> >  empty POST request to info/refs; if a 200 OK response is
> >  received with the proper content type then the server can
> >  be assumed to be Git-aware, and the result contains the
> >  current info/refs data for that repository.
> > 
> > C: POST /repository.git/info/refs HTTP/1.0
> > C: Content-Length: 0
> > 
> > S: HTTP/1.0 200 OK
> > S: Content-Type: application/x-git-refs
> > S:
> > S:95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
> > 
> > Then clients should just attempt this POST first before issuing
> > a GET info/refs.  Non Git-aware servers will issue an error code,
> > and the client can retry with a standard GET request, and assume
> > the server isn't a newer style.
> > 
> 
> I don't understand why you would want to keep the commands in the URL 
> when you are doing a POST?

Caching.

Hth,
Dscho
