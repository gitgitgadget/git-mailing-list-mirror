From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno) to die()
Date: Sat, 6 Jun 2009 23:17:22 +0200
Message-ID: <200906062317.22172.j6t@kdbg.org>
References: <cover.1244299302.git.trast@student.ethz.ch> <200906062236.42858.j6t@kdbg.org> <200906062256.34074.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD3Gg-0005qi-3P
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 23:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbZFFVRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 17:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbZFFVRW
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 17:17:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46709 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbZFFVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 17:17:21 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7B033A7ECA;
	Sat,  6 Jun 2009 23:17:22 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 45CA43FFB6;
	Sat,  6 Jun 2009 23:17:22 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200906062256.34074.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120939>

On Samstag, 6. Juni 2009, Thomas Rast wrote:
> Johannes Sixt wrote:
> > On Samstag, 6. Juni 2009, Thomas Rast wrote:
> > > +
> > > +	va_end(params);
> >
> > This va_end should better be before die().
>
> Not that I object to changing it, but out of curiosity, what do I
> break by putting it after?

I don't know, and I suspect that in practice nothing breaks. It's just a 
matter of style: va_start acquires a "resource", and va_end releases it, and 
you should do that as soon as possible after the "resource" is no longer 
needed.

-- Hannes
