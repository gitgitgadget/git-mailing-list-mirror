From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 12:12:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801101210031.31053@racer.site>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>  <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>  <47855765.9090001@vilain.net>  <alpine.LSU.1.00.0801092328580.31053@racer.site>  <alpine.LFD.1.00.0801092234130.3054@xanadu.home> 
 <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com> <e5bfff550801100345i20cb3030mf04a11d610fda6f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 13:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCwHO-0002Hq-Vz
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 13:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYAJMMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 07:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYAJMMa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 07:12:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:53922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752918AbYAJMM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 07:12:29 -0500
Received: (qmail invoked by alias); 10 Jan 2008 12:12:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 10 Jan 2008 13:12:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aRzROxvva2zWGNHb/X/AgY35VTsy3YOXF4TDOO6
	tVgZevJR5WDk1l
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550801100345i20cb3030mf04a11d610fda6f7@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70063>

Hi,

On Thu, 10 Jan 2008, Marco Costalba wrote:

> - Remove #include <zlib.h> from cache.h and substitute with #include
> "compress.h"

No.  We will always need zlib for compatibility.  You cannot just replace 
zlib usage in git.

> - Add #include <zlib.h> where it is "really" intended as example 
> archive-zip.c

We have a long tradition to have the system includes in cache.h.

Besides, if you have "compress.h" included in cache.h, which in turn has 
to include "zlib.h", what is the use of putting it also in archive-zip.c?

Ciao,
Dscho
