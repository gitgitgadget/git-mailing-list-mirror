From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 18:12:07 -0400
Message-ID: <20140829221206.GB24834@peff.net>
References: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch>
 <xmqqwq9r5dhb.fsf@gitster.dls.corp.google.com>
 <5400EA6C.3030504@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Beat Bolli <bbolli@ewanet.ch>
X-From: git-owner@vger.kernel.org Sat Aug 30 00:12:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNUP1-0002om-QH
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 00:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbaH2WMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 18:12:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:33457 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbaH2WMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 18:12:08 -0400
Received: (qmail 8739 invoked by uid 102); 29 Aug 2014 22:12:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 17:12:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 18:12:07 -0400
Content-Disposition: inline
In-Reply-To: <5400EA6C.3030504@ewanet.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256199>

On Fri, Aug 29, 2014 at 11:02:36PM +0200, Beat Bolli wrote:

> On 29.08.14 20:59, Junio C Hamano wrote:
> >> +# ISO strict date format
> >> +test_expect_success 'ISO and ISO-strict date formats display the same values' '
> >> +	git log --format=%ai%n%ci | sed -e "s/ /T/; s/ //; s/..\$/:&/" >expected &&
> >> +	git log --format=%aI%n%cI >actual &&
> >> +	test_cmp expected actual
> >> +'
> > 
> > This is saying that as long as --date=iso-strict format is
> > bug-to-bug compatible with --date=iso format it is OK.
> > 
> > Which is fine, especially knowing the implementation ;-)
> > 
> 
> Yeah, I wasn't sure how to test this, since the commit dates change with
> each test run. Maybe it's the easy way out, but on the other hand it's
> better than no test at all. Check the known parts with a regex?

If you use test_tick (or test_commit, which calls it), the timestamps
are stable from run to run of the tests.

-Peff
