From: Jeff King <peff@peff.net>
Subject: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Fri, 20 Feb 2009 12:29:18 -0500
Message-ID: <20090220172918.GB4636@coredump.intra.peff.net>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302> <20090220152849.GA3826@coredump.intra.peff.net> <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaZD8-000630-Sp
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbZBTR3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbZBTR3V
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:29:21 -0500
Received: from peff.net ([208.65.91.99]:60825 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbZBTR3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 12:29:20 -0500
Received: (qmail 3642 invoked by uid 107); 20 Feb 2009 17:29:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Feb 2009 12:29:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Feb 2009 12:29:18 -0500
Content-Disposition: inline
In-Reply-To: <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110872>

On Fri, Feb 20, 2009 at 05:25:43PM +0100, Ferry Huberts (Pelagic) wrote:

> I replied in the thread with something comparable:
> http://article.gmane.org/gmane.comp.version-control.git/110358
> 
> My suggestion is make sure that safecrlf is set to false (see the end
> part of the mail)

Oh, sorry, I missed that bit. You said:

> Back to the issue:
> I think requiring autocrlf = false is too strict.  Requiring autocrlf
> = false should be enough. That combined with a bit of text in the
> manual page about these settings: autocrlf = false is strongly
> recommended. Also, safecrlf is required to be set to false.

Assuming there is a typo and you meant to say "Requiring safecrlf =
false should be enough", then yes, I agree. But if you are recommending
to put that into the "git cvsimport" manpage, I'm not sure that makes
sense. Setting autocrlf to input and turning on safecrlf breaks much
more than that; you can't add any file that has a CRLF in it.  So such a
warning should probably go in the config description for those options.

I still think safecrlf could probably be made more useful in this case
to differentiate between "this will corrupt your data if you do a
checkout with your current config settings" and "this will corrupt your
data forever".  But I am not a user of either config variable, so maybe
there is some subtlety I'm missing.

-Peff
