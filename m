From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Symlink mergetools scriptlets into valgrind wrappers
Date: Tue, 30 Aug 2011 14:16:20 -0400
Message-ID: <20110830181620.GA18386@sigill.intra.peff.net>
References: <e11fd4c98faf1fc4f970bd1570fe931e078f436e.1314665234.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySrQ-0007U8-Cn
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab1H3SQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 14:16:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36465
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab1H3SQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 14:16:27 -0400
Received: (qmail 28790 invoked by uid 107); 30 Aug 2011 18:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 14:17:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 14:16:20 -0400
Content-Disposition: inline
In-Reply-To: <e11fd4c98faf1fc4f970bd1570fe931e078f436e.1314665234.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180429>

On Tue, Aug 30, 2011 at 02:47:36AM +0200, Thomas Rast wrote:

> Since bc7a96a (mergetool--lib: Refactor tools into separate files,
> 2011-08-18) the mergetools and difftools related tests fail under
> --valgrind because the mergetools/* scriptlets are not in the exec
> path.
> 
> For now, symlink the mergetools subdir into the t/valgrind/bin
> directory as a whole, since it does not contain anything of interest
> to the valgrind wrappers.

I'm not super-excited about special-casing like this, but I don't think
there's a way to make it much cleaner without a lot of fuss. And the
valgrind stuff is pretty special-cased as it is (it would probably be
cleaner if it were integrated with the bin-wrappers rules in the
Makefile). But it's probably not worth spending effort on it. What's
there works, and your patch is a sane and straightforward fix for this
new issue. So:

Acked-by: Jeff King <peff@peff.net>

-Peff
