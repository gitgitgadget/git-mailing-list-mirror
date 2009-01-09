From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] make diff --color-words customizable
Date: Fri, 9 Jan 2009 06:22:39 -0500
Message-ID: <20090109112239.GA11466@coredump.intra.peff.net>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch> <20090109095300.GA4099@coredump.intra.peff.net> <alpine.DEB.1.00.0901091215590.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 12:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLFTJ-0004g6-H6
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 12:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbZAILWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbZAILWm
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 06:22:42 -0500
Received: from peff.net ([208.65.91.99]:49446 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbZAILWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 06:22:41 -0500
Received: (qmail 18283 invoked by uid 107); 9 Jan 2009 11:23:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 06:23:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 06:22:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901091215590.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105007>

On Fri, Jan 09, 2009 at 12:18:37PM +0100, Johannes Schindelin wrote:

> > It's a per-file thing, so probably in the diff driver that is triggered 
> > via attributes. See userdiff.[ch]; you'll need to add an entry to the 
> > userdiff_driver struct. You can look at the funcname pattern stuff as a 
> > template, as this is very similar.
> 
> I am not sure I would want that in the config or the attributes.  For me, 
> it always has been a question of "oh, that LaTeX diff looks ugly, let's 
> see what words actually changed".
> 
> Only rarely did I wish for a different word boundary detection algorithm.
> 
> So I'd rather have an alias than a config/attribute setting.

I am not sure what you are saying.

If it is "I do not want color-words on by default for LaTeX", then I
agree. I meant merely that _if_ color-words is enabled, the word
boundaries would be taken from the diff driver config (just like we do
for matching the funcname header).

If it is "I want to specify the color-words boundary on a per-run basis
rather than a per-file basis", then I want the opposite. However, there
is no reason that both cannot be supported (with command line or
environment taking precedence over what's in the config).

-Peff
