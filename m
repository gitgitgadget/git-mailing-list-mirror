From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision: allow selection of commits that do not match
 a pattern
Date: Sat, 7 Jul 2007 17:27:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071724410.4093@racer.site>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 07 18:34:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7DF2-0006MH-Sj
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 18:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbXGGQeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbXGGQeg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 12:34:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:49324 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751294AbXGGQeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 12:34:36 -0400
Received: (qmail invoked by alias); 07 Jul 2007 16:34:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 07 Jul 2007 18:34:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KiwAQwWxKJ8fgiEBkRKEjL7yrzegYX+RYRCSAM9
	sD0X1GiyTfAXGv
X-X-Sender: gene099@racer.site
In-Reply-To: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51821>

Hi,

On Sat, 7 Jul 2007, Sven Verdoolaege wrote:

> We do this by maintaining two lists of patterns, one for
> those that should match and one for those that should not match.

I suspect that with this patch,

	git rev-list --not --grep bugfix HEAD

does not work as expected. Why? Because the --not is heeded when 
interpreting "HEAD". And that is confusing, because you use --not for two 
completely unrelated things.

Why not make "git rev-list --grep '!bugfix' HEAD" work?

Yes, you would have to have a special exception that the prefix "!!" 
actually matches an exclamation mark, but I'd be willing to live with 
that.

Ciao,
Dscho
