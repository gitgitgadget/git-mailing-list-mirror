From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Wed, 7 Apr 2010 17:00:10 -0400
Message-ID: <20100407210010.GB27012@coredump.intra.peff.net>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Dlugosz <JDlugosz@tradestation.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 23:00:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzcMV-0005cV-9v
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 23:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0DGVAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 17:00:30 -0400
Received: from peff.net ([208.65.91.99]:60248 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab0DGVAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 17:00:30 -0400
Received: (qmail 10765 invoked by uid 107); 7 Apr 2010 21:00:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Apr 2010 17:00:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Apr 2010 17:00:10 -0400
Content-Disposition: inline
In-Reply-To: <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144285>

On Wed, Apr 07, 2010 at 12:58:33PM -0400, Avery Pennarun wrote:

> This is on purpose, based on the theory that you don't want to lose
> data from your local repo just because someone (accidentally?) deletes
> a branch on the remote server.  Unfortunately, this theory is a bit
> flawed, since someone could just as easily overwrite the remote branch
> with a totally different commit, and you'd still lose it in *that*
> case.  So mostly it's just confusing.

You do have a reflog in the case of overwrite. Delete kills off any
associated reflog (it would be cool if we had a "graveyard" reflog that
kept deleted branch reflogs around for a while).

> Anyway, what you want is "git remote prune origin".

Yep. I think there is "git fetch --prune" these days, too. We could
perhaps add a config option if there isn't one already (I didn't look)
so this happens automatically.

-Peff
