From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Support triangular workflows
Date: Mon, 18 Mar 2013 10:25:26 -0400
Message-ID: <20130318142526.GA23075@sigill.intra.peff.net>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 15:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHb0f-00083t-KY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 15:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab3CROZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 10:25:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56091 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab3CROZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 10:25:30 -0400
Received: (qmail 17632 invoked by uid 107); 18 Mar 2013 14:27:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 10:27:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 10:25:26 -0400
Content-Disposition: inline
In-Reply-To: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218417>

On Mon, Mar 18, 2013 at 06:46:11PM +0530, Ramkumar Ramachandra wrote:

> I've put off implementing remote.default corresponding to
> remote.pushdefault, as Jeff suggested in [1], because it's currently
> not an itch; apart from the obvious symmetry, I don't know what
> purpose it serves: why would anyone want to fetch from a remote other
> than origin by default?  Why wouldn't they simply swap that remote's
> name with "origin"?  However, it's a nice thing to have for symmetry,
> and it should be trivial to implement: any interested person is
> welcome to pick it up.

Yeah, I agree that it does not have much point, aside from people who
have an unreasonable aversion to using the word "origin". There was a
series posted last summer to add remote.default:

  http://article.gmane.org/gmane.comp.version-control.git/201065

It ended up stalled and never got merged. I think the main impetus was
that "git clone -o foo" should leave "foo" in remote.default (of course,
that still leaves unanswered why anyone would really want to use "-o
foo" in the first place).

I think the symmetry makes some sense, but I also think it can come
later if somebody wants it.

>  Documentation/config.txt | 23 ++++++++++++++++---
>  builtin/push.c           |  2 +-
>  remote.c                 | 60 +++++++++++++++++++++++++++++++++++-------------
>  remote.h                 |  1 +
>  4 files changed, 66 insertions(+), 20 deletions(-)

No new tests?

-Peff
