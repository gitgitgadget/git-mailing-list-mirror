From: Jeff King <peff@peff.net>
Subject: Re: git -c var=val not taken into account by git config?
Date: Tue, 8 May 2012 05:16:06 -0400
Message-ID: <20120508091606.GB31286@sigill.intra.peff.net>
References: <4FA857E3.5030609@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Villeneuve <daniel2villeneuve@videotron.ca>
X-From: git-owner@vger.kernel.org Tue May 08 11:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRgWw-0000tQ-54
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 11:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab2EHJQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 05:16:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33823
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab2EHJQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 05:16:09 -0400
Received: (qmail 32184 invoked by uid 107); 8 May 2012 09:16:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 05:16:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 05:16:06 -0400
Content-Disposition: inline
In-Reply-To: <4FA857E3.5030609@videotron.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197349>

On Mon, May 07, 2012 at 07:16:51PM -0400, Daniel Villeneuve wrote:

> Testing color configuration via scripting, I tried the following command:
> 
> git -c color.diff=always config --get-colorbool diff false
> 
> on a repository with color.diff=auto.
> 
> I'd expect "true" as output, but got "false".  "git diff" works as
> expected though.  Is this an exception for "git config"?

I think you meant "--get-colorbool color.diff"; the fact that you are
getting a colorbool does not automatically place the name inside the
color.* section.

With that change, it seems to work as expected.

-Peff
