From: Jeff King <peff@peff.net>
Subject: Re: git status -s -v: no override
Date: Fri, 15 Apr 2011 20:09:18 -0400
Message-ID: <20110416000918.GB9334@sigill.intra.peff.net>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacek Masiulaniec <jacekm@dobremiasto.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAt4p-00088h-Ab
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 02:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab1DPAJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 20:09:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47376
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754262Ab1DPAJU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 20:09:20 -0400
Received: (qmail 14484 invoked by uid 107); 16 Apr 2011 00:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Apr 2011 20:10:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2011 20:09:18 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171650>

On Fri, Apr 15, 2011 at 10:34:55PM +0100, Jacek Masiulaniec wrote:

> Small git-status argument processing issue:
> 
> [jacekm@localhost test]$ git init
> Initialized empty Git repository in /private/tmp/test/.git/
> [jacekm@localhost test]$ git status -v
> # On branch master
> #
> # Initial commit
> #
> nothing to commit (create/copy files and use "git add" to track)
> [jacekm@localhost test]$ git status -s
> [jacekm@localhost test]$ git status -v -s
> [jacekm@localhost test]$ git status -s -v
> [jacekm@localhost test]$
> 
> Things look consistent until the last command: -v does not override -s,
> which is unexpected given that -s does override -v.

Sort of. I think you are expecting "-v" to mean "use the long output
format", but it doesn't. Instead, "-v" actually indicates that we should
show a diff along with the usual output (in your case, the diff is
empty).

There is no option that means "counteract -s or --porcelain seen earlier
on the command line and use the default long format", which I think is
what you want.

-Peff
