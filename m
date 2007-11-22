From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-commit: Include the diff in the commit
	message when verbose.
Date: Thu, 22 Nov 2007 06:13:14 -0500
Message-ID: <20071122111314.GE10389@sigill.intra.peff.net>
References: <1195700089-8326-1-git-send-email-krh@redhat.com> <Pine.LNX.4.64.0711221049350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9zy-0004vz-H8
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXKVLNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXKVLNR
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:13:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1259 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXKVLNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:13:16 -0500
Received: (qmail 22433 invoked by uid 111); 22 Nov 2007 11:13:15 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:13:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:13:14 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711221049350.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65789>

On Thu, Nov 22, 2007 at 10:52:04AM +0000, Johannes Schindelin wrote:

> > +	/* Sigh, the entire diff machinery is hardcoded to output to
> > +	 * stdout.  Do the dup-dance...*/
> 
> I wonder how much effort it would be to change that.  Not that it would 
> help too much, since we want the output in a strbuf anyway.

An "emit"-type callback would be nice and elegant. The biggest trick is
that there are a lot of formatting calls, so you'd need your callback
signature to be a variadic function. But it's probably do-able.

-Peff
