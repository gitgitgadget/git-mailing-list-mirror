From: Jeff King <peff@peff.net>
Subject: Re: git rev-parse --show-toplevel doesn't work inside git-dir
Date: Wed, 5 Jun 2013 12:17:54 -0400
Message-ID: <20130605161754.GD8664@sigill.intra.peff.net>
References: <CAGHpTB+AOrQfEGRxQ6qwFMFO0eKBMq19e3fUruNedm81o5rJfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 18:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkGPR-000570-SK
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 18:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab3FEQR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 12:17:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:51813 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895Ab3FEQR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 12:17:57 -0400
Received: (qmail 30972 invoked by uid 102); 5 Jun 2013 16:18:43 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 11:18:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 12:17:54 -0400
Content-Disposition: inline
In-Reply-To: <CAGHpTB+AOrQfEGRxQ6qwFMFO0eKBMq19e3fUruNedm81o5rJfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226457>

On Wed, Jun 05, 2013 at 10:34:11AM +0300, Orgad Shaneh wrote:

> Running "git rev-parse --show-toplevel" doesn't print anything when it
> is run inside .git dir (on all levels)

This is by design. "--show-toplevel" does not print anything when you
do not have a working tree, and you do not have one if you are inside
the .git directory. If you were to do:

  cd .git
  git --work-tree=.. rev-parse --show-toplevel

(or use GIT_WORK_TREE, or set core.worktree, etc), you would get back
the toplevel of the working tree.

-Peff
