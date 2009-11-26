From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Thu, 26 Nov 2009 01:04:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911260059040.4985@pacific.mpi-cbg.de>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0911260032410.4985@pacific.mpi-cbg.de> <7vvdgyp3zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRmK-00029J-Lh
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbZKYX75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 18:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759585AbZKYX75
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:59:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:50869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759541AbZKYX74 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:59:56 -0500
Received: (qmail invoked by alias); 26 Nov 2009 00:00:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 26 Nov 2009 01:00:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qmZZqlC3qhUNNQoBo8yKPpyLC0ykad4v9HQG9YR
	ArBGOKHRQtwbXE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdgyp3zn.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133709>

Hi,

On Wed, 25 Nov 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This would break spectacularly in MSys.
> 
> How?  If that is the case wouldn't --full-tree break Msys the same way?

If you want to specify an argument on MSys that starts with a slash, you 
have to provide double slashes, otherwise it gets expanded to the Windows 
path (prefixing with the absolute path of the MSys root).

But this introduces yet another inconcistency: using double slashes 
everywhere else does not work.

Hopefully you see the real reason why it breaks down?  The reason is that 
you try to re-interpret something in a special way that means something 
different.  A path starting with a slash simply does not mean "the root of 
the project".  It means "the root of the file system".

Ciao,
Dscho
