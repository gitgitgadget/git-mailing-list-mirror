From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] Documentation: add caveats about I/O buffering for
 check-{attr,ignore}
Date: Thu, 11 Apr 2013 01:31:54 -0400
Message-ID: <20130411053154.GD27795@sigill.intra.peff.net>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <1365645575-11428-3-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 07:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQA7E-0006tG-KE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 07:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab3DKFcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 01:32:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39745 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab3DKFcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 01:32:01 -0400
Received: (qmail 12029 invoked by uid 107); 11 Apr 2013 05:33:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 01:33:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 01:31:54 -0400
Content-Disposition: inline
In-Reply-To: <1365645575-11428-3-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220824>

On Thu, Apr 11, 2013 at 02:59:33AM +0100, Adam Spiers wrote:

> check-attr and check-ignore have the potential to deadlock callers
> which do not read back the output in real-time.  For example, if a
> caller writes N paths out and then reads N lines back in, it risks
> becoming blocked on write() to check-*, and check-* is blocked on
> write back to the caller.  Somebody has to buffer; the pipe buffers
> provide some leeway, but they are limited.
> 
> Thanks to Peff for pointing this out:
> 
>     http://article.gmane.org/gmane.comp.version-control.git/220534
> 
> Signed-off-by: Adam Spiers <git@adamspiers.org>

Thanks, I think the documentation changes look sane.

-Peff
