From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] symbolic ref: refuse non-ref targets in HEAD
Date: Thu, 29 Jan 2009 03:34:37 -0500
Message-ID: <20090129083437.GA6297@coredump.intra.peff.net>
References: <20090129045205.GA31183@coredump.intra.peff.net> <7vljsuh7kf.fsf@gitster.siamese.dyndns.org> <20090129080145.GA777@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:36:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSSNc-0003MY-54
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZA2Iek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbZA2Iek
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:34:40 -0500
Received: from peff.net ([208.65.91.99]:39376 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363AbZA2Iej (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 03:34:39 -0500
Received: (qmail 29957 invoked by uid 107); 29 Jan 2009 08:34:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 03:34:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 03:34:37 -0500
Content-Disposition: inline
In-Reply-To: <20090129080145.GA777@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107648>

On Thu, Jan 29, 2009 at 03:01:45AM -0500, Jeff King wrote:

> > In addition, perhaps it may make sense to use test_create_repo to go one
> > level deeper before starting to play around, so that trash directory's
> > repository will prevent you from going any further up.
> 
> That sort of helps, but only by luck. Each test kills off one layer of
> repo. So the first one kills the test_create_repo, and the second one
> kills the trash directory. Adding another test would kill off the main
> repo. :) So you have to do something per-test. I'll do that in the
> re-roll.

It occurs to me you perhaps did mean to do something per-test, like:

  test_create_repo foo && (cd foo && do_the_actual_test)

That would work, too.

-Peff
