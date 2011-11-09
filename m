From: Jeff King <peff@peff.net>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Wed, 9 Nov 2011 17:26:54 -0500
Message-ID: <20111109222654.GC31535@sigill.intra.peff.net>
References: <4EB9C7D1.30201@nextest.com>
 <20111109220128.GA31535@sigill.intra.peff.net>
 <20111109222032.GB31535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 23:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROGbl-00077V-Ni
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 23:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab1KIW05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 17:26:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38802
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab1KIW04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 17:26:56 -0500
Received: (qmail 19249 invoked by uid 107); 9 Nov 2011 22:26:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Nov 2011 17:26:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2011 17:26:54 -0500
Content-Disposition: inline
In-Reply-To: <20111109222032.GB31535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185174>

On Wed, Nov 09, 2011 at 05:20:32PM -0500, Jeff King wrote:

>   git log -g --format='%ct %H' |
>   awk '{ print $2 if $1 < SOME_TIMESTAMP }'

Hmm, that is obviously not valid awk syntax. My brain has been too fried
by perl. And the comparison goes the wrong way. A (closer to) working
example would be:

  git log -g --format='%ct %H' |
  perl -alne 'print $F[1] if $F[0] > SOME_TIMESTAMP'

But hopefully you get the point.

-Peff
