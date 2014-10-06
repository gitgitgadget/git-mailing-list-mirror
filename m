From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/16] make prune mtime-checking more careful
Date: Sun, 5 Oct 2014 21:42:49 -0400
Message-ID: <20141006014249.GA11495@peff.net>
References: <20141003202045.GA15205@peff.net>
 <xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 03:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaxKB-0003nx-Hz
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 03:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaJFBmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2014 21:42:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:55283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751809AbaJFBmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 21:42:51 -0400
Received: (qmail 5898 invoked by uid 102); 6 Oct 2014 01:42:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Oct 2014 20:42:51 -0500
Received: (qmail 28244 invoked by uid 107); 6 Oct 2014 01:42:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Oct 2014 21:42:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2014 21:42:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257907>

On Sat, Oct 04, 2014 at 03:22:10PM -0700, Junio C Hamano wrote:

> This applied on top of 'maint' (which does have c40fdd01) makes the
> test #9 (prune: do not prune detached HEAD with no reflog) fail.

I'll fix the bone-headed error returns that Ren=C3=A9 noticed and doubl=
e
check that they were the complete culprit in the test failure you saw
(and not just masking some other problem).

> If we merge 'dt/cache-tree-repair' (which in turn needs
> 'jc/reopen-lock-file') to 'maint' and then apply these on top, the
> said test passes.  But I do not see an apparent reason why X-<.

I suspect it's an unintended interaction that just happens to let my
bogus code code the right thing, but I'll double check on that, too.

Thanks both of you for spotting the problems.

-Peff
