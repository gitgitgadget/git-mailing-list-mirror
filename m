From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Tue, 19 Apr 2016 03:00:01 -0400
Message-ID: <20160419070001.GA21875@sigill.intra.peff.net>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
 <1461013950-12503-3-git-send-email-sbeller@google.com>
 <20160419050342.GA19439@sigill.intra.peff.net>
 <CAGZ79kaD3kyWdbT-PhR9XPV_qmYpQipZwvfYYcVvwk62+x5qnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:00:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asPds-0005WD-S7
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 09:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbcDSHAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 03:00:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:51913 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751556AbcDSHAF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 03:00:05 -0400
Received: (qmail 10470 invoked by uid 102); 19 Apr 2016 07:00:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 03:00:04 -0400
Received: (qmail 13578 invoked by uid 107); 19 Apr 2016 07:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 03:00:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 03:00:01 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kaD3kyWdbT-PhR9XPV_qmYpQipZwvfYYcVvwk62+x5qnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291846>

On Mon, Apr 18, 2016 at 11:47:52PM -0700, Stefan Beller wrote:

> I am convinced the better way to do it is like this:
> 
>     Calculate the entropy for each line and take the last line with the
>     lowest entropy as the last line of the hunk.

I'll be curious to see the results, but I think sometimes predictable
and stupid may be the best route with these sorts of things. In
particular, I'd worry that a content-independent measure of entropy
might miss some subtleties of a particular language (e.g., that "*" is
more or less meaningful than some other character). But we'll see. :)

-Peff
