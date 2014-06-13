From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 09:30:29 -0400
Message-ID: <20140613133028.GB18715@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net>
 <20140613114615.GE14066@sigill.intra.peff.net>
 <539AE8CA.50009@drmicha.warpmail.net>
 <539AED0C.8050107@drmicha.warpmail.net>
 <539AEF7E.1050402@drmicha.warpmail.net>
 <539AF49F.3010309@viscovery.net>
 <539AF748.3000901@drmicha.warpmail.net>
 <539AFAF3.9040707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:30:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvRZ2-00039B-6s
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 15:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaFMNac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 09:30:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:43514 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752036AbaFMNaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 09:30:30 -0400
Received: (qmail 31363 invoked by uid 102); 13 Jun 2014 13:30:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 08:30:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 09:30:29 -0400
Content-Disposition: inline
In-Reply-To: <539AFAF3.9040707@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251595>

On Fri, Jun 13, 2014 at 03:21:55PM +0200, Johannes Sixt wrote:

> I don't think so. What is the outcome of
> 
> 	false &&  # simulate a regression
> 	grep foo && exit 1
> 	! grep bar || exit 1
> 
> assuming that the '! grep bar' happens to be true? Answer: The regression
> is not diagnosed because the &&-chain is broken.
> 
> *That* is what I think you described earlier in this thread as "I put
> something failing on the first line of the original version, and the test
> succeeded."

Yeah, I think that is the bit that I was missing from my original
confusion.

  false &&
  anything || exit 1

_does_ work. But that is not what is written. ;)

Thanks for pointing it out.

-Peff
