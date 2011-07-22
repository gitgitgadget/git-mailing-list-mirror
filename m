From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-am and git-submodule rely on $PATH to find perl
Date: Fri, 22 Jul 2011 16:40:18 -0600
Message-ID: <20110722224017.GC19620@sigill.intra.peff.net>
References: <87fwm0inqr.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkOOb-0007i5-C8
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab1GVWk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:40:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48153
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab1GVWk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:40:27 -0400
Received: (qmail 24116 invoked by uid 107); 22 Jul 2011 22:40:56 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 18:40:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 16:40:18 -0600
Content-Disposition: inline
In-Reply-To: <87fwm0inqr.fsf@write-only.cryp.to>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177679>

On Thu, Jul 21, 2011 at 12:35:56AM +0200, Peter Simons wrote:

> Both scripts run perl without any path, i.e. they don't use the
> $PERL_PATH that was passed at build time.

This isn't exactly a bug. The rule we usually follow in git is that you
can use "perl" in the PATH when you are doing simple awk-like things
that any version of perl should do. But you must use PERL_PATH for
#!-lines (because we can't do PATH lookup there), or for any non-trivial
script.

That being said, I don't see any downside to using PERL_PATH. The
Makefile tweaks would be pretty minimal. Want to work up a patch?

-Peff
