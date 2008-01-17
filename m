From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Thu, 17 Jan 2008 10:18:36 -0500
Message-ID: <20080117151836.GA6123@coredump.intra.peff.net>
References: <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801161524390.13593@iabervon.org> <7vprw1mfpr.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170108440.17650@racer.site> <7vabn5mdz7.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170147350.17650@racer.site> <20080117144914.GA2816@coredump.intra.peff.net> <20080117150306.GB2816@coredump.intra.peff.net> <alpine.LSU.1.00.0801171511080.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 16:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFWWN-000054-JX
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 16:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbYAQPSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 10:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYAQPSj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 10:18:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3036 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbYAQPSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 10:18:38 -0500
Received: (qmail 4011 invoked by uid 111); 17 Jan 2008 15:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 17 Jan 2008 10:18:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2008 10:18:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801171511080.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70868>

On Thu, Jan 17, 2008 at 03:12:34PM +0000, Johannes Schindelin wrote:

> > @@ -586,7 +587,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
> >  	}
> >  
> >  	if (len < ecbdata->nparents) {
> > -		set = reset;
> >  		emit_line(reset, reset, line, len);
> >  		return;
> >  	}
> 
> I wonder what I wanted to achieve with that ;-)

Heh. I'm guessing it was supposed to be

  set = reset;
  emit_line(set, reset, line, len);

and you optimized the first line out. :)

-Peff
