From: Jeff King <peff@peff.net>
Subject: Re: Forward-port a patch using git
Date: Wed, 1 Dec 2010 13:16:26 -0500
Message-ID: <20101201181626.GD7774@sigill.intra.peff.net>
References: <4CF66BAA.1010203@shiftmail.org>
 <4CF68FCB.2030301@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Spelic <spelic@shiftmail.org>
X-From: git-owner@vger.kernel.org Wed Dec 01 19:16:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrEH-0005eV-3I
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab0LASQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:16:28 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab0LASQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:16:27 -0500
Received: (qmail 6156 invoked by uid 111); 1 Dec 2010 18:16:27 -0000
Received: from 129-79-255-226.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.226)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 01 Dec 2010 18:16:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Dec 2010 13:16:26 -0500
Content-Disposition: inline
In-Reply-To: <4CF68FCB.2030301@shiftmail.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162565>

On Wed, Dec 01, 2010 at 07:11:23PM +0100, Spelic wrote:

> I found it myself, sorry for having asked.
> 
> It was:
> 
> checkout v2.6.36

Be aware that checking out the v2.6.36 tag will mean you are not on any
branch. So this will work fine:

> apply 1 patch
> commit
> apply 1 patch
> commit
> ...
> rebase v2.6.37-rc4
> git format-patch -o <destdir> -numpatches

But at the end, you will not have any branch tip pointing to your
rebased work. If all you want are the patches as output, then that's
fine. But you may want to do:

  git checkout -b some-useful-name v2.6.36

as the first step instead, which means you can come back to your rebased
work later as "some-useful-name".

-Peff
