From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: Reorder linker flags in the git executable
 rule
Date: Sun, 26 Oct 2014 22:17:05 -0700
Message-ID: <20141027051705.GC2996@peff.net>
References: <87mw8iag72.fsf@gmail.com>
 <CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
 <20141026183530.GA18144@peff.net>
 <CAEvUa7nMYn1EJhrX+Yo-T53-tqB80p_ym9i+Ua6PMLqZrAFmQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xicg5-0000aE-NZ
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 06:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbaJ0FRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 01:17:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:33963 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750824AbaJ0FRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 01:17:09 -0400
Received: (qmail 774 invoked by uid 102); 27 Oct 2014 05:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Oct 2014 00:17:09 -0500
Received: (qmail 2871 invoked by uid 107); 27 Oct 2014 05:17:12 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Oct 2014 01:17:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2014 22:17:05 -0700
Content-Disposition: inline
In-Reply-To: <CAEvUa7nMYn1EJhrX+Yo-T53-tqB80p_ym9i+Ua6PMLqZrAFmQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 02:54:56PM -0400, David Michael wrote:

> Yes, the compiler refuses to run by default when a "-L" option occurs
> after a source/object file.  It tries to interpret it as another file
> name and fails.

Yeah, I think I have seen similar behavior before, but it has been long
enough that I no longer remember the compiler in use.

> I believe I can work around the error with an "export _C89_CCMODE=1",
> but I thought I'd send the patch since this is the only occurrence of
> the problem, and the argument order is inconsistent with other linker
> commands in the file.

I don't think working around it makes sense. That would fix your case,
but nobody else's (though given how long it has been that way without
complaints, I suspect any other compilers this picky may have died off).

> Do you want me to resend the patch and reference the IBM documentation
> in the message?

I don't think you need to. More interesting than documentation is the
real-world breakage you experienced and the analysis of the situation.
I'd be fine taking the patch as-is, or if changing anything, mentioning
the failure mode in the commit message.

-Peff
