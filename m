From: Jeff King <peff@peff.net>
Subject: Re: git pull suggestion
Date: Sat, 10 Apr 2010 00:35:35 -0400
Message-ID: <20100410043535.GA22481@coredump.intra.peff.net>
References: <r2x3abd05a91004071617z9ffd6e02v83d825405bb6ef1@mail.gmail.com>
 <201004081754.24954.trast@student.ethz.ch>
 <p2x3abd05a91004081233j77b7177bm5928913a64de0e57@mail.gmail.com>
 <20100408231154.GB13704@vidovic>
 <v2r3abd05a91004082006v74e243f2x33b500f2f6dadc9f@mail.gmail.com>
 <20100409034911.GA4020@coredump.intra.peff.net>
 <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:36:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0SQf-00046n-35
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031Ab0DJEf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:35:59 -0400
Received: from peff.net ([208.65.91.99]:38132 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab0DJEf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:35:58 -0400
Received: (qmail 14572 invoked by uid 107); 10 Apr 2010 04:35:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 00:35:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 00:35:35 -0400
Content-Disposition: inline
In-Reply-To: <i2y3abd05a91004091233nc11ee5f8m4f40e7451e02518a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144502>

On Fri, Apr 09, 2010 at 03:33:35PM -0400, Aghiles wrote:

> It is another issue, but I feel that the 'dirty working directory' is
> one of the major usability hurdles for people migrating from svn
> and CVS (a git pull --merge-using-stash could address it, maybe).

I think this has been discussed before, but I couldn't find it in the
archives.

It is probably a little bit confusing because your pull will not
necessarily complete immediately. It may have conflicts, which you may
fix up, or you may "git reset --hard" to abort. But either way, you need
to remember that your dirty state was stashed and that you need to pull
it out after it's all done.

I think we would do better to tell the user about stash there, so they
can do it themselves. Then they know where their changes went and how to
get them back. Since v1.6.5.5, this error message now says:

  Your local changes to '%s' would be overwritten by merge.  Aborting.
  Please, commit your changes or stash them before you can merge.

What version of git are you using? If you (or others you are helping)
saw that message and it wasn't helpful, do you have any suggestions for
how to improve it?

-Peff
