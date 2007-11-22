From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] Added config_default($key, $default) to Git.pm
Date: Thu, 22 Nov 2007 07:14:02 -0500
Message-ID: <20071122121402.GF12913@sigill.intra.peff.net>
References: <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045552.30ca55c2@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAwt-0007bC-6W
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXKVMOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbXKVMOI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:14:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1259 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbXKVMOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:14:07 -0500
Received: (qmail 23435 invoked by uid 111); 22 Nov 2007 12:14:03 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 07:14:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 07:14:02 -0500
Content-Disposition: inline
In-Reply-To: <20071122045552.30ca55c2@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65814>

On Thu, Nov 22, 2007 at 04:55:52AM -0600, Dan Zwell wrote:

> Method returns a configuration value if defined, or the default
> value that was passed in, otherwise.
> 
> The main purpose of this method is to allow the empty string to
> be a valid configuration option, and to replace the following
> construct:
> 
> $val = $repo->config('my.key') || $default_val

The config subroutine does not currently take a third argument. Is there
a particular reason not to make $repo->config('my.key', $default_val)
the equivalent of config_default?

> +in situations where the empty string is an acceptable return value.
> +This method may also be called in a vector context, when expecting

The term "vector context" is not commonly used. Most of the perl
documentation calls it "list context" (try googling for each and seeing
the hit numbers).

-Peff
