From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/2] status -s: respect the status.relativePaths
 option
Date: Fri, 27 Nov 2009 02:05:12 -0500
Message-ID: <20091127070512.GF20844@coredump.intra.peff.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
 <62c5bb36940485deefbf73f4bdc3fd45bbea069e.1259248243.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 08:05:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDutL-0006LZ-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 08:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbZK0HFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 02:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbZK0HFG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 02:05:06 -0500
Received: from peff.net ([208.65.91.99]:39590 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbZK0HFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 02:05:05 -0500
Received: (qmail 25201 invoked by uid 107); 27 Nov 2009 07:09:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 27 Nov 2009 02:09:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Nov 2009 02:05:12 -0500
Content-Disposition: inline
In-Reply-To: <62c5bb36940485deefbf73f4bdc3fd45bbea069e.1259248243.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133866>

On Thu, Nov 26, 2009 at 04:24:38PM +0100, Michael J Gruber wrote:

> so that 'status' and 'status -s' in a subdir produce the same file
> names.

Thanks, I had been meaning to look into this (who knew it would only be
two lines ;) ).

Now that short and porcelain formats are diverging a bit, we should
probably have a few tests. I think there may already be a bug in

  git commit --dry-run --porcelain

as it looks like commit will use color and relative path configuration
even for the porcelain version.

-Peff
