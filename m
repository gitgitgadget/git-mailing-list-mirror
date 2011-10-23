From: Jeff King <peff@peff.net>
Subject: Re: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sun, 23 Oct 2011 12:29:44 -0400
Message-ID: <20111023162944.GB28156@sigill.intra.peff.net>
References: <4EA20C5B.3090808@gmail.com>
 <vpqfwiknmh3.fsf@bauges.imag.fr>
 <4EA3D1BB.2010802@gmail.com>
 <4EA415BD.1040109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 23 18:29:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI0vp-0005Ps-Sn
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 18:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab1JWQ3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 12:29:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39940
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab1JWQ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 12:29:48 -0400
Received: (qmail 3722 invoked by uid 107); 23 Oct 2011 16:29:56 -0000
Received: from 75-147-138-244-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (75.147.138.244)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 23 Oct 2011 12:29:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Oct 2011 12:29:44 -0400
Content-Disposition: inline
In-Reply-To: <4EA415BD.1040109@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184144>

On Sun, Oct 23, 2011 at 03:25:17PM +0200, Ren=C3=A9 Scharfe wrote:

> I can reproduce the malloc crash on Ubuntu 11.10 with these simple st=
eps:
> [...]
> Bisect points to 2548183ba, "fix phantom untracked files when
> core.ignorecase is set" from Jeff (cc:d).  If I revert that patch fro=
m
> master (8963314c), git status works fine.

Hmm. Interesting. I can't reproduce here. And I've been running with
this patch for over a year, and never seen that. Given your fix, I gues=
s
it's related to pointer size. Are you on a 32-bit machine, by any
chance?

-Peff
