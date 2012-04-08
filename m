From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 00:48:25 -0400
Message-ID: <20120408044825.GA4296@sigill.intra.peff.net>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 06:48:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGk3F-0000Og-PI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 06:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab2DHEs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 00:48:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54197
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab2DHEs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 00:48:29 -0400
Received: (qmail 31554 invoked by uid 107); 8 Apr 2012 04:48:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 00:48:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 00:48:25 -0400
Content-Disposition: inline
In-Reply-To: <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194976>

On Sat, Apr 07, 2012 at 09:25:29PM -0700, Junio C Hamano wrote:

> Bash has a special case code to behave in a "posixly correct" mode, where
> a lot of extensions are disabled, when invoked as "sh".  Unfortunately, it
> still defines BASH_* variables, including BASH, when operating in this
> mode.
> [...]
> So we may want to be a bit more careful like this:
> 
> if test "z${BASH%/bash}" != "z${BASH}"
> then
> 	: ends with bash so we are already running bash as bash

If bash is in posix mode (including "bash --posix" and being invoked as
"bin/sh"), it will set POSIXLY_CORRECT (but not export it). Similarly,
if POSIXLY_CORRECT is set in the outer environment, it will act more
like sh. So maybe that would be a better test.

-Peff
