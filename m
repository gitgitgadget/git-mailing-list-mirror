From: Jeff King <peff@peff.net>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 17:58:09 -0400
Message-ID: <20120611215808.GA6832@sigill.intra.peff.net>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
 <7vaa097k3q.fsf@alter.siamese.dyndns.org>
 <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com>
 <7vobop5zmp.fsf@alter.siamese.dyndns.org>
 <7vk3zd5y8d.fsf@alter.siamese.dyndns.org>
 <20120611214705.GC32061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Q2zDoXVkaW8gTG91cmVuw6dv?= <pt.smooke@gmail.com>,
	Leila <muhtasib@gmail.com>, konglu@minatec.inpg.fr,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCcq-0000mT-VB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab2FKV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:58:13 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50442
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab2FKV6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:58:12 -0400
Received: (qmail 10664 invoked by uid 107); 11 Jun 2012 21:58:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 17:58:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 17:58:09 -0400
Content-Disposition: inline
In-Reply-To: <20120611214705.GC32061@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199741>

On Mon, Jun 11, 2012 at 05:47:05PM -0400, Jeff King wrote:

> > I just checked the history of unpack-trees code (which is the
> > underlying machinery of read-tree, which in turn is the machinery
> > used to check out another branch by "git checkout"), and I suspect
> > that this particular case has never worked.
> 
> Yeah, I verified it back to v1.6.x, but didn't bother going further
> back.

Actually, it was broken by c819353 (Fix switching to a branch with D/F
when current branch has file D., 2007-03-15).

However, before that the check was too tight, and says:

  fatal: Untracked working tree file 'something' would be removed by merge.

which is not really correct, either.

-Peff
