From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Mon, 3 Mar 2014 13:15:58 -0500
Message-ID: <20140303181558.GA16523@sigill.intra.peff.net>
References: <20140224082459.GA32594@sigill.intra.peff.net>
 <xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
 <20140226101353.GA25711@sigill.intra.peff.net>
 <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
 <20140227112734.GC29668@sigill.intra.peff.net>
 <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
 <20140228085546.GA11709@sigill.intra.peff.net>
 <xmqqob1ruld8.fsf@gitster.dls.corp.google.com>
 <20140301054350.GA20397@sigill.intra.peff.net>
 <xmqqeh2jrvz8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:16:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXPe-0000X3-9E
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbaCCSQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:16:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:60528 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754177AbaCCSQB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:16:01 -0500
Received: (qmail 32544 invoked by uid 102); 3 Mar 2014 18:16:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Mar 2014 12:16:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2014 13:15:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh2jrvz8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243243>

On Mon, Mar 03, 2014 at 10:13:47AM -0800, Junio C Hamano wrote:

> > Or the flip side: if the user wants to use .keep, we should drop
> > bitmaps. My point is that we do not know which way the user wants to
> > go, so we should not tie the options together.
> 
> Hmph.  I think the short of your later explanation is "global config
> may tell us to use bitmap, in which case we would need a way to
> defeat that and have existing .keep honored, and it makes it easier
> to do so if these two are kept separate, because you do not want to
> run around and selectively disable bitmaps in these repositories.
> We can instead do so with repack.packKeptObjects in the global
> configuration." and I tend to agree with the reasoning.

Yes. Do you need a re-roll from me? I think the last version I sent +
the squash to tie the default to bitmap-writing makes the most sense.

-Peff
