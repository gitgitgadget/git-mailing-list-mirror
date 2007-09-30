From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] fork/exec removal series
Date: Sun, 30 Sep 2007 22:43:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302242100.28395@racer.site>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0709302212160.28395@racer.site> <200709302334.37129.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:45:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6b4-0002JQ-Rm
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbXI3Voe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbXI3Voe
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:44:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:51601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752847AbXI3Vod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:44:33 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:44:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 30 Sep 2007 23:44:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EneJU6uqEgZDwrjWPRBvQO6/GNDSyFCpqkcnzG8
	6At/TDKb2OHhzh
X-X-Sender: gene099@racer.site
In-Reply-To: <200709302334.37129.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59576>

Hi,

On Sun, 30 Sep 2007, Johannes Sixt wrote:

> On Sunday 30 September 2007 23:14, Johannes Schindelin wrote:
>
> > Is there more than the case I introduced with shallow clones?
> 
> I don't know which one you are refering to.

The rev-list one in upload-pack.

> These cases I hope to be able to treat as "coroutine":
> 
> - sideband demultiplexer in builtin-fetch-pack.c
> - internal rev-list in upload-pack
> - the two-way pipe handling in convert.c and builtin-upload-archive.c
> 
> There are probably more in daemon.c and imap-send.c.
> 
> BTW, the convert.c case (apply_filter) is most interesting for me, since I 
> have a real-world use-case for a clean-filter.

Calling it coroutine is interesting... But yes, I agree that these three 
cases cannot be handled otherwise.

Ciao,
Dscho
