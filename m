From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git log does not decorate when custom format is used
Date: Wed, 20 Aug 2008 13:53:25 -0400
Message-ID: <20080820175325.GD27773@sigill.intra.peff.net>
References: <1KVmkk-2IOrGi0@fwd26.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrtA-0002Ot-LS
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbYHTRx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbYHTRx2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:53:28 -0400
Received: from peff.net ([208.65.91.99]:1907 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYHTRx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:53:27 -0400
Received: (qmail 25361 invoked by uid 111); 20 Aug 2008 17:53:26 -0000
Received: from lawn-128-61-25-158.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.158)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Aug 2008 13:53:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 13:53:25 -0400
Content-Disposition: inline
In-Reply-To: <1KVmkk-2IOrGi0@fwd26.aul.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93002>

On Wed, Aug 20, 2008 at 02:25:30PM +0200, MichaelTiloDressel@t-online.de wrote:

> is it a bug?

Sort of. More like a missing feature.

> When I use something like:
> git log --pretty=format:'%H %s' --decorate
> I do not get the decoration.
> While 
> git log --pretty=oneline --decorate
> does decorate.

The problem is where the decoration would go. I think it makes sense not
to show the decoration automatically in that case, since its placement
depends on the user formatting.

The right solution would be a '%d' placeholder to include the
decoration. Patch series to follow:

  [1/2] decorate: allow const objects to be decorated
  [2/2] allow '%d' pretty format specifier to show decoration

-Peff
