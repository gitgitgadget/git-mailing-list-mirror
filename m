From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 20:46:23 -0400
Message-ID: <20141014004623.GA22910@peff.net>
References: <20141010062722.GB17481@peff.net>
 <20141010064727.GC17481@peff.net>
 <xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
 <20141013223303.GA17045@peff.net>
 <20141013224342.GA22290@peff.net>
 <xmqq4mv71s0c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 02:46:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdqFy-0007Ku-1I
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 02:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbaJNAq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 20:46:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:58180 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753837AbaJNAqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 20:46:25 -0400
Received: (qmail 2176 invoked by uid 102); 14 Oct 2014 00:46:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 19:46:25 -0500
Received: (qmail 30279 invoked by uid 107); 14 Oct 2014 00:46:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 20:46:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2014 20:46:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mv71s0c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 04:14:59PM -0700, Junio C Hamano wrote:

> We came to more or less the same conclusion.  With your $*" fixed,
> the test "works" as before, with the same definition of "works",
> because without your patch the file ends with <HT>EOF<LF> and with
> your original $*<LF><HT>" the file ends with <HT>EOF<LF> with these
> extra <LF><HT> appended, which was what made me notice, and with $*"
> the file ends with the same <HT>EOF<LF> as before.

Yeah. I think the fact that fixing the test to properly respect EOF
required you to later change the line number is a good indication that
the test was broken in the first place. :)

> I've queued a fix for the original test on ta/config-set and also
> amended your $*".

Thanks. Note that my patch still technically adds a tab in front of the
$*. I can't imagine that would matter, but if we wanted to be extra
conservative, we would make it:

  eval "test ... && set -x
$*"

with no indentation at all.

> Enjoy your dinner ;-)

Thanks, I did. :)

-Peff
