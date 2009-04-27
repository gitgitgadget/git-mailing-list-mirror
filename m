From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] daemon.c: fix segfault on OS X
Date: Mon, 27 Apr 2009 17:53:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904271753190.7741@intel-tinevez-2-302>
References: <49F4BD9F.6070709@googlemail.com> <7vy6tmbzj3.fsf@gitster.siamese.dyndns.org> <49F5BA55.3060606@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyT9I-0001F0-1X
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbZD0Pxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756217AbZD0Pxb
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:53:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:47037 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754899AbZD0Pxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 11:53:31 -0400
Received: (qmail invoked by alias); 27 Apr 2009 15:53:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 27 Apr 2009 17:53:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Pg11i7JfP94BH+8Q2lixVBatBZGDOBD2WGrTnu3
	1aIv1dfbzILrZE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49F5BA55.3060606@googlemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117681>

Hi,

On Mon, 27 Apr 2009, Benjamin Kramer wrote:

> On OS X (and maybe other unices), getaddrinfo(3) returns NULL
> in the ai_canonname field if it's called with an IP address for
> the hostname. We'll now use the IP address for the hostname if
> ai_canonname was NULL, this also matches the behaviour on Linux.
> 
> steps to reproduce:
> $ git daemon --export-all
> $ git clone git://127.0.0.1/frotz
> => git daemon's fork (silently) segfaults.
> 
> Remove the pointless loop while at it. There is only one iteration
> because of the break; on the last line and there are no continues.

Thanks, I indeed overlooked the "break;",
Dscho
