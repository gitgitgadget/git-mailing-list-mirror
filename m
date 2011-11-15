From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] refresh_index: notice typechanges in output
Date: Mon, 14 Nov 2011 21:05:06 -0500
Message-ID: <20111115020506.GA6305@sigill.intra.peff.net>
References: <20111114225056.GA27370@sigill.intra.peff.net>
 <20111114225651.GD3993@sigill.intra.peff.net>
 <7vaa7yi6wv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 03:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ8Oj-0003r7-9h
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 03:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002Ab1KOCFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 21:05:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41398
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab1KOCFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 21:05:09 -0500
Received: (qmail 2318 invoked by uid 107); 15 Nov 2011 02:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 21:05:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 21:05:06 -0500
Content-Disposition: inline
In-Reply-To: <7vaa7yi6wv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185420>

On Mon, Nov 14, 2011 at 04:08:32PM -0800, Junio C Hamano wrote:

> I agree that we should not say that an intent-to-add entry has changed
> type relative to whatever, as by definition there is nothing to compare
> against. "A" that stands for "A"dd is a lot more sensible here, I would
> think.

Yeah, that makes sense to me.

> +			if (cache_errno == ENOENT)
> +				fmt = deleted_fmt;
> +			else if (ce->ce_flags & CE_INTENT_TO_ADD)
> +				fmt = added_fmt; /* must be before other checks */

Thanks, I was trying to figure out how to tell an intent-to-add file
from the 'changed' flag, but obviously looking for the bit in the cache
entry is the right thing.

Do you want to add your patch on top, or do you want me to re-roll with
this squashed in? I can also hold the re-roll until post-release if you
want.

-Peff
