From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] determine_author_info: stop leaking name/email
Date: Mon, 23 Jun 2014 13:21:37 -0400
Message-ID: <20140623172136.GC4838@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
 <20140618203609.GG23896@sigill.intra.peff.net>
 <CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
 <CABPQNSaqGaCnE7jY6yj_0m8iHpU2Y5rt9wAHW=sM_oH9r1qTzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:21:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz7w7-0007Ys-Jp
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbaFWRVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:21:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:49745 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756470AbaFWRVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:21:39 -0400
Received: (qmail 2506 invoked by uid 102); 23 Jun 2014 17:21:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 12:21:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 13:21:37 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaqGaCnE7jY6yj_0m8iHpU2Y5rt9wAHW=sM_oH9r1qTzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252355>

On Mon, Jun 23, 2014 at 11:33:56AM +0200, Erik Faye-Lund wrote:

> This approach has the added benefit of fixing the case where getenv
> uses a static buffer, like POSIX allows.

Good point. I knew we could invalidate the pointer if setenv() was called, but
I didn't know that another getenv() could (I don't know of any such
implementation offhand, but it is not too hard to handle it).

-Peff
