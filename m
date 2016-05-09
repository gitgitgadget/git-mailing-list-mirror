From: Jeff King <peff@peff.net>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 12:12:27 -0400
Message-ID: <20160509161226.GB11861@sigill.intra.peff.net>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
 <878tzmrrfg.fsf@linux-m68k.org>
 <d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
 <xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
 <5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
 <xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
 <CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
 <20160509083323.GB14299@sigill.intra.peff.net>
 <CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>, newren@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 09 18:17:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznnQ-0005LA-T8
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbcEIQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 12:12:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:36363 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbcEIQMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 12:12:30 -0400
Received: (qmail 18758 invoked by uid 102); 9 May 2016 16:12:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:12:29 -0400
Received: (qmail 20240 invoked by uid 107); 9 May 2016 16:12:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 12:12:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 12:12:27 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294003>

On Mon, May 09, 2016 at 12:02:45PM -0400, Eric Sunshine wrote:

> > I had that thought, too, but I think it would be an error to do so.
> > test_seq is supposed to be a replacement for "seq", which does not
> > understand non-numeric sequences.
> 
> Although, the comment block just above test_seq() in
> test-lib-functions.sh says otherwise:
> 
>     Print a sequence of numbers or letters in increasing order.  This
>     is similar to GNU seq(1), but the latter might not be available
>     everywhere (and does not do letters).  It may be used like:
> 
>     for i in $(test_seq 100)
>     do
>         for j in $(test_seq 10 20)
>         do
>             for k in $(test_seq a z)
>             do
>                 echo $i-$j-$k
>             done
>         done
>     done

Oh, indeed. I apparently even Acked that documentation once upon a time. :-/

Anyway, I double-checked my earlier "grep" and I do not think anybody is
using that functionality. So I think we'd be OK to change it as long as
we updated the documentation to match.

I don't really care either way whether it is replaced or not (at one
point there were some people really interested in NO_PERL not even using
one-liners in the test suite, but I am not one of them).

-Peff
