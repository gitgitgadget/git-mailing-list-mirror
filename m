From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of fork
Date: Thu, 7 Jul 2011 15:15:28 -0400
Message-ID: <20110707191528.GD12044@sigill.intra.peff.net>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
 <1310038989-5724-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 21:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeu2y-00083G-0O
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 21:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998Ab1GGTPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 15:15:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35071
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1GGTPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 15:15:30 -0400
Received: (qmail 1690 invoked by uid 107); 7 Jul 2011 19:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 15:15:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 15:15:28 -0400
Content-Disposition: inline
In-Reply-To: <1310038989-5724-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176773>

On Thu, Jul 07, 2011 at 01:43:09PM +0200, Erik Faye-Lund wrote:

> The POSIX-function fork is not supported on Windows. Use our
> start_command API instead.

Is start_command the right solution? From my reading, the fork is
actually because we want to set up a sideband multiplexer. Should we not
just be using start_async() to start a thread, as we do in receive-pack?

-Peff
