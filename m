From: Jeff King <peff@peff.net>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 4 Mar 2015 05:31:19 -0500
Message-ID: <20150304103119.GA19234@peff.net>
References: <20150218191417.GA7767@peff.net>
 <CACsJy8D6nAt3fMw=oh5mwUwfAJKViN1pk9pf9gZSBGyquU_WBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:31:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT6aU-00027B-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 11:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760003AbbCDKb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 05:31:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:56180 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758605AbbCDKbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 05:31:23 -0500
Received: (qmail 2275 invoked by uid 102); 4 Mar 2015 10:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 04:31:22 -0600
Received: (qmail 29230 invoked by uid 107); 4 Mar 2015 10:31:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 05:31:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 05:31:19 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8D6nAt3fMw=oh5mwUwfAJKViN1pk9pf9gZSBGyquU_WBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264748>

On Thu, Feb 26, 2015 at 08:10:38PM +0700, Duy Nguyen wrote:

> On Thu, Feb 19, 2015 at 2:14 AM, Jeff King <peff@peff.net> wrote:
> > Where I really need help now is in the "ideas" page:
> >
> >   http://git.github.io/SoC-2015-Ideas.html
> 
> Is this too ambitious for a summer? I suspect the answer is yes, but anyway..
> 
> Due to http limitations and stateless decision, a lot of data is sent
> back and forth during have/want negotiation for smart-http. I wonder
> if we could implement the "long polling" scheme in a CGI program. The
> program terminates HTTP requests and recreates a full duplex
> connection for upload-pack to talk to the client. upload-pack falls
> back to the normal mode, used by git:// and ssh://.

So basically Git-over-TCP-over-HTTP? :)

That would be a nice thing to have, though looking over the BOSH link
(which this is my first exposure to), it does look rather complicated.
It's not clear to me how easily one could plug in an existing tunneling
solution, and just stick git programs at the endpoints (in other words,
let that solution manage all of the connection state and just present a
socketpair() to git).

I'm not sure it is too ambitious in terms of actual implementation time,
but I think the design work may exceed what most students are capable
of.

-Peff
