From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Thu, 17 Jan 2008 15:12:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171511080.5731@racer.site>
References: <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org> <alpine.LNX.1.00.0801152256480.13593@iabervon.org> <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0801161524390.13593@iabervon.org> <7vprw1mfpr.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170108440.17650@racer.site> <7vabn5mdz7.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170147350.17650@racer.site>
 <20080117144914.GA2816@coredump.intra.peff.net> <20080117150306.GB2816@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 16:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFWQm-0006Dl-Na
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 16:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYAQPMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 10:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYAQPMm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 10:12:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:42808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751581AbYAQPMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 10:12:41 -0500
Received: (qmail invoked by alias); 17 Jan 2008 15:12:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 17 Jan 2008 16:12:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19F9MkvskRF+LzT6JAAHWiSz2/B+DTNGRD5F4cp45
	8d122kinqNVzb6
X-X-Sender: gene099@racer.site
In-Reply-To: <20080117150306.GB2816@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70866>

Hi,

On Thu, 17 Jan 2008, Jeff King wrote:

> On Thu, Jan 17, 2008 at 09:49:14AM -0500, Jeff King wrote:
> 
> > Hmm. I happen to set my "meta" color to something a little less 
> > attention-grabbing (magenta), and I find the alternate coloring to be 
> > a nice visual indicator of "nothing happened on this line". I can see 
> > how bold would be very distracting, though. Perhaps there should be a 
> > color.diff.unimportant?
> 
> BTW, here is the fix to at least color it as plain (it is a little 
> larger than the one line it needs to be because it cleans up the 
> variable name "set", which is what caused this confusion in the first 
> place).

Ah, that explains it!  Your patch looks good to me.

Thanks,
Dscho

P.S.:

> @@ -586,7 +587,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	}
>  
>  	if (len < ecbdata->nparents) {
> -		set = reset;
>  		emit_line(reset, reset, line, len);
>  		return;
>  	}

I wonder what I wanted to achieve with that ;-)
