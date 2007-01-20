From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SEGV in git-apply
Date: Sat, 20 Jan 2007 03:14:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200312000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070120014851.GF5231@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 03:14:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H85kq-00066n-MZ
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 03:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbXATCOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 21:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbXATCOs
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 21:14:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:36667 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932844AbXATCOr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 21:14:47 -0500
Received: (qmail invoked by alias); 20 Jan 2007 02:14:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 20 Jan 2007 03:14:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20070120014851.GF5231@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37250>

Hi,

On Sat, 20 Jan 2007, Martin Waitz wrote:

> Program received signal SIGSEGV, Segmentation fault.
> 0x080500fa in apply_patch (fd=5, filename=0xbf821b4d "/tmp/404241.patch",
>     inaccurate_eof=<value optimized out>) at builtin-apply.c:2504
> 2504                    if (pathlen <= prefix_length ||

It seems that the culprit is not this line (you have an optimized binary, 
so that is expected).

My guess is that your patch does not contain a new name, neither an old 
name.

It could also be that the filename has length 0.

But without that patch I cannot tell.

Ciao,
Dscho
