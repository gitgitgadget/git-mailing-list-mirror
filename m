From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/67] fsck: don't fsck alternates for connectivity-only
 check
Date: Wed, 16 Sep 2015 14:12:37 -0400
Message-ID: <20150916181237.GB17381@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152428.GD29753@sigill.intra.peff.net>
 <f536d3d011ff1943c3cfcf90c9dce664@dscho.org>
 <xmqqtwquqlz2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHCS-0001Lt-FS
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbbIPSMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:12:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:60176 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753218AbbIPSMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:12:46 -0400
Received: (qmail 16398 invoked by uid 102); 16 Sep 2015 18:12:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 13:12:45 -0500
Received: (qmail 20908 invoked by uid 107); 16 Sep 2015 18:12:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 14:12:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 14:12:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwquqlz2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278041>

On Wed, Sep 16, 2015 at 11:04:49AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Hi Peff,
> >
> > On 2015-09-15 17:24, Jeff King wrote:
> >> Commit 02976bf (fsck: introduce `git fsck --connectivity-only`,
> >> 2015-06-22) recently gave fsck an option to perform only a
> >> subset of the checks, by skipping the fsck_object_dir()
> >> call. However, it does so only for the local object
> >> directory, and we still do expensive checks on any alternate
> >> repos. We should skip them in this case, too.
> >> 
> >> Signed-off-by: Jeff King <peff@peff.net>
> >
> > ACK!
> 
> Thanks, both.
> 
> Peff, I am inclined to take at least 1 and 4 outside the context of
> this series and queue them on their own topics.  I do not think
> either is too urgent to be in 2.6, but on the other hand they look
> both trivially correct (that is a famous last word that often comes
> back and haunt us, though), so...

Yeah, they are conceptually their own topics, and I do not mind doing it
that way. Note that a later patch in the sprintf-audit topic touches the
same spot in fsck, and we'll get a nasty conflict if they are done
separately.

Speaking of which, how do you want the next round of patches? I'm
hesitant to spam the list with 67 patches again, when only a fraction
have changed (and for all but the _to/_r thing, I've posted my changes
already).

-Peff
