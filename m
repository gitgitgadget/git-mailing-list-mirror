From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] fast-import: clean up pack_data pointer in
 end_packfile
Date: Mon, 25 Aug 2014 14:55:34 -0400
Message-ID: <20140825185534.GA30953@peff.net>
References: <20140823052334.GA17813@peff.net>
 <20140823052741.GC18075@peff.net>
 <CAL=YDWmC9ncuH=fLR=8PWuB=kJeRP-O3K9MCKGaDfoxF6WWb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLzQb-0006WA-Cm
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbaHYSzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:55:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:58584 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932256AbaHYSzg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:55:36 -0400
Received: (qmail 29215 invoked by uid 102); 25 Aug 2014 18:55:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 13:55:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 14:55:34 -0400
Content-Disposition: inline
In-Reply-To: <CAL=YDWmC9ncuH=fLR=8PWuB=kJeRP-O3K9MCKGaDfoxF6WWb8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255851>

On Mon, Aug 25, 2014 at 10:16:52AM -0700, Ronnie Sahlberg wrote:

> Print an error before returning when pack_data is NULL ?

I don't think so. We call end_packfile in some code paths (like the die
handler) as "close if it's open". So I think it makes sense for it to be
a noop if nothing is open.

-Peff
