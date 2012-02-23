From: Jeff King <peff@peff.net>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 05:27:03 -0500
Message-ID: <20120223102702.GC2912@sigill.intra.peff.net>
References: <4F46036F.3040406@gmail.com>
 <4F460EB7.3030503@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nikolaj Shurkaev <snnicky@gmail.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 11:27:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VtI-000132-1n
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 11:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab2BWK1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 05:27:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48664
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086Ab2BWK1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 05:27:06 -0500
Received: (qmail 8585 invoked by uid 107); 23 Feb 2012 10:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Feb 2012 05:27:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2012 05:27:03 -0500
Content-Disposition: inline
In-Reply-To: <4F460EB7.3030503@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191349>

On Thu, Feb 23, 2012 at 10:02:31AM +0000, Luke Diamand wrote:

> >Thus I suspect there is a but in git log -z command and that doesn't
> >"Separate the commits with NULs instead of with new newlines." as
> >promised in the documents.
> >Is my understanding correct or I don't understand the documentation or
> >somehow pass wrong parameters into git log?
> 
> Just a guess, but doesn't the "--patch" option to git log ask it to
> produce a patch output? Surely that will override the -z: patch will
> not be expecting NULs.

No. You will get the patch text and the log message together, with
commits separated by NUL. Some diff output formats will also respect
"-z" to produce NULs internally (e.g., "--raw" will use it to separate
filenames), but "--patch" does not.

-Peff
