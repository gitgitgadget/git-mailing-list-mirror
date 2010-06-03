From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Thu, 3 Jun 2010 13:07:24 -0400
Message-ID: <20100603170724.GB22779@coredump.intra.peff.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <vpq1vco41go.fsf@bauges.imag.fr>
 <4C07C2E8.508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 19:07:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKDtC-0006kV-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 19:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab0FCRHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 13:07:25 -0400
Received: from peff.net ([208.65.91.99]:54093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab0FCRHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 13:07:24 -0400
Received: (qmail 32110 invoked by uid 107); 3 Jun 2010 17:07:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 03 Jun 2010 13:07:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jun 2010 13:07:24 -0400
Content-Disposition: inline
In-Reply-To: <4C07C2E8.508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148348>

On Thu, Jun 03, 2010 at 04:57:44PM +0200, Michael J Gruber wrote:

> May I kindly direct you to the next parts you cut out, especially the
> one talking about "described thorougly along with the
> rationale in 3/4", and to the commit message of 3/4? :)
> 
> I'm not breaking existing tests, of course, which also test
> format-patch/apply cycles with symlinks.

Yes, but you are breaking "git diff | git apply", aren't you? It is
already broken with textconv, but that is a new feature that people opt
into by using it. Symlink patches are a feature that has worked fine
until now with the above command.

I don't think "but they should be using plumbing to generate patches"
is the right answer, either. Yes, we expect the diff porcelain to behave
differently depending on configuration, but with the exception of
textconv, it always produces an actual applicable patch.

-Peff
