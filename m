From: Jeff King <peff@peff.net>
Subject: Re: "git apply --check" successes but git am says "does not match
 index"
Date: Mon, 15 Aug 2011 21:14:34 -0700
Message-ID: <20110816041434.GA5141@sigill.intra.peff.net>
References: <loom.20110814T113311-277@post.gmane.org>
 <20110815232318.GA4699@sigill.intra.peff.net>
 <7vhb5ijkq0.fsf@alter.siamese.dyndns.org>
 <20110816001306.GA23695@sigill.intra.peff.net>
 <7vd3g6j8sc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zemacsh <ruini.xue@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 06:14:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtB3H-00068u-Od
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 06:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab1HPEOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 00:14:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47582
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab1HPEOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 00:14:50 -0400
Received: (qmail 32005 invoked by uid 107); 16 Aug 2011 04:15:29 -0000
Received: from 206.111.142.135.ptr.us.xo.net (HELO sigill.intra.peff.net) (206.111.142.135)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 00:15:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2011 21:14:34 -0700
Content-Disposition: inline
In-Reply-To: <7vd3g6j8sc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179404>

On Mon, Aug 15, 2011 at 09:10:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I wonder if "git rebase" actually
> > suffers from the same problem,...
> 
> Doesn't it require a spiffy clean work tree before even starting?

Ah, you're right. I was confused that the continue case called
update-index, but the regular case did not. But it calls
require_clean_work_tree, which refreshes the index (in addition to
checking the dirty state, of course). So it's fine.

-Peff
