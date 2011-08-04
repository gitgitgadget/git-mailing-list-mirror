From: Jeff King <peff@peff.net>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Wed, 3 Aug 2011 20:00:54 -0600
Message-ID: <20110804020054.GA1947@sigill.intra.peff.net>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com>
 <20110804014143.GA32579@sigill.intra.peff.net>
 <7v62me6ism.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>, git@vger.kernel.org,
	rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:01:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QonF9-0003YB-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab1HDCA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 22:00:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49669
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab1HDCA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 22:00:57 -0400
Received: (qmail 12923 invoked by uid 107); 4 Aug 2011 02:01:31 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 22:01:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 20:00:54 -0600
Content-Disposition: inline
In-Reply-To: <7v62me6ism.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178653>

On Wed, Aug 03, 2011 at 06:56:41PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It might be a bit more obvious to find if we actually had a
> > --no-pax-header option, though.
> 
> Yeah, we would need to make sure that --no-pack-header causes a barf
> for other backends, though. "struct archiver_args" right now seems to have
> compression_level but I think it should just have "const char **" that is
> interpreted by backends.

Actually, it is relevant for zip, too. The option should really be
called "--no-commit-id" or something similar. I don't think it's as big
a deal with zip (because there is no compatibility issue), but you may
want to omit the header for other reasons (e.g., because you know it
doesn't point to a commit that is public).

-Peff
