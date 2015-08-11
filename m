From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/17] remove hold_lock_file_for_append
Date: Tue, 11 Aug 2015 05:38:09 -0400
Message-ID: <20150811093809.GA10238@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
 <20150810093514.GE30981@sigill.intra.peff.net>
 <xmqqk2t2u5y9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jim Hill <gjthill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 11:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP60k-00048b-VY
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 11:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934006AbbHKJiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 05:38:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933396AbbHKJiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 05:38:15 -0400
Received: (qmail 24151 invoked by uid 102); 11 Aug 2015 09:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 04:38:15 -0500
Received: (qmail 14019 invoked by uid 107); 11 Aug 2015 09:38:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 05:38:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 05:38:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2t2u5y9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275677>

On Mon, Aug 10, 2015 at 03:36:14PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > No users of hold_lock_file_for_append remain, so remove it.
> 
> This does not seem to have anything to do with rotating static buffers
> used in get_pathname(); the only effect it has is to conflict heavily
> with Michael's tempfile topic X-<.

Yeah, the first patch (to drop the final caller) is why I stuck it in
this series, and I did not want to forget the rest of the topic that Jim
worked on.

> Perhaps this should be part of Michael's tempfile topic?

Yes, I think that is OK. We can keep the first patch (to
add_to_alternates_file) here, and do the other one later on top of
Michael's topic.

-Peff
