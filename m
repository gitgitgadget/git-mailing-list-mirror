From: Jeff King <peff@peff.net>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 18:44:13 -0400
Message-ID: <20090603224413.GA2902@coredump.intra.peff.net>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> <7vmy8p54fr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzC8-0003xc-LO
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbZFCWoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbZFCWoU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:44:20 -0400
Received: from peff.net ([208.65.91.99]:38944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965AbZFCWoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:44:19 -0400
Received: (qmail 27423 invoked by uid 107); 3 Jun 2009 22:44:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Jun 2009 18:44:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2009 18:44:13 -0400
Content-Disposition: inline
In-Reply-To: <7vmy8p54fr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120658>

On Wed, Jun 03, 2009 at 03:38:00PM -0700, Junio C Hamano wrote:

> Actually for that "Where did my file 'x' go across the merge chain", I was
> going to suggest something like
> 
> 	git log --simplify-merges -m --raw -- x

But in the original example, the merge commit where 'x' is deleted isn't
shown _at all_ when path limiting is used. You end up either with
"git log -m" showing the two sides of the merge separately, "git log
--simplify-merges -- x" showing stuff that happened on the side branch
but _not_ the actual merge that made a change, or of course "git log --
x" showing nothing (because we don't traverse the changing side of the
merge).

Is there a way to say "show me everything that touched x, _including_
merges"?

-Peff
