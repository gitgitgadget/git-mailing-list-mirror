From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] blame --line-porcelain
Date: Mon, 9 May 2011 09:31:54 -0400
Message-ID: <20110509133153.GA10998@sigill.intra.peff.net>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie>
 <20110506214801.GA17848@sigill.intra.peff.net>
 <20110506221300.GB17848@sigill.intra.peff.net>
 <7voc3fxy6b.fsf@alter.siamese.dyndns.org>
 <20110506222951.GA24474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 15:32:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJQZ8-0000cL-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 15:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab1EINb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 09:31:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39011
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab1EINb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 09:31:56 -0400
Received: (qmail 8995 invoked by uid 107); 9 May 2011 13:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 09:33:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 09:31:54 -0400
Content-Disposition: inline
In-Reply-To: <20110506222951.GA24474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173229>

On Fri, May 06, 2011 at 06:29:51PM -0400, Jeff King wrote:

> > Non-repetition was quite deliberate, as the reader was expected to have
> > memory proportional to the number of lines in the range, but I agree it is
> > not friendly for quick and dirty hack.
> > 
> > You should be able to add a command line option that disables the early
> > return at the beginning of emit_one_suspect_detail() with a 5-6 lines of
> > patch.
> 
> I tried that, and it is slightly more involved. You also need to break a
> multi-line run of lines that blame to a single suspect into its
> constituent lines. I am 75% of the way to such a patch if you are
> interested. It's not a lot of code, but it takes some refactoring of
> emit_porcelain.

It turned out to not be too bad. Here's the series.

  [1/3]: add tests for various blame formats
  [2/3]: blame: refactor porcelain output
  [3/3]: blame: add --line-porcelain output format

-Peff
