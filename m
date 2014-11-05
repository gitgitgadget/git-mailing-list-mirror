From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct
 child_process variables
Date: Wed, 5 Nov 2014 14:35:57 -0500
Message-ID: <20141105193557.GA12620@peff.net>
References: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
 <20141030213523.GA21017@peff.net>
 <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
 <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
 <20141101033327.GA8307@peff.net>
 <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
 <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
 <20141103220408.GA12462@peff.net>
 <xmqq389zrguw.fsf@gitster.dls.corp.google.com>
 <D4F1F843014841509E8BFB9ACC7CDBCC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 20:36:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm6N9-0005Ha-J4
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 20:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaKETf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 14:35:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:37037 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751101AbaKETf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 14:35:58 -0500
Received: (qmail 6142 invoked by uid 102); 5 Nov 2014 19:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Nov 2014 13:35:58 -0600
Received: (qmail 24584 invoked by uid 107); 5 Nov 2014 19:36:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Nov 2014 14:36:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Nov 2014 14:35:57 -0500
Content-Disposition: inline
In-Reply-To: <D4F1F843014841509E8BFB9ACC7CDBCC@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 05, 2014 at 01:35:21PM -0000, Philip Oakley wrote:

> >>  2. Including two lines, like:
> [...]
> I believe that the 'two HEADs' mechanism would also fall foul of the
> 'duplicate refs' warning (untested).

It didn't in my very brief testing of what I posted above, but maybe
there is some other case that triggers it that I didn't exercise.

I grepped through the code and the only "duplicate ref" warning I see
comes from the refs.c code, which comes from commit_packed_refs(). If
the duplicate line is HEAD, I think it shouldn't trigger that, as it is
not a regular ref. That would explain why I didn't see it in my testing.

-Peff
