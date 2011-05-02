From: Jeff King <peff@peff.net>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Mon, 2 May 2011 15:36:51 -0400
Message-ID: <20110502193651.GC10487@sigill.intra.peff.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyvT-0002oq-EW
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab1EBTgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:36:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48971
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab1EBTgx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:36:53 -0400
Received: (qmail 7954 invoked by uid 107); 2 May 2011 19:38:37 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 May 2011 15:38:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 May 2011 15:36:51 -0400
Content-Disposition: inline
In-Reply-To: <20110502193321.GB10487@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172626>

On Mon, May 02, 2011 at 03:33:21PM -0400, Jeff King wrote:

> I didn't check, but what does your patch do with:
> 
>   $ cd "`git rev-parse --show-toplevel`"
>   $ git log ..

Nevermind, it properly complains "'..' is outside repository"; of course
no new code is needed because we could already do "git log ../..".

I do notice that gitk doesn't work, though. Doing "gitk .." produces an
"ambiguous argument" error. It looks like "git rev-parse .." still
treats it as HEAD..HEAD, which may be the source of the error.

-Peff
