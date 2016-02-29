From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Mon, 29 Feb 2016 16:36:20 -0500
Message-ID: <20160229213620.GD25342@sigill.intra.peff.net>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net>
 <56D415C6.2040203@web.de>
 <20160229100258.GC2950@sigill.intra.peff.net>
 <xmqqtwkr9vu6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:36:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVUR-0001jD-KI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbcB2VgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:36:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:51775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbcB2VgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:36:23 -0500
Received: (qmail 9846 invoked by uid 102); 29 Feb 2016 21:36:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:36:23 -0500
Received: (qmail 31331 invoked by uid 107); 29 Feb 2016 21:36:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:36:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 16:36:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwkr9vu6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287909>

On Mon, Feb 29, 2016 at 11:10:09AM -0800, Junio C Hamano wrote:

> >> -       wargs = xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
> >> +       wargs = ALLOC_ARRAY(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
> >>         xutftowcs(wargs, args.buf, 2 * args.len + 1);
> >>         strbuf_release(&args);
> >
> > Argh. Let me write "git commit -a" on the inside of my brown paper bag,
> > so that I actually send out the fix sitting in my working tree, not the
> > half-finished thing I ran "git add" on.
> 
> Just to make sure that I am not confused, what you wrote below
> matches what I received from you two message upthread.
> 
> I am assuming that it is intended that the two messages from you
> have the same patch, and the assignment of ALLOC_ARRAY to wargs was
> a bug Torsten introduced only to his tree when cutting and pasting.
> 
> With that assumption, will queue this one (or the original one,
> which to me is the same thing).

Oh, <phew>. I am only half as incompetent as I thought, then.

I didn't even re-check what I sent, and just assumed Torsten was quoting
it exactly (I _did_ write something like that while making the fix, and
assumed I had just failed to properly commit).

So yes, what I sent both times is the right thing. ;)

-Peff
