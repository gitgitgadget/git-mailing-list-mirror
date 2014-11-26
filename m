From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t7503: use write_script to generate hook scripts
Date: Wed, 26 Nov 2014 14:03:15 -0500
Message-ID: <20141126190315.GB1734@peff.net>
References: <cover.1416955873.git.oystwa@gmail.com>
 <78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
 <20141126045127.GC15252@peff.net>
 <xmqqk32hrfuv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 20:03:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xths0-0002CX-W9
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 20:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbaKZTDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 14:03:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:45388 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750812AbaKZTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 14:03:16 -0500
Received: (qmail 30503 invoked by uid 102); 26 Nov 2014 19:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Nov 2014 13:03:15 -0600
Received: (qmail 9401 invoked by uid 107); 26 Nov 2014 19:03:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Nov 2014 14:03:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Nov 2014 14:03:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk32hrfuv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260295>

On Wed, Nov 26, 2014 at 10:12:08AM -0800, Junio C Hamano wrote:

> >> +write_script "$HOOK" <<EOF
> >
> > While you are touching this line, please make it "<<\EOF". It does not
> > matter for these simple cases, but as a style, we try to avoid
> > interpolation unless it is necessary.
> 
> Thanks.  It is more about reducing cognitive burden from the
> readers.  An unquoted <<EOF signals you that your eyes need to scan
> carefully for $subsitutions to understand what is going on, instead
> of coasting it over.

While we are talking about it, do we have a style preference on
always/never using "<<-" unless necessary? I do not think it is as
important as preventing interpolation, because it does not introduce a
cognitive load in the same way. But consistently using "<<-" is one less
thing for shell newbies to be confused by, and to get wrong when
cargo-culting.

-Peff
