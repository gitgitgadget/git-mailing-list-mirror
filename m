From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/11] test-chmtime: work around Windows limitation
Date: Mon, 1 Jun 2009 11:00:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906011058120.26154@pacific.mpi-cbg.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <7vab4smmab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 10:59:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB3N9-00059X-Hl
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 10:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbZFAI7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 04:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbZFAI7u
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 04:59:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:60577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753187AbZFAI7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 04:59:50 -0400
Received: (qmail invoked by alias); 01 Jun 2009 08:59:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 01 Jun 2009 10:59:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fC0x0nWafr3SGp2Zq6ZcKobBErH7tSRh6T96epI
	vGmCQZb3+rsqT4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vab4smmab.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120452>

Hi,

On Mon, 1 Jun 2009, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Windows has problems changing the mtime when the file is write protected,
> > even by the owner of said file.
> >
> > Add a Windows-only workaround to change the mode if necessary before
> > trying to change the mtime.
> 
> I'll queue this as-is for now, but shouldn't the code remember the
> original mode and change it back?

Hmm, good point.  As I mentioned in another mail, though, I cannot access 
any Windows machine to fix this issue now, sorry.

Not changing the mode back _might_ paper over another issue: if the files 
are deleted later, that mode change might mean that the deletion now 
succeeds, and fixing test-chmtime may make it fail again.  Not sure, 
though.

Ciao,
Dscho
