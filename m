From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Tue, 26 Aug 2008 20:19:45 -0400
Message-ID: <20080827001944.GA7347@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:20:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY8mJ-0002wd-EP
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 02:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbYH0ATr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 20:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYH0ATr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 20:19:47 -0400
Received: from peff.net ([208.65.91.99]:3437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbYH0ATr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 20:19:47 -0400
Received: (qmail 3115 invoked by uid 111); 27 Aug 2008 00:19:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 20:19:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 20:19:45 -0400
Content-Disposition: inline
In-Reply-To: <7vsksr1hgt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93839>

On Tue, Aug 26, 2008 at 04:31:30PM -0700, Junio C Hamano wrote:

> > This allows the use of author abbreviations when specifying commit
> > authors via the --author option to git commit. "--author=$key" is
> > resolved by looking up "user.$key.name" and "user.$key.email" in the
> > config.
> 
> Maybe it is just me, but I am hesitant about the contamination of user.*
> configuration namespace.  This patch as a general solution does not scale
> well, once you start working with more than a few dozen people.

It is not just you. I think this version of the patch is much improved,
but I am still against user.$key.*. At the very least, it needs its own
namespace.

I think if somebody cares, reading external files of various formats
would be nice (and a simple "alias, space, expansion, newline" format
could be introduced), but since I am not volunteering to implement that,
this even simpler implementation is acceptable to me, as long as it is
user.alias.$key.* or similar.

-Peff
