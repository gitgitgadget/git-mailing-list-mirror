From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] commit: show "Author:" hint when the ident is not
 given explicitly
Date: Thu, 15 Jan 2015 02:17:43 -0500
Message-ID: <20150115071743.GF11028@peff.net>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
 <1421278855-8126-11-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 08:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBegh-0003Ch-B6
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 08:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbbAOHRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 02:17:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:34828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751094AbbAOHRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 02:17:45 -0500
Received: (qmail 23039 invoked by uid 102); 15 Jan 2015 07:17:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:17:45 -0600
Received: (qmail 10686 invoked by uid 107); 15 Jan 2015 07:18:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 02:18:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 02:17:43 -0500
Content-Disposition: inline
In-Reply-To: <1421278855-8126-11-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262464>

On Wed, Jan 14, 2015 at 03:40:55PM -0800, Junio C Hamano wrote:

> This is a knee-jerk response to two facts:
> 
>  - the author_ident_sufficiently_given() function is public but
>    nobody uses it;
> 
>  - a corresponding function committer_ident_sufficiently_given() is
>    used to determine when to add "Committer: " reminder in the log
>    message editor.
> 
> The existing logic decides to show "Author:" reminder when the
> author is different from the committer, so there won't be practical
> difference other than we would end up showing both reminders when a
> committer with iffy name derived from the heuristic is committing
> her own patch.
> 
> Which means this patch probably should be dropped.

Yeah, I seem to recall going through this logic myself recently and
coming to the same conclusion (probably while working on fac9083). I
don't think it is really adding anything to the one case where it
triggers (and in fact looks a bit worse, as the author information is
redundant).

-Peff
