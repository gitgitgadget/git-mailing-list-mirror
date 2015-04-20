From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Mon, 20 Apr 2015 16:28:23 -0400
Message-ID: <20150420202822.GA16367@peff.net>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net>
 <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
 <20150420195337.GA15447@peff.net>
 <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
 <20150420200956.GA16249@peff.net>
 <xmqqwq16k189.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Saasen <ssaasen@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkIJ1-0005fH-1T
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 22:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbbDTU22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 16:28:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:47819 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754011AbbDTU2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 16:28:25 -0400
Received: (qmail 11347 invoked by uid 102); 20 Apr 2015 20:28:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 15:28:25 -0500
Received: (qmail 28286 invoked by uid 107); 20 Apr 2015 20:28:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Apr 2015 16:28:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2015 16:28:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwq16k189.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267499>

On Mon, Apr 20, 2015 at 01:12:54PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Either way, though, I do not think it is the upstream Git project's
> > problem.
> 
> The commit to pick where to queue the fixes actually is my problem,
> as I have this illusion that I'd be helping these derived works by
> making it easier for them to merge, not cherry-pick.

True, I had just meant the actual rolling of the releases.

> But I would imagine that they may go the cherry-pick route anyway,
> in which case I may be wasting my time worrying about them X-<.

FWIW, I typically cherry-pick rather than merge. The resulting history
is not as nice, but it means I don't have to think as hard about the
history when doing so. It also means that topics may not be as well
tested (e.g., they may have been implicitly relying on some other thing
that happened upstream that I did _not_ cherry-pick). But we treat even
cherry-picked upstream topics as their own feature branches, and do our
normal internal testing and review.

-Peff
