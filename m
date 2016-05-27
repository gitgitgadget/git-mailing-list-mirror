From: Jeff King <peff@peff.net>
Subject: Re: t7610-mergetool.sh test failure
Date: Fri, 27 May 2016 01:00:54 -0400
Message-ID: <20160527050054.GA25774@sigill.intra.peff.net>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
 <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net>
 <20160526015114.GA12851@sigill.intra.peff.net>
 <20160527044027.GA26143@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 07:01:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b69tO-0002qu-LV
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 07:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbcE0FA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 01:00:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:45084 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750998AbcE0FA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 01:00:57 -0400
Received: (qmail 4708 invoked by uid 102); 27 May 2016 05:00:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 01:00:57 -0400
Received: (qmail 26873 invoked by uid 107); 27 May 2016 05:01:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 May 2016 01:01:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2016 01:00:54 -0400
Content-Disposition: inline
In-Reply-To: <20160527044027.GA26143@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295731>

On Thu, May 26, 2016 at 09:40:27PM -0700, David Aguilar wrote:

> > BTW, one thing I happened to note while looking at this: running the
> > test script will write into /tmp (or wherever your $TMPDIR points).
> > Probably not a big deal, but I wonder if we should be setting $TMPDIR in
> > our test harness.
> 
> We already set $HOME and various other variables to carefully
> tune the testsuite's behavior, so this sounds like a good idea
> IMO.
> 
> Would there be any downsides to setting $TMPDIR equal to the
> trash directory?

The only one I can think of is that if something leaves cruft in
$TMPDIR, it could affect later tests that want to `git add`
indiscriminately. It seems unlikely.

OTOH, I do not think putting things in /tmp is hurting anything. I was
mostly just surprised by it.

-Peff
