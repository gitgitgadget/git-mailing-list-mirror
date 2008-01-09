From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Decompression speed: zip vs lzo
Date: Wed, 9 Jan 2008 23:31:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801092328580.31053@racer.site>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 00:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCkOt-00088M-8X
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 00:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbYAIXb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 18:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbYAIXb1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 18:31:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:39010 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756977AbYAIXbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 18:31:25 -0500
Received: (qmail invoked by alias); 09 Jan 2008 23:31:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 10 Jan 2008 00:31:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+6+J/5l1+PwaHbz+YxD9Kd5ewR7MGuQb6dvn7lA
	c4kESdI5dr8EGd
X-X-Sender: gene099@racer.site
In-Reply-To: <47855765.9090001@vilain.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70027>

Hi,

On Thu, 10 Jan 2008, Sam Vilain wrote:

> I think to go forward this would need a prototype and benchmark figures 
> for things like "annotate" and "fsck --full" - but bear in mind it would 
> be a long road to follow-up to completion, as repository compatibility 
> would need to be a primary concern and this essentially would create a 
> new pack type AND a new *object* type.

No new object type.  Why should it?  But it has to have a config variable 
which says what type of packs/loose objects it has (and you will not be 
able to mix them).

> Not really worth it IMHO - gzip is already fast enough on even the most 
> modern processor these days.

I agree that gzip is already fast enough.

However, pack v4 had more goodies than just being faster; it also promised 
to have smaller packs.  And pack v4 would need to have the same 
infrastructure of repacking if the client does not understand v4 packs.

Ciao,
Dscho
