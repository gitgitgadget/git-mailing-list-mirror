From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pkt-line: show packets in async processes as
 "sideband"
Date: Tue, 1 Sep 2015 18:26:39 -0400
Message-ID: <20150901222639.GD7862@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
 <20150901202412.GA8020@sigill.intra.peff.net>
 <xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZKJF2epU=2gb7jFWni2tBu03dYGgttvZeW40ra=r2iiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:26:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWu0r-0000NO-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbbIAW0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:26:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:53391 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750829AbbIAW0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:26:41 -0400
Received: (qmail 30782 invoked by uid 102); 1 Sep 2015 22:26:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:26:41 -0500
Received: (qmail 6653 invoked by uid 107); 1 Sep 2015 22:26:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:26:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:26:39 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZKJF2epU=2gb7jFWni2tBu03dYGgttvZeW40ra=r2iiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277060>

On Tue, Sep 01, 2015 at 03:23:06PM -0700, Stefan Beller wrote:

> > Hmm, does Stefan's thread-pool thing interact with this decision in
> > any way?
> 
> I do not plan to actually fetch from inside the thread pool, but each thread
> is just a proxy for starting a new process doing the fetch and getting
> the output
> in order.

Ah, right, I think I misunderstood Junio's question. Yes, if we start
calling cmd_fetch() from inside the threads, things may get confusing.

I'll see how painful the thread storage approach would be.

-Peff
