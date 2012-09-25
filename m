From: Jeff King <peff@peff.net>
Subject: Re: Quickly searching for a note
Date: Mon, 24 Sep 2012 20:42:23 -0400
Message-ID: <20120925004223.GC19586@sigill.intra.peff.net>
References: <505CB21E.4040607@workspacewhiz.com>
 <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
 <505CCD2A.8020003@workspacewhiz.com>
 <505CD2FA.80200@kdbg.org>
 <505CD7D0.2000505@workspacewhiz.com>
 <20120921233723.GA29433@sigill.intra.peff.net>
 <7v7grn3pfo.fsf@alter.siamese.dyndns.org>
 <505DE30B.2000805@drmicha.warpmail.net>
 <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
 <505F2598.7080704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 02:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGJEU-0006oV-GH
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab2IYAm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:42:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57479 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2IYAm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:42:29 -0400
Received: (qmail 7971 invoked by uid 107); 25 Sep 2012 00:42:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:42:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:42:23 -0400
Content-Disposition: inline
In-Reply-To: <505F2598.7080704@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206341>

On Sun, Sep 23, 2012 at 05:07:04PM +0200, Michael J Gruber wrote:

> > If we linked with an embeddable scripting language interpreter
> > (e.g. lua, tcl, guile, ...), it may be a more practical enhancement,
> > though.
> > 
> 
> Yes, the idea is "extend, don't embed" the other way round, so to say. I
> still think extending "git log" so that it can call a script with commit
> info already in the environment gives a more convenient approach then
> "embedding git rev-list" into your own script. It's not more performant,
> of course.

I think Junio is going the other way than you think. That is, you still
run rev-list, but rather than call a sub-program, you call a snippet of
an embeddable script. Which is the same idea as yours, but theoretically
way faster.

> I just see many more requests of the type "grep notes" coming, i.e.
> limitting based on other commit info, or in a different way then already
> possible. Just image you want to find out who's responsible for those
> commits in git.git with subject lengths > 100 ;)

Like this:

  git log --lua-filter='return subject().len > 100'

? :)

-Peff
