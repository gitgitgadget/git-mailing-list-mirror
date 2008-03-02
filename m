From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make the exit code of add_file_to_index actually
 useful
Date: Sun, 2 Mar 2008 15:57:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021555500.22527@racer.site>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqZz-0006vF-7Y
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbYCBP5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbYCBP5q
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:57:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:37005 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753441AbYCBP5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:57:46 -0500
Received: (qmail invoked by alias); 02 Mar 2008 15:57:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp033) with SMTP; 02 Mar 2008 16:57:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+guShRt0KgKZDcXFCcWhgWE+rjwGprbd28IliYki
	srTW24n2v3nM23
X-X-Sender: gene099@racer.site
In-Reply-To: <20080302154238.GD2973@steel.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75799>

Hi,

On Sun, 2 Mar 2008, Alex Riesen wrote:

> -			add_file_to_cache(path, verbose);
> +			if (add_file_to_cache(path, verbose))
> +				exit(1);

Does it really, really _have_ to be exit(1)?  I mean, now you block even 
the faintest chance that we can libify libgit.a by overriding die_routine.

A "return -1" might make _much_ more sense, too.

Ciao,
Dscho

