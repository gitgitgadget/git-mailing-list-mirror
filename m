From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Thu, 28 Jan 2010 04:44:46 -0500
Message-ID: <20100128094446.GA14244@coredump.intra.peff.net>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
 <7vpr4wy2lk.fsf@alter.siamese.dyndns.org>
 <20100127114009.GE6262@coredump.intra.peff.net>
 <7veilbqs82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQvt-0000CA-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab0A1Joz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437Ab0A1Joy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:44:54 -0500
Received: from peff.net ([208.65.91.99]:38820 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab0A1Joy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:44:54 -0500
Received: (qmail 20761 invoked by uid 107); 28 Jan 2010 09:44:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 Jan 2010 04:44:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2010 04:44:46 -0500
Content-Disposition: inline
In-Reply-To: <7veilbqs82.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138236>

On Wed, Jan 27, 2010 at 11:10:21AM -0800, Junio C Hamano wrote:

> I wanted to do something like what your patch does by iterating over the
> input inside get_sha1_basic() while we still see @{...}, parsing pieces
> from the beginning, not from the end like the original "do we have the
> reflog indicator at the end?  If so strip it and deal with what we have at
> the front".  Your patch to i-b-n does that by recursing inside, which is a
> nice solution.

Yeah, I wanted to do that too, but it just ended up very messy. I
suppose the i-b-n solution is reasonably elegant, and it should
correctly handle non-get-sha1 instances like:

  git checkout @{-1}@{u}

> Care to roll a patch with additional tests, to build on top of 105e473
> (Fix log -g this@{upstream}, 2010-01-26)?

Yep, series to follow:

  [1/3]: test combinations of @{} syntax
  [2/3]: fix parsing of @{-1}@{u} combination
  [3/3]: reject @{-1} not at beginning of object name

-Peff
