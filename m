From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] builtin-commit: fix author date with --amend
 --author=<author>
Date: Mon, 12 Nov 2007 20:12:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122011540.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> 
 <Pine.LNX.4.64.0711111735100.4362@racer.site> <1194896334.2869.7.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfeB-0001Fc-ED
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXKLUMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbXKLUMX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:12:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:50382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751304AbXKLUMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:12:22 -0500
Received: (qmail invoked by alias); 12 Nov 2007 20:12:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 12 Nov 2007 21:12:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18b2Y9r05obXWAqffqv2/QMwTWMUPYGkH3sRMImq8
	OyIFDdbAKaXWex
X-X-Sender: gene099@racer.site
In-Reply-To: <1194896334.2869.7.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64697>

Hi,

On Mon, 12 Nov 2007, Kristian H?gsberg wrote:

> On Sun, 2007-11-11 at 17:35 +0000, Johannes Schindelin wrote:
> > When amending a commit with a new author, the author date is taken
> > from the original commit.
> 
> The new determine_author_info() should fix this.  There was a problem
> earlier that Junio pointed out and I sent a patch to update
> determine_author_info() to do the right thing for amend commits.  The
> test suite still pass without this patch, and if you look carefully a
> determine_author_info(), you can see it does the right thing:
> 
>   1) Default to getenv for name, email and date
> 
>   2) If a commit has been specified (-c, -C or --amend), we parse the
> author name, email and date from use_message_buffer, which holds the
> commit, overriding the values from getenv.
> 
>   3) If --author has be passed, we parse name and email from the
> argument and override whatever name and email the two previous steps
> came up with.
> 
> Then we add the author line to the commit buffer under construction
> based on these values.
> 
> I suggest we back this patch out.

I agree.

Ciao,
Dscho
