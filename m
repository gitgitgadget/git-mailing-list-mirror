From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 15:28:39 -0400
Message-ID: <20110414192839.GA6001@sigill.intra.peff.net>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASDf-0006ZS-Fl
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 21:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab1DNT2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 15:28:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32816
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab1DNT2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 15:28:41 -0400
Received: (qmail 2412 invoked by uid 107); 14 Apr 2011 19:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 15:29:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 15:28:39 -0400
Content-Disposition: inline
In-Reply-To: <7vipughbxh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171538>

On Thu, Apr 14, 2011 at 12:26:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We just dump the binary goo all over the terminal. So I think the whole
> > combined-diff code path needs to learn how to handle binaries properly.
> 
> How would you show multi-way diffs for binary files?

No clue. But anything would be better than pretending it's line oriented
and dumping binary goo to the terminal.

> It would probably be sufficient to say "binary files differ" at the
> beginning of the patch-combining codepath of the combined diff, which
> would at least keep the --raw -c/--cc output working.

Yeah, something like "binary files differ" would probably be OK for
"-c". I think for "--cc", that is probably the best we can do, too. It
is about condensing uninteresting hunks, but we don't even have the
concept of hunks.

-Peff
