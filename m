From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 18:56:58 -0400
Message-ID: <20140327225658.GC32434@sigill.intra.peff.net>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
 <20140326221531.11352.86408.chriscool@tuxfamily.org>
 <xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
 <20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
 <xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
 <xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
 <20140327223406.GA32434@sigill.intra.peff.net>
 <xmqqha6jcl96.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	mhagger@alum.mit.edu, dan.carpenter@oracle.com, greg@kroah.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:57:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJEP-0004cM-T4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 23:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbaC0W5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 18:57:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:48832 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755633AbaC0W5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 18:57:00 -0400
Received: (qmail 4732 invoked by uid 102); 27 Mar 2014 22:57:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Mar 2014 17:57:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2014 18:56:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqha6jcl96.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245334>

On Thu, Mar 27, 2014 at 03:47:01PM -0700, Junio C Hamano wrote:

> Actually, I think it ends up being hostile to the users to accept
> random cases without a good reason.  If you see two trailer elements
> whose where are specified as "after" and "AFTER" in somebody's
> configuration file, wouldn't that give a wrong impression that a new
> line with the latter somehow has a stronger desire to come later
> than the former?
> 
> If you consistently take only the fixed strings, you do not have to
> worry about many people writing the same things in different ways,
> confusing each other.

I do not agree with this line of reasoning at all. After all, do we have
confusion about the case differences between:

  [COLOR]
  diff = true

  [color]
  UI = false

But I also do not overly care. Literally zero people have complained
that "[log]date = RFC822" is not accepted, so it is probably not a big
deal either way.

-Peff
