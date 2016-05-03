From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote.c: specify correct plural form in "commit
 diverge" message
Date: Tue, 3 May 2016 00:48:06 -0400
Message-ID: <20160503044805.GB32259@sigill.intra.peff.net>
References: <2A734D896A45164C887E476E942BF4F9B5F721@CINMBCNA09.e2k.ad.ge.com>
 <1462234350-30902-1-git-send-email-pclouds@gmail.com>
 <CAGZ79kayCBNn8e5TzD+zhPEopOVTvsTUfy=_9UGP43vktsdFLQ@mail.gmail.com>
 <CACsJy8C0mFfHQ+GSdJyXLc=SArnxKfZCFV7LJkoqEPs0ekzDZg@mail.gmail.com>
 <20160503042008.GB30529@sigill.intra.peff.net>
 <CACsJy8Bqs5dnKc=VPeuqPZ4OUWVdhYNbewWc5rs-R3FGoZuQ5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	ernesto.alfonsogonzalez@ge.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 06:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSFp-00024k-T5
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbcECEsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:48:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:60803 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750773AbcECEsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:48:09 -0400
Received: (qmail 10998 invoked by uid 102); 3 May 2016 04:48:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:48:08 -0400
Received: (qmail 22720 invoked by uid 107); 3 May 2016 04:48:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:48:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 00:48:06 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Bqs5dnKc=VPeuqPZ4OUWVdhYNbewWc5rs-R3FGoZuQ5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293323>

On Tue, May 03, 2016 at 11:43:41AM +0700, Duy Nguyen wrote:

> On Tue, May 3, 2016 at 11:20 AM, Jeff King <peff@peff.net> wrote:
> > Note that I do not think the singular case can ever trigger with your
> > new code. We know that both "ours" and "theirs" are non-zero to get to
> > this message, which means "ours + theirs" must be at least 2 (barring
> > negative commit counts, of course :) ).
> >
> > So you could probably replace the Q_() with just a _().
> 
> Problem is there are languages with more than one plural form (and the
> winner is Arabic with six(!) forms [1]). So even if singular form is
> never used, I think we still should stick to Q_().

Neat, I didn't know Q_() could handle that (I guess you are stuck
specifying only the two cases in the untranslated form, but the PO files
can do magic in the backend).

It would be nice if there were some way to mark it as "this string will
never be shown", or "will always be >= 2" as a hint for translators. I
guess those can go in a specially-formatted comment.

-Peff
