From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 02:53:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTeq-00007R-D7
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 02:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758195Ab0BNBr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 20:47:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:49803 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758146Ab0BNBrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 20:47:25 -0500
Received: (qmail invoked by alias); 14 Feb 2010 01:47:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 14 Feb 2010 02:47:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18s3MBIkessuBZl9vrwH5/dMzkTn4QgDD/zJl3SMp
	6sjZNl79Z6p3vi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100214011812.GA2175@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139879>

Hi,

On Sun, 14 Feb 2010, Dmitry Potapov wrote:

> +	if (strbuf_read(&sbuf, fd, 4096) >= 0)

How certain are you at this point that all of fd's contents fit into your 
memory?

And even if you could be certain, a hint is missing that strbuf_read(), 
its name notwithstanding, does not read NUL-terminated strings. Oh, and 
the size is just a hint for the initial size, and it reads until EOF. That 
has to be said in the commit message.

Ciao,
Dscho
