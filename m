From: Jeff King <peff@peff.net>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 20:41:37 -0400
Message-ID: <20100422004136.GA18570@coredump.intra.peff.net>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
 <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <vpq8w8gjvhn.fsf@bauges.imag.fr>
 <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com>
 <20100422000131.GB14249@coredump.intra.peff.net>
 <k2t3abd05a91004211713u24ff93f3of758e5e09c7b8059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:42:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4kUn-0004pt-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab0DVAmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:42:14 -0400
Received: from peff.net ([208.65.91.99]:46128 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294Ab0DVAmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:42:13 -0400
Received: (qmail 24027 invoked by uid 107); 22 Apr 2010 00:42:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Apr 2010 20:42:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Apr 2010 20:41:37 -0400
Content-Disposition: inline
In-Reply-To: <k2t3abd05a91004211713u24ff93f3of758e5e09c7b8059@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145486>

On Wed, Apr 21, 2010 at 08:13:48PM -0400, Aghiles wrote:

> I don't have the information handy but it was most probably pre-1.5.
> I don't know if my 'branching habits' are common, but I found that
> the old behavior to be more natural with the way we work (creating
> branches for quick parallel work).

OK, then the behavior did change for you. But you are probably about 3
years too late to complain and try to get it changed. :)

> If the current behavior is here to stay, I would humbly suggest to
> mention the 'git checkout -b x origin' syntax in the manual (and
> 'git branch --track x origin').

It is in the checkout manual, but I think the subtlety that you missed
is that "--track" is going to care about whether you start your branch
from your local "master" or the remote "master". Even if they're at the
same commit, you are interested conceptually in basing your work on what
the remote is doing. Maybe we could talk about this in the definition of
<start-point>, I guess.

You may also be interested to know that "git checkout foo" these days
when you have no "foo" branch will do the equivalent of "git checkout -b
--track foo origin/foo", which would also do what you want.

-Peff
