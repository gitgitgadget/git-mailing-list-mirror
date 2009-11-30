From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 02:59:27 -0500
Message-ID: <20091130075927.GA5767@coredump.intra.peff.net>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1AR-0001Wz-JS
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbZK3H7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbZK3H7U
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:59:20 -0500
Received: from peff.net ([208.65.91.99]:33340 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbZK3H7U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:59:20 -0500
Received: (qmail 10491 invoked by uid 107); 30 Nov 2009 08:03:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Nov 2009 03:03:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Nov 2009 02:59:27 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134075>

On Mon, Nov 30, 2009 at 08:55:51AM +0100, Sverre Rabbelier wrote:

> > This feels a little funny for NO_PYTHON to mean "no remote helpers at
> > all". But that is the way the Makefile is set up, since we seem to have
> > only python helpers.
> 
> I don't understand what you mean? Do you mean NO_PYTHON implies "no
> remote helpers at all", or "not having any remote helpers" implies
> NO_PYTHON? Either way, I'm not sure how to set it up differently, not
> having that much Makefile foo myself, so maybe Johan and Daniel could
> comment?

I mean, I would think that the "git_remote_helpers" directory contained
remote helpers of all sorts, not just the python ones. Right now we
_only_ have python ones. So checking for NO_PYTHON in test-lib.sh before
looking at git_remote_helpers makes sense.  But I am concerned that
assumption will be broken silently in the future if non-python helpers
are added to git_remote_helpers.

It is probably not worth caring about too much, though.

-Peff
