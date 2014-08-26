From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 09:33:26 -0400
Message-ID: <20140826133326.GA30887@peff.net>
References: <53FC3768.3090905@arc-aachen.de>
 <20140826130610.GG29180@peff.net>
 <53FC894F.9060402@arc-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Oliver Busch <oliver.busch@arc-aachen.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 15:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMGsO-0002rr-QD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 15:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbaHZNd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 09:33:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:59214 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755034AbaHZNd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 09:33:28 -0400
Received: (qmail 19745 invoked by uid 102); 26 Aug 2014 13:33:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 08:33:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 09:33:26 -0400
Content-Disposition: inline
In-Reply-To: <53FC894F.9060402@arc-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255903>

On Tue, Aug 26, 2014 at 03:19:11PM +0200, Oliver Busch wrote:

> PS: As far as I understand it, there is no "optionality" of the "T" as an
> indicator for the start of the time part.

The standard says (and I am quoting from Wikipedia here, as I do not
have it myself):

  4.3.2 NOTE: By mutual agreement of the partners in information
  interchange, the character [T] may be omitted in applications where
  there is no risk of confusing a date and time of day representation
  with others defined in this International Standard.

But I am not sure that "omitted" means "can be replaced with a space".
And while you can define "by mutual agreement" as "git defines the
format, so any consumers agree to it" that is not necessarily useful to
somebody who wants to feed the result to an iso8601 parser that does not
know or care about git (i.e., it shoves the conversion work onto the
person in the middle).

-Peff
