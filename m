From: Jeff King <peff@peff.net>
Subject: Re: t7610-mergetool.sh test failure
Date: Fri, 27 May 2016 16:01:23 -0400
Message-ID: <20160527200122.GA26608@sigill.intra.peff.net>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net>
 <20160526015114.GA12851@sigill.intra.peff.net>
 <20160527044027.GA26143@gmail.com>
 <20160527050054.GA25774@sigill.intra.peff.net>
 <xmqqshx4row8.fsf@gitster.mtv.corp.google.com>
 <20160527182444.GA1871@sigill.intra.peff.net>
 <CAPc5daV1zAwAHDmkc93kGvwCEFoioZNVta2xGsFJj9jq1H1H4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Aguilar <davvid@gmail.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 22:01:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Nwo-0000Hb-SG
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 22:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbcE0UB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 16:01:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:45409 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbcE0UBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 16:01:25 -0400
Received: (qmail 10260 invoked by uid 102); 27 May 2016 20:01:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 16:01:25 -0400
Received: (qmail 31977 invoked by uid 107); 27 May 2016 20:01:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 16:01:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2016 16:01:23 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daV1zAwAHDmkc93kGvwCEFoioZNVta2xGsFJj9jq1H1H4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295791>

On Fri, May 27, 2016 at 12:58:15PM -0700, Junio C Hamano wrote:

> On Fri, May 27, 2016 at 11:24 AM, Jeff King <peff@peff.net> wrote:
> > Which perhaps shows that maybe some people would
> > see a performance regression if we moved from /tmp to a slower
> > filesystem (e.g., especially people whose git clone is on NFS or
> > something).
> 
> Yup, but they would be using "--root" already if NFS bothers them;
> having TMPDIR pointing somewhere in it would not hurt them, I
> would think.

Yeah, but that is not quite the same as "in the source directory" (i.e.,
they would not notice via "git status" later if cruft was left in their
--root path). But I guess people not using "--root" would, and that may
be good enough.

-Peff
