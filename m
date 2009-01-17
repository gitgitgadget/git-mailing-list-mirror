From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs
 twice
Date: Sat, 17 Jan 2009 20:29:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOGvj-0002Ij-BO
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762179AbZAQT3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761364AbZAQT3H
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:29:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:45218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759875AbZAQT3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:29:06 -0500
Received: (qmail invoked by alias); 17 Jan 2009 19:29:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 17 Jan 2009 20:29:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+b5EEbXyebnAAjYaODAhxoPOlGqVuFtVzWOzFI8P
	l6bMSP7TxKCdwP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljt97nld.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106095>

Hi,

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Instead of traversing them twice, we just build a list of branch switches,
> > pick the one we're interested in, and free the list again.
> 
> Isn't the code keeping them all in core, or am I reading the patch wrong?
> 
> If you know that you are interested in the nth-from-the-last switch, and
> if you are reading from the beginning, you would need to keep at most n 
> last switches you have seen in core, wouldn't you?  

That is correct.  But this is such a highly uncritical code path that I'd 
like to keep this simple rather than fast.

Ciao,
Dscho
