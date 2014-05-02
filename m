From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] approxidate for "git commit --date=foo"
Date: Thu, 1 May 2014 21:03:28 -0400
Message-ID: <20140502010328.GA30556@sigill.intra.peff.net>
References: <CA+55aFx=LizEyS6hq=av_qwRZuu_q3xPSXO-Jr4CAfXqaAuUtA@mail.gmail.com>
 <xmqq1tweec1o.fsf@gitster.dls.corp.google.com>
 <20140501220639.GD14441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1t0-0002b8-Tl
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbaEBBDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:03:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:43251 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751406AbaEBBDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 21:03:30 -0400
Received: (qmail 27708 invoked by uid 102); 2 May 2014 01:03:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 20:03:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 21:03:28 -0400
Content-Disposition: inline
In-Reply-To: <20140501220639.GD14441@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247913>

On Thu, May 01, 2014 at 06:06:39PM -0400, Jeff King wrote:

> > I think the original rationale was that it's OK for us to allow some
> > sloppiness when _viewing_ commits, since you will generally notice the
> > problem. But when making commits, it's better to be careful, since you
> > may be setting the sha1 in stone.
> > 
> > These days we have two tools that could help:
> > 
> >   1. approxidate_careful will do a regular approxidate, but keep track
> >   of whether we found anything even remotely useful. That doesn't mean
> >   you can't still get unexpected results, but at least some truly
> >   useless cases return errors.
> > 
> >   2. For commits with a different author and committer, we mention the
> >   author name in the post-commit summary. We could do the same with a
> >   timestamp that was given (i.e., mentioning it in a standard format)
> >   to give the user another opportunity to double-check what we parsed.
> 
> I think it would make sense if we followed both of those points.

Here are patches to do so.

  [1/4]: commit: use split_ident_line to compare author/committer
  [2/4]: pretty: make show_ident_date public
  [3/4]: commit: print "Date" line when the user has set date
  [4/4]: commit: accept more date formats for "--date"

-Peff
