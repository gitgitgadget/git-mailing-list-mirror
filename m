From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 15:15:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271510060.28586@racer.site>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org>
 <vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org>
 <Pine.LNX.4.64.0708271440500.28586@racer.site> <866431rser.fsf@lola.quinscape.zz>
 <vpqr6lpvzqc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPfLD-0003Qz-Qy
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 16:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337AbXH0ONO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756176AbXH0ONN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 10:13:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:33434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755847AbXH0ONL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 10:13:11 -0400
Received: (qmail invoked by alias); 27 Aug 2007 14:13:10 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp046) with SMTP; 27 Aug 2007 16:13:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AWglRzVTA+p4WtrbehxBl7H6sOED5tJUcivxOH7
	BKZBuI+BAVTvaN
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqr6lpvzqc.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56842>

Hi,

On Mon, 27 Aug 2007, Matthieu Moy wrote:

> David Kastrup <dak@gnu.org> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> On Mon, 27 Aug 2007, Mike Hommey wrote:
> >>
> >>> BTW, wouldn't it be more efficient to store the odf files unzipped ?
> >>
> >> Efficient how?  Speed-wise: no.  Space-wise: yes.
> >
> > Huh?  At least the "Space-wise: yes" seems rather nonsensical.
> 
> I don't know enough about git delta-compression and OpenDocument, but 
> git has better chance to efficiently delta-compress different versions 
> of the document if they're not compressed themselves.

A standalone zip archive (which is what an .odt file is, with a defined 
file structure) cannot be as efficient in compressing text, especially if 
it is versioned text with relatively few differences between versions, as 
delta compression.

So yes, you guessed the explanation (which I omitted) correctly.

As for the speed wise: I doubt that unpacking and then repacking can be 
more efficient than not doing it -- even if the files are transmitted via 
network.  (Remember: blobs are stored compressed, be they in a pack, or 
loose.)

Ciao,
Dscho
