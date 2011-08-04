From: Jeff King <peff@peff.net>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 3 Aug 2011 20:29:03 -0600
Message-ID: <20110804022903.GA3388@sigill.intra.peff.net>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
 <20110804014143.GA32579@sigill.intra.peff.net>
 <7v62me6ism.fsf@alter.siamese.dyndns.org>
 <20110804020054.GA1947@sigill.intra.peff.net>
 <7vwret6hgj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:29:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QongP-0004Xt-9q
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab1HDC3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 22:29:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48462
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755969Ab1HDC3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 22:29:07 -0400
Received: (qmail 13391 invoked by uid 107); 4 Aug 2011 02:29:40 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 22:29:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 20:29:03 -0600
Content-Disposition: inline
In-Reply-To: <7vwret6hgj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178658>

On Wed, Aug 03, 2011 at 07:25:32PM -0700, Junio C Hamano wrote:

> > Actually, it is relevant for zip, too. The option should really be
> > called "--no-commit-id" or something similar. I don't think it's as big
> > a deal with zip (because there is no compatibility issue), but you may
> > want to omit the header for other reasons (e.g., because you know it
> > doesn't point to a commit that is public).
> 
> Hmm, perhaps. It indeed is an implementation detail of the tar backend
> that the commit object name is stored in pax header, so --no-commit-id
> might make sense from "git" point of view, but from the point of view of
> OP that started this thread, he wouldn't care what that extra information
> is --- it can be a commit object name or it can be phase of the moon when
> the archive was made --- he just wants the extra header dropped.
> 
> So I dunno.

If the intent of the option is "write plain-vanilla ustar" (I really
hope it doesn't need to be "plain-vanilla 4.3BSD tar"), then I think we
would do better to have a new --format type. Because from the OP's
perspective, it's not "drop this header that I don't like" but "make
something compatible with older versions of tar".

-Peff
