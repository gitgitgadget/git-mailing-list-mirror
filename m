From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 01:55:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706190151160.4059@racer.site>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 02:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0S0I-0008La-IS
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 02:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763416AbXFSAz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 20:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763900AbXFSAz3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 20:55:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:39777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763137AbXFSAz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 20:55:28 -0400
Received: (qmail invoked by alias); 19 Jun 2007 00:55:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 19 Jun 2007 02:55:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AQrhpqsLAvjRydtndYVx5aEmVMrUhoGg8TDfKOS
	XFDUpePCm1VLZr
X-X-Sender: gene099@racer.site
In-Reply-To: <11821227322913-git-send-email-frank@lichtenheld.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50431>

Hi,

On Mon, 18 Jun 2007, Frank Lichtenheld wrote:

>  Note the FIXME. Does anyone remember the reason why --get-regexp
>  and --list use different output format?

AFAIK --list was meant as a replacement to git-var --list. Thus, it had to 
behave exactly the same.

As for the FIXME: If you have a config like this:

	[core]
		Some = where
		over
		the = core.rainbow

git-config -z would output something like this:

	core.some\0where\0core.over\0core.the\0core.rainbow\0

Right?

As you can see, it is quite hard for a parser to find out what is key, and 
what is value. That FIXME is _exactly_ about this dilemma.

IIRC I stated once that -z should output a value of "true" for these 
cases, since they only make sense as booleans. But AFAIR nothing 
conclusive came out of that thread.

Ciao,
Dscho
