From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] am: terminate state files with a newline
Date: Mon, 24 Aug 2015 02:50:34 -0400
Message-ID: <20150824065033.GA4124@sigill.intra.peff.net>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
 <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
 <20150823055053.GA15849@yoshi.chippynet.com>
 <xmqqy4h16d1f.fsf@gitster.dls.corp.google.com>
 <20150824051344.GA12490@sigill.intra.peff.net>
 <xmqqegit5ghf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tan <pyokagan@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:50:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTlac-0006oJ-3g
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 08:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbbHXGuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 02:50:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:48913 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932281AbbHXGug (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 02:50:36 -0400
Received: (qmail 8041 invoked by uid 102); 24 Aug 2015 06:50:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 01:50:36 -0500
Received: (qmail 20787 invoked by uid 107); 24 Aug 2015 06:50:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 02:50:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 02:50:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegit5ghf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276438>

On Sun, Aug 23, 2015 at 11:48:44PM -0700, Junio C Hamano wrote:

> > I think the "if" here is redundant; strbuf_complete_line already handles
> > it.
> 
> True.  And I like your write_state_bool() wrapper (which should be
> "static void" to the builtin/am.c) very much.
> 
> On top of that, I think the right thing to do to write_file() would
> be to first clean-up the second parameter "fatal" to an "unsigned
> flags" whose (1<<0) bit is "fatal", (1<<1) bit is "binary", and make
> this new call to "strbuf_complete_line()" only when "binary" bit is
> not set.
> 
> The new comment I added before write_file() function needs to be
> adjusted if we were to do this, obviously.

Yup, I agree with all of that. I'm about to go to bed, so I'll assume
you or Paul will cook up a patch. :)

-Peff
