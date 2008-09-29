From: Jeff King <peff@peff.net>
Subject: Re: [RFC 7/9] send-email: Completely replace --signed-off-cc with
	--signed-off-by-cc
Date: Mon, 29 Sep 2008 12:29:36 -0400
Message-ID: <20080929162935.GA2628@coredump.intra.peff.net>
References: <20080929003636.GA18552@coredump.intra.peff.net> <1222664781-55763-1-git-send-email-mfwitten@mit.edu> <1222664781-55763-2-git-send-email-mfwitten@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jnareb@gmail.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:31:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkLe4-0002Qo-Dy
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 18:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbYI2Q3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 12:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYI2Q3i
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 12:29:38 -0400
Received: from peff.net ([208.65.91.99]:1896 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbYI2Q3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 12:29:38 -0400
Received: (qmail 25548 invoked by uid 111); 29 Sep 2008 16:29:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 29 Sep 2008 12:29:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Sep 2008 12:29:36 -0400
Content-Disposition: inline
In-Reply-To: <1222664781-55763-2-git-send-email-mfwitten@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97032>

On Mon, Sep 29, 2008 at 12:06:19AM -0500, Michael Witten wrote:

> This breaks backwards compatibility, but so what---get off your
> lazy arses and remove the cruft.

Sorry, but try to be a lot more careful than that about breaking
compatibility. The right sequence is:

  1. Introduce new option (which has already been done for the command
     line, but it looks like you are adding a new config variable).

     Mention the new option in the documentation as the "right way".

     Possibly mention the old version as "deprecated".

  2. Wait a long time, possibly forever. This gives people a chance to
     adjust, and it lets us wait for a major version bump where such an
     incompatibility might be more expected.

  3. Remove the old option.

So I think you are skipping straight to '3' here. However, I think your
real purpose is to simply clean up the documentation, so why not just do
that? We can still support the old options for historical setups, and
just advertise the new ones in the docs.

-Peff
