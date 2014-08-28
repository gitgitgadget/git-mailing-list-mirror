From: Jeff King <peff@peff.net>
Subject: Re: [BUG] resolved deltas
Date: Thu, 28 Aug 2014 18:22:27 -0400
Message-ID: <20140828222227.GA30879@peff.net>
References: <53F5D98F.4040700@redhat.com>
 <53F79CE3.60803@gmx.net>
 <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
 <20140828220821.GA31545@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN85d-00019Q-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 00:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbaH1WWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 18:22:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:32858 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752350AbaH1WW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 18:22:29 -0400
Received: (qmail 1942 invoked by uid 102); 28 Aug 2014 22:22:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 17:22:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 18:22:27 -0400
Content-Disposition: inline
In-Reply-To: <20140828220821.GA31545@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256129>

On Thu, Aug 28, 2014 at 06:08:21PM -0400, Jeff King wrote:

> Interesting. I couldn't convince Helgrind to catch such a case...

Ugh. It helps if you actually helgrind the git binary, and not the
shell-script from bin-wrappers. I can easily replicate the problem now.
The patch I just posted seems to fix it (at least it has been running in
a loop for over a minute with no failures, whereas before it took only a
few seconds to provoke a failure).

-Peff
