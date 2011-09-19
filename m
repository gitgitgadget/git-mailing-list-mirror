From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 14:20:49 -0400
Message-ID: <20110919182049.GA26115@sigill.intra.peff.net>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
 <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 20:20:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5iSf-00069K-26
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 20:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab1ISSUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 14:20:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37492
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754929Ab1ISSUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 14:20:51 -0400
Received: (qmail 7557 invoked by uid 107); 19 Sep 2011 18:25:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 14:25:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 14:20:49 -0400
Content-Disposition: inline
In-Reply-To: <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181688>

On Mon, Sep 19, 2011 at 10:57:37AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm. Actually, the one for custom browser commands might need it,
> > because that one is expected to be a shell snippet. I suspect the
> > simplest thing is to do something like:
> >
> >   eval "$browser_cmd \"\$@\""
> 
> Yeah, I agree, and the dq around $browser_cmd is kind of important, too,
> for that to work and be readable.

Oops, good catch. Probably the most readable version would be:

  eval "\"$browser_cmd\"" '"$@"'

-Peff
