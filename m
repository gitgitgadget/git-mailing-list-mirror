From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] t0000 cleanups
Date: Tue, 31 Dec 2013 05:33:23 -0500
Message-ID: <20131231103323.GA14823@sigill.intra.peff.net>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228222129.GE5544@google.com>
 <xmqqwqimry2j.fsf@gitster.dls.corp.google.com>
 <20131230185125.GI20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 11:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxwdn-00009P-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 11:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab3LaKd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 05:33:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:52955 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752724Ab3LaKd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 05:33:26 -0500
Received: (qmail 10598 invoked by uid 102); 31 Dec 2013 10:33:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Dec 2013 04:33:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Dec 2013 05:33:23 -0500
Content-Disposition: inline
In-Reply-To: <20131230185125.GI20443@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239836>

On Mon, Dec 30, 2013 at 10:51:25AM -0800, Jonathan Nieder wrote:

> I think it can be better, since the commit message left me scratching
> my head while the patch itself seems pretty simple.  How about
> something like the following?

I am fine with that format, though...

> Analysis and fix:
> 
> 	These scratch areas for sub-tests should be under the t0000
> 	trash directory, but because the TEST_OUTPUT_DIRECTORY
> 	setting from the toplevel test leaks into the environment
> 	they are created under the toplevel output directory (typically
> 	t/) instead.  Because some of the sub-tests simulate failures,
> 	their trash directories are kept around.

This is not exactly true. The TEST_OUTPUT_DIRECTORY setting does not
leak. t0000 sets $TEST_DIRECTORY (which it must, so the sub-scripts can
find test-lib.sh and friends), and then TEST_OUTPUT_DIRECTORY uses that
as a default if it is not explicitly set.

The rest of your rewrite looks correct.

-Peff
