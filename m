From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 23:18:00 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803102316240.4741@racer.site>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site> <200803102232.13727.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org, gitster@poxbox.com
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Mar 10 23:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYqKi-0001c9-1p
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 23:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbYCJWSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 18:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYCJWSE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 18:18:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:47128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751107AbYCJWSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 18:18:01 -0400
Received: (qmail invoked by alias); 10 Mar 2008 22:17:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 10 Mar 2008 23:17:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6ZfAHogW6kavFyuVk1yI1AhRmaP+jKUfeGea9nB
	HUbaIewH8JIfhL
X-X-Sender: gene099@racer.site
In-Reply-To: <200803102232.13727.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76762>

Hi,

On Mon, 10 Mar 2008, Johannes Sixt wrote:

> On Monday 10 March 2008 21:42, Johannes Schindelin wrote:
> > For some reason, the construct
> >
> > 	sh -c "$0 \"$@\"" <editor> <file>
> >
> > does not pick up quotes in <editor> as expected.  So replace $0 with
> > <editor>.
> 
> No surprise. It must be
> 
> 	sh -c '"$0" "$@"' <editor> <file>
> 
> Note the extra quotes around $0.
> 
> >  			args[i++] = "sh";
> >  			args[i++] = "-c";
> > -			args[i++] = "$0 \"$@\"";
> > +			args[i++] = arg0.buf;
> 
> IOW:
> 
> +			args[i++] = "\"$0\" \"$@\"";

Isn't this wrong? What would this do with a core.editor like this:

[core]
	editor = this-editor --with-this --option

Hmm?

Ciao,
Dscho
