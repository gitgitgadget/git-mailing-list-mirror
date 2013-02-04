From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 4 Feb 2013 04:38:21 -0500
Message-ID: <20130204093821.GA32095@sigill.intra.peff.net>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net>
 <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jongman.heo@samsung.com, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 10:38:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2IVj-0002f3-EI
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 10:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab3BDJiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 04:38:25 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59994 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab3BDJiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 04:38:24 -0500
Received: (qmail 17259 invoked by uid 107); 4 Feb 2013 09:39:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Feb 2013 04:39:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2013 04:38:21 -0500
Content-Disposition: inline
In-Reply-To: <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215372>

On Mon, Feb 04, 2013 at 01:16:08AM -0800, Junio C Hamano wrote:

> I think this really boils down to where we draw the "this is good
> enough" line.  I am not sure if losing the file as in $gmane/215211
> is common enough to be special cased to buy us much, while leaving
> other ".depend/foo.o.d was updated to contain a wrong info" cases
> still broken.

Hmm. Yeah, I was thinking it might be more common than ordinary munging
due to something like an interrupted "git clean -x". But given that:

  1. As far as I can tell, it is not a situation that can happen through
     regular use of checkout/make/etc, and...

  2. We have zero reports of it happening in practice (I only discovered
     it while explicitly trying to break the Makefile), and...

  3. It is just one of many possible breakages, all of which can be
     fixed by "git clean -dx" if you suspect issues...

let's just leave it. Thanks for a sanity check.

-Peff
