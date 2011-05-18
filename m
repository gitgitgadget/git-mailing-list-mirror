From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/11] writing out a huge blob to working tree
Date: Wed, 18 May 2011 03:50:23 -0400
Message-ID: <20110518075023.GD27482@sigill.intra.peff.net>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <20110518064158.GB27482@sigill.intra.peff.net>
 <20110518070837.GC27482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 09:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMbWZ-0005Wq-Cs
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 09:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab1ERHu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 03:50:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37306
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab1ERHu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 03:50:26 -0400
Received: (qmail 2783 invoked by uid 107); 18 May 2011 07:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 03:52:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 03:50:23 -0400
Content-Disposition: inline
In-Reply-To: <20110518070837.GC27482@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173855>

On Wed, May 18, 2011 at 03:08:37AM -0400, Jeff King wrote:

> Part of the problem is that with the current code, all you care about is
> "Is it loose, packed non-delta, or packed delta?".
> [...]
> The patch below implements the cheap "is_delta" check.

Hmm, sorry, this patch works well on top of cd36b7b, where I first
detected the slowness, but later in the series we actually do look at
the pack information in the object_info. So my patch breaks that code
path horribly (I still think the concept of avoiding the revindex should
still work in principle, though).

-Peff
