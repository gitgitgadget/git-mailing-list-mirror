From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 16:57:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041657210.4046@racer.site>
References: <20070603223727.GA16637@admingilde.org> <20070604053443.GA15148@moooo.ath.cx>
 <20070604072707.GE16637@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvEym-0000LY-UT
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbXFDP7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbXFDP7n
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:59:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:48573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756193AbXFDP7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 11:59:42 -0400
Received: (qmail invoked by alias); 04 Jun 2007 15:59:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 04 Jun 2007 17:59:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wYfV+u0xw1eeHcRBNTD97JKCl4eFbfnBYwS/5DJ
	lCeJ3BSqyfILRM
X-X-Sender: gene099@racer.site
In-Reply-To: <20070604072707.GE16637@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49110>

Hi,

On Mon, 4 Jun 2007, Martin Waitz wrote:

> Do you think the approach is ok?

I actually would like it more if the calling program did the interpolation 
itself.

So, for example if you want a script to access whatever.my.url, and want 
to allow to interpolate any environment variable, why not

	url=$(eval $(git config whatever.my.url))

I am just hesitant to change the existing behaviour, and possibly 
introduce weird breakages. (There could even be some unwanted env leakages 
in programs like gitweb...)

Ciao,
Dscho
